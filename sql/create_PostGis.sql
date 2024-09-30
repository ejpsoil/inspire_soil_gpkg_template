-- Creo lo schema "so"
CREATE SCHEMA IF NOT EXISTS so AUTHORIZATION postgres;

-- Per rendere GEOGRAFICO IL DB 
CREATE EXTENSION postgis;

-- Per utilizzare uuid_generate_v4() in PostgreSQL, è necessario abilitare l'estensione uuid-ossp. Puoi farlo eseguendo il seguente comando una volta per il tuo database:

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------


/*                  
███████  ██████  ██ ██      ███████ ██ ████████ ███████ 
██      ██    ██ ██ ██      ██      ██    ██    ██      
███████ ██    ██ ██ ██      ███████ ██    ██    █████   
     ██ ██    ██ ██ ██           ██ ██    ██    ██      
███████  ██████  ██ ███████ ███████ ██    ██    ███████
*/   

-- Table soilsite -------------------------------------------------------------------------------------------
CREATE TABLE so.soilsite
(
    --id SERIAL PRIMARY KEY,
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    geometry GEOMETRY(POLYGON, 3035) NOT NULL,
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT,
    soilinvestigationpurpose TEXT NOT NULL, -- Codelist  soilinvestigationpurposevalue
    validfrom TIMESTAMPTZ DEFAULT current_timestamp not null,
    validto TIMESTAMPTZ,
    beginlifespanversion TIMESTAMPTZ DEFAULT current_timestamp not null,
    endlifespanversion TIMESTAMPTZ
);

-- Add Geometry Column
-- SELECT AddGeometryColumn('public', 'soilsite', 'geometry', 3035, 'POLYGON', 2);


COMMENT ON TABLE so.soilsite IS 'Area within a larger survey, study or monitored area, where a specific soil investigation is carried out.';
-- Add Comment Column
--COMMENT ON COLUMN soilsite.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.soilsite.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.soilsite.inspireid_localid IS 'A local identifier, assigned by the data provider. The local identifier is unique within the namespace, that is no other spatial object carries the same unique identifier.';
COMMENT ON COLUMN so.soilsite.inspireid_namespace IS 'Namespace uniquely identifying the data source of the spatial object.';
COMMENT ON COLUMN so.soilsite.inspireid_versionid IS 'The identifier of the particular version of the spatial object, with a maximum length of 25 characters. If the specification of a spatial object type with an external object identifier includes life-cycle information, the version identifier is used to distinguish between the different versions of a spatial object. Within the set of all versions of a spatial object, the version identifier is unique.';
COMMENT ON COLUMN so.soilsite.soilinvestigationpurpose IS 'Indication why a survey was conducted.';
COMMENT ON COLUMN so.soilsite.validfrom IS 'The time when the phenomenon started to exist in the real world.';
COMMENT ON COLUMN so.soilsite.validto IS 'The time from which the phenomenon no longer exists in the real world.';
COMMENT ON COLUMN so.soilsite.beginlifespanversion IS 'Date and time at which this version of the spatial object was inserted or changed in the spatial data set.';
COMMENT ON COLUMN so.soilsite.endlifespanversion IS 'Date and time at which this version of the spatial object was superseded or retired in the spatial data set.';
COMMENT ON COLUMN so.soilsite.geometry IS 'Geometry';

-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_valid_period_soilsite()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.validfrom > NEW.validto THEN
        RAISE EXCEPTION 'Table soilsite: validto must be greater than validfrom';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidperiodsoilsite
BEFORE INSERT OR UPDATE ON so.soilsite
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_period_soilsite();


CREATE OR REPLACE FUNCTION so.check_valid_versions_soilsite()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.beginlifespanversion > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'Table soilsite: beginlifespanversion must be less than endlifespanversion';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidversionsoilsite
BEFORE INSERT OR UPDATE ON so.soilsite
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_versions_soilsite();


CREATE OR REPLACE FUNCTION so.check_soil_investigation_purpose()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.soilinvestigationpurpose NOT IN (SELECT id FROM codelist WHERE collection = 'SoilInvestigationPurposeValue') THEN
        RAISE EXCEPTION 'Table soilsite: Invalid value for soilinvestigationpurpose. Must be present in id of soilinvestigationpurposevalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER soilinvestigationpurpose
BEFORE INSERT OR UPDATE ON so.soilsite
FOR EACH ROW
EXECUTE FUNCTION so.check_soil_investigation_purpose();


CREATE OR REPLACE FUNCTION so.update_begin_today_soilsite()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP < NEW.endlifespanversion OR NEW.endlifespanversion IS NULL THEN
        NEW.beginlifespanversion := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_soilsite
BEFORE UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, soilinvestigationpurpose, validfrom, validto, endlifespanversion
ON so.soilsite
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilsite();

CREATE OR REPLACE FUNCTION so.update_begin_today_soilsite_error()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'If you change record endlifespanversion must be greater than today';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_soilsite_error
AFTER UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, soilinvestigationpurpose, validfrom, validto, endlifespanversion
ON so.soilsite
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilsite_error();




-- Other triggers remain as they are, they are compatible with PostgreSQL/PostGIS.

/* 
███████  ██████  ██ ██      ██████  ██       ██████  ████████ 
██      ██    ██ ██ ██      ██   ██ ██      ██    ██    ██    
███████ ██    ██ ██ ██      ██████  ██      ██    ██    ██    
     ██ ██    ██ ██ ██      ██      ██      ██    ██    ██    
███████  ██████  ██ ███████ ██      ███████  ██████     ██
 */


-- Table soilplot ---------------------------------------------------------------------------------------
CREATE TABLE so.soilplot
(
    --id SERIAL PRIMARY KEY,
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    soilplotlocation GEOMETRY(POINT, 3035) NOT NULL,
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT,
    soilplottype TEXT NOT NULL,  -- Codelist soilplottypevalue
    beginlifespanversion TIMESTAMPTZ DEFAULT current_timestamp not null,
    endlifespanversion TIMESTAMPTZ,
    locatedon UUID REFERENCES so.soilsite(guidkey) ON UPDATE CASCADE
);

-- Add Geometry Column
--SELECT AddGeometryColumn('public', 'soilplot', 'soilplotlocation', 3035, 'POINT', 2);

COMMENT ON TABLE so.soilplot IS 'Spot where a specific soil investigation is carried out.';
-- Add Comment Column
--COMMENT ON COLUMN soilplot.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.soilplot.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.soilplot.inspireid_localid IS 'A local identifier, assigned by the data provider. The local identifier is unique within the namespace, that is no other spatial object carries the same unique identifier.';
COMMENT ON COLUMN so.soilplot.inspireid_namespace IS 'Namespace uniquely identifying the data source of the spatial object.';
COMMENT ON COLUMN so.soilplot.inspireid_versionid IS 'The identifier of the particular version of the spatial object, with a maximum length of 25 characters. If the specification of a spatial object type with an external object identifier includes life-cycle information, the version identifier is used to distinguish between the different versions of a spatial object. Within the set of all versions of a spatial object, the version identifier is unique.';
COMMENT ON COLUMN so.soilplot.soilplottype IS 'Gives information on what kind of plot the observation of the soil is made on.';
COMMENT ON COLUMN so.soilplot.beginlifespanversion IS 'Date and time at which this version of the spatial object was inserted or changed in the spatial data set.';
COMMENT ON COLUMN so.soilplot.endlifespanversion IS 'Date and time at which this version of the spatial object was superseded or retired in the spatial data set.';
COMMENT ON COLUMN so.soilplot.locatedon IS 'Foreign key to the SoilSite table, guidkey field.';
COMMENT ON COLUMN so.soilplot.soilplotlocation IS 'Geometry';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_valid_version_soilplot()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.beginlifespanversion > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'Table soilplot: beginlifespanversion must be less than endlifespanversion';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidversionsoilplot
BEFORE INSERT OR UPDATE ON so.soilplot
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_version_soilplot();

CREATE OR REPLACE FUNCTION so.check_soilplot_type()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.soilplottype NOT IN (SELECT id FROM codelist WHERE collection = 'SoilPlotTypeValue') THEN
        RAISE EXCEPTION 'Table soilplot: Invalid value for soilplottype. Must be present in id of soilplottypevalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER soilplottype
BEFORE INSERT OR UPDATE ON so.soilplot
FOR EACH ROW
EXECUTE FUNCTION so.check_soilplot_type();

CREATE OR REPLACE FUNCTION so.update_begin_today_soilplot()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP < NEW.endlifespanversion OR NEW.endlifespanversion IS NULL THEN
        NEW.beginlifespanversion := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_soilplot
BEFORE UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, soilplottype, endlifespanversion
ON so.soilplot
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilplot();

CREATE OR REPLACE FUNCTION so.update_begin_today_soilplot_error()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'If you change record endlifespanversion must be greater than today';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_soilplot_error
AFTER UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, soilplottype, endlifespanversion
ON so.soilplot
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilplot_error();





/* 
███████  ██████  ██ ██      ██████  ██████   ██████  ███████ ██ ██      ███████ 
██      ██    ██ ██ ██      ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      
███████ ██    ██ ██ ██      ██████  ██████  ██    ██ █████   ██ ██      █████   
     ██ ██    ██ ██ ██      ██      ██   ██ ██    ██ ██      ██ ██      ██      
███████  ██████  ██ ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████ 
 */

CREATE TABLE so.soilprofile 
(
    --id SERIAL PRIMARY KEY, -- SERIAL genera automaticamente valori incrementali per la chiave primaria
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT,
    localidentifier TEXT,
    beginlifespanversion TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp not null,
    endlifespanversion TIMESTAMP WITH TIME ZONE,
    validfrom TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp not null,
    validto TIMESTAMP WITH TIME ZONE,
    isderived BOOLEAN DEFAULT false NOT NULL, -- Cambiato da 0/1 a false/true
	wrbversion TEXT,  
    wrbreferencesoilgroup TEXT NOT NULL,
    isoriginalclassification BOOLEAN DEFAULT true NOT NULL, -- Cambiato da 0/1 a false/true
	
	CHECK ((wrbreferencesoilgroup IS NULL AND wrbversion IS NULL) OR (wrbreferencesoilgroup IS NOT NULL AND wrbversion IS NOT NULL)),
    location UUID UNIQUE,
    FOREIGN KEY (location)
      REFERENCES so.soilplot(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

COMMENT ON TABLE so.soilprofile IS 'Description of the soil that is characterized by a vertical succession of profile elements.';
-- Add Comment Column
-- COMMENT ON COLUMN soilprofile.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.soilprofile.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.soilprofile.inspireid_localid IS 'A local identifier, assigned by the data provider. The local identifier is unique within the namespace, that is no other spatial object carries the same unique identifier.';
COMMENT ON COLUMN so.soilprofile.inspireid_namespace IS 'Namespace uniquely identifying the data source of the spatial object.';
COMMENT ON COLUMN so.soilprofile.inspireid_versionid IS 'The identifier of the particular version of the spatial object, with a maximum length of 25 characters. If the specification of a spatial object type with an external object identifier includes life-cycle information, the version identifier is used to distinguish between the different versions of a spatial object. Within the set of all versions of a spatial object, the version identifier is unique.';
COMMENT ON COLUMN so.soilprofile.localidentifier IS 'Unique identifier of the soil profile given by the data provider of the dataset.';
COMMENT ON COLUMN so.soilprofile.beginlifespanversion IS 'Date and time at which this version of the spatial object was inserted or changed in the spatial data set.';
COMMENT ON COLUMN so.soilprofile.endlifespanversion IS 'Date and time at which this version of the spatial object was superseded or retired in the spatial data set.';
COMMENT ON COLUMN so.soilprofile.validfrom IS 'The time when the phenomenon started to exist in the real world.';
COMMENT ON COLUMN so.soilprofile.validto IS 'The time from which the phenomenon no longer exists in the real world.';
COMMENT ON COLUMN so.soilprofile.isderived IS 'Boolean value to indicate whether the record is of Derived or Observed type';
COMMENT ON COLUMN so.soilprofile.wrbversion IS 'Indicates the WRB classification version.';
COMMENT ON COLUMN so.soilprofile.wrbreferencesoilgroup IS 'First level of classification of the World Reference Base for Soil Resources.';
COMMENT ON COLUMN so.soilprofile.isoriginalclassification IS 'Boolean value to indicate whether the WRB classification system was the original classification system to describe the soil profile.';
COMMENT ON COLUMN so.soilprofile.location IS 'Foreign key to the SoilPlot table, guidkey field.';

-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_valid_period_soilprofile()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.validfrom > NEW.validto THEN
        RAISE EXCEPTION 'Table soilprofile: validto must be less than validfrom';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidperiodsoilprofile
BEFORE INSERT OR UPDATE ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_period_soilprofile();


CREATE OR REPLACE FUNCTION so.check_valid_version_soilprofile()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.beginlifespanversion >= NEW.endlifespanversion THEN
        RAISE EXCEPTION 'Table soilprofile: beginlifespanversion must be less than endlifespanversion';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidversionsoilprofile
BEFORE INSERT OR UPDATE ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_version_soilprofile();


CREATE OR REPLACE FUNCTION so.check_profile_location() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.isderived = TRUE AND NEW.location IS NOT NULL THEN
        RAISE EXCEPTION 'Table soilprofile: For DERIVED profile (isderived = 1), location must be NULL';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckprofilelocation
BEFORE INSERT OR UPDATE ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.check_profile_location();


CREATE OR REPLACE FUNCTION so.check_profile_location_observed()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.isderived = FALSE AND NEW.location IS NULL THEN
        RAISE EXCEPTION 'Table soilprofile: For OBSERVED profile (isderived = 0), location must be NOT NULL';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckprofilelocationobserved
BEFORE INSERT OR UPDATE ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.check_profile_location_observed();



CREATE OR REPLACE FUNCTION so.check_wrb_reference_soil_group()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue') AND NEW.wrbreferencesoilgroup IS NOT NULL) OR
        (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue2014') AND NEW.wrbreferencesoilgroup IS NOT NULL) OR
        (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue2022') AND NEW.wrbreferencesoilgroup IS NOT NULL)
    ) THEN
        RAISE EXCEPTION 'Table soilprofile: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbreferencesoilgroup
BEFORE INSERT OR UPDATE ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.check_wrb_reference_soil_group();

/*

CREATE OR REPLACE FUNCTION check_wrb_reference_soil_group()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue') AND NEW.wrbreferencesoilgroup IS NOT NULL THEN
        RAISE EXCEPTION 'Table soilprofile: Invalid value for wrbreferencesoilgroup. Must be present in id of wrbreferencesoilgroupvalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbreferencesoilgroup
BEFORE INSERT OR UPDATE ON soilprofile
FOR EACH ROW
EXECUTE FUNCTION check_wrb_reference_soil_group();
*/


CREATE OR REPLACE FUNCTION so.update_begin_today_soilprofile()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP < NEW.endlifespanversion OR NEW.endlifespanversion IS NULL THEN
        NEW.beginlifespanversion := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_soilprofile
BEFORE UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, localidentifier, endlifespanversion, validfrom, validto, isderived, wrbreferencesoilgroup, isoriginalclassification
ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilprofile();


CREATE OR REPLACE FUNCTION so.update_begin_today_soilprofile_error()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'If you change record endlifespanversion must be greater than today';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER u_begin_today_soilprofile_error
AFTER UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, localidentifier, endlifespanversion, validfrom, validto, isderived, wrbreferencesoilgroup, isoriginalclassification
ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilprofile_error();


CREATE OR REPLACE FUNCTION so.validate_wrbversion_sp()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.wrbversion NOT IN (SELECT id FROM codelist WHERE collection = 'wrbversion') AND NEW.wrbversion IS NOT NULL) THEN
        RAISE EXCEPTION 'Table soilprofile: Invalid value for wrbversion. Must be present in id of wrbreferencesoilgroupvalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_wrbversion_sp
BEFORE INSERT OR UPDATE ON so.soilprofile
FOR EACH ROW
EXECUTE FUNCTION so.validate_wrbversion_sp();



/* 
 ██████  ████████ ██   ██ ███████ ██████  ███████  ██████  ██ ██      ███    ██  █████  ███    ███ ███████ ████████ ██    ██ ██████  ███████ 
██    ██    ██    ██   ██ ██      ██   ██ ██      ██    ██ ██ ██      ████   ██ ██   ██ ████  ████ ██         ██     ██  ██  ██   ██ ██      
██    ██    ██    ███████ █████   ██████  ███████ ██    ██ ██ ██      ██ ██  ██ ███████ ██ ████ ██ █████      ██      ████   ██████  █████   
██    ██    ██    ██   ██ ██      ██   ██      ██ ██    ██ ██ ██      ██  ██ ██ ██   ██ ██  ██  ██ ██         ██       ██    ██      ██      
 ██████     ██    ██   ██ ███████ ██   ██ ███████  ██████  ██ ███████ ██   ████ ██   ██ ██      ██ ███████    ██       ██    ██      ███████ 

 */

CREATE TABLE so.othersoilnametype
(
    id SERIAL PRIMARY KEY,
    othersoilname_type TEXT NOT NULL, --Codelist othersoilnametypevalue
    othersoilname_class TEXT,
    isoriginalclassification BOOLEAN DEFAULT FALSE NOT NULL,
    othersoilname UUID,
    FOREIGN KEY (othersoilname) REFERENCES so.soilprofile(guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON TABLE so.othersoilnametype IS 'An identification of the soil profile according to a specific classification scheme.';
-- Add Comment Column
COMMENT ON COLUMN so.othersoilnametype.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.othersoilnametype.othersoilname_type IS 'Name of the soil profile according to a specific classification scheme.';
COMMENT ON COLUMN so.othersoilnametype.othersoilname_class IS 'Specific classification scheme.';
COMMENT ON COLUMN so.othersoilnametype.isoriginalclassification IS 'Boolean value to indicate whether the specified classification scheme was the original classification scheme to describe the profile.';
COMMENT ON COLUMN so.othersoilnametype.othersoilname IS 'Foreign key to the SoilProfile table, guidkey field.';



-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_soil_name()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.othersoilname_type NOT IN (SELECT id FROM codelist WHERE collection = 'OtherSoilNameTypeValue') THEN
        RAISE EXCEPTION 'Table othersoilnametype: Invalid value for othersoilname_type. Must be present in id of othersoilnametypevalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER soilname
BEFORE INSERT OR UPDATE ON so.othersoilnametype
FOR EACH ROW
EXECUTE FUNCTION so.check_soil_name();



/* 
██ ███████ ██████  ███████ ██████  ██ ██    ██ ███████ ██████  ███████ ██████   ██████  ███    ███ 
██ ██      ██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██      ██   ██ ██    ██ ████  ████ 
██ ███████ ██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ █████   ██████  ██    ██ ██ ████ ██ 
██      ██ ██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██      ██   ██ ██    ██ ██  ██  ██ 
██ ███████ ██████  ███████ ██   ██ ██   ████   ███████ ██████  ██      ██   ██  ██████  ██      ██
 */

CREATE TABLE so.isderivedfrom 
(
    --id SERIAL PRIMARY KEY,
    base_id UUID NOT NULL,
    related_id UUID NOT NULL,
    CONSTRAINT unicrelationidf PRIMARY KEY (base_id, related_id),
    FOREIGN KEY (base_id) REFERENCES so.soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (related_id) REFERENCES so.soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON TABLE so.isderivedfrom IS 'Link between Derived Soil Profiles and Observed Soil Profiles.';
-- Add Comment Column
--COMMENT ON COLUMN isderivedfrom.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.isderivedfrom.base_id IS 'Foreign key to the SoilProfile table, guidkey field. - Observed Soil Profile';
COMMENT ON COLUMN so.isderivedfrom.related_id IS 'Foreign key to the SoilProfile table, guidkey field. - Derived Soil Profile';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_isderived()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.base_id NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = TRUE) THEN
        RAISE EXCEPTION 'Table isderivedfrom: Attention, the value of the "base_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type derived';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER checkisderived
BEFORE INSERT OR UPDATE ON so.isderivedfrom
FOR EACH ROW
EXECUTE FUNCTION so.check_isderived();

CREATE OR REPLACE FUNCTION so.check_isobserved()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.related_id NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = FALSE) THEN
        RAISE EXCEPTION 'Table isderivedfrom: Attention, the value of the "related_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type observed';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER checkisobserved
BEFORE INSERT OR UPDATE ON so.isderivedfrom
FOR EACH ROW
EXECUTE FUNCTION so.check_isobserved();



/* 
███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██ 
██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██  
███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████   
     ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██    
███████  ██████  ██ ███████ ██████   ██████  ██████     ██   
 */ 

CREATE TABLE so.soilbody
(
    --id SERIAL PRIMARY KEY,
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT, 
    beginlifespanversion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    endlifespanversion TIMESTAMP,
    soilbodylabel TEXT NOT NULL
);


COMMENT ON TABLE so.soilbody IS 'Part of the soil cover that is delineated and that is homogeneous with regard to certain soil properties and/or spatial patterns.';
-- Add Comment Column
--COMMENT ON COLUMN soilbody.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.soilbody.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.soilbody.inspireid_localid IS 'A local identifier, assigned by the data provider. The local identifier is unique within the namespace, that is no other spatial object carries the same unique identifier.';
COMMENT ON COLUMN so.soilbody.inspireid_namespace IS 'Namespace uniquely identifying the data source of the spatial object.';
COMMENT ON COLUMN so.soilbody.inspireid_versionid IS 'The identifier of the particular version of the spatial object, with a maximum length of 25 characters. If the specification of a spatial object type with an external object identifier includes life-cycle information, the version identifier is used to distinguish between the different versions of a spatial object. Within the set of all versions of a spatial object, the version identifier is unique.';
COMMENT ON COLUMN so.soilbody.beginlifespanversion IS 'Date and time at which this version of the spatial object was inserted or changed in the spatial data set.';
COMMENT ON COLUMN so.soilbody.endlifespanversion IS 'Date and time at which this version of the spatial object was superseded or retired in the spatial data set.';
COMMENT ON COLUMN so.soilbody.soilbodylabel IS 'Label to identify the soil body according to the specified reference framework (metadata).';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_valid_version_soilbody()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.beginlifespanversion > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'Table soilbody: beginlifespanversion must be less than endlifespanversion';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidversionsoilbody
BEFORE INSERT OR UPDATE ON so.soilbody
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_version_soilbody();

CREATE OR REPLACE FUNCTION so.update_begin_today_soilbody()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP < NEW.endlifespanversion OR NEW.endlifespanversion IS NULL THEN
        NEW.beginlifespanversion := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_soilbody
AFTER UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, endlifespanversion, soilbodylabel
ON so.soilbody
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilbody();


CREATE OR REPLACE FUNCTION so.update_begin_today_soilbody_error()
RETURNS TRIGGER AS $$
BEGIN
    IF CURRENT_TIMESTAMP > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'If you change record endlifespanversion must be greater than today';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_soilbody_error
AFTER UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, endlifespanversion, soilbodylabel
ON so.soilbody
FOR EACH ROW
EXECUTE FUNCTION so.update_begin_today_soilbody_error();



/*
███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██          ██████  ███████  ██████  ███    ███ 
██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██          ██       ██      ██    ██ ████  ████ 
███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████           ██   ███ █████   ██    ██ ██ ████ ██ 
     ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██            ██    ██ ██      ██    ██ ██  ██  ██ 
███████  ██████  ██ ███████ ██████   ██████  ██████     ██    ███████  ██████  ███████  ██████  ██      ██ 
*/

CREATE TABLE so.soilbody_geom
(
    id SERIAL PRIMARY KEY,
    geom GEOMETRY(MULTIPOLYGON, 3035) NOT NULL,
    idsoilbody UUID NOT NULL,
    FOREIGN KEY (idsoilbody) REFERENCES so.soilbody(guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Add Geometry Column
-- SELECT AddGeometryColumn('public', 'soilbody_geom', 'geom', 3035, 'MULTIPOLYGON', 2);

COMMENT ON TABLE so.soilbody_geom IS 'Shape of a Soil Body.';
-- Add Comment Column
COMMENT ON COLUMN so.soilbody_geom.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.soilbody_geom.idsoilbody IS 'Foreign key to the SoilBody table, guidkey field.';
COMMENT ON COLUMN so.soilbody_geom.geom IS 'Geometry';




/* "
██████  ███████ ██████  ██ ██    ██ ███████ ██████  ██████  ██████   ██████  ███████ ██ ██      ███████ ██████  ██████  ███████ ███████ ███████ ███    ██  ██████ ███████ ██ ███    ██ ███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██ 
██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      ██   ██ ██   ██ ██      ██      ██      ████   ██ ██      ██      ██ ████   ██ ██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██  
██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ ██████  ██████  ██    ██ █████   ██ ██      █████   ██████  ██████  █████   ███████ █████   ██ ██  ██ ██      █████   ██ ██ ██  ██ ███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████   
██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██      ██   ██ ██    ██ ██      ██ ██      ██      ██      ██   ██ ██           ██ ██      ██  ██ ██ ██      ██      ██ ██  ██ ██      ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██    
██████  ███████ ██   ██ ██   ████   ███████ ██████  ██      ██   ██  ██████  ██      ██ ███████ ███████ ██      ██   ██ ███████ ███████ ███████ ██   ████  ██████ ███████ ██ ██   ████ ███████  ██████  ██ ███████ ██████   ██████  ██████     ██    
 */

CREATE TABLE so.derivedprofilepresenceinsoilbody (
    --id SERIAL PRIMARY KEY,
    idsoilbody UUID NOT NULL,
    idsoilprofile UUID NOT NULL,
    lowervalue REAL,
    uppervalue REAL,
    CONSTRAINT unicrelationdpsb PRIMARY KEY (idsoilbody, idsoilprofile),
    FOREIGN KEY (idsoilbody) REFERENCES so.soilbody (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idsoilprofile) REFERENCES so.soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON TABLE so.derivedprofilepresenceinsoilbody IS 'Indicates the percentages (lower and upper boundary) that the derived profile takes part in the Soil body.';
-- Add Comment Column
--COMMENT ON COLUMN derivedprofilepresenceinsoilbody.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.derivedprofilepresenceinsoilbody.idsoilbody IS 'Foreign key to the SoilBody table, guidkey field.';
COMMENT ON COLUMN so.derivedprofilepresenceinsoilbody.idsoilprofile IS 'Foreign key to the SoilProfile table, guidkey field.';
COMMENT ON COLUMN so.derivedprofilepresenceinsoilbody.lowervalue IS 'Upper value.';
COMMENT ON COLUMN so.derivedprofilepresenceinsoilbody.uppervalue IS 'Lower value'; 


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_lowervaluesum()
RETURNS TRIGGER AS $$
DECLARE
    total_lowervalue INTEGER;
BEGIN
    SELECT SUM(lowervalue) INTO total_lowervalue FROM derivedprofilepresenceinsoilbody WHERE idsoilbody = NEW.idsoilbody;
    
    IF total_lowervalue + NEW.lowervalue > 100 THEN
        RAISE EXCEPTION 'Table derivedprofilepresenceinsoilbody: sum of lowervalue exceeds 100 for the same idsoilbody';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER i_cecklowervaluesum
BEFORE INSERT OR UPDATE ON so.derivedprofilepresenceinsoilbody
FOR EACH ROW
EXECUTE FUNCTION so.check_lowervaluesum();

CREATE OR REPLACE FUNCTION so.check_isderived_soilbody()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM soilprofile WHERE guidkey = NEW.idsoilprofile AND isderived = 1) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Table derivedprofilepresenceinsoilbody: Attention, the value of the "idsoilprofile" field cannot be inserted because profile is not of type derived';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER i_checkisderived_soilbody
BEFORE INSERT OR UPDATE ON so.derivedprofilepresenceinsoilbody
FOR EACH ROW
EXECUTE FUNCTION so.check_isderived_soilbody();



/* 
███████  ██████  ██ ██      ██████  ███████ ██████  ██ ██    ██ ███████ ██████   ██████  ██████       ██ ███████  ██████ ████████ 
██      ██    ██ ██ ██      ██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██    ██ ██   ██      ██ ██      ██         ██    
███████ ██    ██ ██ ██      ██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ ██    ██ ██████       ██ █████   ██         ██    
     ██ ██    ██ ██ ██      ██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██         ██    
███████  ██████  ██ ███████ ██████  ███████ ██   ██ ██   ████   ███████ ██████   ██████  ██████   █████  ███████  ██████    ██    
 */

CREATE TABLE so.soilderivedobject
(
    --id SERIAL PRIMARY KEY, 
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT,
    accessuri TEXT,
    geometry GEOMETRY(POLYGON, 3035) NOT NULL
    --geometry geometry(POLYGON) --envelop
);

-- Add Geometry Column
-- SELECT AddGeometryColumn('public', 'soilderivedobject', 'geometry', 3035, 'POLYGON', 2);


COMMENT ON TABLE so.soilderivedobject IS 'A spatial object type for representing spatial objects with soil-related property derived from one or more soil and possibly other non soil properties.';
-- Add Comment Column
-- COMMENT ON COLUMN soilderivedobject.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.soilderivedobject.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.soilderivedobject.inspireid_localid IS 'A local identifier, assigned by the data provider. The local identifier is unique within the namespace, that is no other spatial object carries the same unique identifier.';
COMMENT ON COLUMN so.soilderivedobject.inspireid_namespace IS 'Namespace uniquely identifying the data source of the spatial object.';
COMMENT ON COLUMN so.soilderivedobject.inspireid_versionid IS 'The identifier of the particular version of the spatial object, with a maximum length of 25 characters. If the specification of a spatial object type with an external object identifier includes life-cycle information, the version identifier is used to distinguish between the different versions of a spatial object. Within the set of all versions of a spatial object, the version identifier is unique.';
COMMENT ON COLUMN so.soilderivedobject.accessuri IS 'SoilDerivedObject URI';
COMMENT ON COLUMN so.soilderivedobject.geometry IS 'Geometry'; 



/* 
██ ███████ ██████   █████  ███████ ███████ ██████   ██████  ███    ██  ██████  ██████  ███████ ███████ ██████  ██    ██ ███████ ██████  ███████  ██████  ██ ██      ██████  ██████   ██████  ███████ ██ ██      ███████ 
██ ██      ██   ██ ██   ██ ██      ██      ██   ██ ██    ██ ████   ██ ██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██      ██   ██ ██      ██    ██ ██ ██      ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      
██ ███████ ██████  ███████ ███████ █████   ██   ██ ██    ██ ██ ██  ██ ██    ██ ██████  ███████ █████   ██████  ██    ██ █████   ██   ██ ███████ ██    ██ ██ ██      ██████  ██████  ██    ██ █████   ██ ██      █████   
██      ██ ██   ██ ██   ██      ██ ██      ██   ██ ██    ██ ██  ██ ██ ██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██      ██   ██      ██ ██    ██ ██ ██      ██      ██   ██ ██    ██ ██      ██ ██      ██      
██ ███████ ██████  ██   ██ ███████ ███████ ██████   ██████  ██   ████  ██████  ██████  ███████ ███████ ██   ██   ████   ███████ ██████  ███████  ██████  ██ ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████
 */

CREATE TABLE so.isbasedonobservedsoilprofile 
(
  -- id SERIAL PRIMARY KEY,
  idsoilderivedobject UUID NOT NULL,
  idsoilprofile UUID NOT NULL,
  CONSTRAINT unicrelationibosp PRIMARY KEY (idsoilderivedobject, idsoilprofile),
  FOREIGN KEY (idsoilderivedobject) REFERENCES so.soilderivedobject (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idsoilprofile) REFERENCES so.soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON TABLE so.isbasedonobservedsoilprofile IS 'Table of Link to an observed soil profile on whose properties the derived value is based.';
-- Add Comment Column
-- COMMENT ON COLUMN isbasedonobservedsoilprofile.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.isbasedonobservedsoilprofile.idsoilderivedobject IS 'Foreign key to the SoilDerivedObject table, guidkey field.';
COMMENT ON COLUMN so.isbasedonobservedsoilprofile.idsoilprofile IS 'Foreign key to the SoilProfile table, guidkey field.';

-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_isobserved_dobj()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM soilprofile WHERE guidkey = NEW.idsoilprofile AND isderived = 0) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Table isbasedonobservedsoilprofile: Attention, the value of the "idsoilprofile" field cannot be inserted because profile is not of type observed';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER i_checkisobserved_dobj
BEFORE INSERT OR UPDATE ON so.isbasedonobservedsoilprofile
FOR EACH ROW
EXECUTE FUNCTION so.check_isobserved_dobj();


/* 
██ ███████ ██████   █████  ███████ ███████ ██████   ██████  ███    ██ ███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██     
██ ██      ██   ██ ██   ██ ██      ██      ██   ██ ██    ██ ████   ██ ██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██      
██ ███████ ██████  ███████ ███████ █████   ██   ██ ██    ██ ██ ██  ██ ███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████       
██      ██ ██   ██ ██   ██      ██ ██      ██   ██ ██    ██ ██  ██ ██      ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██        
██ ███████ ██████  ██   ██ ███████ ███████ ██████   ██████  ██   ████ ███████  ██████  ██ ███████ ██████   ██████  ██████     ██      
 */

CREATE TABLE so.isbasedonsoilbody
(
  -- id SERIAL PRIMARY KEY,
  idsoilderivedobject UUID NOT NULL,
  idsoilbody UUID NOT NULL,
  CONSTRAINT unicrelationibosb PRIMARY KEY (idsoilderivedobject, idsoilbody),
  FOREIGN KEY (idsoilderivedobject) REFERENCES so.soilderivedobject (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idsoilbody) REFERENCES so.soilbody (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON TABLE so.isbasedonsoilbody IS 'Table of Link to a soil body on whose properties the derived value is based.';
-- Add Comment Column
-- COMMENT ON COLUMN isbasedonsoilbody.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.isbasedonsoilbody.idsoilderivedobject IS 'Foreign key to the SoilDerivedObject table, guidkey field.';
COMMENT ON COLUMN so.isbasedonsoilbody.idsoilbody IS 'Foreign key to the SoilBody table, guidkey field.';



/* 
██ ███████ ██████   █████  ███████ ███████ ██████   ██████  ███    ██ ███████  ██████  ██ ██      ██████  ███████ ██████  ██ ██    ██ ███████ ██████   ██████  ██████       ██ ███████  ██████ ████████ 
██ ██      ██   ██ ██   ██ ██      ██      ██   ██ ██    ██ ████   ██ ██      ██    ██ ██ ██      ██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██    ██ ██   ██      ██ ██      ██         ██    
██ ███████ ██████  ███████ ███████ █████   ██   ██ ██    ██ ██ ██  ██ ███████ ██    ██ ██ ██      ██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ ██    ██ ██████       ██ █████   ██         ██    
██      ██ ██   ██ ██   ██      ██ ██      ██   ██ ██    ██ ██  ██ ██      ██ ██    ██ ██ ██      ██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██         ██    
██ ███████ ██████  ██   ██ ███████ ███████ ██████   ██████  ██   ████ ███████  ██████  ██ ███████ ██████  ███████ ██   ██ ██   ████   ███████ ██████   ██████  ██████   █████  ███████  ██████    ██    
*/   


CREATE TABLE so.isbasedonsoilderivedobject (
  -- id SERIAL PRIMARY KEY,
  base_id UUID NOT NULL,
  related_id UUID NOT NULL,
  CONSTRAINT unicrelationibosdo PRIMARY KEY (base_id, related_id),
  FOREIGN KEY (base_id) REFERENCES so.soilderivedobject (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (related_id) REFERENCES so.soilderivedobject (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);



COMMENT ON TABLE so.isbasedonsoilderivedobject IS 'Table of Link to a soil derived object on whose properties the derived value is based.';
-- Add Comment Column
-- COMMENT ON COLUMN isbasedonsoilderivedobject.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.isbasedonsoilderivedobject.base_id IS 'Foreign key to the SoilDerivedObject table, guidkey field. - Base SoilDerivedObject';
COMMENT ON COLUMN so.isbasedonsoilderivedobject.related_id IS 'Foreign key to the SoilDerivedObject table, guidkey field. - Derived SoilDerivedObject';


/* 
██████  ██████   ██████  ███████ ██ ██      ███████ ███████ ██      ███████ ███    ███ ███████ ███    ██ ████████ 
██   ██ ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ████  ████ ██      ████   ██    ██    
██████  ██████  ██    ██ █████   ██ ██      █████   █████   ██      █████   ██ ████ ██ █████   ██ ██  ██    ██    
██      ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ██  ██  ██ ██      ██  ██ ██    ██    
██      ██   ██  ██████  ██      ██ ███████ ███████ ███████ ███████ ███████ ██      ██ ███████ ██   ████    ██   
 */

CREATE TABLE so.profileelement
(
    -- id SERIAL PRIMARY KEY, 
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    inspireid_localid TEXT,      
    inspireid_namespace TEXT,     
    inspireid_versionid TEXT, 
    profileelementdepthrange_uppervalue INTEGER, 
    profileelementdepthrange_lowervalue INTEGER,  
    beginlifespanversion TIMESTAMPTZ DEFAULT current_timestamp not null, 
    endlifespanversion TIMESTAMPTZ,  

    layertype TEXT,      -- Codelist layertypevalue
    layerrocktype TEXT,      -- Codelist lithologyvalue

    layergenesisprocess TEXT,      -- Codelist eventprocessvalue  
    layergenesisenviroment TEXT,      -- Codelist eventenvironmentvalue 
    layergenesisprocessstate TEXT,      -- Codelist layergenesisprocessstatevalue

    profileelementtype BOOLEAN DEFAULT false NOT NULL,
    ispartof UUID NOT NULL,
    FOREIGN KEY (ispartof)
      REFERENCES so.soilprofile(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

COMMENT ON TABLE so.profileelement IS 'An abstract spatial object type grouping soil layers and / or horizons for functional/operational aims.';
-- Add Comment Column
-- COMMENT ON COLUMN profileelement.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.profileelement.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.profileelement.inspireid_localid IS 'A local identifier, assigned by the data provider. The local identifier is unique within the namespace, that is no other spatial object carries the same unique identifier.';
COMMENT ON COLUMN so.profileelement.inspireid_namespace IS 'Namespace uniquely identifying the data source of the spatial object.';
COMMENT ON COLUMN so.profileelement.inspireid_versionid IS 'The identifier of the particular version of the spatial object, with a maximum length of 25 characters. If the specification of a spatial object type with an external object identifier includes life-cycle information, the version identifier is used to distinguish between the different versions of a spatial object. Within the set of all versions of a spatial object, the version identifier is unique.';
COMMENT ON COLUMN so.profileelement.profileelementdepthrange_uppervalue IS 'Upper depth of the profile element (layer or horizon) measured from the surface of a soil profile (in cm)';
COMMENT ON COLUMN so.profileelement.profileelementdepthrange_lowervalue IS 'Lower depth of the profile element (layer or horizon) measured from the surface of a soil profile (in cm)';
COMMENT ON COLUMN so.profileelement.beginlifespanversion IS 'Date and time at which this version of the spatial object was inserted or changed in the spatial data set.';
COMMENT ON COLUMN so.profileelement.endlifespanversion IS 'Date and time at which this version of the spatial object was superseded or retired in the spatial data set.';
COMMENT ON COLUMN so.profileelement.layertype IS 'Assignation of a layer according to the concept that fits its kind.';
COMMENT ON COLUMN so.profileelement.layerrocktype IS 'Type of the material in which the layer developed.';
COMMENT ON COLUMN so.profileelement.layergenesisprocess IS 'Last non-pedogenic process (geologic or anthropogenic) that coined the material composition and internal structure of the layer.';
COMMENT ON COLUMN so.profileelement.layergenesisenviroment IS 'Setting in which the last non-pedogenic process (geologic or anthropogenic) that coined the material composition and internal structure of the layer took place.';
COMMENT ON COLUMN so.profileelement.layergenesisprocessstate IS 'Indication whether the process specified in layerGenesisProcess is on-going or seized in the past.';
COMMENT ON COLUMN so.profileelement.profileelementtype IS 'Boolean value to indicate whether the record is of Horizon or Layer type';
COMMENT ON COLUMN so.profileelement.ispartof IS 'Foreign key to the SoilProfile table, guidkey field.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_valid_version_profileelement()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.beginlifespanversion > NEW.endlifespanversion THEN
        RAISE EXCEPTION 'Table profileelement: beginlifespanversion must be less than endlifespanversion';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidversionprofileelement
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_version_profileelement();

CREATE OR REPLACE FUNCTION so.check_valid_deepprofileelement()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.profileelementdepthrange_lowervalue >= NEW.profileelementdepthrange_uppervalue THEN
        RAISE EXCEPTION 'Table profileelement: profileelementdepthrange_uppervalue must be greater than profileelementdepthrange_lowervalue';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvaliddeepprofileelement
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_deepprofileelement();


CREATE OR REPLACE FUNCTION so.check_geogenic_fields_not_null()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.layertype <> 'http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic' THEN
        IF NEW.layerrocktype IS NOT NULL THEN
            RAISE EXCEPTION 'layerrocktype must be NULL when LayerTypeValue is not "geogenic".';
        ELSIF NEW.layergenesisprocess IS NOT NULL THEN
            RAISE EXCEPTION 'layergenesisprocess must be NULL when LayerTypeValue is not "geogenic".';
        ELSIF NEW.layergenesisenviroment IS NOT NULL THEN
            RAISE EXCEPTION 'layergenesisenviroment must be NULL when LayerTypeValue is not "geogenic".';
        ELSIF NEW.layergenesisprocessstate IS NOT NULL THEN
            RAISE EXCEPTION 'layergenesisprocessstate must be NULL when LayerTypeValue is not "geogenic".';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER checkgeogenicfieldsnotnull
BEFORE INSERT ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_geogenic_fields_not_null();



CREATE OR REPLACE FUNCTION so.check_horizon_fields()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.profileelementtype = 0 THEN
        IF NEW.layertype IS NOT NULL THEN
            RAISE EXCEPTION 'layertype must be NULL when profileelementtype is "HORIZON".';
        END IF;
        IF NEW.layerrocktype IS NOT NULL THEN
            RAISE EXCEPTION 'layerrocktype must be NULL when profileelementtype is "HORIZON".';
        END IF;
        IF NEW.layergenesisprocess IS NOT NULL THEN
            RAISE EXCEPTION 'layergenesisprocess must be NULL when profileelementtype is "HORIZON".';
        END IF;
        IF NEW.layergenesisenviroment IS NOT NULL THEN
            RAISE EXCEPTION 'layergenesisenviroment must be NULL when profileelementtype is "HORIZON".';
        END IF;
        IF NEW.layergenesisprocessstate IS NOT NULL THEN
            RAISE EXCEPTION 'layergenesisprocessstate must be NULL when profileelementtype is "HORIZON".';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckhorizonfields
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_horizon_fields();


CREATE OR REPLACE FUNCTION so.check_layertype()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.layertype AND collection = 'LayerTypeValue') THEN
        RAISE EXCEPTION 'Table profileelement: Invalid value for layertype. Must be present in id of layertypevalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER layertype
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_layertype();


CREATE OR REPLACE FUNCTION so.check_layergenesisenviroment()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.layergenesisenviroment IS NOT NULL AND NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.layergenesisenviroment AND collection = 'EventEnvironmentValue') THEN
        RAISE EXCEPTION 'Table profileelement: Invalid value for layergenesisenviroment. Must be present in id of eventenvironmentvalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER layergenesisenviroment
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_layergenesisenviroment();

CREATE OR REPLACE FUNCTION so.check_layergenesisprocess()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.layergenesisprocess IS NOT NULL AND NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.layergenesisprocess AND collection = 'EventProcessValue') THEN
        RAISE EXCEPTION 'Table profileelement: Invalid value for layergenesisprocess. Must be present in id of eventprocessvalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER layergenesisprocess
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_layergenesisprocess();


CREATE OR REPLACE FUNCTION so.check_layergenesisprocessstate()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.layergenesisprocessstate IS NOT NULL AND NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.layergenesisprocessstate AND collection = 'LayerGenesisProcessStateValue') THEN
        RAISE EXCEPTION 'Table profileelement: Invalid value for layergenesisprocessstate. Must be present in id of layergenesisprocessstatevalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER layergenesisprocessstate
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_layergenesisprocessstate();


CREATE OR REPLACE FUNCTION so.check_layerrocktype()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.layerrocktype IS NOT NULL AND NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.layerrocktype AND collection = 'LithologyValue') THEN
        RAISE EXCEPTION 'Table profileelement: Invalid value for layerrocktype. Must be present in id of lithologyvalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER layerrocktype
BEFORE INSERT OR UPDATE ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_layerrocktype();


CREATE OR REPLACE FUNCTION so.check_depth_range_function() 
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.profileelementdepthrange_uppervalue IS NULL AND NEW.profileelementdepthrange_lowervalue IS NULL) THEN
        RAISE EXCEPTION 'At least one of profileelementdepthrange_uppervalue and profileelementdepthrange_lowervalue must not be null';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_depth_range
BEFORE INSERT OR UPDATE ON  so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_depth_range_function();


CREATE OR REPLACE FUNCTION so.u_begin_today_profileelement()
RETURNS TRIGGER AS
$$
BEGIN
    IF (current_timestamp < NEW.endlifespanversion OR NEW.endlifespanversion IS NULL) THEN
        UPDATE profileelement
        SET beginlifespanversion = to_char(current_timestamp, 'YYYY-MM-DD"T"HH24:MI:SS.US"Z"')
        WHERE guidkey = NEW.guidkey;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_profileelement
AFTER UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, profileelementdepthrange_uppervalue, profileelementdepthrange_lowervalue, endlifespanversion, layertype, layerrocktype, layergenesisprocess, layergenesisenviroment, layergenesisprocessstate, profileelementtype
ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.u_begin_today_profileelement();

CREATE OR REPLACE FUNCTION so.u_begin_today_profileelement_error()
RETURNS TRIGGER AS
$$
BEGIN
    IF (current_timestamp > NEW.endlifespanversion OR NEW.endlifespanversion IS NULL) THEN
        RAISE EXCEPTION 'If you change record endlifespanversion must be greater than today';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER begin_today_profileelement_error
AFTER UPDATE OF inspireid_localid, inspireid_namespace, inspireid_versionid, profileelementdepthrange_uppervalue, profileelementdepthrange_lowervalue, endlifespanversion, layertype, layerrocktype, layergenesisprocess, layergenesisenviroment, layergenesisprocessstate, profileelementtype
ON so.profileelement
FOR EACH ROW
EXECUTE FUNCTION so.u_begin_today_profileelement_error();








/* 
██████   █████  ██████  ████████ ██  ██████ ██      ███████ ███████ ██ ███████ ███████ ███████ ██████   █████   ██████ ████████ ██  ██████  ███    ██ ████████ ██    ██ ██████  ███████ 
██   ██ ██   ██ ██   ██    ██    ██ ██      ██      ██      ██      ██    ███  ██      ██      ██   ██ ██   ██ ██         ██    ██ ██    ██ ████   ██    ██     ██  ██  ██   ██ ██      
██████  ███████ ██████     ██    ██ ██      ██      █████   ███████ ██   ███   █████   █████   ██████  ███████ ██         ██    ██ ██    ██ ██ ██  ██    ██      ████   ██████  █████   
██      ██   ██ ██   ██    ██    ██ ██      ██      ██           ██ ██  ███    ██      ██      ██   ██ ██   ██ ██         ██    ██ ██    ██ ██  ██ ██    ██       ██    ██      ██      
██      ██   ██ ██   ██    ██    ██  ██████ ███████ ███████ ███████ ██ ███████ ███████ ██      ██   ██ ██   ██  ██████    ██    ██  ██████  ██   ████    ██       ██    ██      ███████
 */

CREATE TABLE so.particlesizefractiontype
(
    id SERIAL PRIMARY KEY, 
    fractioncontent REAL NOT NULL, 
    pariclesize_min REAL NOT NULL, 
    pariclesize_max REAL NOT NULL, 
    idprofileelement UUID NOT NULL,
    FOREIGN KEY (idprofileelement)
      REFERENCES so.profileelement(guidkey) 
      ON DELETE CASCADE 
      ON UPDATE CASCADE

);


COMMENT ON TABLE so.particlesizefractiontype IS 'Share of the soil that is composed of mineral soil particles of the size within the size range specified.';
-- Add Comment Column
COMMENT ON COLUMN so.particlesizefractiontype.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.particlesizefractiontype.fractioncontent IS 'Percentage of the defined fraction.';
COMMENT ON COLUMN so.particlesizefractiontype.pariclesize_min IS 'Upper limit of the particle size of the defined fraction (expressed in µm)';
COMMENT ON COLUMN so.particlesizefractiontype.pariclesize_max IS 'Lower limit of the particle size of the defined fraction (expressed in µm)';
COMMENT ON COLUMN so.particlesizefractiontype.idprofileelement IS 'Foreign key to the ProfileElement table, guidkey field.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_fraction_sum()
RETURNS TRIGGER AS $$
DECLARE
    total_fraction NUMERIC;
BEGIN
    -- Calcola la somma di fractioncontent esistente più il nuovo valore
    SELECT ROUND(SUM(fractioncontent), 1) + ROUND(NEW.fractioncontent, 1)
    INTO total_fraction
    FROM particlesizefractiontype
    WHERE idprofileelement = NEW.idprofileelement;

    -- Controlla se la somma supera 100
    IF total_fraction > 100 THEN
        RAISE EXCEPTION 'The sum of fractioncontent for idprofileelement cannot exceed 100';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER i_check_fraction_sum
BEFORE INSERT ON so.particlesizefractiontype
FOR EACH ROW
EXECUTE FUNCTION so.check_fraction_sum();



/* 
███████  █████   ██████  ██   ██  ██████  ██████  ██ ███████  ██████  ███    ██ ███    ██  ██████  ████████  █████  ████████ ██  ██████  ███    ██ ████████ ██    ██ ██████  ███████ 
██      ██   ██ ██    ██ ██   ██ ██    ██ ██   ██ ██    ███  ██    ██ ████   ██ ████   ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ████   ██    ██     ██  ██  ██   ██ ██      
█████   ███████ ██    ██ ███████ ██    ██ ██████  ██   ███   ██    ██ ██ ██  ██ ██ ██  ██ ██    ██    ██    ███████    ██    ██ ██    ██ ██ ██  ██    ██      ████   ██████  █████   
██      ██   ██ ██    ██ ██   ██ ██    ██ ██   ██ ██  ███    ██    ██ ██  ██ ██ ██  ██ ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ██  ██ ██    ██       ██    ██      ██      
██      ██   ██  ██████  ██   ██  ██████  ██   ██ ██ ███████  ██████  ██   ████ ██   ████  ██████     ██    ██   ██    ██    ██  ██████  ██   ████    ██       ██    ██      ███████ 
 */

CREATE TABLE so.faohorizonnotationtype
(
    id SERIAL PRIMARY KEY, 
    faohorizondiscontinuity INTEGER, 
    faohorizonmaster_1 TEXT NOT NULL, -- Codelist faohorizonmastervalue
    faohorizonmaster_2 TEXT, -- Codelist faohorizonmastervalue
    faohorizonsubordinate_1 TEXT, -- Codelist faohorizonsubordinatevalue
    faohorizonsubordinate_2 TEXT, -- Codelist faohorizonsubordinatevalue
    faohorizonsubordinate_3 TEXT, -- Codelist faohorizonsubordinatevalue
    faohorizonverical INTEGER,
    faoprime TEXT NOT NULL,  -- Codelist faoprimevalue
    isoriginalclassification BOOLEAN DEFAULT false NOT NULL,
    idprofileelement UUID UNIQUE, 
    FOREIGN KEY (idprofileelement) 
      REFERENCES so.profileelement(guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON TABLE so.faohorizonnotationtype IS 'A classification of a horizon according to the Horizon classification system specified in Guidelines for soil description, 4th edition, Food and Agriculture Organization of the United Nations, Rome, 2006.';
-- Add Comment Column
COMMENT ON COLUMN so.faohorizonnotationtype.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.faohorizonnotationtype.faohorizondiscontinuity IS 'Number used to indicate a discontinuity in the horizon notation.';
COMMENT ON COLUMN so.faohorizonnotationtype.faohorizonmaster_1 IS 'First Symbol of the master part of the horizon notation.';
COMMENT ON COLUMN so.faohorizonnotationtype.faohorizonmaster_2 IS 'Second Symbol of the master part of the horizon notation.';
COMMENT ON COLUMN so.faohorizonnotationtype.faohorizonsubordinate_1 IS 'First Designations of subordinate distinctions and features within the master horizons and layers are based on profile characteristics observable in the field and are applied during the description of the soil at the site.';
COMMENT ON COLUMN so.faohorizonnotationtype.faohorizonsubordinate_2 IS 'Second Designations of subordinate distinctions and features within the master horizons and layers are based on profile characteristics observable in the field and are applied during the description of the soil at the site.';
COMMENT ON COLUMN so.faohorizonnotationtype.faohorizonsubordinate_3 IS 'Third Designations of subordinate distinctions and features within the master horizons and layers are based on profile characteristics observable in the field and are applied during the description of the soil at the site.';
COMMENT ON COLUMN so.faohorizonnotationtype.faohorizonverical IS 'Order number of the vertical subdivision in the horizon notation.';
COMMENT ON COLUMN so.faohorizonnotationtype.faoprime IS 'A prime and double prime may be used to connotate master horizon symbol of the lower of two respectively three horizons having identical Arabic-numeral prefixes and letter combinations.';
COMMENT ON COLUMN so.faohorizonnotationtype.isoriginalclassification IS 'Boolean value to indicate whether the FAO horizon notation was the original notation to describe the horizon.';
COMMENT ON COLUMN so.faohorizonnotationtype.idprofileelement IS 'Foreign key to the ProfileElement table, guidkey field.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_faoprofileelementtype()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idprofileelement IS NOT NULL THEN
        IF (SELECT profileelementtype FROM profileelement WHERE guidkey = NEW.idprofileelement) <> 1 THEN
            RAISE EXCEPTION 'Table faohorizonnotationtype: The associated profileelement must have profileelementtype = 0 (HORIZON)';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckfaoprofileelementtype
BEFORE INSERT OR UPDATE ON so.faohorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_faoprofileelementtype();


CREATE OR REPLACE FUNCTION so.check_faohorizonmaster_1()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.faohorizonmaster_1 IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.faohorizonmaster_1 AND collection = 'FAOHorizonMasterValue') THEN
            RAISE EXCEPTION 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER faohorizonmaster_1
BEFORE INSERT OR UPDATE ON so.faohorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_faohorizonmaster_1();

CREATE OR REPLACE FUNCTION so.check_faohorizonmaster_2()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.faohorizonmaster_2 IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.faohorizonmaster_2 AND collection = 'FAOHorizonMasterValue') THEN
            RAISE EXCEPTION 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER faohorizonmaster_2
BEFORE INSERT OR UPDATE ON so.faohorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_faohorizonmaster_2();


CREATE OR REPLACE FUNCTION so.check_faohorizonsubordinate_1()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.faohorizonsubordinate_1 IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.faohorizonsubordinate_1 AND collection = 'FAOHorizonSubordinateValue') THEN
            RAISE EXCEPTION 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER faohorizonsubordinate_1
BEFORE INSERT OR UPDATE ON so.faohorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_faohorizonsubordinate_1();


CREATE OR REPLACE FUNCTION so.check_faohorizonsubordinate_2()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.faohorizonsubordinate_2 IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.faohorizonsubordinate_2 AND collection = 'FAOHorizonSubordinateValue') THEN
            RAISE EXCEPTION 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER faohorizonsubordinate_2
BEFORE INSERT OR UPDATE ON so.faohorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_faohorizonsubordinate_2();



CREATE OR REPLACE FUNCTION so.check_faohorizonsubordinate_3()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.faohorizonsubordinate_3 IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.faohorizonsubordinate_3 AND collection = 'FAOHorizonSubordinateValue') THEN
            RAISE EXCEPTION 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER faohorizonsubordinate_3
BEFORE INSERT OR UPDATE ON so.faohorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_faohorizonsubordinate_3();

CREATE OR REPLACE FUNCTION so.check_faoprime()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.faoprime IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM codelist WHERE id = NEW.faoprime AND collection = 'FAOPrimeValue') THEN
            RAISE EXCEPTION 'Table faohorizonnotationtype: Invalid value for faoprime. Must be present in id of faoprimevalue codelist.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER faoprime
BEFORE INSERT OR UPDATE ON so.faohorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_faoprime();


/* 
 ██████  ████████ ██   ██ ███████ ██████  ██   ██  ██████  ██████  ██ ███████  ██████  ███    ██ ███    ██  ██████  ████████  █████  ████████ ██  ██████  ███    ██ ████████ ██    ██ ██████  ███████ 
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██    ███  ██    ██ ████   ██ ████   ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ████   ██    ██     ██  ██  ██   ██ ██      
██    ██    ██    ███████ █████   ██████  ███████ ██    ██ ██████  ██   ███   ██    ██ ██ ██  ██ ██ ██  ██ ██    ██    ██    ███████    ██    ██ ██    ██ ██ ██  ██    ██      ████   ██████  █████   
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██  ███    ██    ██ ██  ██ ██ ██  ██ ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ██  ██ ██    ██       ██    ██      ██      
 ██████     ██    ██   ██ ███████ ██   ██ ██   ██  ██████  ██   ██ ██ ███████  ██████  ██   ████ ██   ████  ██████     ██    ██   ██    ██    ██  ██████  ██   ████    ██       ██    ██      ███████
 */

CREATE TABLE so.otherhorizonnotationtype
(
    -- id SERIAL PRIMARY KEY, 
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    horizonnotation TEXT NOT NULL, --Codelist otherhorizonnotationtypevalue
    diagnostichorizon TEXT, -- Codelist wrbdiagnostichorizonvalue 
    isoriginalclassification BOOLEAN DEFAULT false NOT NULL, 
    otherhorizonnotation TEXT
);

COMMENT ON TABLE so.otherhorizonnotationtype IS 'classification of a horizon according to a specific classification system.';
-- Add Comment Column
-- COMMENT ON COLUMN otherhorizonnotationtype.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.otherhorizonnotationtype.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.otherhorizonnotationtype.horizonnotation IS 'Notation characterizing the soil horizon according to a specified classification system.';
COMMENT ON COLUMN so.otherhorizonnotationtype.diagnostichorizon IS 'Codelist wrbdiagnostichorizonvalue';
COMMENT ON COLUMN so.otherhorizonnotationtype.isoriginalclassification IS 'Boolean value to indicate whether the specified horizon notation system was the original notation system to describe the horizon.';
COMMENT ON COLUMN so.otherhorizonnotationtype.otherhorizonnotation IS '';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_horizonnotation_insert()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.horizonnotation IS NOT NULL AND NEW.horizonnotation NOT IN (SELECT id FROM codelist WHERE collection = 'OtherHorizonNotationTypeValue') THEN
        RAISE EXCEPTION 'Invalid value for horizonnotation in table otherhorizonnotationtype. Must be present in id of otherhorizonnotationtypevalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER otherhorizonnotationtype
BEFORE INSERT OR UPDATE ON so.otherhorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_horizonnotation_insert();


CREATE OR REPLACE FUNCTION so.check_diagnostichorizon_insert()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.diagnostichorizon IS NOT NULL AND NEW.diagnostichorizon NOT IN (SELECT id FROM codelist WHERE collection = NEW.horizonnotation) THEN
        RAISE EXCEPTION 'Invalid value for diagnostichorizon in table otherhorizonnotationtype. Must be present in the relativecodelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER diagnostichorizon
BEFORE INSERT OR UPDATE ON  so.otherhorizonnotationtype
FOR EACH ROW
EXECUTE FUNCTION so.check_diagnostichorizon_insert();




/*
 ██████  ████████ ██   ██ ███████ ██████  ██   ██  ██████  ██████  ██ ███████  ██████  ███    ██         ██████  ██████   ██████  ███████ ██ ██      ███████ ███████ ██      ███████ ███    ███ ███████ ███    ██ ████████ 
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██    ███  ██    ██ ████   ██         ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ████  ████ ██      ████   ██    ██    
██    ██    ██    ███████ █████   ██████  ███████ ██    ██ ██████  ██   ███   ██    ██ ██ ██  ██         ██████  ██████  ██    ██ █████   ██ ██      █████   █████   ██      █████   ██ ████ ██ █████   ██ ██  ██    ██    
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██  ███    ██    ██ ██  ██ ██         ██      ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ██  ██  ██ ██      ██  ██ ██    ██    
 ██████     ██    ██   ██ ███████ ██   ██ ██   ██  ██████  ██   ██ ██ ███████  ██████  ██   ████ ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████ ███████ ███████ ███████ ██      ██ ███████ ██   ████    ██    
*/

CREATE TABLE so.otherhorizon_profileelement
(
  --id SERIAL PRIMARY KEY,
  idprofileelement UUID NOT NULL,
  idotherhorizonnotationtype UUID NOT NULL,
  CONSTRAINT unicrelationprooth PRIMARY KEY (idprofileelement, idotherhorizonnotationtype),
  FOREIGN KEY (idprofileelement) REFERENCES so.profileelement (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idotherhorizonnotationtype) REFERENCES so.otherhorizonnotationtype (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON TABLE so.otherhorizon_profileelement IS 'Table of Link between OtherHorizonNotationType and ProfilEelement.';
-- Add Comment Column
--COMMENT ON COLUMN otherhorizon_profileelement.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.otherhorizon_profileelement.idprofileelement IS 'Foreign key to the ProfileElement table, guidkey field.';
COMMENT ON COLUMN so.otherhorizon_profileelement.idotherhorizonnotationtype IS 'Foreign key to the OtherhorizonNotationType table, guidkey field.';

-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_otherhorizon_profileelement_profileelementtype()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT profileelementtype FROM profileelement WHERE guidkey = NEW.idprofileelement) = 1 THEN
        RAISE EXCEPTION 'Table otherhorizon_profileelement: The associated profileelement must have profileelementtype = 0 (HORIZON)';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckothprofileelementtype
BEFORE INSERT OR UPDATE ON so.otherhorizon_profileelement
FOR EACH ROW
EXECUTE FUNCTION so.check_otherhorizon_profileelement_profileelementtype();


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 
██     ██ ██████  ██████   ██████  ██    ██  █████  ██      ██ ███████ ██ ███████ ██████   ██████  ██████   ██████  ██    ██ ██████  ████████ ██    ██ ██████  ███████ 
██     ██ ██   ██ ██   ██ ██    ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██       ██   ██ ██    ██ ██    ██ ██   ██    ██     ██  ██  ██   ██ ██      
██  █  ██ ██████  ██████  ██    ██ ██    ██ ███████ ██      ██ █████   ██ █████   ██████  ██   ███ ██████  ██    ██ ██    ██ ██████     ██      ████   ██████  █████   
██ ███ ██ ██   ██ ██   ██ ██ ▄▄ ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██    ██ ██   ██ ██    ██ ██    ██ ██         ██       ██    ██      ██      
 ███ ███  ██   ██ ██████   ██████   ██████  ██   ██ ███████ ██ ██      ██ ███████ ██   ██  ██████  ██   ██  ██████   ██████  ██         ██       ██    ██      ███████ 
 */

CREATE TABLE so.wrbqualifiergrouptype 
(
    --id SERIAL PRIMARY KEY, 
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	wrbversion TEXT NOT NULL DEFAULT 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue',
    qualifierplace TEXT NOT NULL, -- Codelist wrbqualifierplacevalue
    wrbqualifier TEXT NOT NULL,  --Codelist wrbqualifiervalue 
    wrbspecifier_1 TEXT,    -- Codelist wrbspecifiervalue
    wrbspecifier_2 TEXT,    -- Codelist wrbspecifiervalue
    UNIQUE (wrbversion, qualifierplace, wrbqualifier, wrbspecifier_1, wrbspecifier_2)
);



COMMENT ON TABLE so.wrbqualifiergrouptype IS 'A data type to define the group of a qualifier and its possible specifier(s), its place and position with regard to the World Reference Base (WRB) Reference Soil Group (RSG) it belongs to according to World reference base for soil resources 2006, first update 2007, World Soil Resources Reports No. 103, Food and Agriculture Organization of the United Nations, Rome, 2007';
-- Add Comment Column
--COMMENT ON COLUMN wrbqualifiergrouptype.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.wrbqualifiergrouptype.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.wrbqualifiergrouptype.qualifierplace IS 'Attribute to indicate the placement of the Qualifier with regard to the WRB reference soil group (RSG). The placement can be in front of the RSG i.e. prefix or it can be behind the RSG i.e. suffix.';
COMMENT ON COLUMN so.wrbqualifiergrouptype.wrbqualifier IS 'Name element of WRB, 2nd level of classification';
COMMENT ON COLUMN so.wrbqualifiergrouptype.wrbspecifier_1 IS 'Code that indicates the degree of expression of a qualifier or the depth range of which the qualifier applies.';
COMMENT ON COLUMN so.wrbqualifiergrouptype.wrbspecifier_2 IS 'Code that indicates the degree of expression of a qualifier or the depth range of which the qualifier applies.';
COMMENT ON COLUMN so.wrbqualifiergrouptype.wrbversion IS 'Indicates the WRB classification version.';

-- Trigger and Function -------------------------------------------------------------------------------------------------
/*
CREATE OR REPLACE FUNCTION check_wrbqualifiergrouptype_wrbqualifier()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue' AND id = NEW.wrbqualifier) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for wrbqualifier. Must be present in id of wrbqualifiervalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER wrbqualifier
BEFORE INSERT OR UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION check_wrbqualifiergrouptype_wrbqualifier();
*/

CREATE OR REPLACE FUNCTION so.check_wrbqualifiergrouptype_wrbqualifier()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue') AND NEW.wrbqualifier IS NOT NULL) OR
        (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue2014') AND NEW.wrbqualifier IS NOT NULL) OR
        (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue2022') AND NEW.wrbqualifier IS NOT NULL)
    ) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbqualifier
BEFORE INSERT OR UPDATE ON so.wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION so.check_wrbqualifiergrouptype_wrbqualifier();


CREATE OR REPLACE FUNCTION so.check_qualifierplace_wrbqualifiergrouptype()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT id FROM codelist WHERE collection = 'WRBQualifierPlaceValue' AND id = NEW.qualifierplace) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for qualifierplace. Must be present in id of wrbqualifierplacevalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER qualifierplace
BEFORE INSERT OR UPDATE ON so.wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION so.check_qualifierplace_wrbqualifiergrouptype();



CREATE OR REPLACE FUNCTION so.check_wrbspecifier_1_wrbqualifiergrouptype()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue') AND NEW.wrbspecifier_1 IS NOT NULL) OR
        (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2014') AND NEW.wrbspecifier_1 IS NOT NULL) OR
        (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2022') AND NEW.wrbspecifier_1 IS NOT NULL)
    ) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbspecifier_1
BEFORE INSERT OR UPDATE ON so.wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION so.check_wrbspecifier_1_wrbqualifiergrouptype();



/*
CREATE OR REPLACE FUNCTION check_wrbspecifier_1_wrbqualifiergrouptype()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue' AND id = NEW.wrbspecifier_1) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for wrbspecifier_1. Must be present in id of wrbspecifiervalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbspecifier_1
BEFORE INSERT OR UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION check_wrbspecifier_1_wrbqualifiergrouptype();
*/

CREATE OR REPLACE FUNCTION so.check_wrbspecifier_2_wrbqualifiergrouptype()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue') AND NEW.wrbspecifier_2 IS NOT NULL) OR
        (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2014') AND NEW.wrbspecifier_2 IS NOT NULL) OR
        (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2022') AND NEW.wrbspecifier_2 IS NOT NULL)
    ) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbspecifier_2
BEFORE INSERT OR UPDATE ON so.wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION so.check_wrbspecifier_2_wrbqualifiergrouptype();


/*
CREATE OR REPLACE FUNCTION check_wrbspecifier_2_wrbqualifiergrouptype()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue' AND id = NEW.wrbspecifier_2) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for wrbspecifier_2. Must be present in id of wrbspecifiervalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbspecifier_2
BEFORE INSERT OR UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION check_wrbspecifier_2_wrbqualifiergrouptype();
*/


CREATE OR REPLACE FUNCTION so.validate_wrbversion_gt()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.wrbversion NOT IN (SELECT id FROM codelist WHERE collection = 'wrbversion') AND NEW.wrbversion IS NOT NULL) THEN
        RAISE EXCEPTION 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of wrbreferencesoilgroupvalue codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_wrbversion_gt
BEFORE INSERT OR UPDATE ON so.wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION so.validate_wrbversion_gt();

CREATE OR REPLACE FUNCTION so.check_unique_wrbqualifiergrouptype()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se esiste una riga con gli stessi valori
    IF EXISTS (
        SELECT 1
        FROM wrbqualifiergrouptype
        WHERE wrbversion = NEW.wrbversion
          AND qualifierplace = NEW.qualifierplace
          AND wrbqualifier = NEW.wrbqualifier
          AND (wrbspecifier_1 = NEW.wrbspecifier_1 OR (wrbspecifier_1 IS NULL AND NEW.wrbspecifier_1 IS NULL))
          AND (wrbspecifier_2 = NEW.wrbspecifier_2 OR (wrbspecifier_2 IS NULL AND NEW.wrbspecifier_2 IS NULL))
    ) THEN
        -- Solleva un'eccezione se viene trovato un duplicato
        RAISE EXCEPTION 'Duplicate entry found for wrbversion, qualifierplace, wrbqualifier, wrbspecifier_1, wrbspecifier_2.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER unique_wrbqualifiergrouptype
BEFORE INSERT OR UPDATE ON so.wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION so.check_unique_wrbqualifiergrouptype();


CREATE OR REPLACE FUNCTION so.check_specifiers_not_equal()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.wrbspecifier_1 = NEW.wrbspecifier_2 THEN
        RAISE EXCEPTION 'wrbspecifier_1 and wrbspecifier_2 must not be equal';
    END IF;

    IF NEW.wrbspecifier_2 IS NOT NULL AND NEW.wrbspecifier_1 IS NULL THEN
        RAISE EXCEPTION 'wrbspecifier_1 must not be NULL when wrbspecifier_2 is not NULL';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER specifiers_not_equal
BEFORE INSERT OR UPDATE ON so.wrbqualifiergrouptype
FOR EACH ROW
EXECUTE FUNCTION so.check_specifiers_not_equal();




/*
██     ██ ██████  ██████   ██████  ██    ██  █████  ██      ██ ███████ ██ ███████ ██████   ██████  ██████   ██████  ██    ██ ██████          ██████  ██████   ██████  ███████ ██ ██      ███████ 
██     ██ ██   ██ ██   ██ ██    ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██       ██   ██ ██    ██ ██    ██ ██   ██         ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      
██  █  ██ ██████  ██████  ██    ██ ██    ██ ███████ ██      ██ █████   ██ █████   ██████  ██   ███ ██████  ██    ██ ██    ██ ██████          ██████  ██████  ██    ██ █████   ██ ██      █████   
██ ███ ██ ██   ██ ██   ██ ██ ▄▄ ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██    ██ ██   ██ ██    ██ ██    ██ ██              ██      ██   ██ ██    ██ ██      ██ ██      ██      
 ███ ███  ██   ██ ██████   ██████   ██████  ██   ██ ███████ ██ ██      ██ ███████ ██   ██  ██████  ██   ██  ██████   ██████  ██      ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████ 
*/


CREATE TABLE so.wrbqualifiergroup_profile
(
  --id SERIAL PRIMARY KEY,
  idsoilprofile UUID NOT NULL,
  idwrbqualifiergrouptype UUID NOT NULL,
  qualifierposition INTEGER NOT NULL,
  CONSTRAINT unicrelationspwbr PRIMARY KEY (idsoilprofile, idwrbqualifiergrouptype),
  FOREIGN KEY (idsoilprofile) REFERENCES so.soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idwrbqualifiergrouptype) REFERENCES so.wrbqualifiergrouptype (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON TABLE so.wrbqualifiergroup_profile IS 'Table of Link between WrbQualifierGroupType and SoilProfile.';
-- Add Comment Column
-- COMMENT ON COLUMN wrbqualifiergroup_profile.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.wrbqualifiergroup_profile.idsoilprofile IS 'Foreign key to the SaoilProfile table, guidkey field.';
COMMENT ON COLUMN so.wrbqualifiergroup_profile.idwrbqualifiergrouptype IS 'Foreign key to the WrbqualifierGroupType table, guidkey field.';
COMMENT ON COLUMN so.wrbqualifiergroup_profile.qualifierposition IS 'Number to indicate the position of a qualifier with regard to the WRB reference soil group (RSG) it belongs to and with regard to its placement to that (RSG) i.e. as a prefix or a suffix.';

-- Trigger and Function -------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION so.check_wrbversion_match()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        (SELECT wrbversion FROM soilprofile WHERE guidkey = NEW.idsoilprofile) <>
        (SELECT wrbversion FROM wrbqualifiergrouptype WHERE guidkey = NEW.idwrbqualifiergrouptype)
    ) THEN
        RAISE EXCEPTION 'Mismatch in wrbversion values.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wrbversion_match
BEFORE INSERT OR UPDATE ON so.wrbqualifiergroup_profile
FOR EACH ROW
EXECUTE FUNCTION so.check_wrbversion_match();


CREATE OR REPLACE FUNCTION so.check_qualifier_position_unique()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM wrbqualifiergroup_profile wp
        JOIN wrbqualifiergrouptype wt ON wp.idwrbqualifiergrouptype = wt.guidkey
        WHERE wp.idsoilprofile = NEW.idsoilprofile
          AND wp.qualifierposition = NEW.qualifierposition
          AND wt.qualifierplace = (
              SELECT qualifierplace
              FROM wrbqualifiergrouptype
              WHERE guidkey = NEW.idwrbqualifiergrouptype
          )
          AND (wp.idsoilprofile, wp.idwrbqualifiergrouptype) != (NEW.idsoilprofile, NEW.idwrbqualifiergrouptype)
    ) THEN
        RAISE EXCEPTION 'qualifierposition must be unique for each qualifierplace within the same soilprofile';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER qualifier_position_unique
BEFORE INSERT OR UPDATE ON so.wrbqualifiergroup_profile
FOR EACH ROW
EXECUTE FUNCTION so.check_qualifier_position_unique();




/* 
████████ ██   ██ ██ ███    ██  ██████  
   ██    ██   ██ ██ ████   ██ ██       
   ██    ███████ ██ ██ ██  ██ ██   ███ 
   ██    ██   ██ ██ ██  ██ ██ ██    ██ 
   ██    ██   ██ ██ ██   ████  ██████  
 */

CREATE TABLE so.thing 
(
  -- id SERIAL PRIMARY KEY,
  guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL, 
  description TEXT NOT NULL, 
  properties BYTEA 
);


COMMENT ON TABLE so.thing IS 'Object containing the sensor(s) producing the datae.';
-- Add Comment Column
-- COMMENT ON COLUMN thing.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.thing.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.thing.name IS 'Name of the object containing the sensor(s) producing the data';
COMMENT ON COLUMN so.thing.description IS 'Description of the object contains the sensor(s) that produce the data';
COMMENT ON COLUMN so.thing.properties IS 'File containing object properties';


/* 
██████   █████  ████████  █████  ███████ ████████ ██████  ███████  █████  ███    ███  ██████  ██████  ██      ██      ███████  ██████ ████████ ██  ██████  ███    ██ 
██   ██ ██   ██    ██    ██   ██ ██         ██    ██   ██ ██      ██   ██ ████  ████ ██      ██    ██ ██      ██      ██      ██         ██    ██ ██    ██ ████   ██ 
██   ██ ███████    ██    ███████ ███████    ██    ██████  █████   ███████ ██ ████ ██ ██      ██    ██ ██      ██      █████   ██         ██    ██ ██    ██ ██ ██  ██ 
██   ██ ██   ██    ██    ██   ██      ██    ██    ██   ██ ██      ██   ██ ██  ██  ██ ██      ██    ██ ██      ██      ██      ██         ██    ██ ██    ██ ██  ██ ██ 
██████  ██   ██    ██    ██   ██ ███████    ██    ██   ██ ███████ ██   ██ ██      ██  ██████  ██████  ███████ ███████ ███████  ██████    ██    ██  ██████  ██   ████                                                                                                                                                                    
 */

CREATE TABLE so.datastreamcollection
(
  -- id SERIAL PRIMARY KEY,
  guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT,
  description TEXT NOT NULL, 
  observedarea BYTEA,
  beginphenomenontime TIMESTAMP WITH TIME ZONE,
  endphenomenontime TIMESTAMP WITH TIME ZONE,
  beginresulttime TIMESTAMP WITH TIME ZONE, 
  endresulttime TIMESTAMP WITH TIME ZONE,
  properties BYTEA, 
  idthing UUID NOT NULL, 
  FOREIGN KEY (idthing)
      REFERENCES so.thing(guidkey)
);

COMMENT ON TABLE so.datastreamcollection IS 'Collection of Dta Stream.';
-- Add Comment Column
-- COMMENT ON COLUMN datastreamcollection.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.datastreamcollection.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.datastreamcollection.name IS 'Name of the data stream ';
COMMENT ON COLUMN so.datastreamcollection.description IS 'Description of the data stream ';
COMMENT ON COLUMN so.datastreamcollection.observedarea IS 'Data stream observation area';
COMMENT ON COLUMN so.datastreamcollection.beginphenomenontime IS 'Start of PhenomenonTime, which describes the time at which the result applies to the property of the feature of interest';
COMMENT ON COLUMN so.datastreamcollection.endphenomenontime IS 'End of PhenomenonTime, which describes the time at which the result applies to the property of the feature of interest';
COMMENT ON COLUMN so.datastreamcollection.beginresulttime IS 'Start of the resultTime, which describes when the result became available, typically when the procedure associated with the observation was completed';
COMMENT ON COLUMN so.datastreamcollection.endresulttime IS 'End of resultTime, which describes when the result became available, typically when the procedure associated with the observation was completed';
COMMENT ON COLUMN so.datastreamcollection.properties IS 'File containing object properties';
COMMENT ON COLUMN so.datastreamcollection.idthing IS 'Foreign key to the Thing table, guidkey field.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_valid_phenomenon_time()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.beginphenomenontime > NEW.endphenomenontime THEN
        RAISE EXCEPTION 'Table datastreamcollection: beginphenomenontime must be less than endphenomenontime';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER i_ceckvalidphetimedatastreamcollection
BEFORE INSERT OR UPDATE ON so.datastreamcollection
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_phenomenon_time();


CREATE OR REPLACE FUNCTION so.check_valid_result_time()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.beginresulttime > NEW.endresulttime THEN
        RAISE EXCEPTION 'Table datastreamcollection: beginresulttime must be less than endresulttime';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER i_ceckvalidrestimedatastreamcollection
BEFORE INSERT OR UPDATE ON so.datastreamcollection
FOR EACH ROW
EXECUTE FUNCTION so.check_valid_result_time();


/* 
██    ██ ███    ██ ██ ████████  ██████  ███████ ███    ███ ███████  █████  ███████ ██    ██ ██████  ███████ 
██    ██ ████   ██ ██    ██    ██    ██ ██      ████  ████ ██      ██   ██ ██      ██    ██ ██   ██ ██      
██    ██ ██ ██  ██ ██    ██    ██    ██ █████   ██ ████ ██ █████   ███████ ███████ ██    ██ ██████  █████   
██    ██ ██  ██ ██ ██    ██    ██    ██ ██      ██  ██  ██ ██      ██   ██      ██ ██    ██ ██   ██ ██      
 ██████  ██   ████ ██    ██     ██████  ██      ██      ██ ███████ ██   ██ ███████  ██████  ██   ██ ███████ 
 */

CREATE TABLE so.unitofmeasure 
(
    -- id SERIAL PRIMARY KEY,
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    uomname TEXT,
    uomsymbol TEXT,
    measuretype TEXT,
    namestandardunit TEXT,
    scaletostandardunit REAL,
    offsettostandardunit REAL,
    formula TEXT
);

COMMENT ON TABLE so.unitofmeasure IS 'Any of the systems devised to measure some physical quantity such distance or area or a system devised to measure such things as the passage of time.';
-- Add Comment Column
-- COMMENT ON COLUMN unitofmeasure.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.unitofmeasure.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.unitofmeasure.uomname IS 'The name(s) of a particular unit of measure.';
COMMENT ON COLUMN so.unitofmeasure.uomsymbol IS 'The symbol used for this unit of measure, such at "ft" for feet, or "m" for meter.';
COMMENT ON COLUMN so.unitofmeasure.measuretype IS 'Type of Measure';
COMMENT ON COLUMN so.unitofmeasure.namestandardunit IS 'Name of the standard units to which this unit of measure can be directly converted.';
COMMENT ON COLUMN so.unitofmeasure.scaletostandardunit IS 'Multiplicative factor for conversion of this unit of measure to the standard one (often the ISO standard unit).';
COMMENT ON COLUMN so.unitofmeasure.offsettostandardunit IS 'Offset(ToStandardUnit) can be used to make the conversion from X to S by';
COMMENT ON COLUMN so.unitofmeasure.formula IS 'An algebraic formula (probably in some programming language) converting this unit of measure (represented in the formula by its uomSymbol) to the ISO standard (represented by its symbol.';



/* 
 ██████  ██████  ███████ ███████ ██████  ██    ██  █████  ██████  ██      ███████ ██████  ██████   ██████  ██████  ███████ ██████  ████████ ██    ██ 
██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██      ██   ██ ██   ██ ██    ██ ██   ██ ██      ██   ██    ██     ██  ██  
██    ██ ██████  ███████ █████   ██████  ██    ██ ███████ ██████  ██      █████   ██████  ██████  ██    ██ ██████  █████   ██████     ██      ████   
██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██   ██ ██   ██ ██      ██      ██      ██   ██ ██    ██ ██      ██      ██   ██    ██       ██    
 ██████  ██████  ███████ ███████ ██   ██   ████   ██   ██ ██████  ███████ ███████ ██      ██   ██  ██████  ██      ███████ ██   ██    ██       ██  
 */

CREATE TABLE so.observableproperty
(
    -- id SERIAL PRIMARY KEY,
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT, 
    definition TEXT, 
    description TEXT,
    foi TEXT,
    phenomenontype TEXT,
    basephenomenon TEXT NOT NULL, 
    domain_min REAL, 
    domain_max REAL, 
    domain_typeofvalue TEXT CHECK (domain_typeofvalue IN ('result_value', 'result_uri')),
    domain_code TEXT,
    iduom UUID,
    CHECK ((domain_min IS NULL AND domain_max IS NULL) OR (domain_min IS NOT NULL AND domain_max IS NOT NULL)),
    FOREIGN KEY (iduom) 
      REFERENCES so.unitofmeasure(guidkey) 
);


COMMENT ON TABLE so.observableproperty IS 'Represents a single observable property e.g. temperature.';
-- Add Comment Column
-- COMMENT ON COLUMN observableproperty.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.observableproperty.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.observableproperty.name IS 'Name of the Observable Property';
COMMENT ON COLUMN so.observableproperty.definition IS 'Definition of the Observable Property';
COMMENT ON COLUMN so.observableproperty.description IS 'Description of the Observable Property';
COMMENT ON COLUMN so.observableproperty.foi IS 'The Feature of Interest to which the Observable Property belongs';
COMMENT ON COLUMN so.observableproperty.phenomenontype IS 'Type of phenomenon to which the Observable Property belongs';
COMMENT ON COLUMN so.observableproperty.basephenomenon IS 'The phenomenon that the Observable Property description builds upon.';
COMMENT ON COLUMN so.observableproperty.domain_min IS 'Minimum limit of the domain of values ​​that the Observable Property can take on';
COMMENT ON COLUMN so.observableproperty.domain_max IS 'Maximum limit of the domain of values ​​that the Observable Property can take on';
COMMENT ON COLUMN so.observableproperty.domain_typeofvalue IS 'Whether the value is numeric or encoded';
COMMENT ON COLUMN so.observableproperty.domain_code IS 'Encoding in case the value is encoded';
COMMENT ON COLUMN so.observableproperty.iduom IS 'Foreign key to the UnitOfMeasure table, guidkey field.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_foi()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.foi NOT IN (SELECT id FROM codelist WHERE collection = 'FOIType') THEN
        RAISE EXCEPTION 'Table observableproperty: Invalid value for foi. Must be present in id of foi codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER foi
BEFORE INSERT OR UPDATE ON so.observableproperty
FOR EACH ROW
EXECUTE FUNCTION so.check_foi();


CREATE OR REPLACE FUNCTION so.check_phenomenon_type()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.phenomenontype NOT IN (SELECT id FROM codelist WHERE collection = 'PhenomenonType') THEN
        RAISE EXCEPTION 'Table observableproperty: Invalid value for phenomenonType. Must be present in PhenomenonType.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER phenomenonType
BEFORE INSERT OR UPDATE ON so.observableproperty
FOR EACH ROW
EXECUTE FUNCTION so.check_phenomenon_type();


CREATE OR REPLACE FUNCTION so.check_base_phenomenon()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.basephenomenon NOT IN (
        SELECT id FROM codelist WHERE foi_phenomenon = CONCAT(NEW.foi, NEW.phenomenonType)
    ) THEN
        RAISE EXCEPTION 'Table observableproperty: Invalid value for basephenomenon. The values must be present in the PhenomenonTypevalue of the Feature Of Interest and the Phenomenon type defined in the record.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER basephenomenon
BEFORE INSERT OR UPDATE ON so.observableproperty
FOR EACH ROW
EXECUTE FUNCTION so.check_base_phenomenon();

CREATE OR REPLACE FUNCTION so.check_domain()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.domain_min > NEW.domain_max THEN
        RAISE EXCEPTION 'Table observableproperty: domain_min must be less than domain_max';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckdomain
BEFORE INSERT OR UPDATE ON so.observableproperty
FOR EACH ROW
EXECUTE FUNCTION so.check_domain();

CREATE OR REPLACE FUNCTION so.check_domain_value()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.domain_typeofvalue = 'result_uri' AND (NEW.domain_min IS NOT NULL OR NEW.domain_max IS NOT NULL) THEN
        RAISE EXCEPTION 'Table observableproperty: For domain_typeofvalue = result_uri, domain_min and domain_max must be NULL';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckdomain_value
BEFORE INSERT OR UPDATE ON so.observableproperty
FOR EACH ROW
EXECUTE FUNCTION so.check_domain_value();


/* 
███████ ███████ ███    ██ ███████  ██████  ██████  
██      ██      ████   ██ ██      ██    ██ ██   ██ 
███████ █████   ██ ██  ██ ███████ ██    ██ ██████  
     ██ ██      ██  ██ ██      ██ ██    ██ ██   ██ 
███████ ███████ ██   ████ ███████  ██████  ██   ██                                                  
 */

CREATE TABLE so.sensor 
(
  -- id SERIAL PRIMARY KEY,
  guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL, 
  description TEXT NOT NULL 
);


COMMENT ON TABLE so.sensor IS 'Represents a Sensor Object';
-- Add Comment Column
-- COMMENT ON COLUMN sensor.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.sensor.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.sensor.name IS 'Code of the Sensor';
COMMENT ON COLUMN so.sensor.description IS 'Description of the Sensor';


/* 
██████  ███████ ██       █████  ████████ ███████ ██████  ██████   █████  ██████  ████████ ██    ██ 
██   ██ ██      ██      ██   ██    ██    ██      ██   ██ ██   ██ ██   ██ ██   ██    ██     ██  ██  
██████  █████   ██      ███████    ██    █████   ██   ██ ██████  ███████ ██████     ██      ████   
██   ██ ██      ██      ██   ██    ██    ██      ██   ██ ██      ██   ██ ██   ██    ██       ██    
██   ██ ███████ ███████ ██   ██    ██    ███████ ██████  ██      ██   ██ ██   ██    ██       ██    

 */


CREATE TABLE so.relatedparty
(
    -- id SERIAL PRIMARY KEY, 
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    individualname TEXT, 
    organizationname TEXT, 
    positionname TEXT, 
    address TEXT, 
    contactinstructions TEXT, 
    electronicmailaddress TEXT, 
    hoursofservice TEXT, 
    telephonefacsimile INTEGER, 
    telephonevoice INTEGER, 
    website TEXT, 
    role TEXT  
);

COMMENT ON TABLE so.relatedparty IS 'An organisation or a person with a role related to a resource.';
-- Add Comment Column
-- COMMENT ON COLUMN relatedparty.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.relatedparty.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.relatedparty.individualname IS 'Name of the related person.';
COMMENT ON COLUMN so.relatedparty.organizationname IS 'Name of the related person.';
COMMENT ON COLUMN so.relatedparty.positionname IS 'Position of the party in relation to a resource, such as head of department.';
COMMENT ON COLUMN so.relatedparty.address IS 'An address provided as free text.';
COMMENT ON COLUMN so.relatedparty.contactinstructions IS 'Supplementary instructions on how or when to contact an individual or organisation.';
COMMENT ON COLUMN so.relatedparty.electronicmailaddress IS 'An electronic mailbox address of the organisation or individual.';
COMMENT ON COLUMN so.relatedparty.hoursofservice IS 'Periods of time when the organisation or individual can be contacted.';
COMMENT ON COLUMN so.relatedparty.telephonefacsimile IS 'Number of a facsimile machine of the organisation or individual.';
COMMENT ON COLUMN so.relatedparty.telephonevoice IS 'Telephone number of the organisation or individual.';
COMMENT ON COLUMN so.relatedparty.website IS 'Pages provided on the World Wide Web by the organisation or individual.';
COMMENT ON COLUMN so.relatedparty.role IS 'Role(s) of the party in relation to a resource, such as owner.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_role()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.role NOT IN (SELECT id FROM codelist WHERE collection = 'ResponsiblePartyRole') AND NEW.role IS NOT NULL THEN
        RAISE EXCEPTION 'Table relatedparty: Invalid value for role. Must be present in id of responsiblepartyrole codelist.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER role
BEFORE INSERT OR UPDATE ON so.relatedparty
FOR EACH ROW
EXECUTE FUNCTION so.check_role();




/* 
██████   ██████   ██████ ██    ██ ███    ███ ███████ ███    ██ ████████  ██████ ██ ████████  █████  ████████ ██  ██████  ███    ██ 
██   ██ ██    ██ ██      ██    ██ ████  ████ ██      ████   ██    ██    ██      ██    ██    ██   ██    ██    ██ ██    ██ ████   ██ 
██   ██ ██    ██ ██      ██    ██ ██ ████ ██ █████   ██ ██  ██    ██    ██      ██    ██    ███████    ██    ██ ██    ██ ██ ██  ██ 
██   ██ ██    ██ ██      ██    ██ ██  ██  ██ ██      ██  ██ ██    ██    ██      ██    ██    ██   ██    ██    ██ ██    ██ ██  ██ ██ 
██████   ██████   ██████  ██████  ██      ██ ███████ ██   ████    ██     ██████ ██    ██    ██   ██    ██    ██  ██████  ██   ████ 
 */


CREATE TABLE so.documentcitation 
(     
    --id SERIAL PRIMARY KEY, 
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT, 
    shortname TEXT, 
    date TIMESTAMP WITH TIME ZONE,
    link TEXT, 
    specificreference TEXT 
);

COMMENT ON TABLE so.documentcitation IS 'Citation for the purposes of unambiguously referencing a document.';
-- Add Comment Column
-- COMMENT ON COLUMN documentcitation.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.documentcitation.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.documentcitation.name IS 'Name of the document.';
COMMENT ON COLUMN so.documentcitation.shortname IS 'Short name or alternative title of the document.';
COMMENT ON COLUMN so.documentcitation.date IS 'Date of creation, publication or revision of the document.';
COMMENT ON COLUMN so.documentcitation.link IS 'Link to an online version of the document.';
COMMENT ON COLUMN so.documentcitation.specificreference IS 'Reference to a specific part of the document.';


/* 
██████  ██████   ██████   ██████ ███████ ███████ ███████ 
██   ██ ██   ██ ██    ██ ██      ██      ██      ██      
██████  ██████  ██    ██ ██      █████   ███████ ███████ 
██      ██   ██ ██    ██ ██      ██           ██      ██ 
██      ██   ██  ██████   ██████ ███████ ███████ ███████ 
 */

CREATE TABLE so.process
( 
    -- id SERIAL PRIMARY KEY, 
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    inspireid_localid TEXT, 
    inspireid_namespace TEXT, 
    inspireid_versionid TEXT, 
    name TEXT, 
    description TEXT, 
    type TEXT NOT NULL, 
    idrelatedparty1 UUID NOT NULL,
    idrelatedparty2 UUID,
    iddocumentcitation1 UUID,
    iddocumentcitation2 UUID,
    FOREIGN KEY (idrelatedparty1)
      REFERENCES so.relatedparty(guidkey),
    FOREIGN KEY (idrelatedparty2)
      REFERENCES so.relatedparty(guidkey),       
    FOREIGN KEY (iddocumentcitation1)
      REFERENCES so.documentcitation(guidkey),
    FOREIGN KEY (iddocumentcitation2)
      REFERENCES so.documentcitation(guidkey)
);

COMMENT ON TABLE so.process IS 'Description of an observation process';
-- Add Comment Column
-- COMMENT ON COLUMN process.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.process.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.process.inspireid_localid IS 'A local identifier, assigned by the data provider. The local identifier is unique within the namespace, that is no other spatial object carries the same unique identifier.';
COMMENT ON COLUMN so.process.inspireid_namespace IS 'Namespace uniquely identifying the data source of the spatial object.';
COMMENT ON COLUMN so.process.inspireid_versionid IS 'The identifier of the particular version of the spatial object, with a maximum length of 25 characters. If the specification of a spatial object type with an external object identifier includes life-cycle information, the version identifier is used to distinguish between the different versions of a spatial object. Within the set of all versions of a spatial object, the version identifier is unique.';
COMMENT ON COLUMN so.process.name IS 'Name of the Process';
COMMENT ON COLUMN so.process.description IS 'Description of the Proces';
COMMENT ON COLUMN so.process.type IS 'Type of process.';
COMMENT ON COLUMN so.process.idrelatedparty1 IS 'First Foreign key to the RelatedParty table, guidkey field.';
COMMENT ON COLUMN so.process.idrelatedparty2 IS 'Second Foreign key to the RelatedParty table, guidkey field.';
COMMENT ON COLUMN so.process.iddocumentcitation1 IS 'FirstForeign key to the DocumentCitation table, guidkey field.';
COMMENT ON COLUMN so.process.iddocumentcitation2 IS 'Second Foreign key to the DocumentCitation table, guidkey field.';




/*
 ██████  ██████  ███████ ███████ ██████  ██    ██  █████  ██████  ██      ███████ ██████  ██████   ██████  ██████  ███████ ██████  ████████ ██    ██         ██████  ██████   ██████   ██████ ███████ ███████ ███████ 
██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██      ██   ██ ██   ██ ██    ██ ██   ██ ██      ██   ██    ██     ██  ██          ██   ██ ██   ██ ██    ██ ██      ██      ██      ██      
██    ██ ██████  ███████ █████   ██████  ██    ██ ███████ ██████  ██      █████   ██████  ██████  ██    ██ ██████  █████   ██████     ██      ████           ██████  ██████  ██    ██ ██      █████   ███████ ███████ 
██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██   ██ ██   ██ ██      ██      ██      ██   ██ ██    ██ ██      ██      ██   ██    ██       ██            ██      ██   ██ ██    ██ ██      ██           ██      ██ 
 ██████  ██████  ███████ ███████ ██   ██   ████   ██   ██ ██████  ███████ ███████ ██      ██   ██  ██████  ██      ███████ ██   ██    ██       ██    ███████ ██      ██   ██  ██████   ██████ ███████ ███████ ███████ 
 */


CREATE TABLE so.observableproperty_process (
    idprocess UUID NOT NULL,
    idobservedproperty UUID NOT NULL,
    CONSTRAINT pk_observableproperty_process PRIMARY KEY (idprocess, idobservedproperty),
    
    FOREIGN KEY (idprocess)
      REFERENCES so.process(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (idobservedproperty)
      REFERENCES so.observableproperty(guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON TABLE so.observableproperty_process IS 'Table of Link between Process and ObservableProperty.';
-- Add Comment Column
COMMENT ON COLUMN so.observableproperty_process.idprocess IS 'Foreign key to the Process table, guidkey field. - Observed Soil Profile';
COMMENT ON COLUMN so.observableproperty_process.idobservedproperty IS 'Foreign key to the ObservablePropery table, guidkey field. - Derived Soil Profile';



/*
██████   █████  ████████  █████  ███████ ████████ ██████  ███████  █████  ███    ███ 
██   ██ ██   ██    ██    ██   ██ ██         ██    ██   ██ ██      ██   ██ ████  ████ 
██   ██ ███████    ██    ███████ ███████    ██    ██████  █████   ███████ ██ ████ ██ 
██   ██ ██   ██    ██    ██   ██      ██    ██    ██   ██ ██      ██   ██ ██  ██  ██ 
██████  ██   ██    ██    ██   ██ ███████    ██    ██   ██ ███████ ██   ██ ██      ██ 
*/


CREATE TABLE so.datastream
(
    -- id SERIAL PRIMARY KEY,
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    idsoilsite UUID,
    idsoilprofile UUID,
    idsoilderivedobject UUID,
    idprofileelement UUID,
    iddatastreamcollection UUID,
    idprocess UUID NOT NULL,
    idobservedproperty UUID NOT NULL,
    idsensor UUID,

    -- Feature Of Interset ----------------------------------------          
    FOREIGN KEY (idsoilsite)
      REFERENCES so.soilsite(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (idsoilprofile)
      REFERENCES so.soilprofile(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (idsoilderivedobject)
      REFERENCES so.soilderivedobject(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (idprofileelement)
      REFERENCES so.profileelement(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    -------------------------------------------------------------------
    
    FOREIGN KEY (iddatastreamcollection)
      REFERENCES so.datastreamcollection(guidkey),

    FOREIGN KEY (idprocess)
      REFERENCES so.process(guidkey),
       
    FOREIGN KEY (idobservedproperty)
      REFERENCES so.observableproperty(guidkey),
      
    FOREIGN KEY (idsensor)
      REFERENCES so.sensor(guidkey),
    
    -- Only one among Soil Site, Soil Profile, Profile Element, and Soil Derived Object can be populated.
    CONSTRAINT check_single_id CHECK (
        (idsoilsite IS NOT NULL AND idsoilprofile IS NULL AND idsoilderivedobject IS NULL AND idprofileelement IS NULL) OR
        (idsoilsite IS NULL AND idsoilprofile IS NOT NULL AND idsoilderivedobject IS NULL AND idprofileelement IS NULL) OR
        (idsoilsite IS NULL AND idsoilprofile IS NULL AND idsoilderivedobject IS NOT NULL AND idprofileelement IS NULL) OR
        (idsoilsite IS NULL AND idsoilprofile IS NULL AND idsoilderivedobject IS NULL AND idprofileelement IS NOT NULL)
    ),

    -- Only a unique series of property/process/sensor/datastreamcollection can belong to a single feature.
    CONSTRAINT unique_data_idsoilsite_key UNIQUE (
        idsoilsite, iddatastreamcollection, idsensor, idprocess, idobservedproperty
    ),
    CONSTRAINT unique_data_idsoilprofile_key UNIQUE (
        idsoilprofile, iddatastreamcollection, idsensor, idprocess, idobservedproperty
    ),
    CONSTRAINT unique_data_idprofileelement_key UNIQUE (
        idprofileelement, iddatastreamcollection, idsensor, idprocess, idobservedproperty
    ),
    CONSTRAINT unique_data_idsoilderivedobject_key UNIQUE (
        idsoilderivedobject, iddatastreamcollection, idsensor, idprocess, idobservedproperty
    ),

    -- Only specific property/process pairs can exist
    FOREIGN KEY (idprocess, idobservedproperty) REFERENCES so.observableproperty_process(idprocess, idobservedproperty)

);

COMMENT ON TABLE so.datastream IS 'Stream of Data.';
-- Add Comment Column
-- COMMENT ON COLUMN datastream.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.datastream.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.datastream.idsoilsite IS 'Foreign key to the Process table, guidkey field.';
COMMENT ON COLUMN so.datastream.idsoilprofile IS 'Foreign key to the SoilProfile table, guidkey field.';
COMMENT ON COLUMN so.datastream.idsoilderivedobject IS 'Foreign key to the SoilDerivedObject table, guidkey field.';
COMMENT ON COLUMN so.datastream.idprofileelement IS 'Foreign key to the ProfileElement table, guidkey field.';
COMMENT ON COLUMN so.datastream.iddatastreamcollection IS 'Foreign key to the DatastreamCollection table, guidkey field.';
COMMENT ON COLUMN so.datastream.idprocess IS 'Foreign key to the Process table, guidkey field.';
COMMENT ON COLUMN so.datastream.idobservedproperty IS 'Foreign key to the ObservablePropery table, guidkey field.';
COMMENT ON COLUMN so.datastream.idsensor IS 'Foreign key to the Datastream table, guidkey field.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_soilprofile_obspro()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idsoilprofile IS NOT NULL AND NEW.idobservedproperty NOT IN (
        SELECT guidkey FROM observableproperty WHERE foi = 'soilprofile'
    ) THEN
        RAISE EXCEPTION 'Invalid value for observedproperty. Must be a valid Soil Profile Parameter.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER soilprofile_obspro
BEFORE INSERT OR UPDATE ON so.datastream
FOR EACH ROW
EXECUTE FUNCTION so.check_soilprofile_obspro();

CREATE OR REPLACE FUNCTION so.check_soilsite_obspro()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idsoilsite IS NOT NULL AND NEW.idobservedproperty NOT IN (
        SELECT guidkey FROM observableproperty WHERE foi = 'soilsite'
    ) THEN
        RAISE EXCEPTION 'Invalid value for observedproperty. Must be a valid Soil Site Parameter.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER soilsite_obspro
BEFORE INSERT OR UPDATE ON so.datastream
FOR EACH ROW
EXECUTE FUNCTION so.check_soilsite_obspro();

CREATE OR REPLACE FUNCTION so.check_profileelement_obspro()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idprofileelement IS NOT NULL AND NEW.idobservedproperty NOT IN (
        SELECT guidkey FROM observableproperty WHERE foi = 'profileelement'
    ) THEN
        RAISE EXCEPTION 'Invalid value for observedproperty. Must be a valid Profile Element Parameter.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER profileelement_obspro
BEFORE INSERT OR UPDATE ON so.datastream
FOR EACH ROW
EXECUTE FUNCTION so.check_profileelement_obspro();

CREATE OR REPLACE FUNCTION so.check_soilderivedobject_obspro()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idsoilderivedobject IS NOT NULL AND NEW.idobservedproperty NOT IN (
        SELECT guidkey FROM observableproperty WHERE foi = 'soilderivedobject'
    ) THEN
        RAISE EXCEPTION 'Invalid value for observedproperty. Must be a valid Derived Object Parameter.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER soilderivedobject_obspro
BEFORE INSERT OR UPDATE ON so.datastream
FOR EACH ROW
EXECUTE FUNCTION so.check_soilderivedobject_obspro();




/* 
 ██████  ██████  ███████ ███████ ██████  ██    ██  █████  ████████ ██  ██████  ███    ██ 
██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██   ██    ██    ██ ██    ██ ████   ██ 
██    ██ ██████  ███████ █████   ██████  ██    ██ ███████    ██    ██ ██    ██ ██ ██  ██ 
██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██   ██    ██    ██ ██    ██ ██  ██ ██ 
 ██████  ██████  ███████ ███████ ██   ██   ████   ██   ██    ██    ██  ██████  ██   ████ 
 */


CREATE TABLE so.observation
(
    -- id SERIAL PRIMARY KEY,
    guidkey UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    phenomenontime TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp not null, 
    resulttime TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp not null,
    validtime TIMESTAMP WITH TIME ZONE,
    resultquality TEXT,
    result_value REAL,
    result_uri TEXT,
    iddatastream UUID,

    FOREIGN KEY (iddatastream)
      REFERENCES so.datastream(guidkey) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON TABLE so.observation IS 'An observation is an act that results in the estimation of the value of a feature property, and involves application of a specified procedure, such as a sensor, instrument, algorithm or process chain.';
-- Add Comment Column
-- COMMENT ON COLUMN observation.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.observation.guidkey IS 'Universally unique identifier';
COMMENT ON COLUMN so.observation.phenomenontime IS 'Describe the time that the result applies to the property of the feature-of-interest';
COMMENT ON COLUMN so.observation.resulttime IS 'Describe the time when the result became available, typically when the procedure associated with the observation was completed For some observations this is identical to the phenomenonTime.';
COMMENT ON COLUMN so.observation.validtime IS 'Describe the time period during which the result is intended to be used.';
COMMENT ON COLUMN so.observation.resultquality IS 'Describe the quality of the result';
COMMENT ON COLUMN so.observation.result_value IS 'Numeric Value of the Observation';
COMMENT ON COLUMN so.observation.result_uri IS 'Coded Value of the Observation';;
COMMENT ON COLUMN so.observation.iddatastream IS 'Foreign key to the Datastream table, guidkey field.';


-- Trigger and Function -------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION so.check_validperiod_observation()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.resulttime > NEW.validtime THEN
        RAISE EXCEPTION 'Table observation: resulttime must be less than validtime';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ceckvalidperiodobservation
BEFORE INSERT OR UPDATE ON so.observation
FOR EACH ROW
EXECUTE FUNCTION so.check_validperiod_observation();

CREATE OR REPLACE FUNCTION so.check_result_value_uri()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.result_value IS NOT NULL AND NEW.result_uri IS NOT NULL) OR 
       (NEW.result_value IS NULL AND NEW.result_uri IS NULL) THEN
        RAISE EXCEPTION 'Both result_value and result_uri cannot be evaluated at the same time or they cannot be null';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_result_value_uri
BEFORE INSERT OR UPDATE ON so.observation
FOR EACH ROW
EXECUTE FUNCTION so.check_result_value_uri();

-- Trigger per il controllo del valore del risultato durante l'INSERT
CREATE OR REPLACE FUNCTION so.control_result_value() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.result_value > (
        SELECT CAST(observableproperty.domain_max AS REAL)
        FROM observation
        JOIN datastream ON observation.iddatastream = datastream.guidkey
        JOIN observableproperty ON datastream.idobservedproperty = observableproperty.guidkey
        WHERE datastream.guidkey = NEW.iddatastream
    ) OR NEW.result_value < (
        SELECT CAST(observableproperty.domain_min AS REAL)
        FROM observation
        JOIN datastream ON observation.iddatastream = datastream.guidkey
        JOIN observableproperty ON datastream.idobservedproperty = observableproperty.guidkey
        WHERE datastream.guidkey = NEW.iddatastream
    ) THEN
        RAISE EXCEPTION 'Errore nella osservazione';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER controlresultvalue
BEFORE INSERT OR UPDATE ON so.observation
FOR EACH ROW
EXECUTE FUNCTION so.control_result_value();


/* 
██████   █████  ██████   █████  ███    ███ ███████ ████████ ███████ ██████  
██   ██ ██   ██ ██   ██ ██   ██ ████  ████ ██         ██    ██      ██   ██ 
██████  ███████ ██████  ███████ ██ ████ ██ █████      ██    █████   ██████  
██      ██   ██ ██   ██ ██   ██ ██  ██  ██ ██         ██    ██      ██   ██ 
██      ██   ██ ██   ██ ██   ██ ██      ██ ███████    ██    ███████ ██   ██ 
 */



CREATE TABLE so.parameter
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL, 
    value TEXT NOT NULL, 
    idobservation UUID,
    FOREIGN KEY (idobservation) 
      REFERENCES so.observation(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


COMMENT ON TABLE so.parameter IS 'Describe an arbitrary event-specific parameter. This might be an environmental parameter, an instrument setting or input, or an event-specific sampling parameter that is not tightly bound to either the feature-of-interest  or to the observation procedure.';
-- Add Comment Column
COMMENT ON COLUMN so.parameter.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.parameter.name IS 'GenericName shall indicate the meaning of the named value. Its value should be taken from a well-governed source if possible.';
COMMENT ON COLUMN so.parameter.value IS 'Any shall provide the value. The type Any should be substituted by a suitable concrete type, such as CI_ResponsibleParty or Measure';
COMMENT ON COLUMN so.parameter.idobservation IS 'Foreign key to the Observation table, guidkey field.';



/* 
██████  ██████   ██████   ██████ ███████ ███████ ███████ ██████   █████  ██████   █████  ███    ███ ███████ ████████ ███████ ██████  
██   ██ ██   ██ ██    ██ ██      ██      ██      ██      ██   ██ ██   ██ ██   ██ ██   ██ ████  ████ ██         ██    ██      ██   ██ 
██████  ██████  ██    ██ ██      █████   ███████ ███████ ██████  ███████ ██████  ███████ ██ ████ ██ █████      ██    █████   ██████  
██      ██   ██ ██    ██ ██      ██           ██      ██ ██      ██   ██ ██   ██ ██   ██ ██  ██  ██ ██         ██    ██      ██   ██ 
██      ██   ██  ██████   ██████ ███████ ███████ ███████ ██      ██   ██ ██   ██ ██   ██ ██      ██ ███████    ██    ███████ ██   ██ 
 */


CREATE TABLE so.processparameter
(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL,  -- Codelist processparameternamevalue 
    description TEXT,  
    idprocess UUID,
    FOREIGN KEY (idprocess)
      REFERENCES so.process(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE

);

COMMENT ON TABLE so.processparameter IS 'Description of the given parameter.';
-- Add Comment Column
COMMENT ON COLUMN so.processparameter.id IS 'Primary Key of the Table';
COMMENT ON COLUMN so.processparameter.name IS 'Name of the process parameter.';
COMMENT ON COLUMN so.processparameter.description IS 'Description of the process parameter.';
COMMENT ON COLUMN so.processparameter.idprocess IS 'Foreign key to the Process table, guidkey field.';



/* 
 ██████  ██████  ██████  ███████ ██      ██ ███████ ████████ 
██      ██    ██ ██   ██ ██      ██      ██ ██         ██    
██      ██    ██ ██   ██ █████   ██      ██ ███████    ██    
██      ██    ██ ██   ██ ██      ██      ██      ██    ██    
 ██████  ██████  ██████  ███████ ███████ ██ ███████    ██    
 */


create table so.codelist
(
    id TEXT,
    label TEXT,
    definition TEXT,
    collection TEXT,
    foi TEXT,
    phenomenon TEXT,
    foi_phenomenon TEXT,
    parent TEXT
);



COMMENT ON TABLE so.codelist IS 'Table to manage Codelists.';
-- Add Comment Column
COMMENT ON COLUMN so.codelist.id IS 'Uri of the codelist value';
COMMENT ON COLUMN so.codelist.label IS 'Label of the value';
COMMENT ON COLUMN so.codelist.definition IS 'Definition of the value';
COMMENT ON COLUMN so.codelist.collection IS 'Collection of values';
COMMENT ON COLUMN so.codelist.foi IS 'Feature of Interest of the collection';
COMMENT ON COLUMN so.codelist.phenomenon IS 'Phenomenon of the collection';
COMMENT ON COLUMN so.codelist.foi_phenomenon IS 'Concatenation of fields foi and phenomenon e';





-- LayerTypeValue
-- profileelement
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/LayerTypeValue

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/depthInterval', 'depth interval', 'Fixed depth range where soil is described and/or samples are taken.', 'LayerTypeValue', null, null, null, null);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic', 'geogenic', 'Domain of the soil profile composed of material resulting from the same, non-pedogenic process, e.g. sedimentation, that might display an unconformity to possible over- or underlying adjacent domains.', 'LayerTypeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/subSoil', 'subsoil', 'Natural soil material below the topsoil and overlying the unweathered parent material.', 'LayerTypeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/topSoil', 'topsoil', 'Upper part of a natural soil that is generally dark coloured and has a higher content of organic matter and nutrients when compared to the (mineral) horizons below excluding the humus layer.', 'LayerTypeValue', NULL, NULL, NULL, NULL);

-- EventProcessValue
-- profileelement
-- INSPIRE
--http://inspire.ec.europa.eu/codelist/EventProcessValue

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/bolideImpact', 'bolide impact', 'The impact of an extraterrestrial body on the surface of the earth.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/cometaryImpact', 'cometary impact', 'the impact of a comet on the surface of the earth', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/meteoriteImpact', 'meteorite impact', 'the impact of a meteorite on the surface of the earth', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deepWaterOxygenDepletion', 'deep water oxygen depletion', 'Process of removal of oxygen from from the deep part of a body of water.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', 'deformation', 'Movement of rock bodies by displacement on fault or shear zones, or change in shape of a body of earth material.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/ductileFlow', 'ductile flow', 'deformation without apparent loss of continuity at the scale of observation.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/faulting', 'faulting', 'The process of fracturing, frictional slip, and displacement accumulation that produces a fault', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/folding', 'folding', 'deformation in which planar surfaces become regularly curviplanar surfaces with definable limbs (zones of lower curvature) and hinges (zones of higher curvature).', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/fracturing', 'fracturing', 'The formation of a surface of failure resulting from stress', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/shearing', 'shearing', 'A deformation in which contiguous parts of a body are displaced relatively to each other in a direction parallel to a surface. The surface may be a discrete fault, or the deformation may be a penetrative strain and the shear surface is a geometric abstraction.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/diageneticProcess', 'diagenetic process', 'Any chemical, physical, or biological process that affects a sedimentary earth material after initial deposition, and during or after lithification, exclusive of weathering and metamorphism.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/extinction', 'extinction', 'Process of disappearance of a species or higher taxon, so that it no longer exists anywhere or in the subsequent fossil record.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/geomagneticProcess', 'geomagnetic process', 'Process that results in change in Earth''s magnetic field.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magneticFieldReversal', 'magnetic field reversal', 'geomagnetic event', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/polarWander', 'polar wander', 'process of migration of the axis of the earth''s dipole field relative to the rotation axis of the Earth.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/humanActivity', 'human activity', 'Processes of human modification of the earth to produce geologic features.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/excavation', 'excavation', 'removal of material, as in a mining operation', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/grading', 'grading', 'leveling of earth surface by rearrangement of prexisting material', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/materialTransportAndDeposition', 'material transport and deposition', 'transport and heaping of material, as in a land fill, mine dump, dredging operations', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/mixing', 'mixing', 'Mixing', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticProcess', 'magmatic process', 'A process involving melted rock (magma).', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/eruption', 'eruption', 'The ejection of volcanic materials (lava, pyroclasts, and volcanic gases) onto the Earth''s surface, either from a central vent or from a fissure or group of fissures', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/intrusion', 'intrusion', 'The process of emplacement of magma in pre-existing rock', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticCrystallisation', 'magmatic crystallisation', 'The process by which matter becomes crystalline, from a gaseous, fluid, or dispersed state', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/melting', 'melting', 'change of state from a solid to a liquid', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/metamorphicProcess', 'metamorphic process', 'Mineralogical, chemical, and structural adjustment of solid rocks to physical and chemical conditions that differ from the conditions under which the rocks in question originated, and are generally been imposed at depth, below the surface zones of weathering and cementation.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/alteration', 'alteration', 'General term for any change in the mineralogical or chemical composition of a rock. Typically related to interaction with hydrous fluids.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/contactMetamorphism', 'contact metamorphism', 'Metamorphism taking place in rocks at or near their contact with a genetically related body of igneous rock', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/dislocationMetamorphism', 'dislocation metamorphism', 'Metamorphism concentrated along narrow belts of shearing or crushing without an appreciable rise in temperature', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelChange', 'sea level change', 'Process of mean sea level changing relative to some datum.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelFall', 'sea level fall', 'process of mean sea level falling relative to some datum', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelRise', 'sea level rise', 'process of mean sea level rising relative to some datum', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/sedimentaryProcess', 'sedimentary process', 'A phenomenon that changes the distribution or physical properties of sediment at or near the earth''s surface.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deposition', 'deposition', 'Accumulation of material; the constructive process of accumulation of sedimentary particles, chemical precipitation of mineral matter from solution, or the accumulation of organicMaterial on the death of plants and animals.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/erosion', 'erosion', 'The process of disaggregation of rock and displacement of the resultant particles (sediment) usually by the agents of currents such as, wind, water, or ice by downward or down-slope movement in response to gravity or by living organisms (in the case of bioerosion).', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/speciation', 'speciation', 'Process that results inappearance of new species.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', 'tectonic process', 'Processes related to the interaction between or deformation of rigid plates forming the crust of the Earth.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/accretion', 'accretion', 'The addition of material to a continent. Typically involves convergent or transform motion.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/continentalBreakup', 'continental breakup', 'Fragmentation of a continental plate into two or more smaller plates; may involve rifting or strike slip faulting.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/continentalCollision', 'continental collision', 'The amalgamation of two continental plates or blocks along a convergent margin.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/obduction', 'obduction', 'The overthrusting of continental crust by oceanic crust or mantle rocks at a convergent plate boundary.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/orogenicProcess', 'orogenic process', 'mountain building process.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/spreading', 'spreading', 'A process whereby new oceanic crust is formed by upwelling of magma at the center of mid-ocean ridges and by a moving-away of the new material from the site of upwelling at rates of one to ten centimeters per year.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/subduction', 'subduction', 'The process of one lithospheric plate descending beneath another', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/transformFaulting', 'transform faulting', 'A strike-slip fault that links two other faults or two other plate boundaries (e.g. two segments of a mid-ocean ridge). Transform faults often exhibit characteristics that distinguish them from transcurrent faults: (1) For transform faults formed at the same time as the faults they link, slip on the transform fault has equal magnitude at all points along the transform; slip magnitude on the transform fault can exceed the length of the transform fault, and slip does not decrease to zero at the fault termini. (2) For transform faults linking two similar features, e.g. if two mid-ocean ridge segments linked by a transform have equal spreading rates, then the length of the transform does not change as slip accrues on it.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/weathering', 'weathering', 'The process or group of processes by which earth materials exposed to atmospheric agents at or near the Earth''s surface are changed in color, texture, composition, firmness, or form, with little or no transport of the loosened or altered material. Processes typically include oxidation, hydration, and leaching of soluble constituents.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/biologicalWeathering', 'biological weathering', 'breakdown of rocks by biological agents, e.g. the penetrating and expanding force of roots, the presence of moss and lichen causing humic acids to be retained in contact with rock, and the work of animals (worms, moles, rabbits) in modifying surface soil', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/chemicalWeathering', 'chemical weathering', 'The process of weathering by which chemical reactions (hydrolysis, hydration, oxidation, carbonation, ion exchange, and solution) transform rocks and minerals into new chemical combinations that are stable under conditions prevailing at or near the Earth''s surface; e.g. the alteration of orthoclase to kaolinite.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/physicalWeathering', 'physical weathering', 'The process of weathering by which frost action, salt-crystal growth, absorption of water, and other physical processes break down a rock to fragments, involving no chemical change', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deepPloughing', 'deep ploughing', 'mixing of loose surface material by ploughing deeper than frequently done during annual soil cultivation', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionByOrFromMovingIce', 'deposition by or from moving ice', 'Deposition of sediment from ice by melting or pushing. The material has been transported in the ice after entrainment in the moving ice or after deposition from other moving fluids on the ice.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionFromAir', 'deposition from air', 'Deposition of sediment from air, in which the sediment has been transported after entrainment in the moving air.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionFromWater', 'deposition from water', 'Deposition of sediment from water, in which the sediment has been transported after entrainment in the moving water or after deposition from other moving fluids.', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/digging', 'digging', 'repeated mixing of loose surface material by digging with a spade or similar tool', 'EventProcessValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/geologicProcess', 'geologic process', 'process that effects the geologic record', 'EventProcessValue', NULL, NULL, NULL, NULL);

-- LayerGenesisProcessStateValue
-- profileelement
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue/ongoing', 'on-going', 'The process has started in the past and is still active.', 'LayerGenesisProcessStateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue/terminated', 'terminated', 'The process is no longer active.', 'LayerGenesisProcessStateValue', NULL, NULL, NULL, NULL);


-- FAOHorizonMaster
-- faohorizonnotationtype
-- INSPIRE
-- https://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue


INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/B', 'B', 'B horizons', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/O', 'O', 'O horizons or layers', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/C', 'C', 'C horizons or layers', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/E', 'E', 'E horizons', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/I', 'I', 'I layers', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/W', 'W', 'W layers', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/H', 'H', 'H horizons or layers', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/A', 'A', 'A horizons', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/R', 'R', 'R layers', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/L', 'L', 'L layers', 'FAOHorizonMasterValue', NULL, NULL, NULL, NULL);


-- FAOHorizonSubordinate
-- faohorizonnotationtype
-- INSPIRE
-- https://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue


INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/a', 'a', 'Highly decomposed organic material', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/b', 'b', 'Buried genetic horizon', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/c', 'c', 'Concretions or nodules', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/c-L', 'c-L', 'Coprogenous earth', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/f', 'f', 'Frozen soil', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/d-L', 'd-L', 'Diatomaceous earth', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/e', 'e', 'Moderately decomposed organic material', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/g', 'g', 'Stagnic conditions', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/d', 'd', 'Dense layer (physically root restrictive)', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/i-HO', 'i-HO', 'Slightly decomposed organic material;"Slightly decomposed organic material: In organic soils and used in combination with H or O horizons, it indicates the state of decomposition of the organic material', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/r', 'r', 'Strong reduction', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/u', 'u', 'Urban and other human-made materials', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/x', 'x', 'Fragipan characteristics', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/k', 'k', 'Accumulation of pedogenetic carbonates', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/l', 'l', 'Capillary fringe mottling (gleying)', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/z', 'z', 'Pedogenetic accumulation of salts more soluble than gypsum', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/@', '@', 'Evidence of cryoturbation', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/j', 'j', 'Jarosite accumulation', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/v', 'v', 'Occurrence of plinthite', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/t', 't', 'Illuvial accumulation of silicate clay', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/m-L', 'm-L', 'Marl', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/n', 'n', 'Pedogenetic accumulation of exchangeable sodium', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/h', 'h', 'Accumulation of organic matter', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/w', 'w', 'Development of colour or structure', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/m', 'm', 'Strong cementation or induration (pedogenetic, massive)', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/q', 'q', 'Accumulation of pedogenetic silica', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/o', 'o', 'Residual accumulation of sesquioxides (pedogenetic)', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/p', 'p', 'Ploughing or other human disturbance', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/s', 's', 'Illuvial accumulation of sesquioxides', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/i', 'i', 'Slickensides', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/y', 'y', 'Pedogenetic accumulation of gypsum', 'FAOHorizonSubordinateValue', NULL, NULL, NULL, NULL);

-- FAOPrime
-- faohorizonnotationtype
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/FAOPrimeValue

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/0','0','No Prime applies to this layer or horizon', 'FAOPrimeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/1','1','One Prime applies to this layer or horizon', 'FAOPrimeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/2','2','Two Primes apply to this layer or horizon', 'FAOPrimeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/3','3','Three Primes apply to this layer or horizon', 'FAOPrimeValue', NULL, NULL, NULL, NULL);

-- ResponsiblePartyRole
-- relatedparty
-- INSPIRE
-- http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/resourceProvider', 'Resource Provider', 'Party that supplies the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/custodian', 'Custodian', 'Party that accepts accountability and responsibility for the data and ensures appropriate care and maintenance of the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/owner', 'Owner', 'Party that owns the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/user', 'User', 'Party who uses the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/distributor', 'Distributor', 'Party who distributes the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/originator', 'Originator', 'Party who created the resource', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/pointOfContact', 'Point of Contact', 'Party who can be contacted for acquiring knowledge about or acquisition of the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/principalInvestigator', 'Principal Investigator', 'Key party responsible for gathering information and conducting research.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/processor', 'Processor', 'Party who has processed the data in a manner such that the resource has been modified.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/publisher', 'Publisher', 'Party who published the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/author', 'Author', 'Party who authored the resource.', 'ResponsiblePartyRole', NULL, NULL, NULL, NULL);

-- SoilInvestigationPurposeValue
-- soilsite
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue/generalSoilSurvey', 'general soil survey', 'Soil characterisation with unbiased selection of investigation location.', 'SoilInvestigationPurposeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue/specificSoilSurvey', 'specific soil survey', 'Investigation of soil properties at locations biased by a specific purpose.', 'SoilInvestigationPurposeValue', NULL, NULL, NULL, NULL);

-- SoilPlotTypeValue
-- soilplot
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/borehole', 'borehole', 'Penetration into the sub-surface with removal of soil/rock material by using, for instance, a hollow tube-shaped tool, in order to carry out profile descriptions, sampling and/or field tests.', 'SoilPlotTypeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/sample', 'sample', 'Exacavation where soil material is removed as a soil sample without doing any soil profile description.', 'SoilPlotTypeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/trialPit', 'trial pit', 'Excavation or other exposition of the soil prepared to carry out profile descriptions, sampling and/or field tests.', 'SoilPlotTypeValue', NULL, NULL, NULL, NULL);

-- WRBReferenceSoilGroupValue
-- soilprofile
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/acrisol', 'Acrisols', 'Soil having an argic horizon, CECclay < 50%.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/albeluvisol', 'Albeluvisols', 'Soil having an argic horizon and albeluvic tonguin.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/alisol', 'Alisols', 'Soil having an argic horizon with CECclay >24 and BS < 50%.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/andosol', 'Andosols', 'Soil having an andic or vitric horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/anthrosol', 'Anthrosols', 'Soils profoundly modified through long-term human activities.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/arenosol', 'Arenosols', 'Soil having a coarse texture up to >100 cm depth.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/calcisol', 'Calcisols', 'Soil having a calcic or petrocalcic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/cambisol', 'Cambisols', 'Soil having a cambic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/chernozem', 'Chernozems', 'Soil having a chernic or blackish mollic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/cryosol', 'Cryosols', 'Soil having a cryic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/durisol', 'Durisols', 'Soil having a duric or petroduric horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/ferralsol', 'Ferralsols', 'Soil having a ferralic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/fluvisol', 'Fluvisols', 'Soil having a fluvic materials.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/gleysol', 'Gleysols', 'Soil having a gleyic properties.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/gypsisol', 'Gypsisols', 'Soil having a gypsic or petrogypsic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/histosol', 'Histosols', 'Soil having organic matter >40 cm depth.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/kastanozem', 'Kastanozems', 'Soil having a brownish mollic horizon and secondary CaCO3.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/leptosol', 'Leptosols', 'Shallow soils, <=25 cm deep', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/lixisol', 'Lixisols', 'Soil having an argic horizon and CECclay <24.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/luvisol', 'Luvisols', 'Soil having an argic horizon and CECclay >24.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/nitisol', 'Nitisols', 'Soil having a nitic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/phaeozem', 'Phaeozems', 'Soil having a mollic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/planosol', 'Planosols', 'Soil having reducing condition and pedogenetic abrupt textural change.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/plinthosol', 'Plinthosols', 'Soil having plinthite or petroplinthite.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/podzol', 'Podzols', 'Soil having a spodic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/regosol', 'Regosols', 'Soil without a diagnostic horizon', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/solonchak', 'Solonchaks', 'Soil having a salic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/solonetz', 'Solonetzs', 'Soil having a natric horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/stagnosol', 'Stagnosols', 'Soil having reducing condition.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/technosol', 'Technosols', 'Soil having a human artefacts.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/umbrisol', 'Umbrisols', 'Soil having an umbric horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/vertisol', 'Vertisols', 'Soil having a vertic horizon.', 'WRBReferenceSoilGroupValue', NULL, NULL, NULL, NULL);

-- WRBQualifierPlaceValue
-- wrbqualifiergrouptype
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/suffix', 'suffix', 'Suffix', 'WRBQualifierPlaceValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/prefix', 'prefix', 'Prefix', 'WRBQualifierPlaceValue', NULL, NULL, NULL, NULL);

-- WRBQualifierValue
-- wrbqualifiergrouptype
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/WRBQualifierValue

INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Abruptic', 'Abruptic', 'Abruptic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aceric', 'Aceric', 'Aceric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Acroxic', 'Acroxic', 'Acroxic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Albic', 'Albic', 'Albic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Alcalic', 'Alcalic', 'Alcalic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Alumic', 'Alumic', 'Alumic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Anthric', 'Anthric', 'Anthric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Arenic', 'Arenic', 'Arenic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aridic', 'Aridic', 'Aridic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Brunic', 'Brunic', 'Brunic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Calcaric', 'Calcaric', 'Calcaric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Carbonatic', 'Carbonatic', 'Carbonatic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Chloridic', 'Chloridic', 'Chloridic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Chromic', 'Chromic', 'Chromic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Clayic', 'Clayic', 'Clayic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Colluvic', 'Colluvic', 'Colluvic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Densic', 'Densic', 'Densic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Drainic', 'Drainic', 'Drainic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Dystric', 'Dystric', 'Dystric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endoduric', 'Endoduric', 'Endoduric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endoeutric', 'Endoeutric', 'Endoeutric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Epidystric', 'Epidystric', 'Epidystric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Epieutric', 'Epieutric', 'Epieutric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Escalic', 'Escalic', 'Escalic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Eutric', 'Eutric', 'Eutric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ferric', 'Ferric', 'Ferric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fragic', 'Fragic', 'Fragic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gelic', 'Gelic', 'Gelic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Geric', 'Geric', 'Geric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Glossalbic', 'Glossalbic', 'Glossalbic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Glossic', 'Glossic', 'Glossic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Greyic', 'Greyic', 'Greyic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gypsiric', 'Gypsiric', 'Gypsiric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Haplic', 'Haplic', 'Haplic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hortic', 'Hortic', 'Hortic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Humic', 'Humic', 'Humic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperdystric', 'Hyperdystric', 'Hyperdystric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypereutric', 'Hypereutric', 'Hypereutric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperochric', 'Hyperochric', 'Hyperochric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyposalic', 'Hyposalic', 'Hyposalic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyposodic', 'Hyposodic', 'Hyposodic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Lamellic', 'Lamellic', 'Lamellic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Laxic', 'Laxic', 'Laxic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Magnesic', 'Magnesic', 'Magnesic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Manganiferric', 'Manganiferric', 'Manganiferric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Mesotrophic', 'Mesotrophic', 'Mesotrophic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Novic', 'Novic', 'Novic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Nudiargic', 'Nudiargic', 'Nudiargic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ornithic', 'Ornithic', 'Ornithic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Oxyaquic', 'Oxyaquic', 'Oxyaquic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pachic', 'Pachic', 'Pachic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pellic', 'Pellic', 'Pellic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petrogleyic', 'Petrogleyic', 'Petrogleyic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pisocalcic', 'Pisocalcic', 'Pisocalcic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Placic', 'Placic', 'Placic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Plaggic', 'Plaggic', 'Plaggic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Profondic', 'Profondic', 'Profondic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Protothionic', 'Protothionic', 'Protothionic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Reductaquic', 'Reductaquic', 'Reductaquic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Reductic', 'Reductic', 'Reductic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Rhodic', 'Rhodic', 'Rhodic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ruptic', 'Ruptic', 'Ruptic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Siltic', 'Siltic', 'Siltic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Skeletic', 'Skeletic', 'Skeletic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sodic', 'Sodic', 'Sodic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sombric', 'Sombric', 'Sombric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sulphatic', 'Sulphatic', 'Sulphatic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Takyric', 'Takyric', 'Takyric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Tephric', 'Tephric', 'Tephric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Terric', 'Terric', 'Terric', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thaptobathyfragic', 'Thaptobathyfragic', 'Thaptobathyfragic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thionic', 'Thionic', 'Thionic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thixotropic', 'Thixotropic', 'Thixotropic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Toxic', 'Toxic', 'Toxic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Transportic', 'Transportic', 'Transportic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Turbic', 'Turbic', 'Turbic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Umbriglossic', 'Umbriglossic', 'Umbriglossic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Vermic', 'Vermic', 'Vermic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Xanthic', 'Xanthic', 'Xanthic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Yermic', 'Yermic', 'Yermic', 'WRBQualifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Bathi', 'Bathi', 'Bathi', 'WRBQualifierValue', NULL, NULL, NULL, NULL);

-- Example so.codelistnot published online -------------------------------------------------------------
-- WRBSpecifiers
-- wrbqualifiergrouptype
-- CREA 
-- http://inspire.ec.europa.eu/codelist/WRBSpecifierValue (void)

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Bathi', 'Bathi', 'Bathi', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Cumuli', 'Cumuli', 'Cumuli', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Endo', 'Endo', 'Endo', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Epi', 'Epi', 'Epi', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Hyper', 'Hyper', 'Hyper', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Hypo', 'Hypo', 'Hypo', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Ortho', 'Ortho', 'Ortho', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Para', 'Para', 'Para', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Proto', 'Proto', 'Proto', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Thapto', 'Thapto', 'Thapto', 'WRBSpecifierValue', NULL, NULL, NULL, NULL);

-- Internal so.codelistfor managing forms -------------------------------------------------------------
-- OtherHorizonNotationType
-- otherhorizonnotationtype
-- CREA
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('WRBdiagnostichorizon', 'WRB', 'WRB Diagnostic Horizon', 'OtherHorizonNotationTypeValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('USDAdiagnostichorizon', 'USDA', 'USDA Diagnostic Horizon', 'OtherHorizonNotationTypeValue', NULL, NULL, NULL, NULL);

-- Example so.codelistnot published online -------------------------------------------------------------
-- WRBdiagnostichorizon
-- otherhorizonnotationtype
-- CREA

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/albic', 'albic', 'albico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/andic', 'andic', 'andico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/anthraquic', 'anthraquic', 'antraquico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/argic', 'argic', 'argico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/calcic', 'calcic', 'calcico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/cambic', 'cambic', 'cambico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/chernic', 'chernic', 'chernico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/cryic', 'cryic', 'cryico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/duric', 'duric', 'durico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ferralic', 'ferralic', 'ferralico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ferric', 'ferric', 'ferrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/folistic', 'folistic', 'folico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/fragic', 'fragic', 'fragico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/fulvic', 'fulvic', 'fulvico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/gypsic', 'gypsic', 'gypsico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/histic', 'histic', 'histico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/idragric', 'idragric', 'idragrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/irragric', 'irragric', 'irragrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/melanic', 'melanic', 'melanico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/mollic', 'mollic', 'mollico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/natric', 'natric', 'natrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/nitic', 'nitic', 'nitico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ochric', 'ochric', 'ocrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ortic', 'ortic', 'ortico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petrocalcic', 'petrocalcic', 'petrocalcico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petroduric', 'petroduric', 'petrodurico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petrogypsic', 'petrogypsic', 'petrogypsico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petroplinthic', 'petroplinthic', 'petroplintico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/plaggen', 'plaggen', 'plaggico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/plinthic', 'plinthic', 'plintico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/salic', 'salic', 'salico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/spodic', 'spodic', 'spodico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/sulfuric', 'sulfuric', 'solforico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/takyric', 'takyric', 'takyrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/terric', 'terric', 'terrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/umbric', 'umbric', 'umbrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/vertic', 'vertic', 'vertico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/vitric', 'vitric', 'vitrico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/yermic', 'yermic', 'yermico', 'WRBdiagnostichorizon', NULL, NULL, NULL, NULL);

-- Example so.codelistnot published online -------------------------------------------------------------
-- diagnostichorizon
-- otherhorizonnotationtype
-- CREA

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/USDA/diagnostichorizon/12386', 'Void', 'Void', 'USDAdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/USDA', NULL, NULL, NULL);

-- Example so.codelistnot published online -------------------------------------------------------------
-- OtherSoilNameTypeValue
-- othersoilnametype
-- CREA

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/OtherSoilNameTypeValue/OSN', 'Void', 'Void', 'OtherSoilNameTypeValue', NULL, NULL, NULL, NULL);

-- SoilSiteParameterNameValue
-- soilsite
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalAs', 'Arsenic and compounds (as As)', 'as in E-PRTR, CAS-Nr.: 7440-38-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalBa', 'Barium and compounds (as Ba)', 'CAS-Nr.: 82870-81-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCd', 'Cadmium and compounds (as Cd)', 'as in E-PRTR, CAS-Nr.: 7440-43-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCr', 'Chromium and compounds (as Cr)', 'as in E-PRTR, CAS-Nr.: 7440-47-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCo', 'Cobalt and compounds (as Co)', 'CAS-Nr.: 7440-48-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCu', 'Copper and compounds (as Cu)', 'as in E-PRTR, CAS-Nr.: 7440-50-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalHg', 'Mercury and compounds (as Hg)', 'as in E-PRTR, CAS-Nr.: 7439-97-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalNi', 'Nickel and compounds (as Ni)', 'as in E-PRTR, CAS-Nr.: 7440-02-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalPb', 'Lead and compounds (as Pb)', 'as in E-PRTR, CAS-Nr.: 7439-92-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalTl', 'Thallium and compounds (as Tl)', 'CAS-Nr.: 82870-81-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalZn', 'Zinc and compounds (as Zn)', 'as in E-PRTR, CAS-Nr.: 7440-66-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalSb', 'Antimony and compounds (as Sb)', 'CAS-Nr.: 7440-36-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalV', 'Vanadium and compounds (as V)', 'CAS-Nr.: 7440-62-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalMo', 'Molybdenum and compounds (as Mo)', 'CAS-Nr.: 7439-89-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/organometalSn', 'Organotin compounds (as total Sn)', 'as in E-PRTR, CAS-Nr.: 7440-31-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/organometalTributylSn', 'Tributyltin and compounds (total mass)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/organometalTriphenylSn', 'Triphenyltin and compounds (total mass)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/inorganicAsbestos', 'Asbestos', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/inorganicCN', 'Cyanides (as total CN)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/inorganicF', 'Fluorides (as total F)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticBTEX', 'BTEX', 'as in E-PRTR,  Sum of benzene, toluene. Ethylbenzene and Xylenes', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticBenzene', 'Benzene', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticToluene', 'Toluene', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticEthylbenzene', 'Ethylbenzene', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticXylene', 'Xylene', 'as in E-PRTR, sum of 3 isomers', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticStyrene', 'Styrene', 'Styrene', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCBs', 'Polychlorinated biphenyls (PCBs)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB28', 'Polychlorinated biphenyl 28', 'CAS-Nr.: 7012-37-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB52', 'Polychlorinated biphenyls 52', 'CAS-Nr.: 35693-99-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB101', 'Polychlorinated biphenyls 101', 'CAS-Nr.: 37680-73-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB138', 'Polychlorinated biphenyls 138', 'CAS-Nr.: 35065-28-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB153', 'Polychlorinated biphenyls 153', 'CAS-Nr.: 35065-27-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB180', 'Polychlorinated biphenyls 180', 'CAS-Nr.: 35065-29-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB77', 'Polychlorinated biphenyls 77', 'as in POP convention, CAS-Nr.: 1336-36-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB81', 'Polychlorinated biphenyls 81', 'as in POP convention, CAS-Nr.: 70362-50-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB126', 'Polychlorinated biphenyls 126', 'as in POP convention, CAS-Nr.: 57465-288', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB169', 'Polychlorinated biphenyls 169', 'as in POP convention, CAS-Nr.: 32774-16-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB105', 'Polychlorinated biphenyls 105', 'as in POP convention, CAS-Nr.: 32598-14-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB114', 'Polychlorinated biphenyls 114', 'as in POP convention, CAS-Nr.: 74472-37-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB118', 'Polychlorinated biphenyls 118', 'as in POP convention, CAS-Nr.: 31508-00-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB123', 'Polychlorinated biphenyls 123', 'as in POP convention, CAS-Nr.: 65510-44-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB156', 'Polychlorinated biphenyls 156', 'as in POP convention, CAS-Nr.: 38380-08-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB157', 'Polychlorinated biphenyls 157', 'as in POP convention, CAS-Nr.: 69782-90-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB167', 'Polychlorinated biphenyls 167', 'as in POP convention, CAS-Nr.: 52663-72-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB189', 'Polychlorinated biphenyls 189', 'as in POP convention, CAS-Nr.: 39635-31-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticHCB', 'Hexachlorobenzene (HCB)', 'as in E-PRTR, CAS-Nr.: 118-74-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCDD-PCF', 'PCDD+PCDF (dioxines and furans; as Teq)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-7-8-Tetra-CDD', '2,3,7,8-Tetra-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-Penta-CDD', '1,2,3,7,8-Penta-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-7-8-Hexa-CDD', '1,2,3,4,7,8-Hexa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-6-7-8-Hexa-CDD', '1,2,3,6,7,8-Hexa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-9-Hexa-CDD', '1,2,3,7,8,9-Hexa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-3-6-7-8-Hepta-CDD', '1,2,3,3,6,7,8-Hepta-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-6-7-8-9-Octa-CDD', '1,2,3,4,6,7,8,9-Octa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-7-8-Tetra-CDF', '2,3,7,8-Tetra-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-Penta-CDF', '1,2,3,7,8-Penta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-4-7-8-Penta-CDF', '2,3,4,7,8-Penta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-7-8-Hexa-CDF', '1,2,3,4,7,8-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-6-7-8-Hexa-CDF', '1,2,3,6,7,8-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-9-Hexa-CDF', '1,2,3,7,8,9-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-4-6-7-8-Hexa-CDF', '2,3,4,6,7,8-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-6-7-8-Hepta-CDF', '1,2,3,4,6,7,8-Hepta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-7-8-9-Hepta-CDF', '1,2,3,4,7,8,9-Hepta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-6-7-8-9-Octa-CDF', '1,2,3,4,6,7,8,9-Octa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticClbenzenes', 'Chlorobenzenes (total)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticTriClbenzenes', 'Trichlorobenzenes', 'Chlorobenzenes (total)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPentaClbenzene', 'Pentachlorobenzene', 'as in E-PRTR, CAS-Nr.: 608-93-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticHCBD', 'Hexachlorobutadiene (HCBD)', 'as in E-PRTR, CAS-Nr.: 87-68-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticHBB', 'Hexabromobiphenyl (HBB)', 'as in E-PRTR, CAS-Nr.: 36355-1-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticBDPE', 'Brominated diphenylether (sum) / Pentabromodiphenylether', 'as in priority substances EU water policy, CAS-Nr.: ../32534-81-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic6-7BDPE', 'Hexabromodiphenyl ether and heptabromodiphenyl ether', 'as in POP convention', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic4-5BDPE', 'Tetrabromodiphenyl ether and Pentabromodiphenyl ether', 'as in POP convention', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticAOX', 'halogenated organic compounds (as AOX)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticC10-13', 'Chloro-alkanes C10-C13', 'as in priority substances EU water policy, CAS-Nr.: 85535-84-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticTCE', '{Trichloroethylene}', 'as in E-PRTR,CAS-Nr.:  79-01-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticPCE', '{Tetrachloroethylene (or Perchloroethylene)}', 'as in E-PRTR, CAS-Nr.: 127-18-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticDCM', 'Dichloromethane (DCM)', 'as in E-PRTR, CAS-Nr.: 75-09-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticTriCM', '{Trichloromethane (chloroform)}', 'as in E-PRTR, CAS-Nr.: 67-66-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticEDC', '1,2-dichlorethane (EDC)', 'as in E-PRTR, CAS-Nr.: 107-06-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticTCM', '{Tetrachloromethane (TCM)}', 'as in E-PRTR, CAS-Nr.: 56-23-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticVinylCl', 'Vinylchloride', 'as in E-PRTR, CAS-Nr.: 75-01-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticPFOS-A', 'Perfluorooctane sulfonic (acid and salts) and Perfluorooctane sulfonyl fluoride', 'as in E-PRTR,', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsTotal', 'Phenols (as total C of phenols)', 'as in E-PRTR,  108-95-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsPCP', 'Pentachlorophenol (PCP)', 'as in E-PRTR, 87-86-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsClPTotal', 'Chlorophenols (total)', 'Chlorophenols (total)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsNonylP', 'Nonylphenols / (4-nonylphenol)', 'as in priority substances EU water policy, CAS-Nr.: 25154-52-3/(104-40-5)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsOctylP', '{Octylphenols and octylphenolethoxylates}', 'as in E-PRTR, CAS-Nr.: 1806-26-4/ 140-66-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAHsum', 'PAHs sum or report specific releases of', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BaP', 'Benzo(a)pyrene', 'as in E-PRTR, CAS-Nr.: 50-32-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BbF', 'Benzo(b)fluoranthene', 'as in E-PRTR, CAS-Nr.: 205-99-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BkF', 'Benzo(k)fluoranthene', 'as in E-PRTR, CAS-Nr.: 207-08-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-IcP', 'Indeno(1,23-cd)pyrene', 'as in E-PRTR, CAS-Nr.: 193-39-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BgP', '{Benzo(g,h,i)perylene}', 'as in E-PRTR, CAS-Nr.: 191-24-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-ANT', 'Anthracene', 'as in E-PRTR, CAS-Nr.: 120-12-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-NAP', 'Naphtalene', 'as in E-PRTR, CAS-Nr.: 91-20-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-ACY', 'Acenaphthylene', 'CAS-Nr.: 208-96-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-ACE', 'Acenaphthene', 'CAS-Nr.: 83-32-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-FLE', 'Fluorene', 'CAS-Nr.: 86-73-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-PHE', 'Phenanthrene', 'CAS-Nr.: 85-01-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-FLA', 'Fluoranthene', 'CAS-Nr.: 206-44-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-PYE', 'Pyrene', 'CAS-Nr.: 129-00-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BaA', 'Benzo(a)anthracene', 'CAS-Nr.: 56-55-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-CHE', 'Chrysene', 'CAS-Nr.: 218-01-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-DaA', 'Dibenzo(a,h)anthracene', 'CAS-Nr.: 53-70-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAldrin', 'Aldrin', 'as in E-PRTR, CAS-Nr.: 309-00-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDieldrin', 'Dieldrin', 'as in E-PRTR, CAS-Nr.: 60-57-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideEndrin', 'Endrin', 'as in E-PRTR, CAS-Nr.: 72-20-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideIsodrin', '{Isodrin}', 'as in E-PRTR, 465-73-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideOpDDT', 'op-DDT', 'CAS-Nr.: 789-02-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticidePpDDT', 'pp-DDT', 'CAS-Nr.: 50-29-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAlHCH', 'alpha-HCH', 'CAS-Nr.: 319-84-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideBeHCH', 'beta-HCH', 'CAS-Nr.: 319-85-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDeHCH', 'delta-HCH', 'CAS-Nr.: 319-86-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideGaHCH', 'gamma-HCH (Lindan)', 'as in E-PRTR, CAS-Nr.: 58-89-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAtrazin', 'Atrazine', 'as in E-PRTR, 1912-24-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlordane', 'Chlordane', 'as in E-PRTR, 57-74-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlordecone', 'Chlordecone', 'as in E-PRTR, CAS-Nr.:143-50-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlorfenvinphos', 'Chlorfenvinphos', 'as in E-PRTR, CAS-Nr.:470-90-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlorpyrifos', 'Chlorpyrifos', 'as in E-PRTR, CAS-Nr.:2921-88-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDiuron', 'Diuron', 'as in E-PRTR, CAS-Nr.:330-54-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideEndosulphan', 'Endosulphan', 'as in E-PRTR, CAS-Nr.:115-29-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideHeptachlor', 'Heptachlor', 'as in E-PRTR, CAS-Nr.:76-44-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideMirex', 'Mirex', 'as in E-PRTR, CAS-Nr.:2385-85-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideSimazine', 'Simazine', 'as in E-PRTR, CAS-Nr.:122-34-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideToxaphene', 'Toxaphene', 'as in E-PRTR, CAS-Nr.:8001-35-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideIsoproturon', 'Isoproturon', 'as in E-PRTR, CAS-Nr.:34123-59-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDEHP', 'Di-(2-ethyl hexyl) phtalate (DEHP)', 'as in priority substances EU water policy, CAS-Nr.:117-81-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideTrifluralin', 'Trifluralin', 'as in E-PRTR, CAS-Nr.:1582-09-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAlachlor', 'Alachlor', 'as in E-PRTR, CAS-Nr.:15972-60-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideCyclodiene', 'Cyclodiene pesticides', 'as in priority substances EU water policy', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/otherMTBE', 'Methyl tertiary-butyl ether (MTBE)', 'CAS-Nr.:1634-04-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/otherMineralOil', 'Mineral oil', 'Mineral oil', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/otherPhtalatesTotal', 'Phtalates (total)', 'Phtalates (total)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', NULL);

-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- CONTINUE 
-- SoilSiteParameterNameValue
-- soilsite
-- CREA
-- http:

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PHISICAL AND BIOLOGICA TOGETHER ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================

INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Land use', 'Land use', 'http://inspire.ec.europa.eu/theme/lu', 'SoilSiteParameterNameValue', 'soilsite', 'biological', 'soilsitebiological', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Flora', 'Flora', 'http://lod.nal.usda.gov/nalt/17393', 'SoilSiteParameterNameValue', 'soilsite', 'biological', 'soilsitebiological', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Flora - Above - ground biomass', 'Flora above ground biomass', 'http://lod.nal.usda.gov/nalt/131626', 'SoilSiteParameterNameValue', 'soilsite', 'biological', 'soilsitebiological', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Mechanic - Particle - size distribution - Coarse fragments', 'Coarse fragments', 'http://lod.nal.usda.gov/nalt/27363', 'SoilSiteParameterNameValue', 'soilsite', 'physical', 'soilsitephysical', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Meteorological geographical features - Hydrologic', 'Hydrology', 'http://www.eionet.europa.eu/gemet/concept/4118', 'SoilSiteParameterNameValue', 'soilsite', 'physical', 'soilsitephysical', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Meteorological geographical features - Thermic', 'Thermic', 'http://lod.nal.usda.gov/nalt/61641', 'SoilSiteParameterNameValue', 'soilsite', 'physical', 'soilsitephysical', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Morphological features', 'Morphological features', 'http://lod.nal.usda.gov/nalt/26939', 'SoilSiteParameterNameValue', 'soilsite', 'physical', 'soilsitephysical', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Morphological features - Voids', 'Voids', 'http://lod.nal.usda.gov/nalt/63409', 'SoilSiteParameterNameValue', 'soilsite', 'physical', 'soilsitephysical', NULL);


-- SoilProfileParameterNameValue
-- soilprofile
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PHISICAL AND CHEMICAL TOGETHER ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/carbonStock', 'carbon stock', 'The total mass of carbon in soil for a given depth.', 'SoilProfileParameterNameValue', 'soilprofile', 'chemical', 'soilprofilechemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/potentialRootDepth', 'potential root depth', 'Potential depth of the soil profile where roots develop (in cm).', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/availableWaterCapacity', 'available water capacity', 'Amount of water that a soil can store that is usable by plants, based on the potential root depth.', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/waterDrainage', 'water drainage', 'Natural internal water drainage class of the soil profile.', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', NULL);

-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- CONTINUE 
-- SoilProfileParameterNameValue
-- soilsite
-- CREA
-- http:
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================

INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Mechanic - Particle - size distribution - Coarse fragments', 'Coarse fragments', 'http://lod.nal.usda.gov/nalt/27363', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Meteorological geographical features - Hydrologic', 'Hydrology', 'http://www.eionet.europa.eu/gemet/concept/4118', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', NULL);
INSERT INTO so.codelist(definition, label, id, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Morphological features', 'Morphological features', 'http://lod.nal.usda.gov/nalt/26939', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', NULL);




-- SoilDerivedObjectParameterNameValue
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PHISICAL AND CHEMICAL TOGETHER ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/carbonStock', 'carbon stock', 'The total mass of carbon in soil for a given depth.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/organicCarbonContent', 'organic carbon content', 'Portion of the soil measured as carbon in organic form, excluding living macro and mesofauna and living plant tissue.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/nitrogenContent', 'nitrogen content', 'Total nitrogen content in the soil, including both the organic and inorganic forms.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/pHValue', 'pH value', 'pH value of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/cadmiumContent', 'cadmium content', 'Cadmium content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/chromiumContent', 'chromium content', 'Chromium content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/copperContent', 'copper content', 'Copper content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/leadContent', 'lead content', 'Lead content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/mercuryContent', 'mercury content', 'Mercury content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/nickelContent', 'nickel content', 'Nickel content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/zincContent', 'zinc content', 'Zinc content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/potentialRootDepth', 'potential root depth', 'Potential depth of the soil profile where roots develop (in cm).', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'physical', 'soilderivedobjectphysical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/availableWaterCapacity', 'available water capacity', 'Amount of water that a soil can store that is usable by plants, based on the potential root depth.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'physical', 'soilderivedobjectphysical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/waterDrainage', 'water drainage', 'Natural water drainage class of the soil profile.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'physical', 'soilderivedobjectphysical', NULL);

-- ProfileElementParameterNameValue
-- profileelement
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/organicCarbonContent', 'organic carbon content', 'Portion of the soil measured as carbon in organic forms, excluding living macro and mesofauna and living plant tissue.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/nitrogenContent', 'nitrogen content', 'total nitrogen content in the soil, including both the organic and inorganic forms.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/pHValue', 'pH value', 'pH value of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/cadmiumContent', 'cadmium content', 'Cadmium content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/chromiumContent', 'chromium content', 'Chromium content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/copperContent', 'copper content', 'Copper content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/leadContent', 'lead content', 'Lead content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/mercuryContent', 'mercury content', 'Mercury content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/nickelContent', 'nickel content', 'Nickel content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', NULL);


-- =================================================================================??????????????????????????????????????????????????????????????????????????????????????=================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- SoilProfileParameterNameValue   DUPLICATO SOPRA CONTROLLARE
-- soilprofile
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================
-- ========================================================================================================================================================================================================================================================================================

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/pe_phisical', 'Void', 'Void', 'SoilProfileParameterNameValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/pe_biological', 'Void', 'Void', 'SoilProfileParameterNameValue', NULL, NULL, NULL, NULL);

-- LithologyValue
-- profileelement
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/LithologyValue

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/acidicIgneousMaterial', 'acidicIgneousMaterial', 'acidicIgneousMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/acidicIgneousRock', 'acidicIgneousRock', 'acidicIgneousRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/alkaliFeldsparRhyolite', 'alkaliFeldsparRhyolite', 'alkaliFeldsparRhyolite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/amphibolite', 'amphibolite', 'amphibolite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/anthropogenicMaterial', 'anthropogenicMaterial', 'anthropogenicMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/ashAndLapilli', 'ashAndLapilli', 'ashAndLapilli', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/ashBrecciaBombOrBlockTephra', 'ashBrecciaBombOrBlockTephra', 'ashBrecciaBombOrBlockTephra', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/basicIgneousMaterial', 'basicIgneousMaterial', 'basicIgneousMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/boulderGravelSizeSediment', 'boulderGravelSizeSediment', 'boulderGravelSizeSediment', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/breccia', 'breccia', 'breccia', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateMudstone', 'carbonateMudstone', 'carbonateMudstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateRichMudstone', 'carbonateRichMudstone', 'carbonateRichMudstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateSedimentaryMaterial', 'carbonateSedimentaryMaterial', 'carbonateSedimentaryMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateSedimentaryRock', 'carbonateSedimentaryRock', 'carbonateSedimentaryRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/cataclasiteSeries', 'cataclasiteSeries', 'cataclasiteSeries', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chalk', 'chalk', 'chalk', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chemicalSedimentaryMaterial', 'chemicalSedimentaryMaterial', 'chemicalSedimentaryMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chloriteActinoliteEpidoteMetamorphicRock', 'chloriteActinoliteEpidoteMetamorphicRock', 'chloriteActinoliteEpidoteMetamorphicRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/clasticSedimentaryMaterial', 'clasticSedimentaryMaterial', 'clasticSedimentaryMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/crystallineCarbonate', 'crystallineCarbonate', 'crystallineCarbonate', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/dacite', 'dacite', 'dacite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/dolomite', 'dolomite', 'dolomite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/eclogite', 'eclogite', 'eclogite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/foliatedMetamorphicRock', 'foliatedMetamorphicRock', 'foliatedMetamorphicRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/fragmentalIgneousMaterial', 'fragmentalIgneousMaterial', 'fragmentalIgneousMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/framestone', 'framestone', 'framestone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericConglomerate', 'genericConglomerate', 'genericConglomerate', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericMudstone', 'genericMudstone', 'genericMudstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericSandstone', 'genericSandstone', 'genericSandstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/gneiss', 'gneiss', 'gneiss', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/grainstone', 'grainstone', 'grainstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granite', 'granite', 'granite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granodiorite', 'granodiorite', 'granodiorite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granofels', 'granofels', 'granofels', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granulite', 'granulite', 'granulite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hornfels', 'hornfels', 'hornfels', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hybridSediment', 'hybridSediment', 'hybridSediment', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hybridSedimentaryRock', 'hybridSedimentaryRock', 'hybridSedimentaryRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/igneousMaterial', 'igneousMaterial', 'igneousMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/igneousRock', 'igneousRock', 'igneousRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureCarbonateSedimentaryRock', 'impureCarbonateSedimentaryRock', 'impureCarbonateSedimentaryRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureDolomite', 'impureDolomite', 'impureDolomite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureLimestone', 'impureLimestone', 'impureLimestone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/intermediateCompositionIgneousMaterial', 'intermediateCompositionIgneousMaterial', 'intermediateCompositionIgneousMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/limestone', 'limestone', 'limestone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/marble', 'marble', 'marble', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/materialFormedInSurficialEnvironment', 'materialFormedInSurficialEnvironment', 'materialFormedInSurficialEnvironment', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/metamorphicRock', 'metamorphicRock', 'metamorphicRock', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/micaSchist', 'micaSchist', 'micaSchist', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/migmatite', 'migmatite', 'migmatite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/mineDumpMaterial', 'mineDumpMaterial', 'mineDumpMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/monzogranite', 'monzogranite', 'monzogranite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/mudSizeSediment', 'mudSizeSediment', 'mudSizeSediment', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/naturalUnconsolidatedMaterial', 'naturalUnconsolidatedMaterial', 'naturalUnconsolidatedMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/nonClasticSiliceousSedimentaryMaterial', 'nonClasticSiliceousSedimentaryMaterial', 'nonClasticSiliceousSedimentaryMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/organicBearingMudstone', 'organicBearingMudstone', 'organicBearingMudstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/organicRichSedimentaryMaterial', 'organicRichSedimentaryMaterial', 'organicRichSedimentaryMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/packstone', 'packstone', 'packstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/peat', 'peat', 'peat', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/phyllite', 'phyllite', 'phyllite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/sandSizeSediment', 'sandSizeSediment', 'sandSizeSediment', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/silicateMudstone', 'silicateMudstone', 'silicateMudstone', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/skarn', 'skarn', 'skarn', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/slate', 'slate', 'slate', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/syenogranite', 'syenogranite', 'syenogranite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tephra', 'tephra', 'tephra', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tonalite', 'tonalite', 'tonalite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tuffite', 'tuffite', 'tuffite', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/unconsolidatedMaterial', 'unconsolidatedMaterial', 'unconsolidatedMaterial', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/waste', 'waste', 'waste', 'LithologyValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', 'https://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', 'https://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', 'LithologyValue', NULL, NULL, NULL, NULL);

-- EventEnvironmentValue
-- profileelement
-- INSPIRE
-- http://inspire.ec.europa.eu/codelist/EventEnvironmentValue

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/agriculturalAndForestryLandSetting''', 'agricultural and forestry land setting', 'Human influence setting with intensive agricultural activity or forestry land use,  including forest plantations.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/carbonateShelfSetting', 'carbonate shelf setting', 'A type of carbonate platform that is attached to a continental landmass and a region of sedimentation that is analogous to shelf environments for terrigenous clastic deposition. A carbonate shelf may receive some supply of material from the adjacent landmass.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaSlopeSetting', 'delta slope setting', 'Slope setting within the deltaic  system.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dwellingAreaSetting', 'dwelling area setting', 'Dwelling area setting.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/earthInteriorSetting', 'earth interior setting', 'Geologic environments within the solid Earth.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/earthSurfaceSetting', 'earth surface setting', 'Geologic environments on the surface of the solid Earth.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/extraTerrestrialSetting', 'extra-terrestrial setting', 'Material originated outside of the Earth or its atmosphere.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/fanDeltaSetting', 'fan delta setting', 'A debris-flow or sheetflood-dominated alluvial fan build out into a lake or the sea.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/foreshore', 'foreshore', 'A foreshore is the region between mean high water and mean low water marks of the tides. Depending on the tidal range this may be a vertical distance of anything from a few tens of centimetres to many meters.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciofluvialSetting', 'glaciofluvial setting', 'A setting influenced by glacial meltwater streams. This setting can be sub- en-, supra- and proglacial.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciolacustrineSetting', 'glaciolacustrine setting', 'Ice margin lakes and other lakes related to glaciers. Where meltwater streams enter the lake, sands and gravels are deposited in deltas. At the lake floor, typivally rhythmites (varves) are deposited.Ice margin lakes and other lakes related to glaciers.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciomarineSetting', 'glaciomarine setting', 'A marine environment influenced by glaciers. Dropstone diamictons and dropstone muds are typical deposits in this environment.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/graben', 'graben', 'An elongate trough or basin, bounded on both sides by high-angle normal faults that dip toward one another. It is a structual form that may or may not be geomorphologically expressed as a rift valley.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/halfGraben', 'half-graben', 'A elongate , asymmetric trough or basin bounded on one side by a normal fault.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humanEnvironmentSetting', 'human environment setting', 'Human environment setting.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intracratonicSetting', 'intracratonic setting', 'A basin formed within the interior region  of a continent, away from plate boundaries.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/landReclamationSetting', 'land reclamation setting', '''Human influence setting making land capable of more intensive use by changing its general character, as by drainage of excessively wet land, irrigation of arid or semiarid land; or recovery of submerged land from seas, lakes and rivers, restoration after human-induced degradation by removing toxic substances.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/miningAreaSetting', 'mining area setting', 'Human influence setting in which mineral resources are extracted from the ground.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/saltPan', 'salt pan', 'A small, undrained, shallow depression in which water accumulates and evaporates, leaving a salt deposit.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tectonicallyDefinedSetting', 'tectonically defined setting', 'Setting defined by relationships to tectonic plates on or in the Earth.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wasteAndMaterialDepositionAreaSetting', 'waste and material deposition area setting', 'Human influence setting in which non-natural or natural materials from elsewhere are deposited.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wetToSubHumidSetting', 'wet to sub-humid setting', '''A Wet to sub-humid climate is according Thornthwaite''s climate classification system associated with rain forests (wet), forests (humid) and grassland (sub-humid).''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/fastSpreadingCenterSetting', 'fast spreading center setting', 'Spreading center at which the opening rate is greater than 100 mm per year.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mediumRateSpreadingCenterSetting', 'medium-rate spreading center setting', 'Spreading center at which the opening rate is between 50 and 100 mm per year.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/slowSpreadingCenterSetting', 'slow spreading center setting', 'Spreading center at which the opening rate is less than 50 mm per year.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dunefieldSetting', 'dunefield setting', '''Extensive deposits on sand in an area where the supply is abundant. As a characteristic, individual dunes somewhat resemble barchans but are highly irregular in shape and crowded; erg areas of the Sahara are an example.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dustAccumulationSetting', 'dust accumulation setting', 'Setting in which finegrained particles accumulate, e.g. loess deposition.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/sandPlainSetting', 'sand plain setting', 'A sand-covered plain dominated by aeolian processes.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/gibberPlainSetting', 'gibber plain setting', '''A desert plain strewn with wind-abraded pebbles, or gibbers; a gravelly desert.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marginalMarineSabkhaSetting', 'marginal marine sabkha setting', 'Setting characterized by arid to semi-arid conditions on restricted coastal plains mostly above normal high tide level, with evaporite-saline mineral, tidal-flood, and eolian deposits. Boundaries with intertidal setting and non-tidal terrestrial setting are gradational. (Jackson, 1997, p. 561).', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/playaSetting', 'playa setting', 'The usually dry and nearly level plain that occupies the lowest parts of closed depressions, such as those occurring on intermontane basin floors. Temporary flooding occurs primarily in response to precipitation-runoff events.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierBeachSetting', 'barrier beach setting', '''A narrow, elongate sand or gravel ridge rising slightly above the high-tide level and extending generally parallel with the shore, but separated from it by a lagoon (Shepard, 1954, p.1904), estuary, or marsh; it is extended by longshore transport and is rarely more than several kilometers long.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierLagoonSetting', 'barrier lagoon setting', 'A lagoon that is roughly parallel to the coast and is separated from the open ocean by a strip of land or by a barrier reef. Tidal influence is typically restricted and the lagoon is commonly hypersaline.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerBathyalSetting', 'lower bathyal setting', 'The ocean environment at depths between 1000 and 3500 metres.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleBathyalSetting', 'middle bathyal setting', 'The ocean environment at water depths between 600 and 1000 metres.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperBathyalSetting', 'upper bathyal setting', 'The ocean environment at water depths between 200 and 600 metres.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/backreefSetting', 'backreef setting', '''The landward side of a reef. The term is often used adjectivally to refer to deposits within the restricted lagoon behind a barrier reef, such as the ''back-reef facies'' of lagoonal deposits. In some places, as on a platform-edge reef tract, ''back reef'' refers to the side of the reef away from the open sea, even though no land may be nearby.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forereefSetting', 'forereef setting', '''The seaward side of a reef; the slope covered with deposits of coarse reef talus.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/reefFlatSetting', 'reef flat setting', 'A stony platform of reef rock, landward of the reef crest at or above the low tide level, occasionally with patches of living coral and associated organisms, and commonly strewn with coral fragments and coral sand.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/basinBogSetting', 'basin bog setting', 'An ombrotrophic or ombrogene peat/bog whose nutrient supply is exclusively from rain water (including snow and atmospheric fallout) therefore making nutrients extremely oligotrophic.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/blanketBog', 'blanket bog', '''Topogeneous bog/peat whose moisture content is largely dependent on surface water. It is relatively rich in plant nutrients, nitrogen, and mineral matter, is mildly acidic to nearly neutral, and contains little or no cellulose; forms in topographic depressions with essential stagnat or non-moving minerotrophic water supply''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/collisionalSetting', 'collisional setting', 'ectonic setting in which two continental crustal plates impact and are sutured together after intervening oceanic crust is entirely consumed at a subduction zone separating the plates. Such collision typically involves major mountain forming events, exemplified by the modern Alpine and Himalayan mountain chains.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forelandSetting', 'foreland setting', 'The exterior area of an orogenic belt where deformation occurs without significant metamorphism. Generally the foreland is closer to the continental interior than other portions of the orogenic belt are.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hinterlandTectonicSetting', 'hinterland tectonic setting', '''Tectonic setting in the internal part of an orogenic belt, characterized by plastic deformation of rocks accompanied by significant metamorphism, typically involving crystalline basement rocks. Typically denotes the most structurally thickened part of an orogenic belt, between a magmatic arc or collision zone and a more ''external'' foreland setting.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerContinentalCrustalSetting', 'lower continental-crustal setting', 'Continental crustal setting characterized by upper amphibolite to granulite facies metamorphism, in situ melting, residual anhydrous metamorphic rocks, and ductile flow of rock bodies.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleContinentalCrustSetting', 'middle continental crust setting', 'Continental crustal setting characterized by greenschist to upper amphibolite facies metamorphism, plutonic igneous rocks, and ductile deformation.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperContinentalCrustalSetting', 'upper continental crustal setting', 'Continental crustal setting dominated by non metamorphosed to low greenschist facies metamorphic rocks, and brittle deformation.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalCrustalSetting', 'continental-crustal setting', '''That type of the Earth''s crust which underlies the continents and the continental shelves; it is equivalent to the sial and continental sima and ranges in thickness from about 25 km to more than 70 km under mountain ranges, averaging ~40 km. The density of the continental crust averages ~2.8 g/cm3 and is ~2.7 g.cm3 in the upper layer. The velocities of compressional seismic waves through it average ~6.5 km/s and are less than ~7.0 km/sec.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanicCrustalSetting', 'oceanic-crustal setting', '''That type of the Earth''s crust which underlies the ocean basins. The oceanic crust is 5-10 km thick; it has a density of 2.9 g/cm3, and compressional seismic-wave velocities travelling through it at 4-7.2 km/sec. Setting in crust produced by submarine volcanism at a mid ocean ridge.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/transitionalCrustalSetting', 'transitional-crustal setting', 'Crust formed in the transition zone between continental and oceanic crust, during the history of continental rifting that culminates in the formation of a new ocean.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaDistributaryChannelSetting', 'delta distributary channel setting', 'A divergent stream flowing away from the main stream and not returning to it, as in a delta or on an alluvial plain.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaDistributaryMouthSetting', 'delta distributary mouth setting', 'The mouth of a delta distributary channel where fluvial discharge moves from confined to unconfined flow conditions.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaFrontSetting', 'delta front setting', '''A narrow zone where deposition in deltas is most active, consisting of a continuous sheet of sand, and occurring within the effective depth of wave erosion (10 m or less). It is the zone separating the prodelta from the delta plain, and it may or may not be steep''''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaPlainSetting', 'delta plain setting', '''The level or nearly level surface composing the landward part of a large or compound delta; strictly, an alluvial plain characterized by repeated channel bifurcation and divergence, multiple distributary channels, and interdistributary flood basins.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarineDeltaSetting', 'estuarine delta setting', 'A delta that has filled, or is in the process of filling, an estuary.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/interdistributaryBaySetting', 'interdistributary bay setting', 'A pronounced indentation of the delta front between advancing stream distributaries, occupied by shallow water, and either open to the sea or partly enclosed by minor distributaries.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lacustrineDeltaSetting', 'lacustrine delta setting', 'The low, nearly flat, alluvial tract of land at or near the mouth of a river, commonly forming a triangular or fan-shaped plain of considerable area, crossed by many distributaries of the main river, perhaps extending beyond the general trend of the lake shore, resulting from the accumulation of sediment supplied by the river in such quantities that it is not removed by waves or currents. Most deltas are partly subaerial and partly below water.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/prodeltaSetting', 'prodelta setting', '''The part of a delta that is below the effective depth of wave erosion, lying beyond the delta front, and sloping gently down to the floor of the basin into which the delta is advancing and where clastic river sediment ceases to be a significant part of the basin-floor deposits; it is entirely below the water level.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerDeltaPlainSetting', 'lower delta plain setting', 'The part of a delta plain which is penetrated by saline water and is subject to tidal processes.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperDeltaPlainSetting', 'upper delta plain setting', 'The part of a delta plain essentially unaffected by basinal processes. They do not differ substantially from alluvial environments except that areas of swamp, marsh and lakes are usually more widespread and channels may bifurcate downstream.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/coastalDuneFieldSetting', 'coastal dune field setting', '''A dune field on low-lying land recently abandoned or built up by the sea; the dunes may ascend a cliff and travel inland.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/contactMetamorphicSetting', 'contact metamorphic setting', 'Metamorphism of country rock at the contact of an igneous body.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/crustalSetting', 'crustal setting', '''The outermost layer or shell of the Earth, defined according to various criteria, including seismic velocity, density and composition; that part of the Earth above the Mohorovicic discontinuity, made up of the sial and the sima.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/highPressureLowTemperatureEarthInteriorSetting', 'high pressure low temperature Earth interior setting', '''High pressure environment characterized by geothermal gradient significantly lower than standard continental geotherm; environment in which blueschist facies metamorphic rocks form. Typically associated with subduction zones.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hypabyssalSetting', 'hypabyssal setting', '''Igneous environment close to the Earth''s surface, characterized by more rapid cooling than plutonic setting to produce generally fine-grained intrusive igneous rock that is commonly associated with co-magmatic volcanic rocks.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowPressureHighTemperatureSetting', 'low pressure high temperature setting', 'Setting characterized by temperatures significantly higher that those associated with normal continental geothermal gradient.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mantleSetting', 'mantle setting', 'The zone of the Earth below the crust and above the core, which is divided into the upper mantle and the lower mantle, with a transition zone separating them.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/regionalMetamorphicSetting', 'regional metamorphic setting', '''Metamorphism not obviously localized along contacts of igneous bodies; includes burial metamorphism and ocean ridge metamorphism.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/ultraHighPressureCrustalSetting', 'ultra high pressure crustal setting', 'Setting characterized by pressures characteristic of upper mantle, but indicated by mineral assemblage in crustal composition rocks.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/anoxicSetting', 'anoxic setting', 'Setting depleted in oxygen, typically subaqueous.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aridOrSemiAridEnvironmentSetting', 'arid or Semi Arid environment setting', '''Setting characterized by mean annual precipitation of 10 inches (25 cm) or less. (Jackson, 1997, p. 172). Equivalent to SLTT ''Desert setting'', but use ''Arid'' to emphasize climatic nature of setting definition.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/caveSetting', 'cave setting', '''A natural underground open space; it generally has a connection to the surface, is large enough for a person to enter, and extends into darkness. The most common type of cave is formed in limestone by dissolution.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaicSystemSetting', 'deltaic system setting', 'Environments at the mouth of a river or stream that enters a standing body of water (ocean or lake). The delta forms a triangular or fan-shaped plain of considerable area. Subaerial parts of the delta are crossed by many distributaries of the main river,', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierRelatedSetting', 'glacier related setting', 'Earth surface setting with geography defined by spatial relationship to glaciers (e.g. on top of a glacier, next to a glacier, in front of a glacier...). Processes related to moving ice dominate sediment transport and deposition and landform development.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hillslopeSetting', 'hillslope setting', 'Earth surface setting characterized by surface slope angles high enough that gravity alone becomes a significant factor in geomorphic development, as well as base-of-slope areas influenced by hillslope processes. Hillslope activities include creep, sliding, slumping, falling, and other downslope movements caused by slope collapse induced by gravitational influence on earth materials. May be subaerial or subaqueous.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humidTemperateClimaticSetting', 'humid temperate climatic setting', 'Setting with seasonal climate having hot to cold or humid to arid seasons.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humidTropicalClimaticSetting', 'humid tropical climatic setting', 'Setting with hot, humid climate influenced by equatorial air masses, no winter season.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/polarClimaticSetting', 'polar climatic setting', 'Setting with climate dominated by temperatures below the freezing temperature of water. Includes polar deserts because precipitation is generally scant at high latitude. Climatically controlled by arctic air masses, cold dry environment with short summer.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/shorelineSetting', 'shoreline setting', 'Geologic settings characterized by location adjacent to the ocean or a lake. A zone of indefinite width (may be many kilometers), bordering a body of water that extends from the water line inland to the first major change in landform features. Includes settings that may be subaerial, intermittently subaqueous, or shallow subaqueous, but are intrinsically associated with the interface between land areas and water bodies.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subaerialSetting', 'subaerial setting', 'Setting at the interface between the solid earth and the atmosphere, includes some shallow subaqueous settings in river channels and playas. Characterized by conditions and processes, such as erosion, that exist or operate in the open air on or immediately adjacent to the land surface.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subaqueousSetting', 'subaqueous setting', 'Setting situated in or under permanent, standing water. Used for marine and lacustrine settings, but not for fluvial settings.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/terrestrialSetting', 'terrestrial setting', 'Setting characterized by absence of direct marine influence. Most of the subaerial settings are also terrestrial, but lacustrine settings, while terrestrial, are not subaerial, so the subaerial settings are not included as subcategories.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wetlandSetting', 'wetland setting', 'Setting characterized by gentle surface slope, and at least intermittent presence of standing water, which may be fresh, brackish, or saline. Wetland may be terrestrial setting or shoreline setting.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarineLagoonSetting', 'estuarine lagoon setting', '''A lagoon produced by the temporary sealing of a river estuary by a storm barrier. Such lagoons are usually seasonal and exist until the river breaches the barrier; they occur in regions of low or spasmodic rainfall.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalRiftSetting', 'continental rift setting', 'Extended terrane in a zone of continental breakup, may include incipient oceanic crust. Examples include Red Sea, East Africa Rift, Salton Trough.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/englacialSetting', 'englacial setting', '''Contained, embedded, or carried within the body of a glacier or ice sheet; said of meltwater streams, till, drift, moraine.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacialOutwashPlainSetting', 'glacial outwash plain setting', '''A broad, gently sloping sheet of outwash deposited by meltwater streams flowing in front of or beyond a glacier, and formed by coalescing outwahs fans; the surface of a broad body of outwash.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierLateralSetting''', 'glacier lateral setting', 'Settings adjacent to edges of confined glacier.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/proglacialSetting', 'proglacial setting', '''Immediately in front of or just beyond the outer limits of a glacier or ice sheet, generally at or near its lower end; said of lakes, streams, deposits, and other features produced by or derived from the glacier ice.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subglacialSetting', 'subglacial setting', '''Formed or accumulated in or by the bottom parts of a glacier or ice sheet; said of meltwater streams, till, moraine, etc.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/supraglacialSetting', 'supraglacial setting', '''''Carried upon, deposited from, or pertaining to the top surface of a glacier or ice sheet; said of meltwater streams, till, drift, etc. '' (Jackson, 1997, p. 639). Dreimanis (1988, p. 39) recommendation that ''supraglacial'' supersede ''superglacial'' is followed.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/inactiveSpreadingCenterSetting', 'inactive spreading center setting', 'Setting on oceanic crust formed at a spreading center that has been abandoned.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/seamountSetting', 'seamount setting', 'Setting that consists of a conical mountain on the ocean floor (guyot). Typically characterized by active volcanism, pelagic sedimentation. If the mountain is high enough to reach the photic zone, carbonate production may result in reef building to produce a carbonate platform or atoll setting.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/algalFlatSetting', 'algal flat setting', '''Modern ''algal flats are found on rock or mud in areas flooded only by the highest tides and are often subject to high evaporation rates. Algal flats survive only when an area is salty enough to eliminate snails and other herbivorous animals that eat algae, yet is not so salty that the algae cannot survive. The most common species of algae found on algal flats are blue-green algae of the genera Scytonema and Schizothrix. These algae can tolerate the daily extremes in temperature and oxygen that typify conditions on the flats. Other plants sometimes found on algal flats include one-celled green algae, flagellates, diatoms, bacteria, and isolated scrubby red and black mangroves, as well as patches of saltwort. Animals include false cerith, cerion snails, fiddler crabs, and great land crabs. Flats with well developed algal mats are restricted for the most part to the Keys, with Sugarloaf and Crane Keys offering prime examples of algal flat habitat.'' (Audubon, 1991)''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mudFlatSetting', 'mud flat setting', 'A relatively level area of fine grained material (e.g. silt) along a shore (as in a sheltered estuary or chenier-plain) or around an island, alternately covered and uncovered by the tide or covered by shallow water, and barren of vegetation. Includes most tidal flats, but lacks denotation of tidal influence.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerMantleSetting', 'lower mantle setting', 'That part of the mantle that lies below a depth of about 660 km. With increasing depth, density increases from ~4.4 g/cm3 to ~5.6 g/cm3, and velocity of compressional seismic waves increases from ~10.7 km/s to ~13.7 km/s (Dziewonski and Anderson, 1981).', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperMantleSetting', 'upper mantle setting', 'That part of the mantle which lies above a depth of about 660 km and has a density of 3.4 g/cm3 to 4.0 g/cm3 with increasing depth. Similarly, P-wave velocity increases from about 8 to 11 km/sec with depth and S wave velocity increases from about 4.5 to 6 km/sec with depth. It is presumed to be peridotitic in composition. It includes the subcrustal lithosphere the asthenosphere and the transition zone.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aboveCarbonateCompensationDepthSetting', 'above carbonate compensation depth setting', 'Marine environment in which carbonate sediment does not dissolve before reaching the sea floor and can accumulate.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/abyssalSetting', 'abyssal setting', 'The ocean environment at water depths between 3,500 and 6,000 metres.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/basinPlainSetting', 'basin plain setting', '''Near flat areas of ocean floor, slope less than 1:1000; generally receive only distal turbidite and pelagic sediments.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/bathyalSetting', 'bathyal setting', 'The ocean environment at water depths between 200 and 3500 metres.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/belowCarbonateCompensationDepthSetting', 'below carbonate compensation depth setting', 'Marine environment in which water is deep enough that carbonate sediment goes into solution before it can accumulate on the sea floor.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/biologicalReefSetting', 'biological reef setting', '''A ridgelike or moundlike structure, layered or massive, built by sedentary calcareous organisms, esp. corals, and consisting mostly of their remains; it is wave-resistant and stands topographically above the surrounding contemporaneously deposited sediment.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalBorderlandSetting', 'continental borderland setting', 'An area of the continental margin between the shoreline and the continental slope that is topographically more complex than the continental shelf. It is characterized by ridges and basins, some of which are below the depth of the continental shelf. An example is the southern California continental borderland (Jackson, 1997, p. 138).', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalShelfSetting', 'continental shelf setting', '''That part of the ocean floor that is between the shoreline and the continental slope (or, when there is no noticeable continental slope, a depth of 200 m). It is characterized by its gentle slope of 0.1 degree (Jackson, 1997, p. 138). Continental shelves have a classic shoreline-shelf-slope profile termed ''clinoform''.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deepSeaTrenchSetting', 'deep sea trench setting', 'Deep ocean basin with steep (average 10 degrees) slope toward land, more gentle slope (average 5 degrees) towards the sea, and abundant seismic activity on landward side of trench. Does not denote water depth, but may be very deep.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/epicontinentalMarineSetting', 'epicontinental marine setting', 'Marine setting situated within the interior of the continent, rather than at the edge of a continent.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hadalSetting', 'hadal setting', 'The deepest oceanic environment, i.e., over 6,000 m in depth. Always in deep sea trench.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marineCarbonatePlatformSetting', 'marine carbonate platform setting', 'A shallow submerged plateau separated from continental landmasses, on which high biological carbonate production rates produce enough sediment to maintain the platform surface near sea level. Grades into atoll as area becomes smaller and ringing coral reefs become more prominent part of the setting.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/neriticSetting', 'neritic setting', 'The ocean environment at depths between low-tide level and 200 metres, or between low-tide level and approximately the edge of the continental shelf.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanHighlandSetting', 'ocean highland setting', 'Broad category for subaqueous marine settings characterized by significant relief above adjacent sea floor.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/slopeRiseSetting', 'slope-rise setting', 'The part of a subaqueous basin that is between a bordering shelf setting, which separate the basin from an adjacent landmass, and a very low-relief basin plain setting.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/submarineFanSetting', 'submarine fan setting', 'Large fan-shaped cones of sediment on the ocean floor, generally associated with submarine canyons that provide sediment supply to build the fan.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/innerNeriticSetting', 'inner neritic setting', 'The ocean environment at depths between low tide level and 30 metres.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleNeriticSetting', 'middle neritic setting', 'The ocean environment at depths between 30 and 100 metres.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/outerNeriticSetting', 'outer neritic setting', 'The ocean environment at depths between 100 meters and approximately the edge of the continental shelf or between 100 and 200 meters.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/midOceanRidgeSetting', 'mid ocean ridge setting', 'Ocean highland associated with a divergent continental margin (spreading center). Setting is characterized by active volcanism, locally steep relief, hydrothermal activity, and pelagic sedimentation.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanicPlateauSetting', 'oceanic plateau setting', 'Region of elevated ocean crust that commonly rises to within 2-3 km of the surface above an abyssal sea floor that lies several km deeper. Climate and water depths are such that a marine carbonate platform does not develop.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerOceanicCrustalSetting', 'lower oceanic-crustal setting', 'Setting characterized by dominantly intrusive mafic rocks, with sheeted dike complexes in upper part and gabbroic to ultramafic intrusive or metamorphic rocks in lower part.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperOceanicCrustalSetting', 'upper oceanic crustal setting', 'Oceanic crustal setting dominated by extrusive rocks, abyssal oceanic sediment, with increasing mafic intrusive rock in lower part.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/alluvialFanSetting', 'alluvial fan setting', '''A low, outspread, relatively flat to gently sloping mass of loose rock material, shaped like an open fan or a segment of a cone, deposited by a stream (esp. in a semiarid region) at the place where it issues from a narrow mountain valley upon a plain or broad valley, or where a tributary stream is near or at its junction with the main stream, or wherever a constriction in a valley abruptly ceases or the gradient of the stream suddenly decreases; it is steepest near the mouth of the valley where its apex points upstream, and it slopes gently and convexly outward with gradually decreasing gradient.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/alluvialPlainSetting', 'alluvial plain setting', '''An assemblage landforms produced by alluvial and fluvial processes (braided streams, terraces, etc.,) that form low gradient, regional ramps along the flanks of mountains and extend great distances from their sources (e.g., High Plains of North America). (NRCS GLOSSARY OF LANDFORM AND GEOLOGIC TERMS). A level or gently sloping tract or a slightly undulating land surface produced by extensive deposition of alluvium... Synonym-- wash plain;...river plain; aggraded valley plain;... (Jackson, 1997, p. 17). May include one or more River plain systems.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/pedimentSetting', 'pediment setting', '''A gently sloping erosional surface developed at the foot of a receding hill or mountain slope. The surface may be essentially bare, exposing earth material that extends beneath adjacent uplands; or it may be thinly mantled with alluvium and colluvium, ultimately in transit from upland front to basin or valley lowland. In hill-foot slope terrain the mantle is designated ''pedisediment.'' The term has been used in several geomorphic contexts: Pediments may be classed with respect to (a) landscape positions, for example, intermontane-basin piedmont or valley-border footslope surfaces (respectively, apron and terrace pediments (Cooke and Warren, 1973)); (b) type of material eroded, bedrock or regolith; or (c) combinations of the above. compare - Piedmont slope.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/activeContinentalMarginSetting', 'active continental margin setting', 'Plate margin setting on continental crust.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/activeSpreadingCenterSetting', 'active spreading center setting', 'Divergent plate margin at which new oceanic crust is being formed.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forearcSetting', 'forearc setting', 'Tectonic setting between a subduction-related trench and a volcanic arc.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subductionZoneSetting', 'subduction zone setting', 'Tectonic setting at which a tectonic plate, usually oceanic, is moving down into the mantle beneath another overriding plate.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/transformPlateBoundarySetting', 'transform plate boundary setting', 'Plate boundary at which the adjacent plates are moving laterally relative to each other.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/volcanicArcSetting', 'volcanic arc setting', 'A generally curvillinear belt of volcanoes above a subduction zone.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierTerminusSetting', 'glacier terminus setting', 'Region of sediment deposition at the glacier terminus due to melting of glacier ice, melt-out, ablation and flow till setting.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/braidedRiverChannelSetting', 'braided river channel setting', 'A stream that divides into or follows an interlacing or tangled network of several small branching and reuniting shallow channels separated from each other by ephemeral branch islands or channel bars, resembling in plan the strands of a complex braid. Such a stream is generally believed to indicate an inability to carry all of its load, such as an overloaded and aggrading stream flowing in a wide channel on a floodplain.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/meanderingRiverChannelSetting', 'meandering river channel setting', 'Produced by a mature stream swinging from side to side as it flows across its floodplain or shifts its course laterally toward the convex side of an original curve.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/abandonedRiverChannelSetting', 'abandoned river channel setting', 'A drainage channel along which runoff no longer occurs, as on an alluvial fan.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/cutoffMeanderSetting', 'cutoff meander setting', 'The abandoned, bow- or horseshoe-shaped channel of a former meander, left when the stream formed a cutoff across a narrow meander neck. Note that these are typically lakes, thus also lacustrine.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/floodplainSetting', 'floodplain setting', 'The surface or strip of relatively smooth land adjacent to a river channel, constructed by the present river in its existing regimen and covered with water when the river overflows its banks. It is built of alluvium carried by the river during floods and deposited in the sluggish water beyond the influence of the swiftest current. A river has one floodplain and may have one or more terraces representing abandoned floodplains.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/riverChannelSetting', 'river channel setting', '''The bed where a natural body of surface water flows or may flow; a natural passageway or depression of perceptible extent containing continuously or periodically flowing water, or forming a connecting link between two bodies of water; a watercourse.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/springSetting', 'spring setting', 'Setting characterized by a place where groundwater flows naturally from a rock or the soil onto the land surface or into a water body.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierIslandCoastlineSetting', 'barrier island coastline setting', 'Setting meant to include all the various geographic elements typically associated with a barrier island coastline, including the barrier islands, and geomorphic/geographic elements that are linked by processes associated with the presence of the island (e.g. wash over fans, inlet channel, back barrier lagoon).''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/beachSetting', 'beach setting', '''The unconsolidated material at the shoreline that covers a gently sloping zone, typically with a concave profile, extending landward from the low-water line to the place where there is a definite change in material or physiographic form (such as a cliff), or to the line of permanent vegetation (usually the effective limit of the highest storm waves); at the shore of a body of water, formed and washed by waves or tides, usually covered by sand or gravel, and lacking a bare rocky surface.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/carbonateDominatedShorelineSetting', 'carbonate dominated shoreline setting', 'A shoreline setting in which terrigenous input is minor compared to local carbonate sediment production. Constructional biogenic activity is an important element in geomorphic development.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/coastalPlainSetting', 'coastal plain setting', 'A low relief plain bordering a water body extending inland to the nearest elevated land, sloping very gently towards the water body. Distinguished from alluvial plain by presence of relict shoreline-related deposits or morphology.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarySetting', 'estuary setting', 'Environments at the seaward end or the widened funnel-shaped tidal mouth of a river valley where fresh water comes into contact with seawater and where tidal effects are evident (adapted from Glossary of Geology, Jackson, 1997, p. 217).', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lagoonalSetting', 'lagoonal setting', '''A shallow stretch of salt or brackish water, partly or completely separated from a sea or lake by an offshore reef, barrier island, sand or spit (Jackson, 1997). Water is shallow, tidal and wave-produced effects on sediments; strong light reaches sediment.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowEnergyShorelineSetting', 'low energy shoreline setting', 'Settings characterized by very low surface slope and proximity to shoreline. Generally within peritidal setting, but characterized by low surface gradients and generally low-energy sedimentary processes.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/rockyCoastSetting', 'rocky coast setting', 'Shoreline with significant relief and abundant rock outcrop.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/strandplainSetting', 'strandplain setting', 'A prograded shore built seaward by waves and currents, and continuous for some distance along the coast. It is characterized by subparallel beach ridges and swales, in places with associated dunes.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/supratidalSetting', 'supratidal setting', 'Pertaining to the shore area marginal to the littoral zone, just above high-tide level.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalSetting', 'tidal setting', 'Setting subject to tidal processes.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aeolianProcessSetting', 'aeolian process setting', 'Sedimentary setting in which wind is the dominant process producing, transporting, and depositing sediment. Typically has low-relief plain or piedmont slope physiography.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/piedmontSlopeSystemSetting', 'piedmont slope system setting', '''Location on gentle slope at the foot of a mountain; generally used in terms of intermontane-basin terrain. Main components include: (a) An erosional surface on bedrock adjacent to the receding mountain front (pediment, rock pediment); (b) A constructional surface comprising individual alluvial fans and interfan valleys, also near the mountain front; and (c) A distal complex of coalescent fans (bajada), and alluvial slopes without fan form. Piedmont slopes grade to basin-floor depressions with alluvial and temporary lake plains or to surfaces associated with through drainage.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intertidalSetting', 'intertidal setting', '''Pertaining to the benthic ocean environment or depth zone between high water and low water; also, pertaining to the organisms of that environment.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marineSetting', 'marine setting', 'Setting characterized by location under the surface of the sea.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalChannelSetting', 'tidal channel setting', 'A major channel followed by the tidal currents, extending from offshore into a tidal marsh or a tidal flat.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalMarshSetting', 'tidal marsh setting', '''A marsh bordering a coast (as in a shallow lagoon or sheltered bay), formed of mud and of the resistant mat of roots of salt-tolerant plants, and regularly inundated during high tides; a marshy tidal flat.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/backArcSetting', 'back arc setting', 'Tectonic setting adjacent to a volcanic arc formed above a subduction zone. The back arc setting is on the opposite side of the volcanic arc from the trench at which oceanic crust is consumed in a subduction zone. Back arc setting includes terrane that is affected by plate margin and arc-related processes.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/extendedTerraneSetting', 'extended terrane setting', 'Tectonic setting characterized by extension of the upper crust, manifested by formation of rift valleys or basin and range physiography, with arrays of low to high angle normal faults. Modern examples include the North Sea, East Africa, and the Basin and Range of the North American Cordillera. Typically applied in continental crustal settings.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hotSpotSetting', 'hot spot setting', 'Setting in a zone of high heat flow from the mantle. Typically identified in intraplate settings, but hot spot may also interact with active plate margins (Iceland...). Includes surface manifestations like volcanic center, but also includes crust and mantle manifestations as well.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intraplateTectonicSetting', 'intraplate tectonic setting', 'Tectonically stable setting far from any active plate margins.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/passiveContinentalMarginSetting', 'passive continental margin setting', 'Boundary of continental crust into oceanic crust of an oceanic basin that is not a subduction zone or transform fault system. Generally is rifted margin formed when ocean basin was initially formed.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/plateMarginSetting', 'plate margin setting', 'Tectonic setting at the boundary between two tectonic plates.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/plateSpreadingCenterSetting', 'plate spreading center setting', 'Tectonic setting where new oceanic crust is being or has been formed at a divergent plate boundary. Includes active and inactive spreading centers.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/bogSetting', 'bog setting', 'Waterlogged, spongy ground, consisting primarily of mosses, containing acidic, decaying vegetation that may develop into peat.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lacustrineSetting', 'lacustrine setting', 'Setting associated with a lake. Always overlaps with terrestrial, may overlap with subaerial, subaqueous, or shoreline.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/riverPlainSystemSetting', 'river plain system setting', '''Geologic setting dominated by a river system; river plains may occur in any climatic setting. Includes active channels, abandoned channels, levees, oxbow lakes, flood plain. May be part of an alluvial plain that includes terraces composed of abandoned river plain deposits.''', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalFlatSetting', 'tidal flat setting', 'An extensive, nearly horizontal, barren tract of land that is alternately covered and uncovered by the tide, and consisting of unconsolidated sediment (mostly mud and sand). It may form the top surface of a deltaic deposit.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/swampOrMarshSetting', 'swamp or marsh setting', 'A water-saturated, periodically wet or continually flooded area with the surface not deeply submerged, essentially without the formation of peat. Marshes are characterized by sedges, cattails, rushes, or other aquatic and grasslike vegetation. Swamps are characterized by tree and brush vegetation.', 'EventEnvironmentValue', NULL, NULL, NULL, NULL);

-- Example so.codelistnot published online -------------------------------------------------------------
-- ProcessParameterNameValue
-- processparameter
-- CREA
-- http://inspire.ec.europa.eu/codelist/ProcessParameterNameValue (void)

INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://crea.gov.it/codelist/12345', 'Void', 'Void', 'ProcessParameterNameValue', NULL, NULL, NULL, NULL);

-- Internal so.codelistfor managing forms -------------------------------------------------------------
-- Define the FOI
-- CREA
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('profileelement', 'profileelement', NULL, 'FOIType', '', NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('soilprofile', 'soilprofile', NULL, 'FOIType', '', NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('soilderivedobject', 'soilderivedobject', NULL, 'FOIType', '', NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('soilsite', 'soilsite', NULL, 'FOIType', '', NULL, NULL, NULL);

-- Internal so.codelistfor managing forms -------------------------------------------------------------
-- Define the PhenomenonType
-- CREA
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('chemical', 'chemical', NULL, 'PhenomenonType', '', NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('biological', 'biological', NULL, 'PhenomenonType', '', NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('physical', 'physical', NULL, 'PhenomenonType', '', NULL, NULL, NULL);

--- Internal so.codelistfor managing forms -------------------------------------------------------------
-- CREA
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/pc01', 'excessively drained', 'excessively drained', 'WaterDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/pc02', 'somewhat excessively', 'somewhat excessively', 'WaterDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/pc03', 'well drained', 'well drained', 'WaterDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/pc04', 'moderately well drained', 'moderately well drained', 'WaterDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/pc05', 'somewhat poorly drained', 'somewhat poorly drained', 'WaterDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/pc06', 'poorly drained', 'poorly drained', 'WaterDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/pc07', 'very poorly drained', 'very poorly drained', 'WaterDrainage', NULL, NULL, NULL, NULL);

-- Internal so.codelistfor managing forms -------------------------------------------------------------
-- CREA
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('WaterDrainage', 'WaterDrainage', 'WaterDrainage', 'PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Effervescence', 'Effervescence', 'Effervescence', 'PropertyCoded', NULL, NULL, NULL, NULL);

-- Internal so.codelistfor managing forms -------------------------------------------------------------
-- CREA
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Test_01', 'Test_01', 'Test_01', 'Effervescence', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Test_02', 'Test_02', 'Test_02', 'Effervescence', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Test_03', 'Test_03', 'Test_03', 'Effervescence', NULL, NULL, NULL, NULL);













-- =======================================================================================================================================================================================================
-- =======================================================================================================================================================================================================
-- =======================================================================================================================================================================================================

-- Internal so.codelistfor managing PropertyCoded codelist-------------------------------------------------------------
-- CREA
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('AnthropicAspects','AnthropicAspects','AnthropicAspects','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('SuperficialAspects','SuperficialAspects','SuperficialAspects','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('PlantCover','PlantCover','PlantCover','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('SiteCurvature','SiteCurvature','SiteCurvature','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Deposition','Deposition','Deposition','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('ExternalDrainage','ExternalDrainage','ExternalDrainage','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('MorphologicalElements','MorphologicalElements','MorphologicalElements','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('ArealErosion','ArealErosion','ArealErosion','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Erosion','Erosion','Erosion','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('FloodFrequency','FloodFrequency','FloodFrequency','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('MorphologyLandSystems','MorphologyLandSystems','MorphologyLandSystems','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('PhysiographicForm','PhysiographicForm','PhysiographicForm','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('SoilState','SoilState','SoilState','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('LandUse','LandUse','LandUse','PropertyCoded', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('Vegetation','Vegetation','Vegetation','PropertyCoded', NULL, NULL, NULL, NULL);




-- AnthropicAspects
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/AntropogenicSurfaceAspects#65b757df-ae67-49d7-a451-46f93449af01', 'others', 'others', 'AnthropicAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/AntropogenicSurfaceAspects#5650c978-0eae-457b-bd58-7a70fd974ac0', 'compacted by animals', 'compacted by animals', 'AnthropicAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/AntropogenicSurfaceAspects#eb598b7b-91c3-4de8-a455-652c2b918056', 'compacted by machines', 'compacted by machines', 'AnthropicAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/AntropogenicSurfaceAspects#69f71941-7c2e-4cb8-86ed-3789f2de4336', 'leveled or flattened', 'leveled or flattened', 'AnthropicAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/AntropogenicSurfaceAspects#4a36f41d-1c27-41f4-9aa9-d8c63bcf3c9e', 'arranged with heaps', 'arranged with heaps', 'AnthropicAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/AntropogenicSurfaceAspects#baa7188b-de1d-47d5-b279-bb4824d273a3', 'ploughed', 'ploughed', 'AnthropicAspects', NULL, NULL, NULL, NULL);

-- SuperficialAspects
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#cb58b331-35e5-42d9-bf8a-9716dc23acab', 'others', 'others', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#12dc414c-d379-463b-b708-ae7cdc50e386', 'mounds from burrowing animals', 'mounds from burrowing animals', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#36b837aa-2c97-467b-85ca-cd34929ce5ce', 'sedimentary crusts', 'sedimentary crusts', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#7834ada9-fc06-442c-ad2f-caed1eba6cb3', 'structural crusts', 'structural crusts', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#5c1e99fd-1424-463d-a7d7-cc8dde807dbb', 'saline efflorescence', 'saline efflorescence', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#812fb79e-a02f-480c-829c-55b0efa9be30', 'gilgai', 'gilgai (microreliefs from expansive clays)', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#fe38c5ee-4e87-4731-9b72-73fcf7593549', 'soil-snow interface burrows', 'soil-snow interface burrows', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#d66be720-1b62-4df2-8c08-1deaa7c19f9c', 'mammal burrowing', 'mammal burrowing', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#38b29033-bdcf-4545-bf81-8ebdee128509', 'self-mulching', 'self-mulching', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#9e2ceae3-0b44-4fcd-8805-6208c1238388', 'worm casts', 'worm casts', 'SuperficialAspects', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/classification/thesaurus/stratum/PedobiologicalSurfaceAspects#daf95373-c540-40b4-beb7-8077bac39eb2', 'dispersed organo-sodic complex', 'dispersed organo-sodic complex', 'SuperficialAspects', NULL, NULL, NULL, NULL);

-- PlantCover
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/copertveget_01', 'bare soil', 'bare soil', 'PlantCover', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/copertveget_02', '<10% extremely low', '<10% extremely low', 'PlantCover', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/copertveget_03', '10-25% very low', '10-25% very low', 'PlantCover', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/copertveget_04', '25-50% low', '25-50% low', 'PlantCover', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/copertveget_05', '50-75% high', '50-75% high', 'PlantCover', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/copertveget_06', '>75% very high', '>75% very high', 'PlantCover', NULL, NULL, NULL, NULL);

-- SiteCurvature
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_01', 'concave-concave', 'concave-concave', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_02', 'concave-linear', 'concave-linear', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_03', 'concave-convex', 'concave-convex', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_04', 'linear-concave', 'linear-concave', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_05', 'linear-linear', 'linear-linear', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_06', 'linear-convex', 'linear-convex', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_07', 'convex-concave', 'convex-concave', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_08', 'convex-linear', 'convex-linear', 'SiteCurvature', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cur_sito_09', 'convex-convex', 'convex-convex', 'SiteCurvature', NULL, NULL, NULL, NULL);

-- Deposition
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/deposizione_01', 'absent', 'absent', 'Deposition', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/deposizione_02', 'hydric', 'hydric', 'Deposition', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/deposizione_03', 'eolian', 'eolian', 'Deposition', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/deposizione_04', 'gravitational', 'gravitational', 'Deposition', NULL, NULL, NULL, NULL);

-- ExternalDrainage
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_est_01', 'negligible', 'negligible', 'ExternalDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_est_02', 'very low', 'very low', 'ExternalDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_est_03', 'low', 'low', 'ExternalDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_est_04', 'medium', 'medium', 'ExternalDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_est_05', 'high', 'high', 'ExternalDrainage', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_est_06', 'very high', 'very high', 'ExternalDrainage', NULL, NULL, NULL, NULL);

-- MorphologicalElements
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_01', 'depression', 'depression', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_02', 'open depression', 'open depression', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_03', 'closed depression', 'closed depression', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_04', 'plane', 'plane', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_05', 'plane', 'plane', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_06', 'tread', 'tread', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_07', 'summit', 'summit', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_08', 'ridge', 'ridge', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_09', 'saddle', 'saddle', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_10', 'summit', 'summit', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_11', 'slope', 'slope', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_12', 'head slope', 'head slope', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_13', 'foot slope', 'foot slope', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_14', 'back slope', 'back slope', 'MorphologicalElements', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/elem_morf_15', 'simple slope', 'simple slope', 'MorphologicalElements', NULL, NULL, NULL, NULL);

-- ArealErosion
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_area_01', '0 - 5 %', '0 - 5 %', 'ArealErosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_area_02', '5 - 10 %', '5 - 10 %', 'ArealErosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_area_03', '10 - 25 %', '10 - 25 %', 'ArealErosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_area_04', '25 - 50 %', '25 - 50 %', 'ArealErosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_area_05', '> 50 %', '> 50 %', 'ArealErosion', NULL, NULL, NULL, NULL);

-- Erosion
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_01', 'absent', 'absent', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_02', 'water: sheet erosion moderate', 'water: sheet erosion moderate', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_03', 'water: rill', 'water: rill', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_04', 'water: gully', 'water: gully', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_05', 'water: tunnel erosion', 'water: tunnel erosion', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_06', 'mass: collapse', 'mass: collapse', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_07', 'mass: sliding', 'mass: sliding', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/dissolutionCreep', 'creeping and solifluction', 'creeping and solifluction', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_09', 'wind: strong', 'wind: strong', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_10', 'karst erosion', 'karst erosion', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_11', 'water: bank erosion', 'water: bank erosion', 'Erosion', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/eros_real_12', 'anthropic: process mechanical erosion', 'anthropic: process mechanical erosion', 'Erosion', NULL, NULL, NULL, NULL);

-- FloodFrequency
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/inond_freq_01', 'absent', 'absent', 'FloodFrequency', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/inond_freq_02', 'rare ', 'rare (1-5 times/100 years)', 'FloodFrequency', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/inond_freq_03', 'occasional ', 'occasional (5-50 times/100 years)', 'FloodFrequency', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/inond_freq_04', 'frequent', 'frequent (>50 times/100 years)', 'FloodFrequency', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/inond_freq_05', 'common ', 'common (>5 times/100 years)', 'FloodFrequency', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/inond_freq_06', 'unknown', 'unknown', 'FloodFrequency', NULL, NULL, NULL, NULL);

-- MorphologyLandSystems
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_01', 'unknown', 'unknown', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_02', 'upland plains of low mountain with subparallel drainage pattern', 'upland plains of low mountain with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_03', 'upland plains and low mountain with low gradient with subdendritic drainage pattern', 'upland plains and low mountain with low gradient with subdendritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_04', 'piedmont areas of volcanic apparatus with low gradient or flat, with subparallel drainage pattern', 'piedmont areas of volcanic apparatus with low gradient or flat, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_05', 'coastal lagoonal areas, with dunal bar and artificial leveed drainage pattern', 'coastal lagoonal areas, with dunal bar and artificial leveed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_06', 'flat areas and low-lying areas reclaimed by artificial drainage pattern', 'flat areas and low-lying areas reclaimed by artificial drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_07', 'low hill with low and medium gradient with subparallel drainage pattern', 'low hill with low and medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_08', 'low hill with medium gradient with subdentritic drainage pattern', 'low hill with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_09', 'low and medium hills with low and medium gradient and subdentritic drainage pattern', 'low and medium hills with low and medium gradient and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_10', 'low and medium hills with low and medium gradient with subparallel drainage pattern', 'low and medium hills with low and medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_11', 'low and medium hills with medium gradient and subparallel drainage pattern', 'low and medium hills with medium gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_12', 'low and medium hills and dissected summit terraces with subdentritic to subparallel drainage pattern', 'low and medium hills and dissected summit terraces with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_13', 'high level hills and low mountain with high gradient with subdentritic to subparallel drainage pattern', 'high level hills and low mountain with high gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_14', 'low hills and aggraded landforms (terraces, alluvial fans, etc.) with subparallel to subdentritic drainage pattern with low gradient', 'low hills and aggraded landforms (terraces, alluvial fans, etc.) with subparallel to subdentritic drainage pattern with low gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_15', 'medium and high hills with medium gradient with angular drainage pattern', 'medium and high hills with medium gradient with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_16', 'low and high mountain with medium and high gradient, with subparallel drainage pattern and angular on mainly limestone, anhydritic or chalky covered by permanent grassland, grassland-pasture', 'low and high mountain with medium and high gradient, with subparallel drainage pattern and angular on mainly limestone, anhydritic or chalky covered by permanent grassland, grassland-pasture', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_17', 'karstic hills and upland plains with doline drainage pattern', 'karstic hills and upland plains with doline drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_18', 'karstic hills and treads with low and medium gradient with doline drainage pattern', 'karstic hills and treads with low and medium gradient with doline drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_19', 'complex filling basins (karst and alluvium-colluvium)', 'complex filling basins (karst and alluvium-colluvium)', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_20', 'complex filling basins (karst, alluvial lacustrine and alluvium-colluvium)', 'complex filling basins (karst, alluvial lacustrine and alluvium-colluvium)', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_21', 'complex filled intermontane basin (karst, alluvial lacustrine and alluvium-colluvium)', 'complex filled intermontane basin (karst, alluvial lacustrine and alluvium-colluvium)', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_22', 'flood plane with alluvial funs, nappe talus and landslide deposits', 'flood plane with alluvial funs, nappe talus and landslide deposits', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_23', 'isolated volcanic apparatus with medium and high gradient', 'isolated volcanic apparatus with medium and high gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_24', 'valley floor with meandering drainage pattern', 'valley floor with meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_25', 'valley floor, and depressed reclaimed flat areas with artificial drainage pattern', 'valley floor, and depressed reclaimed flat areas with artificial drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_26', 'valley floor, terraces and aggraded landforms with low gradient, with subparallel drainage pattern', 'valley floor, terraces and aggraded landforms with low gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_27', 'flood plane', 'flood plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_28', 'valley floor with mainly meandering drainage pattern and partially braided', 'valley floor with mainly meandering drainage pattern and partially braided', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_29', 'alluvial glacis, dissected terraces, medium and high hills with medium gradient with subdentritic and subparallel drainage pattern', 'alluvial glacis, dissected terraces, medium and high hills with medium gradient with subdentritic and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_30', 'flood plane', 'flood plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_31', 'valley floor with meandering drainage pattern', 'valley floor with meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_32', 'valley floor and stream terrace', 'valley floor and stream terrace', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_33', 'coastal plane with dunal bar and artificial rectified drainage pattern', 'coastal plane with dunal bar and artificial rectified drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_34', 'coastal plane with dunal bar and terraced dunes with artificial rectified a/o leveed drainage pattern', 'coastal plane with dunal bar and terraced dunes with artificial rectified a/o leveed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_35', 'coastal plane with dunal bar and dissected terraced dunes with subparallel drainage pattern', 'coastal plane with dunal bar and dissected terraced dunes with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_36', 'piedmont plane of volcanic apparatus', 'piedmont plane of volcanic apparatus', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_37', 'planes in intermontane basins', 'planes in intermontane basins', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_38', 'intermontane basins with coalescent fans', 'intermontane basins with coalescent fans', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_39', 'glacial plane', 'glacial plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_40', 'high mountain with high gradient with karstic landforms', 'high mountain with high gradient with karstic landforms', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_41', 'slopes and upland plain in high elevation with weakly developed or absent drainage pattern', 'slopes and upland plain in high elevation with weakly developed or absent drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_42', 'high level hills with medium gradient with subdentritic drainage pattern', 'high level hills with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_43', 'high hills with medium gradient with subparallel drainage pattern', 'high hills with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_44', 'high level hills with medium gradient with isolated relief and treads with angular drainage pattern', 'high level hills with medium gradient with isolated relief and treads with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_45', 'low and high hills with high gradient and subparallel drainage pattern', 'low and high hills with high gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_46', 'high level hills and low mountain with medium and high gradient with angular drainage pattern', 'high level hills and low mountain with medium and high gradient with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_47', 'high level hills and low mountain with medium gradient with angular drainage pattern', 'high level hills and low mountain with medium gradient with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_48', 'high level hills and low mountain with medium gradient with subdentritic drainage pattern', 'high level hills and low mountain with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_49', 'high level hills and low mountain with medium gradient with subparallel drainage pattern', 'high level hills and low mountain with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_50', 'high mountain with high gradient with subparallel drainage pattern', 'high mountain with high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_51', 'low and high mountain with medium gradient with subparallel drainage pattern', 'low and high mountain with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_52', 'low and high mountain with medium and high gradient, with subparallel drainage pattern', 'low and high mountain with medium and high gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_53', 'high mountain with high gradient with subparallel to angular drainage pattern', 'high mountain with high gradient with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_54', 'high mountain with high gradient and steep with angular drainage pattern', 'high mountain with high gradient and steep with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_55', 'high mountain with high gradient and steep with contorted to angular drainage pattern', 'high mountain with high gradient and steep with contorted to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_56', 'low hill with low and medium gradient with angular drainage pattern', 'low hill with low and medium gradient with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_57', 'low hill with low and medium gradient with subdentritic drainage pattern', 'low hill with low and medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_58', 'valley floor with terraces and funs', 'valley floor with terraces and funs', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_59', 'low hill with low gradient with subdentritic drainage pattern', 'low hill with low gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_60', 'low and high mountain with high gradient and steep with drainage pattern da angular a subparallel', 'low and high mountain with high gradient and steep with drainage pattern da angular a subparallel', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_61', 'low mountain with high gradient and steep with subparallel to angular drainage pattern', 'low mountain with high gradient and steep with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_62', 'low mountain with medium and high gradient with hills and angular drainage pattern', 'low mountain with medium and high gradient with hills and angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_63', 'high level hills and low mountain with medium and high gradient with parallel drainage pattern', 'high level hills and low mountain with medium and high gradient with parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_64', 'low and medium hills with low and medium gradient with subdentritic drainage pattern', 'low and medium hills with low and medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_65', 'low and medium hills with medium gradient with subdentritic drainage pattern', 'low and medium hills with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_66', 'low and medium hills with scarp and structural summit surface', 'low and medium hills with scarp and structural summit surface', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_67', 'low and high mountain with high gradient and steep with drainage pattern subdentritic and angular', 'low and high mountain with high gradient and steep with drainage pattern subdentritic and angular', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_68', 'low mountain with high gradient with subparallel drainage pattern', 'low mountain with high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_69', 'low mountain with low and medium gradient with subparallel drainage pattern', 'low mountain with low and medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_70', 'low mountain with medium and high gradient with subdentritic drainage pattern', 'low mountain with medium and high gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_71', 'low mountain with medium and high gradient with subparallel drainage pattern', 'low mountain with medium and high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_72', 'low mountain and high hills with medium and high gradient with treads and with subparallel drainage pattern', 'low mountain and high hills with medium and high gradient with treads and with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_73', 'low mountain with medium and high gradient with subparallel to parallel drainage pattern', 'low mountain with medium and high gradient with subparallel to parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_74', 'low mountain with medium and high gradient with karstic landforms and contorted drainage pattern', 'low mountain with medium and high gradient with karstic landforms and contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_75', 'high level hills and low mountain with medium gradient with subparallel to angular drainage pattern', 'high level hills and low mountain with medium gradient with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_76', 'low mountain with high gradient and steep with karstic landforms and contorted drainage pattern', 'low mountain with high gradient and steep with karstic landforms and contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_77', 'low mountain with high gradient with contorted drainage pattern', 'low mountain with high gradient with contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_78', 'low mountain with medium gradient with subdentritic drainage pattern', 'low mountain with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_79', 'low mountain with medium gradient with subparallel drainage pattern', 'low mountain with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_80', 'low mountain with treads with low and medium gradient with karstic landforms and parallel drainage pattern', 'low mountain with treads with low and medium gradient with karstic landforms and parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_81', 'low mountain with low and medium gradient with subdentritic to subparallel drainage pattern', 'low mountain with low and medium gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_82', 'low mountain and high hills with medium and high gradient with subdentritic to subparallel drainage pattern', 'low mountain and high hills with medium and high gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_83', 'low mountain and high hills with low gradient with summit treads with angular or weakly developed drainage pattern', 'low mountain and high hills with low gradient with summit treads with angular or weakly developed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_84', 'low, medium and high hills with high gradient with subparallel drainage pattern', 'low, medium and high hills with high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_85', 'medium hills with medium gradient with subdentritic to subparallel drainage pattern', 'medium hills with medium gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_86', 'high mountain with high gradient with angular drainage pattern', 'high mountain with high gradient with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_87', 'medium and high hills with karstic landforms with medium gradient with contorted drainage pattern', 'medium and high hills with karstic landforms with medium gradient with contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_88', 'high hills with low and medium gradient with subdentritic drainage pattern', 'high hills with low and medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_89', 'medium and high hills with medium gradient with subdentritic to subparallel drainage pattern', 'medium and high hills with medium gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_90', 'medium and high hills with medium gradient with subdentritic drainage pattern', 'medium and high hills with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_91', 'high level hills and low mountain with medium and high gradient with subparallel drainage pattern', 'high level hills and low mountain with medium and high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_92', 'medium and low hills with low and medium gradient with dentritic drainage pattern', 'medium and low hills with low and medium gradient with dentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_93', 'medium and low hills with medium and high gradient with subdentritic to subparallel drainage pattern', 'medium and low hills with medium and high gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_94', 'medium and low hills with high gradient with subdentritic drainage pattern', 'medium and low hills with high gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_95', 'high level hills and low mountain with high gradient with subparallel drainage pattern', 'high level hills and low mountain with high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_96', 'medium and high hills with medium gradient with dentritic drainage pattern', 'medium and high hills with medium gradient with dentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_97', 'medium and high hills and low hills with medium gradient with subparallel drainage pattern', 'medium and high hills and low hills with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_98', 'mountain relief with high gradient with radial drainage pattern', 'mountain relief with high gradient with radial drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_99', 'volcanic relief of low mountain with medium gradient and steep and low mountain with low gradient, with weakly developed drainage pattern', 'volcanic relief of low mountain with medium gradient and steep and low mountain with low gradient, with weakly developed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_100', 'high level hills and low mountain with high gradient and steep with subparallel to angular drainage pattern', 'high level hills and low mountain with high gradient and steep with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_101', 'volcanic relief of low mountain with low and medium gradient with weakly developed drainage pattern', 'volcanic relief of low mountain with low and medium gradient with weakly developed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_102', 'treads of low mountain with low gradient with subdentritic drainage pattern', 'treads of low mountain with low gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_103', 'treads of medium elevation', 'treads of medium elevation', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_104', 'treads and low hills with low gradient with subparallel drainage pattern', 'treads and low hills with low gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_105', 'treads and aggraded landforms with low gradient with isolated hills with medium gradient', 'treads and aggraded landforms with low gradient with isolated hills with medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_106', 'treads and slopes with low gradient with weakly developed drainage pattern', 'treads and slopes with low gradient with weakly developed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_107', 'treads and upland plains of medium and high hills and low mountain with weakly developed rectangular drainage pattern', 'treads and upland plains of medium and high hills and low mountain with weakly developed rectangular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_108', 'low mountain with high gradient with angular drainage pattern', 'low mountain with high gradient with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_109', 'terraced stream surfaces', 'terraced stream surfaces', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_110', 'structural surface of volcanic apparatus', 'structural surface of volcanic apparatus', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_111', 'stream terraces', 'stream terraces', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_112', 'terraces and treads', 'terraces and treads', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_113', 'dissected terraces and treads', 'dissected terraces and treads', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_114', 'dissected marine terraces with parallel drainage pattern', 'dissected marine terraces with parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_115', 'marine terrace and coastal plane', 'marine terrace and coastal plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_116', 'dissected marine terraces', 'dissected marine terraces', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_117', 'slightly dissected marine terrace and coastal planes with dunal bars', 'slightly dissected marine terrace and coastal planes with dunal bars', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_118', 'dissected marine terraces  and coastal planes', 'dissected marine terraces  and coastal planes', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_119', 'high and medium valley floor with funs and nappe talus with medium gradient, with flow traces from glacial events', 'high and medium valley floor with funs and nappe talus with medium gradient, with flow traces from glacial events', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_120', 'structural terraces with rills and subparallel drainage pattern', 'structural terraces with rills and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_121', 'terraces, aggraded landforms with low gradient with subparallel drainage pattern', 'terraces, aggraded landforms with low gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_122', 'terraces, aggraded landforms with low gradient and low hills, with subparallel drainage pattern', 'terraces, aggraded landforms with low gradient and low hills, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_123', 'high level hills and low mountain with high gradient with flow traces from glacial events and angular drainage pattern', 'high level hills and low mountain with high gradient with flow traces from glacial events and angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_124', 'slopes of volcanic apparatus with low and medium gradient', 'slopes of volcanic apparatus with low and medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_125', 'slopes of volcanic apparatus proximal to the crater with medium/high gradient', 'slopes of volcanic apparatus proximal to the crater with medium/high gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_126', 'slopes of volcanic apparatus proximal to the caldera with medium gradient with centrifugal drainage pattern', 'slopes of volcanic apparatus proximal to the caldera with medium gradient with centrifugal drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_127', 'low and high mountain with high gradient with subparallel or angular drainage pattern', 'low and high mountain with high gradient with subparallel or angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_128', 'valley floor, terraces and aggraded landforms with medium gradient and subparallel drainage pattern', 'valley floor, terraces and aggraded landforms with medium gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_129', 'fluvioglacial terraces with erosive escarpment and subparallel drainage pattern and dissected v-shaped', 'fluvioglacial terraces with erosive escarpment and subparallel drainage pattern and dissected v-shaped', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_130', 'slightly convex fluvio-glacial fans with braided channel', 'slightly convex fluvio-glacial fans with braided channel', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_131', 'low mountain with high gradient and parallel drainage pattern', 'low mountain with high gradient and parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_132', 'fluvial or fluvioglacial floodplain downstream from the springs with meandering drainage pattern', 'fluvial or fluvioglacial floodplain downstream from the springs with meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_133', 'undifferentiated fluvial floodplain with paleochannel traces with meandering drainage pattern', 'undifferentiated fluvial floodplain with paleochannel traces with meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_134', 'terraced dissected valley floor on the floodplain with braided channel and meandering drainage pattern', 'terraced dissected valley floor on the floodplain with braided channel and meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_135', 'partially dissected, sometimes terraced flood plane and streams with meandering drainage pattern', 'partially dissected, sometimes terraced flood plane and streams with meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_136', 'medium and high hills with medium and high gradient with subdentritic to subparallel drainage pattern', 'medium and high hills with medium and high gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_137', 'low and high mountain with high gradient and low mountain with medium gradient, with subparallel drainage pattern', 'low and high mountain with high gradient and low mountain with medium gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_138', 'delta apparatus and marine deposits landforms with rectified artificial and reclaimed drainage pattern', 'delta apparatus and marine deposits landforms with rectified artificial and reclaimed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_139', 'flood plane with hanging stream beds and with straightway to meandering drainage pattern', 'flood plane with hanging stream beds and with straightway to meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_140', 'flood plane with hanging stream beds with straightway drainage pattern', 'flood plane with hanging stream beds with straightway drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_141', 'raised terraces on plain, basculated (direction s-n) with subparallel drainage pattern and dissected v-shaped', 'raised terraces on plain, basculated (direction s-n) with subparallel drainage pattern and dissected v-shaped', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_142', 'high mountain with high gradient and steep with subparallel to angular drainage pattern', 'high mountain with high gradient and steep with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_143', 'low and high mountain with medium gradient with dentritic, subdentritic and parallel drainage pattern', 'low and high mountain with medium gradient with dentritic, subdentritic and parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_144', 'beaches', 'beaches', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_145', 'low mountain with high gradient with subdentritic to subparallel drainage pattern', 'low mountain with high gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_146', 'low mountain and high hills, steep with subparallel to angular drainage pattern', 'low mountain and high hills, steep with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_147', 'valley floor with braided fluvial channels, bar tops and alluvial fans', 'valley floor with braided fluvial channels, bar tops and alluvial fans', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_148', 'valley floor with braided to meandering drainage pattern', 'valley floor with braided to meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_149', 'flood plane downstream from the springs with rectified drainage pattern, with bar tops and fluvial rill', 'flood plane downstream from the springs with rectified drainage pattern, with bar tops and fluvial rill', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_150', 'morainic hills', 'morainic hills', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_151', 'low hill with medium gradient with subparallel to angular drainage pattern', 'low hill with medium gradient with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_152', 'medium and high hills with medium and high gradient, with angular drainage pattern, with flow traces from glacial events', 'medium and high hills with medium and high gradient, with angular drainage pattern, with flow traces from glacial events', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_153', 'low and medium hills with medium gradient with from subdentritic to subparallel drainage pattern', 'low and medium hills with medium gradient with from subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_154', 'high mountain with high gradient and steep with radial drainage pattern and glacial morphology', 'high mountain with high gradient and steep with radial drainage pattern and glacial morphology', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_155', 'high and medium valley floor with alluvial fans and nappe talus with medium gradient', 'high and medium valley floor with alluvial fans and nappe talus with medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_156', 'low and high mountain with high gradient and steep with karst phenomena', 'low and high mountain with high gradient and steep with karst phenomena', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_157', 'high level hills and low mountain with high gradient with subdentritic drainage pattern', 'high level hills and low mountain with high gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_158', 'high hills and low mountain with high gradient and steep with flow traces from glacial events and karst phenomena', 'high hills and low mountain with high gradient and steep with flow traces from glacial events and karst phenomena', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_159', 'low and high mountain with high gradient and steep with prominent flow traces from glacial events and angular drainage pattern', 'low and high mountain with high gradient and steep with prominent flow traces from glacial events and angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_160', 'valley floor with alluvial fans and nappe talus with low and medium gradient and medium elevation', 'valley floor with alluvial fans and nappe talus with low and medium gradient and medium elevation', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_161', 'high hill and low montain with aggraded landforms (terraces, alluvial fans) with high gradient and parallel drainage pattern', 'high hill and low montain with aggraded landforms (terraces, alluvial fans) with high gradient and parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_162', 'high mountain with high gradient and steep with angular drainage pattern, with prominent flow traces from glacial events and karst phenomena', 'high mountain with high gradient and steep with angular drainage pattern, with prominent flow traces from glacial events and karst phenomena', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_163', 'low and high mountain with high gradient and steep with flow traces from glacial events and subparallel drainage pattern', 'low and high mountain with high gradient and steep with flow traces from glacial events and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_164', 'medium and high hills with medium and high gradient with subparallel drainage pattern', 'medium and high hills with medium and high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_165', 'relief and upland plains di bassa and alta montagna da media with high gradient with subparallel to angular drainage pattern', 'relief and upland plains di bassa and alta montagna da media with high gradient with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_166', 'low and high mountain with high gradient with subdentritic to subparallel drainage pattern', 'low and high mountain with high gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_167', 'low and high mountain with high gradient and steep with flow traces from glacial events and subdentritic drainage pattern', 'low and high mountain with high gradient and steep with flow traces from glacial events and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_168', 'partially dissected flood plane on the floodplain with braided channel and meandering drainage pattern', 'partially dissected flood plane on the floodplain with braided channel and meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_169', 'high gradients low mountains and high hills', 'high gradients low mountains and high hills', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_170', 'medium upland plains with subparallel drainage pattern', 'medium upland plains with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_171', 'structural terrace', 'structural terrace', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_172', 'marine terrace', 'marine terrace', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_173', 'upland plains of low mountain with low and medium gradient with karstic landforms and contorted drainage pattern', 'upland plains of low mountain with low and medium gradient with karstic landforms and contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_174', 'karstic medium and high hills with low and medium gradient', 'karstic medium and high hills with low and medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_175', 'high level hills and low mountain with medium and high gradient karstic with doline drainage pattern', 'high level hills and low mountain with medium and high gradient karstic with doline drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_176', 'alluvial fans and nappe talus with medium gradient and medium elevation', 'alluvial fans and nappe talus with medium gradient and medium elevation', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_177', 'coastal plane with dunal bars', 'coastal plane with dunal bars', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_178', 'low mountain with medium gradient with dentritic drainage pattern', 'low mountain with medium gradient with dentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_179', 'flood plane', 'flood plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_180', 'low mountain with medium and high gradient with subparallel to angular drainage pattern', 'low mountain with medium and high gradient with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_181', 'high hills with medium gradient with deranged drainage pattern', 'high hills with medium gradient with deranged drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_182', 'high level hills with medium and high gradient with subparallel drainage pattern', 'high level hills with medium and high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_183', 'low hill with low and medium gradient with dentritic drainage pattern', 'low hill with low and medium gradient with dentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_184', 'low hill with medium and high gradient with subparallel to angular drainage pattern', 'low hill with medium and high gradient with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_185', 'low hill with medium gradient with subdentritic to subparallel drainage pattern', 'low hill with medium gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_186', 'medium hills with medium gradient with subparallel drainage pattern', 'medium hills with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_187', 'high level hills with high gradient with subparallel drainage pattern', 'high level hills with high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_188', 'structural depression in mountain converging slopes', 'structural depression in mountain converging slopes', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_189', 'low mountain with high gradient with subparallel to angular drainage pattern', 'low mountain with high gradient with subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_190', 'valley floor', 'valley floor', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_191', 'delta apparatus and marine deposits landforms with hanging stream beds with linear to meandering drainage pattern', 'delta apparatus and marine deposits landforms with hanging stream beds with linear to meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_192', 'slightly convex alluvial fans with braided channel and meandering drainage pattern', 'slightly convex alluvial fans with braided channel and meandering drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_193', 'high mountain with high gradient and steep with karstic landforms', 'high mountain with high gradient and steep with karstic landforms', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_194', 'medium and high hills with karstic landforms with medium and high gradient with contorted drainage pattern', 'medium and high hills with karstic landforms with medium and high gradient with contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_195', 'treads and karstic plateau of medium elevation and riser with upland plains of low mountain', 'treads and karstic plateau of medium elevation and riser with upland plains of low mountain', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_196', 'low and high mountain with high gradient with flow traces from glacial events and angular to subparallel drainage pattern', 'low and high mountain with high gradient with flow traces from glacial events and angular to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_197', 'high mountain with high gradient and steep with subparallel drainage pattern', 'high mountain with high gradient and steep with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_198', 'high mountain with high gradient and steep with flow traces from glacial events and angular drainage pattern', 'high mountain with high gradient and steep with flow traces from glacial events and angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_199', 'low and high mountain with high gradient and steep with slightly developed angular drainage pattern', 'low and high mountain with high gradient and steep with slightly developed angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_200', 'low and high mountain with high gradient with karstic landforms and subparallel drainage pattern', 'low and high mountain with high gradient with karstic landforms and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_201', 'fluvio-glacial plane with alluvial funs, nappe talus and landslide deposits', 'fluvio-glacial plane with alluvial funs, nappe talus and landslide deposits', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_202', 'medium and high hills with medium gradient with subparallel drainage pattern', 'medium and high hills with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_203', 'upland plain in high elevation with subparallel drainage pattern', 'upland plain in high elevation with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_204', 'filled basins (alluvium-colluvium)', 'filled basins (alluvium-colluvium)', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_205', 'alluvial funs and nappe talus with low gradient and low elevation', 'alluvial funs and nappe talus with low gradient and low elevation', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_206', 'flat surfaces with low gradient with subparallel drainage pattern', 'flat surfaces with low gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_207', 'structural surface of volcanic apparatus with convex summit and elongated ridge with dentritic drainage pattern and canyons', 'structural surface of volcanic apparatus with convex summit and elongated ridge with dentritic drainage pattern and canyons', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_208', 'caldera and volcanic slopes with low and medium gradient, with centrifugal and centripetal drainage pattern', 'caldera and volcanic slopes with low and medium gradient, with centrifugal and centripetal drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_209', 'slopes of volcanic apparatus and caldere with medium to high gradient with centrifugal and centripetal drainage pattern', 'slopes of volcanic apparatus and caldere with medium to high gradient with centrifugal and centripetal drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_210', 'slope with medium gradient of coalescent volcanic calderas', 'slope with medium gradient of coalescent volcanic calderas', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_211', 'irregolar slopes a media and with high gradient islands', 'irregolar slopes a media and with high gradient islands', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_212', 'flat area and coastal lagoonal depressed', 'flat area and coastal lagoonal depressed', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_213', 'terraces and treads di bassa quota with low gradient with subparallel drainage pattern', 'terraces and treads di bassa quota with low gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_214', 'low and medium coastal hills with low gradient and subparallel drainage pattern', 'low and medium coastal hills with low gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_215', 'low and medium hills with medium gradient with dentritic drainage pattern', 'low and medium hills with medium gradient with dentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_216', 'low and medium hills with medium and high gradient with drainage pattern angolare', 'low and medium hills with medium and high gradient with drainage pattern angolare', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_217', 'low mountain with high gradient and steep with drainage pattern da subdentritic ad angular', 'low mountain with high gradient and steep with drainage pattern da subdentritic ad angular', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_218', 'high level hills and low mountain with medium and high gradient with drainage pattern da angular a contorted', 'high level hills and low mountain with medium and high gradient with drainage pattern da angular a contorted', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_219', 'low mountain with high gradient with flow traces from glacial events and contorted drainage pattern', 'low mountain with high gradient with flow traces from glacial events and contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_220', 'complex filling basins (karst, alluvial lacustrine and alluvium-colluvium) with artificial drainage pattern', 'complex filling basins (karst, alluvial lacustrine and alluvium-colluvium) with artificial drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_221', 'medium and high hills with medium gradient and low mountain with medium gradient with dentritic drainage pattern', 'medium and high hills with medium gradient and low mountain with medium gradient with dentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_222', 'low mountain with high gradient with deranged drainage pattern', 'low mountain with high gradient with deranged drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_223', 'low and high mountain with medium and high gradient, with subparallel drainage pattern and angular', 'low and high mountain with medium and high gradient, with subparallel drainage pattern and angular', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_224', 'high mountain with high gradient with flow traces from glacial events and subparallel to angular drainage pattern', 'high mountain with high gradient with flow traces from glacial events and subparallel to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_225', 'low and medium hills with medium gradient', 'low and medium hills with medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_226', 'treads and slopes with low and medium gradient with weakly developed or absent drainage pattern', 'treads and slopes with low and medium gradient with weakly developed or absent drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_227', 'steep slopes of low mountain with subparallel or with deranged drainage pattern', 'steep slopes of low mountain with subparallel or with deranged drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_228', 'medium and high hills with medium and high gradient with subdentritic drainage pattern', 'medium and high hills with medium and high gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_229', 'coastal low hill, with low  to medium gradient with subparallel drainage pattern', 'coastal low hill, with low  to medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_230', 'coastal low hill with medium to high gradient with subparallel to subdentritic drainage pattern', 'coastal low hill with medium to high gradient with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_231', 'low and medium coastal relief, a pendenza da bassa a media with subparallel drainage pattern', 'low and medium coastal relief, a pendenza da bassa a media with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_232', 'low and medium coastal relief, with medium to high gradient with subparallel drainage pattern', 'low and medium coastal relief, with medium to high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_233', 'high and medium coastal relief, with medium to high gradient with subparallel to subdentritic drainage pattern', 'high and medium coastal relief, with medium to high gradient with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_234', 'low and medium coastal relief, coastal relief with medium to high gradient with drainage pattern subradiale', 'low and medium coastal relief, coastal relief with medium to high gradient with drainage pattern subradiale', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_235', 'low and medium coastal relief with medium and high gradient with subparallel drainage pattern that connected karstic plateau with doline drainage pattern', 'low and medium coastal relief with medium and high gradient with subparallel drainage pattern that connected karstic plateau with doline drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_236', 'low and medium coastal relief, with medium to high gradient, with superfici di spianamento marino (terraces marini) to subparallel drainage pattern', 'low and medium coastal relief, with medium to high gradient, with superfici di spianamento marino (terraces marini) to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_237', 'low, medium and high coastal hills with high tor steep gradient (falesie) with subparallel drainage pattern', 'low, medium and high coastal hills with high tor steep gradient (falesie) with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_238', 'low, medium and high coastal hills with medium and high gradient, with subparallel to subdentritic drainage pattern', 'low, medium and high coastal hills with medium and high gradient, with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_239', 'medium and high hills with low and medium gradient with subparallel to subdentritic drainage pattern', 'medium and high hills with low and medium gradient with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_240', 'low mountain with medium to high gradient with treads structural e/o morfologici with low gradient, subdentritic drainage pattern', 'low mountain with medium to high gradient with treads structural e/o morfologici with low gradient, subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_241', 'low and high mountain with high tor steep gradient with subdentritic to subparallel drainage pattern', 'low and high mountain with high tor steep gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_242', 'low and high mountain with high tor steep gradient with subparallel drainage pattern', 'low and high mountain with high tor steep gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_243', 'valley floor with meandering drainage pattern and alluvial terraces', 'valley floor with meandering drainage pattern and alluvial terraces', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_244', 'medium hills with low and medium gradient with subparallel drainage pattern', 'medium hills with low and medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_245', 'high mountain with medium and high gradient and subparallel to subdentritic drainage pattern', 'high mountain with medium and high gradient and subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_246', 'medium and high hills with high gradient and angular drainage pattern', 'medium and high hills with high gradient and angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_247', 'valley floor and aggraded landforms (terraces, funs, etc.) with subparallel drainage pattern with low and medium gradient', 'valley floor and aggraded landforms (terraces, funs, etc.) with subparallel drainage pattern with low and medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_248', 'upland plains of low and high mountain with low and medium gradient with karstic landforms and contorted drainage pattern', 'upland plains of low and high mountain with low and medium gradient with karstic landforms and contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_249', 'fluvio-glacial plane', 'fluvio-glacial plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_250', 'low, medium and high hills with medium and high gradient with angular drainage pattern', 'low, medium and high hills with medium and high gradient with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_251', 'valley floor with bar tops', 'valley floor with bar tops', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_252', 'delta plane', 'delta plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_253', 'medium and high hills with high gradient with subdentritic drainage pattern', 'medium and high hills with high gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_254', 'low hill with medium gradient with drainage pattern from subdentritic to subparallel', 'low hill with medium gradient with drainage pattern from subdentritic to subparallel', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_255', 'high level hills and low mountain with medium and high gradient with flow traces from glacial events and angular drainage pattern', 'high level hills and low mountain with medium and high gradient with flow traces from glacial events and angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_256', 'low mountain with medium and high gradient with hills, with flow traces from glacial events and angular drainage pattern', 'low mountain with medium and high gradient with hills, with flow traces from glacial events and angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_257', 'high level hills and low mountain with medium and high gradient karstic with doline drainage pattern', 'high level hills and low mountain with medium and high gradient karstic with doline drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_258', 'slopes of volcanic islands with medium and high gradient, with volcanic cones', 'slopes of volcanic islands with medium and high gradient, with volcanic cones', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_259', 'slopes of volcanic islands with low and medium gradient', 'slopes of volcanic islands with low and medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_260', 'slopes of islands with low and medium gradient with structural surface and karstic landforms', 'slopes of islands with low and medium gradient with structural surface and karstic landforms', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_261', 'reclaimed depressed areas of coastal lakes with artificial leveed drainage pattern and recent dunes', 'reclaimed depressed areas of coastal lakes with artificial leveed drainage pattern and recent dunes', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_262', 'ancient dune partially terraced, with artificial rectified drainage pattern pattern', 'ancient dune partially terraced, with artificial rectified drainage pattern pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_263', 'dissected ancient dunes and surfaces with low and medium gradient', 'dissected ancient dunes and surfaces with low and medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_264', 'low and medium hills a pendenza bassa and media and subdentritic to subparallel drainage pattern', 'low and medium hills a pendenza bassa and media and subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_265', 'structural surface of volcanic apparatus strongly dissected with narrow elongated summit and canyons', 'structural surface of volcanic apparatus strongly dissected with narrow elongated summit and canyons', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_266', 'deeply dissected slopes of volcanic plateaux with medium and low gradient with summit escarpments', 'deeply dissected slopes of volcanic plateaux with medium and low gradient with summit escarpments', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_267', 'deeply dissected slopes of volcanic plateaux with medium and high gradient with summit escarpments', 'deeply dissected slopes of volcanic plateaux with medium and high gradient with summit escarpments', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_268', 'high hills and low mountain of volcanic apparatus with main caldera or secondary calderas with centripetal or centrifugal drainage pattern', 'high hills and low mountain of volcanic apparatus with main caldera or secondary calderas with centripetal or centrifugal drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_269', 'treads structural of islands with low gradient and steep slope', 'treads structural of islands with low gradient and steep slope', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_270', 'regular slopes of islands with low to high gradient', 'regular slopes of islands with low to high gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_271', 'irregular slopes of islands with medium and high gradient or with steep slope', 'irregular slopes of islands with medium and high gradient or with steep slope', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_272', 'low and medium hills with medium and high gradient with subdentritic drainage pattern', 'low and medium hills with medium and high gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_273', 'complex filling basins (karst, alluvial lacustrine and alluvium-colluvium) with artificial drainage pattern', 'complex filling basins (karst, alluvial lacustrine and alluvium-colluvium) with artificial drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_274', 'high level hills and low mountain with slopes with high gradient or steep and summit with low gradient; parallel and subparallel drainage pattern', 'high level hills and low mountain with slopes with high gradient or steep and summit with low gradient; parallel and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_275', 'medium and high hills consisting by deeply dissected terraced flat surfaces with slopes with medium and high gradient and subparallel drainage pattern', 'medium and high hills consisting by deeply dissected terraced flat surfaces with slopes with medium and high gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_276', 'medium hills with medium gradient and many summit escarpments edging long and narrow ridges with subparallel to subdentritic drainage pattern', 'medium hills with medium gradient and many summit escarpments edging long and narrow ridges with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_277', 'medium and high hills with medium and low gradient, with subparallel to subdentritic drainage pattern', 'medium and high hills with medium and low gradient, with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_278', 'dissected treads and aggradation landforms with low gradient', 'dissected treads and aggradation landforms with low gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_279', 'low and medium hills with medium and low gradient, with subparallel to subdentritic drainage pattern', 'low and medium hills with medium and low gradient, with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_280', 'medium and high hills with medium gradient with subdentritic drainage pattern', 'medium and high hills with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_281', 'low and medium hills with medium gradient with nappe talus and subparallel drainage pattern', 'low and medium hills with medium gradient with nappe talus and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_282', 'low and medium hills with medium and high gradient and subdentritic to subparallel drainage pattern', 'low and medium hills with medium and high gradient and subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_283', 'low mountain with dissected and sometimes terraced structural surface with low or medium gradient, with subparallel drainage pattern', 'low mountain with dissected and sometimes terraced structural surface with low or medium gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_284', 'low to high hills with high gradient and parallel drainage pattern', 'low to high hills with high gradient and parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_285', 'low to high hills with medium and high gradient with parallel and subparallel drainage pattern', 'low to high hills with medium and high gradient with parallel and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_286', 'low and medium hills with medium and high gradient with karstic landforms and contorted drainage pattern', 'low and medium hills with medium and high gradient with karstic landforms and contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_287', 'high level hills and low mountain with medium and high gradient, with subparallel and subdentritic drainage pattern', 'high level hills and low mountain with medium and high gradient, with subparallel and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_288', 'summit areas consist by medium treads and karstic plateau and areas with low and medium gradient', 'summit areas consist by medium treads and karstic plateau and areas with low and medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_289', 'low and high mountain with high gradient and steep with parallel or subparallel drainage pattern', 'low and high mountain with high gradient and steep with parallel or subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_290', 'high level hills and low mountain with medium and high gradient with karstic landforms and contorted drainage pattern', 'high level hills and low mountain with medium and high gradient with karstic landforms and contorted drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_291', 'upland plains and low mountain with angular drainage pattern', 'upland plains and low mountain with angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_292', 'high mountain with high gradient with contorted to angular drainage pattern', 'high mountain with high gradient with contorted to angular drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_293', 'terraces and dissected coastal treads with subparallel drainage pattern and narrow coastal plane', 'terraces and dissected coastal treads with subparallel drainage pattern and narrow coastal plane', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_294', 'flat coastal areas', 'flat coastal areas', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_295', 'coastal hills with medium and high gradient with subparallel to subdentritic drainage pattern', 'coastal hills with medium and high gradient with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_296', 'low, medium and high hills with subdentritic to subparallel drainage pattern', 'low, medium and high hills with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_297', 'high level hills with medium gradient and low mountain with medium and high gradient, with subparallel drainage pattern', 'high level hills with medium gradient and low mountain with medium and high gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_298', 'medium and high hills with medium gradient and low mountain with medium and high gradient, with subparallel to subdentritic drainage pattern', 'medium and high hills with medium gradient and low mountain with medium and high gradient, with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_299', 'medium and high hills with medium gradient and low mountain with medium gradient, with subdentritic drainage pattern', 'medium and high hills with medium gradient and low mountain with medium gradient, with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_300', 'low, medium and high hills with high gradient and low mountain with high gradient and subparallel drainage pattern', 'low, medium and high hills with high gradient and low mountain with high gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_301', 'medium and high hills with medium gradient and dentritic drainage pattern', 'medium and high hills with medium gradient and dentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_302', 'terraces and deeply dissected coastal treads with subparallel drainage pattern', 'terraces and deeply dissected coastal treads with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_303', 'coastal areas, dissected residual terraces and slopes of low hill with medium gradient and subdentritic drainage pattern', 'coastal areas, dissected residual terraces and slopes of low hill with medium gradient and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_304', 'low mountain with medium, high or steep gradient, with subparallel to subdentritic drainage pattern', 'low mountain with medium, high or steep gradient, with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_305', 'low, medium and high hills with medium gradient, with subparallel to subdentritic drainage pattern', 'low, medium and high hills with medium gradient, with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_306', 'high level hills and low mountain with medium gradient, with subdentritic to subparallel drainage pattern', 'high level hills and low mountain with medium gradient, with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_307', 'high hills with medium gradient and low mountain with medium and high gradient, with dentritic and subdentritic drainage pattern', 'high hills with medium gradient and low mountain with medium and high gradient, with dentritic and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_308', 'medium and high hills with medium and low gradient, with subdentritic drainage pattern', 'medium and high hills with medium and low gradient, with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_309', 'slopes in low elevation and low gradient and low and medium hills with medium gradient, with subparallel drainage pattern', 'slopes in low elevation and low gradient and low and medium hills with medium gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_310', 'low, medium and high hills with medium gradient, with convex or flat summit arrotondate, with subparallel to subdentritic drainage pattern', 'low, medium and high hills with medium gradient, with convex or flat summit arrotondate, with subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_311', 'low and medium hills with medium gradient and slopes of medium elevation with low gradient, with subparallel drainage pattern', 'low and medium hills with medium gradient and slopes of medium elevation with low gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_312', 'coastal planes and slopes in low elevation and low gradient', 'coastal planes and slopes in low elevation and low gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_313', 'floodplain in low elevation, and slopes with low gradient and low hills and medium gradient, with subparallel drainage pattern', 'floodplain in low elevation, and slopes with low gradient and low hills and medium gradient, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_314', 'low and medium hills with medium and high gradient and low surfaces with low gradient, with subparallel to angolar drainage pattern', 'low and medium hills with medium and high gradient and low surfaces with low gradient, with subparallel to angolar drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_315', 'marine terrace with bordor steep slopes and with deep flat bottomed rills', 'marine terrace with bordor steep slopes and with deep flat bottomed rills', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_316', 'coastal terraces and low hills with medium gradient slightly dissected and with parallel to subparallel drainage pattern', 'coastal terraces and low hills with medium gradient slightly dissected and with parallel to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_317', 'coastal planes partially karstic', 'coastal planes partially karstic', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_318', 'slopes of volcanic apparatus in medium and high elevation with low and medium gradient, with poorly developed subparallel drainage pattern', 'slopes of volcanic apparatus in medium and high elevation with low and medium gradient, with poorly developed subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_319', 'low and medium hills with medium and high gradient, with parallel and subparallel drainage pattern', 'low and medium hills with medium and high gradient, with parallel and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_320', 'low hill with medium and high gradient with residual terraces on the summit and valley floor, with parallel drainage pattern', 'low hill with medium and high gradient with residual terraces on the summit and valley floor, with parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_321', 'low, medium and high hils and low mountain with high gradient and parallel to subparallel drainage pattern', 'low, medium and high hils and low mountain with high gradient and parallel to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_322', 'low, medium and high hills with medium and high gradient with subdentritic drainage pattern', 'low, medium and high hills with medium and high gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_323', 'low to high hills with leveled summit or with medium gradient and slopes with high gradient or steep', 'low to high hills with leveled summit or with medium gradient and slopes with high gradient or steep', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_324', 'medium and high hills with medium gradient and low mountain with medium to steep gradient and subparallel drainage pattern', 'medium and high hills with medium gradient and low mountain with medium to steep gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_325', 'low to high hills with medium and high gradient or steep and low mountain with steep slopes with subparallel drainage pattern', 'low to high hills with medium and high gradient or steep and low mountain with steep slopes with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_326', 'low and medium hills with treads dissected with low and medium gradient and versanti with high and steep gradient with subparallel drainage pattern', 'low and medium hills with treads dissected with low and medium gradient and versanti with high and steep gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_327', 'medium and high hills with medium and high gradient and with parallel drainage pattern', 'medium and high hills with medium and high gradient and with parallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_328', 'slopes in low and medium elevation with low gradient and low and medium hills with medium gradient and subdentritic drainage pattern', 'slopes in low and medium elevation with low gradient and low and medium hills with medium gradient and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_329', 'medium and high hills with medium gradient and low mountain with low and medium gradient and subdentritic drainage pattern', 'medium and high hills with medium gradient and low mountain with low and medium gradient and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_330', 'low and medium hills with medium gradient and subparallel drainage pattern', 'low and medium hills with medium gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_331', 'medium and high hills with medium gradient and medium slopes with low gradient and subparallel to subdentritic drainage pattern', 'medium and high hills with medium gradient and medium slopes with low gradient and subparallel to subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_332', 'medium and high hills with treads dissected with low gradient and slopes with medium gradient', 'medium and high hills with treads dissected with low gradient and slopes with medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_333', 'high hills and low mountain with medium gradient and summit dissected treads of low mountain with low and medium gradient', 'high hills and low mountain with medium gradient and summit dissected treads of low mountain with low and medium gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_334', 'treads with low and medium gradient with rills with high to steep gradient and dissected low and medium hills with slopes', 'treads with low and medium gradient with rills with high to steep gradient and dissected low and medium hills with slopes', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_335', 'planes and slopes in low elevation and low gradient with low gradient and low hill with medium gradient with subparallel drainage pattern', 'planes and slopes in low elevation and low gradient with low gradient and low hill with medium gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_336', 'planes and slopes in low elevation and low and medium elevation with low gradient dissected, with parallel and subparallel drainage pattern', 'planes and slopes in low elevation and low and medium elevation with low gradient dissected, with parallel and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_337', 'dissected flat treads of medium elevation or with low gradient and riser with upland plains of low mountain', 'dissected flat treads of medium elevation or with low gradient and riser with upland plains of low mountain', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_338', 'slopes of dissected structural surface of medium and high hills with medium gradient and summit areas with low gradient', 'slopes of dissected structural surface of medium and high hills with medium gradient and summit areas with low gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_339', 'slopes of dissected structural surface of medium and high hills with medium and high gradient', 'slopes of dissected structural surface of medium and high hills with medium and high gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_340', 'treads and slopes with low gradient of medium and dissected karstified high hills with medium and high gradient with subparallel drainage pattern', 'treads and slopes with low gradient of medium and dissected karstified high hills with medium and high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_341', 'slopes with low gradient and flat areas of dissected medium and high hills with medium and high gradient', 'slopes with low gradient and flat areas of dissected medium and high hills with medium and high gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_342', 'low to high hills with medium gradient and slopes of low and medium elevation with low gradient with dentritic and subdentritic drainage pattern', 'low to high hills with medium gradient and slopes of low and medium elevation with low gradient with dentritic and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_343', 'dissected marine terraces, with slopes with medium and high gradient and parallel and subparallel drainage pattern', 'dissected marine terraces, with slopes with medium and high gradient and parallel and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_344', 'low and medium hills with low and medium summit with low gradient and parallel and subparallel drainage pattern', 'low and medium hills with low and medium summit with low gradient and parallel and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_345', 'medium and high hills with medium gradient and medium slopes with low gradient with subdentritic drainage pattern', 'medium and high hills with medium gradient and medium slopes with low gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_346', 'low and medium hills with medium gradient with residual marine terraces and low gradient with subparallel drainage pattern', 'low and medium hills with medium gradient with residual marine terraces and low gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_347', 'low and medium hills with medium gradient and eroded and dissected terraced surfaces with low gradient with subparallel drainage pattern', 'low and medium hills with medium gradient and eroded and dissected terraced surfaces with low gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_348', 'low and medium hills with medium gradient and low slopes with low gradient with subdentritic drainage pattern', 'low and medium hills with medium gradient and low slopes with low gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_349', 'low and medium hills with medium gradient and slopes of low and medium elevation with low gradient with subparallel and subdentritic drainage pattern', 'low and medium hills with medium gradient and slopes of low and medium elevation with low gradient with subparallel and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_350', 'medium and high hills with medium gradient, with subdentritic to subparallel drainage pattern', 'medium and high hills with medium gradient, with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_351', 'low and medium hills with medium gradient with subdentritic to subparallel drainage pattern', 'low and medium hills with medium gradient with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_352', 'coastal planes and wave-cut platform', 'coastal planes and wave-cut platform', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_353', 'flat areas and and low slopes with low gradient', 'flat areas and and low slopes with low gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_354', 'coastal planes with valley floor and flat terraces and low slopes with low gradient', 'coastal planes with valley floor and flat terraces and low slopes with low gradient', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_355', 'low and medium hills with medium to high gradient and subparallel drainage pattern', 'low and medium hills with medium to high gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_356', 'medium and high hills with medium gradient and low mountain with medium and high gradient with subparallel and subdentritic drainage pattern', 'medium and high hills with medium gradient and low mountain with medium and high gradient with subparallel and subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_357', 'low to high hills with medium to high gradient and subparallel drainage pattern', 'low to high hills with medium to high gradient and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_358', 'low to high hills with medium gradient and subdentritic and subparallel drainage pattern', 'low to high hills with medium gradient and subdentritic and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_359', 'coastal planes with artificial rectified drainage pattern and residual marine terraces', 'coastal planes with artificial rectified drainage pattern and residual marine terraces', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_360', 'coastal planes with with dunal bars, valley floor and terraces', 'coastal planes with with dunal bars, valley floor and terraces', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_361', 'piedmont areas of volcanic apparatus with low gradient or flat, with subparallel drainage pattern', 'piedmont areas of volcanic apparatus with low gradient or flat, with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_362', 'high level hills and low mountain with high gradient and steep with subdentritic to subparallel drainage pattern', 'high level hills and low mountain with high gradient and steep with subdentritic to subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_363', 'valley floor with meandering partially rectified drainage pattern and dissected fluvial terraces', 'valley floor with meandering partially rectified drainage pattern and dissected fluvial terraces', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_364', 'coastal plane with artificial rectified drainage pattern', 'coastal plane with artificial rectified drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_365', 'high hills with medium gradient with subdentritic drainage pattern', 'high hills with medium gradient with subdentritic drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_366', 'low and medium hills with medium gradient with subdentritic and subparallel drainage pattern', 'low and medium hills with medium gradient with subdentritic and subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_367', 'low and high mountain with medium and high gradient with subparallel drainage pattern', 'low and high mountain with medium and high gradient with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_368', 'volcanic slopes of low mountain with medium and high gradient and steep slopes, with weakly developed drainage pattern', 'volcanic slopes of low mountain with medium and high gradient and steep slopes, with weakly developed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_369', 'volcanic slopes of low mountain with low and medium gradient with small volcanic cones and weakly developed drainage pattern', 'volcanic slopes of low mountain with low and medium gradient with small volcanic cones and weakly developed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_370', 'treads and piedmont slopes of low and medium volcanic apparatus with low and medium gradient with drainage pattern partially developed', 'treads and piedmont slopes of low and medium volcanic apparatus with low and medium gradient with drainage pattern partially developed', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_371', 'eroded deeply dissected terrace and karstic plateau', 'eroded deeply dissected terrace and karstic plateau', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_372', 'slightly dissected marine terrace inclined towards sea and coastal plane with dunal bar', 'slightly dissected marine terrace inclined towards sea and coastal plane with dunal bar', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_373', 'low and high mountain with high gradient or steep and low mountain with medium gradient, locally karstic and with subparallel drainage pattern', 'low and high mountain with high gradient or steep and low mountain with medium gradient, locally karstic and with subparallel drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_374', 'treads and slopes with low and medium gradient in low and medium elevation with weakly developed drainage pattern', 'treads and slopes with low and medium gradient in low and medium elevation with weakly developed drainage pattern', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_375', 'dissected terraces and treads', 'dissected terraces and treads', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/morfo_st_376', 'marine terrace and beach plains', 'marine terrace and beach plains', 'MorphologyLandSystems', NULL, NULL, NULL, NULL);


-- PhysiographyForm
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_01', 'unknown', 'unknown', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_02', 'anthropic origin landforms', 'anthropic origin landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_03', 'dumping or landfill area', 'dumping or landfill area', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_04', 'dumping area', 'dumping area', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_05', 'landfill area', 'landfill area', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_06', 'mining area', 'mining area', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_07', 'abandoned mine', 'abandoned mine', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_08', 'active mine', 'active mine', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_09', 'dike, channel or others artificial works', 'dike, channel or others artificial works', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_10', 'terraced slope', 'terraced slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_11', 'banked terraced slope', 'banked terraced slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_12', 'terraced slope degradated', 'terraced slope degradated', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_13', 'terraced slope integral', 'terraced slope integral', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_14', 'mechanized terraced slope', 'mechanized terraced slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_15', 'levelled ground, reshaped slope', 'levelled ground, reshaped slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_16', 'karst origin landforms', 'karst origin landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_17', 'karst depression', 'karst depression', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_18', 'open doline', 'open doline', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_19', 'sinkhole doline', 'sinkhole doline', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_20', 'flat bottomed doline', 'flat bottomed doline', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_21', 'open uvala', 'open uvala', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_22', 'hum', 'hum', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_23', 'residual relief (chicot)', 'residual relief (chicot)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_24', 'polje', 'polje', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_25', 'collapsed uvala', 'collapsed uvala', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_26', 'open polje', 'open polje', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_27', 'uvala', 'uvala', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_28', 'subsidence doline', 'subsidence doline', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_29', 'intensively karstic slope', 'intensively karstic slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_30', 'karst stones ("griza"or "gris�")', 'karst stones ("griza"or "gris�")', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_31', 'intensively karstic plateau', 'intensively karstic plateau', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_32', 'plateau with a fluviokarst network', 'plateau with a fluviokarst network', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_33', 'fluviokarst valley', 'fluviokarst valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_34', 'spring or blind fluviokarst valley', 'spring or blind fluviokarst valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_35', 'karst canyon', 'karst canyon', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_36', 'dry fluviokarst valley', 'dry fluviokarst valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_37', 'erosive modelling landforms', 'erosive modelling landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_38', 'debris accumulation form', 'debris accumulation form', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_39', 'talus (debris) cone', 'talus (debris) cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_40', 'active talus cone', 'active talus cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_41', 'stabilized talus cone', 'stabilized talus cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_42', 'alluvial glacis', 'alluvial glacis', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_43', 'rockfal talus', 'rockfal talus', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_44', 'active nappe talus', 'active nappe talus', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_45', 'stabilized nappe talus', 'stabilized nappe talus', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_46', 'peat bog slope', 'peat bog slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_47', 'avalanche cone', 'avalanche cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_48', 'avalanche channel', 'avalanche channel', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_49', 'slope with landslides and eventually rill and/or gully erosion', 'slope with landslides and eventually rill and/or gully erosion', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_50', 'slope with "biancane"', 'slope with "biancane"', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_51', 'badlands', 'badlands', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_52', 'slope with soil slips', 'slope with soil slips', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_53', 'slope with mappable catastrophical landslide', 'slope with mappable catastrophical landslide', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_54', 'slope with mass flow', 'slope with mass flow', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_55', 'creeping slope', 'creeping slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_56', 'slope with solifluction', 'slope with solifluction', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_57', 'slope with sheet and/or rill and/or gully erosion', 'slope with sheet and/or rill and/or gully erosion', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_58', 'slope with rill and/or gully erosion', 'slope with rill and/or gully erosion', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_59', 'slope with sheet erosion', 'slope with sheet erosion', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_60', 'slope with landslides', 'slope with landslides', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_61', 'landslide body', 'landslide body', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_62', 'landslide main scarp', 'landslide main scarp', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_63', 'erosion glacis or pediment', 'erosion glacis or pediment', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_64', 'linear slope', 'linear slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_65', 'linear aggraded slope', 'linear aggraded slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_66', 'linear non aggraded slope', 'linear non aggraded slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_67', 'linear regular slope', 'linear regular slope', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_68', 'scarp', 'scarp', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_69', 'scarp foot', 'scarp foot', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_70', 'residual terrace', 'residual terrace', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_71', 'planation surface', 'planation surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_72', 'dissected planation surface', 'dissected planation surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_73', 'levelled planation surface', 'levelled planation surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_74', 'semi-levelled planation surface', 'semi-levelled planation surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_75', 'residual relief (tor)', 'residual relief (tor)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_76', 'slope dissected by small valleys', 'slope dissected by small valleys', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_77', 'not aggraded slope dissected by small valleys, severly eroded', 'not aggraded slope dissected by small valleys, severly eroded', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_78', 'aggraded slope dissected by small valleys, severly eroded', 'aggraded slope dissected by small valleys, severly eroded', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_79', 'aggraded slope dissected by small valleys, redissected', 'aggraded slope dissected by small valleys, redissected', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_80', 'aggraded slope dissected by small valleys, concave form filled', 'aggraded slope dissected by small valleys, concave form filled', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_81', 'aggraded slope dissected by small valleys', 'aggraded slope dissected by small valleys', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_82', 'not aggraded slope dissected by small valleys', 'not aggraded slope dissected by small valleys', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_83', 'aggraded slope dissected by small valleys, flat bottom filled', 'aggraded slope dissected by small valleys, flat bottom filled', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_84', 'regular slope dissected by small valleys,', 'regular slope dissected by small valleys,', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_85', 'regular slope dissected by small valleys, severly eroded', 'regular slope dissected by small valleys, severly eroded', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_86', 'aggraded slope dissected by small valleys, catastrophically redissected', 'aggraded slope dissected by small valleys, catastrophically redissected', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_87', 'convex slope or summit', 'convex slope or summit', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_88', 'valley', 'valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_89', 'V shaped asimetric valley', 'V shaped asimetric valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_90', 'U shaped valley', 'U shaped valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_91', 'canyon', 'canyon', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_92', 'V shaped valley', 'V shaped valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_93', 'fluvial origin between mountain ridge landforms', 'fluvial origin between mountain ridge landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_94', 'valley floor between mountain ridges', 'valley floor between mountain ridges', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_95', 'valley floor between mountain ridges', 'valley floor between mountain ridges', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_96', 'valley floor with bedrock outcrop', 'valley floor with bedrock outcrop', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_97', 'valley floor active bed with interlaced channels', 'valley floor active bed with interlaced channels', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_98', 'ephemeral stream bed (fiumara)', 'ephemeral stream bed (fiumara)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_99', 'in filled valley floor', 'in filled valley floor', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_100', 'hanging valley floor', 'hanging valley floor', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_101', 'valley floor with traces of interlaced channels', 'valley floor with traces of interlaced channels', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_102', 'valley floor with traces of individual channels', 'valley floor with traces of individual channels', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_103', 'valley floor in reclaimed flood plane', 'valley floor in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_104', 'valley floor in reclaimed flood plane', 'valley floor in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_105', 'valley floor in reclaimed flood plane with bedrock outcrop', 'valley floor in reclaimed flood plane with bedrock outcrop', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_106', 'valley floor active bed with interlaced channels in reclaimed flood plane', 'valley floor active bed with interlaced channels in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_107', 'ephemeral stream bed (fiumara) in reclaimed flood plane', 'ephemeral stream bed (fiumara) in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_108', 'in filled valley floor in reclaimed flood plane', 'in filled valley floor in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_109', 'hanging valley floor in reclaimed flood plane', 'hanging valley floor in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_110', 'valley floor with traces of interlaced channels in reclaimed flood plane', 'valley floor with traces of interlaced channels in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_111', 'valley floor with traces of individual channels in reclaimed flood plane', 'valley floor with traces of individual channels in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_112', 'small alluvial fans', 'small alluvial fans', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_113', 'alluvial fan', 'alluvial fan', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_114', 'inter-fan depression', 'inter-fan depression', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_115', 'coalescent alluvial fans', 'coalescent alluvial fans', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_116', 'alluvial glacis of alluvial fans', 'alluvial glacis of alluvial fans', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_117', 'in filled or reclaimed lacustrine plane in reclaimed flood plane', 'in filled or reclaimed lacustrine plane in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_118', 'almost mineral in filled or reclaimed lacustrine plane in reclaimed flood plane', 'almost mineral in filled or reclaimed lacustrine plane in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_119', 'almost organical in filled or reclaimed lacustrine plane in reclaimed flood plane', 'almost organical in filled or reclaimed lacustrine plane in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_120', 'almost mineral in filled or reclaimed lacustrine hanging plane in reclaimed flood plane', 'almost mineral in filled or reclaimed lacustrine hanging plane in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_121', 'erosion terrace', 'erosion terrace', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_122', 'in filled or reclaimed lacustrine plane', 'in filled or reclaimed lacustrine plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_123', 'almost mineral in filled or reclaimed lacustrine plane', 'almost mineral in filled or reclaimed lacustrine plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_124', 'almost organical in filled or reclaimed lacustrine plane', 'almost organical in filled or reclaimed lacustrine plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_125', 'almost mineral in filled or reclaimed lacustrine hanging plane', 'almost mineral in filled or reclaimed lacustrine hanging plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_126', 'large in filled depression', 'large in filled depression', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_127', 'hanging large in filled depression', 'hanging large in filled depression', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_128', 'fluvial terrace between mountain ridges', 'fluvial terrace between mountain ridges', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_129', 'dissected fluvial terrace between mountain ridges', 'dissected fluvial terrace between mountain ridges', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_130', 'fluvial terrace between mountain ridges with uneven surface', 'fluvial terrace between mountain ridges with uneven surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_131', 'riverbank erosion scarp', 'riverbank erosion scarp', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_132', 'fluvial terrace with traces of interlaced channels between mountain ridges', 'fluvial terrace with traces of interlaced channels between mountain ridges', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_133', 'fluvial terrace with traces of individual channels traces between mountain ridges', 'fluvial terrace with traces of individual channels traces between mountain ridges', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_134', 'glacial and periglacial landforms', 'glacial and periglacial landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_135', 'block flow (and rock glaciers)', 'block flow (and rock glaciers)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_136', 'glacial circle', 'glacial circle', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_137', 'surface with crioturbation', 'surface with crioturbation', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_138', 'fluvial-glacial accumulation landforms', 'fluvial-glacial accumulation landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_139', 'esker', 'esker', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_140', 'proglacial alluvial relieves (Kame)', 'proglacial alluvial relieves (Kame)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_141', 'proglacial alluvial plane (Sandur)', 'proglacial alluvial plane (Sandur)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_142', 'glacial valley', 'glacial valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_143', 'hanging glacial valley', 'hanging glacial valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_144', 'U shaped glacial valley', 'U shaped glacial valley', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_145', 'moraine relieves', 'moraine relieves', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_146', 'bottom moraine, ablation moraine', 'bottom moraine, ablation moraine', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_147', 'drumlin', 'drumlin', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_148', 'frontal moraine', 'frontal moraine', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_149', 'intermoraine depression', 'intermoraine depression', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_150', 'lateral moraine', 'lateral moraine', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_151', 'nivomoraine', 'nivomoraine', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_152', 'nivation hollow', 'nivation hollow', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_153', 'overexcavation hollow', 'overexcavation hollow', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_154', 'filled overexcavation hollow', 'filled overexcavation hollow', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_155', 'glacial erosion terrace', 'glacial erosion terrace', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_156', 'lagoonal, lacustrine and marine origin landforms', 'lagoonal, lacustrine and marine origin landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_157', 'marine abrasion platform', 'marine abrasion platform', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_158', 'talus', 'talus', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_159', 'lacustrine terrace', 'lacustrine terrace', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_160', 'coastal plane', 'coastal plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_161', 'tide plane', 'tide plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_162', 'bar', 'bar', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_163', 'mud plane', 'mud plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_164', 'lacustrine fluctuation strip', 'lacustrine fluctuation strip', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_165', 'tide channel', 'tide channel', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_166', 'marsh plane', 'marsh plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_167', 'sand plane', 'sand plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_168', 'marine terrace', 'marine terrace', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_169', 'dissected marine terrace', 'dissected marine terrace', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_170', 'fluvial origin in large plains landforms', 'fluvial origin in large plains landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_171', 'reclaimed flood plane', 'reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_172', 'transitional area: natural levee in reclaimed flood plane', 'transitional area: natural levee in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_173', 'distant crevasse splay or channel in reclaimed flood plane', 'distant crevasse splay or channel in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_174', 'bar top in reclaimed flood plane', 'bar top in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_175', 'single paleochannel in reclaimed flood plane', 'single paleochannel in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_176', 'low land spring in reclaimed flood plane', 'low land spring in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_177', 'overtopping area in reclaimed flood plane', 'overtopping area in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_178', 'crevasse splay or channel in reclaimed flood plane', 'crevasse splay or channel in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_179', 'paleochannel with interlaced channels in reclaimed flood plane', 'paleochannel with interlaced channels in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_180', 'area with interlaced channels traces in reclaimed flood plane', 'area with interlaced channels traces in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_181', 'area with individual channels traces in reclaimed flood plane', 'area with individual channels traces in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_182', 'depression in reclaimed flood plane', 'depression in reclaimed flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_183', 'flood plane', 'flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_184', 'transitional area: natural levee in flood plane', 'transitional area: natural levee in flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_185', 'distant crevasse splay or channel', 'distant crevasse splay or channel', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_186', 'bar top in flood plane', 'bar top in flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_187', 'hanging flood plane', 'hanging flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_188', 'active bed with interlaced channels', 'active bed with interlaced channels', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_189', 'flood plane splay', 'flood plane splay', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_190', 'fluvial island', 'fluvial island', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_191', 'paleochannel with single channel', 'paleochannel with single channel', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_192', 'low land spring in flood plane', 'low land spring in flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_193', 'meanders plane', 'meanders plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_194', 'overtopping area', 'overtopping area', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_195', 'crevasse splay or channel', 'crevasse splay or channel', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_196', 'paleochannel  with interlaced channels in flood plane', 'paleochannel  with interlaced channels in flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_197', 'area with interlaced channels traces in flood plane', 'area with interlaced channels traces in flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_198', 'area with individual channels traces in flood plane', 'area with individual channels traces in flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_199', 'depression in flood plane', 'depression in flood plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_200', 'delta', 'delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_201', 'transitional area: natural levee in delta', 'transitional area: natural levee in delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_202', 'bar top in delta plane', 'bar top in delta plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_203', 'overtopping area in delta', 'overtopping area in delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_204', 'crevasse splay in delta', 'crevasse splay in delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_205', 'not active bed in delta', 'not active bed in delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_206', 'depression in delta', 'depression in delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_207', 'reclaimed delta', 'reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_208', 'transitional area: natural levee in reclaimed delta', 'transitional area: natural levee in reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_209', 'interchannel basin in reclaimed delta', 'interchannel basin in reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_210', 'bar top in reclaimed delta plane', 'bar top in reclaimed delta plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_211', 'delta plane in reclaimed delta', 'delta plane in reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_212', 'overtopping area in reclaimed delta', 'overtopping area in reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_213', 'crevasse splay in reclaimed delta', 'crevasse splay in reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_214', 'not active bed in reclaimed delta', 'not active bed in reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_215', 'depression in reclaimed delta', 'depression in reclaimed delta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_216', 'piedmont plane', 'piedmont plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_217', 'piedmont fan', 'piedmont fan', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_218', 'interfan depression', 'interfan depression', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_219', 'piedmont coalescent fan', 'piedmont coalescent fan', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_220', 'alluvial glacis in piedmont plane', 'alluvial glacis in piedmont plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_221', 'distal zone fan in piedmont plane', 'distal zone fan in piedmont plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_222', 'fan with traces of  braided streams in piedmont plane', 'fan with traces of  braided streams in piedmont plane', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_223', 'paleochannel  with interlaced channels on fan', 'paleochannel  with interlaced channels on fan', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_224', 'paleochannel  with single channel on fan', 'paleochannel  with single channel on fan', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_225', 'fluvial terrace in plain', 'fluvial terrace in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_226', 'paleochannel  with interlaced channels on fluvial terrace in plain', 'paleochannel  with interlaced channels on fluvial terrace in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_227', 'dissected fluvial terrace in plain', 'dissected fluvial terrace in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_228', 'paleochannel  with single channel on fluvial terrace in plain', 'paleochannel  with single channel on fluvial terrace in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_229', 'fluvial terrace with uneven surface in plain', 'fluvial terrace with uneven surface in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_230', 'thin fluvial terrace in plain', 'thin fluvial terrace in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_231', 'fluvial terrace with traces of interlaced channels in plain', 'fluvial terrace with traces of interlaced channels in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_232', 'fluvial terrace with traces of individual channels in plain', 'fluvial terrace with traces of individual channels in plain', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_233', 'tectonic and structural origin landforms', 'tectonic and structural origin landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_234', 'cuesta', 'cuesta', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_235', 'tectonic depression (Graben)', 'tectonic depression (Graben)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_236', 'irregular slope with fault scarp', 'irregular slope with fault scarp', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_237', 'tectonic relief (Horst)', 'tectonic relief (Horst)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_238', 'structural surface', 'structural surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_239', 'dissected structural surface', 'dissected structural surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_240', 'uneven structural surface', 'uneven structural surface', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_241', 'fault scarp', 'fault scarp', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_242', 'volcanic origin landforms', 'volcanic origin landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_243', 'caldera', 'caldera', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_244', 'volcanic cone', 'volcanic cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_245', 'volcanic cinder cone', 'volcanic cinder cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_246', 'volcanic lava cone', 'volcanic lava cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_247', 'volcanic polygenetic cone', 'volcanic polygenetic cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_248', 'volcanic scoriae cone', 'volcanic scoriae cone', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_249', 'volcanic dome', 'volcanic dome', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_250', 'lava flow', 'lava flow', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_251', 'volcanic plateau', 'volcanic plateau', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_252', 'volcanic crater', 'volcanic crater', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_253', 'volcanic explosion crater (maar)', 'volcanic explosion crater (maar)', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_254', 'volcanic-tectonic depression', 'volcanic-tectonic depression', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_255', 'eolian origin landforms', 'eolian origin landforms', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_256', 'eolian deposit', 'eolian deposit', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_257', 'dunes', 'dunes', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_258', 'leant dunes', 'leant dunes', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_259', 'levelled dunes', 'levelled dunes', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_260', 'stable dunes', 'stable dunes', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_261', 'deflation basin', 'deflation basin', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_262', 'interdunal area', 'interdunal area', 'PhysiographyForm', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/fisiogr_forma_263', 'interdunal area periodically flooded (lama)', 'interdunal area periodically flooded (lama)', 'PhysiographyForm', NULL, NULL, NULL, NULL);

-- SoilState
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_01', 'recently ploughed', 'recently ploughed', 'SoilState', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_02', 'present gassing or crop cultivation', 'present gassing or crop cultivation', 'SoilState', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_03', 'other working', 'other working', 'SoilState', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_04', 'spontaneous vegetation on cropland soil', 'spontaneous vegetation on cropland soil', 'SoilState', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_05', 'bare after harvest', 'bare after harvest', 'SoilState', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_06', 'recent spreading of organic matter', 'recent spreading of organic matter', 'SoilState', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_07', 'littered', 'littered', 'SoilState', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/stato_suolo_08', 'cover of technological materials refuses', 'cover of technological materials refuses', 'SoilState', NULL, NULL, NULL, NULL);

-- LandUse
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_01', 'urban areas', 'urban areas', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_02', 'urban fabric', 'urban fabric', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_03', 'industrial commercial', 'industrial commercial', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_04', 'mine dump and construction sites', 'mine dump and construction sites', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_05', 'dump sites landfill or mine dump sites industrial or public', 'dump sites landfill or mine dump sites industrial or public', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_06', 'dump sites landfill or mine dump sites industrial or public', 'dump sites landfill or mine dump sites industrial or public', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_07', 'construction sites spaces under construction development soil or bedrock', 'construction sites spaces under construction development soil or bedrock', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_08', 'artificial nonagricultural vegetated areas', 'artificial nonagricultural vegetated areas', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_09', 'sport and leisure facilities', 'sport and leisure facilities', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_10', 'sport and leisure facilities', 'sport and leisure facilities', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_11', 'croplands', 'croplands', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_12', 'arable land cultivated areas regularly ploughed and generally under a rotation system', 'arable land cultivated areas regularly ploughed and generally under a rotation system', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_13', 'non-irrigated arable land cereals legumes fodder crops root crops and fallow land', 'non-irrigated arable land cereals legumes fodder crops root crops and fallow land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_14', 'simple row crops in not irrigated land', 'simple row crops in not irrigated land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_15', 'Mais in aree non irrigue', 'Mais in aree non irrigue', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_16', 'Soia in aree non irrigue', 'Soia in aree non irrigue', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_17', 'Barbabietole in aree non irrigue', 'Barbabietole in aree non irrigue', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_18', 'sunflowers in not irrigated lands', 'sunflowers in not irrigated lands', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_19', 'see-bed in not irrigated land', 'see-bed in not irrigated land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_20', 'horticulture in open field in not irrigated land', 'horticulture in open field in not irrigated land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_21', 'row crops in permanently irrigated land', 'row crops in permanently irrigated land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_22', 'simple row crops in permanently irrigated land', 'simple row crops in permanently irrigated land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_23', 'Soia in aree irrigue', 'Soia in aree irrigue', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_24', 'Soia in aree irrigue', 'Soia in aree irrigue', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_25', 'Barbabietole in aree irrigue', 'Barbabietole in aree irrigue', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_26', 'sunflowers in irrigated lands', 'sunflowers in irrigated lands', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_27', 'seed-bed in permanently irrigated land', 'seed-bed in permanently irrigated land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_28', 'sunflowers in irrigated lands', 'sunflowers in irrigated lands', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_29', 'horticulture in open field in irrigated land', 'horticulture in open field in irrigated land', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_30', 'rice fields land developed for rice cultivation flat surfaces', 'rice fields land developed for rice cultivation flat surfaces', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/BX2', 'permanent crops, crops not under a rotation system which provide repeated', 'permanent crops, crops not under a rotation system which provide repeated', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_32', 'vineyards areas planted with vines', 'vineyards areas planted with vines', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_33', 'specialized vineyards', 'specialized vineyards', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_34', 'vineyards associated with permanent crops', 'vineyards associated with permanent crops', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_35', 'fruit trees and berry plantations', 'fruit trees and berry plantations', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_36', 'drupaceous plants', 'drupaceous plants', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_37', 'apple trees', 'apple trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_38', 'citrus grove', 'citrus grove', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_39', 'forest fruits', 'forest fruits', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_40', 'small fruits', 'small fruits', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_41', 'carob wood', 'carob wood', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_42', 'fig trees', 'fig trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_43', 'kiwi', 'kiwi', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_44', 'indian fig trees', 'indian fig trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_45', 'pistachios', 'pistachios', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_46', 'other small fruits', 'other small fruits', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_47', 'olive groves areas planted with olive trees', 'olive groves areas planted with olive trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_48', 'specialized olive trees', 'specialized olive trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_49', 'olive tree associated with permanent crops', 'olive tree associated with permanent crops', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/B80', 'other permanent crops', 'other permanent crops', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_51', 'agroforestry', 'agroforestry', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_52', 'poplar wood, willow grove and other broad-leaved', 'poplar wood, willow grove and other broad-leaved', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_53', 'poplar wood', 'poplar wood', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_54', 'willow grove', 'willow grove', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_55', 'other broad-leaved species', 'other broad-leaved species', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_56', 'coniferous species in rapid growth', 'coniferous species in rapid growth', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_57', 'chestnut wood', 'chestnut wood', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_58', 'corilus avellana', 'corilus avellana', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_59', 'walnut orchard', 'walnut orchard', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_60', 'other row crops (es: ornamental eucaliptus)', 'other row crops (es: ornamental eucaliptus)', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_61', 'pastures', 'pastures', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_62', 'pastures dense predominantly graminoid grass cover', 'pastures dense predominantly graminoid grass cover', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_63', 'not irrigated grassland', 'not irrigated grassland', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_64', 'irrigated grassland', 'irrigated grassland', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_65', 'heterogeneous croplands', 'heterogeneous croplands', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_66', 'annual crops associated with permanent crops', 'annual crops associated with permanent crops', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_67', 'annual crops associated with olive groves and vineyards', 'annual crops associated with olive groves and vineyards', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_68', 'annual crops associated with vineyards', 'annual crops associated with vineyards', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_69', 'annual crops associated with olive groves and', 'annual crops associated with olive groves and', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_70', 'annual crops associated with mixed fruit trees', 'annual crops associated with mixed fruit trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_71', 'complex cultivation juxtaposition of small parcels of diverse annual crops', 'complex cultivation juxtaposition of small parcels of diverse annual crops', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_72', 'croplands associated with natural spaces', 'croplands associated with natural spaces', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_73', 'agroforestal area', 'agroforestal area', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_74', 'forests and seminatural areas', 'forests and seminatural areas', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_75', 'forests', 'forests', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_76', 'broad-leaved forests', 'broad-leaved forests', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_77', 'forest of quercus ilex and coark trees', 'forest of quercus ilex and coark trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_78', 'forest of caduc leaved quercus', 'forest of caduc leaved quercus', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_79', 'forest of mesophil  broad-leaved species', 'forest of mesophil  broad-leaved species', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_80', 'chestnut tree forests', 'chestnut tree forests', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_81', 'forest of beech', 'forest of beech', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_82', 'forest of hygrophilous species', 'forest of hygrophilous species', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_83', 'forest of not native broad-leaved species', 'forest of not native broad-leaved species', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_84', 'conifereous forest vegetation formation composed where coniferous species predominate', 'conifereous forest vegetation formation composed where coniferous species predominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_85', 'forest of mediterranean pine trees', 'forest of mediterranean pine trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_86', 'forest of montane pine trees and/or oromediterranean pine trees', 'forest of montane pine trees and/or oromediterranean pine trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_87', 'forest of white fir and/or red fir tree', 'forest of white fir and/or red fir tree', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_88', 'forest of larch and/or cembrus pine trees', 'forest of larch and/or cembrus pine trees', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_89', 'forest of not native broad-leaved species dominate', 'forest of not native broad-leaved species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_90', 'mixed forest vegetation formation composed where broad-leaved and coniferous species co-dominate', 'mixed forest vegetation formation composed where broad-leaved and coniferous species co-dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_91', 'mixed forest vegetation formation composed where broad-leaved species dominate', 'mixed forest vegetation formation composed where broad-leaved species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_92', 'mixed forest vegetation formation composed where quercus ilex dominate', 'mixed forest vegetation formation composed where quercus ilex dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_93', 'mixed forest vegetation formation composed where qurcus species dominate', 'mixed forest vegetation formation composed where qurcus species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_94', 'mixed forest vegetation formation composed where mesofile broad-leaved species dominate', 'mixed forest vegetation formation composed where mesofile broad-leaved species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_95', 'mixed forest vegetation formation composed where chestnut tree dominate', 'mixed forest vegetation formation composed where chestnut tree dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_96', 'mixed forest vegetation formation composed where beech tree dominate', 'mixed forest vegetation formation composed where beech tree dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_97', 'mixed forest vegetation formation composed where not native coniferous species dominate', 'mixed forest vegetation formation composed where not native coniferous species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_98', 'mixed forest vegetation formation composed where not native broad-leaved species dominate', 'mixed forest vegetation formation composed where not native broad-leaved species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_99', 'mixed forest vegetation formation composed where coniferous species dominate', 'mixed forest vegetation formation composed where coniferous species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_100', 'mixed forest vegetation formation composed where mediterranean pine trees dominate', 'mixed forest vegetation formation composed where mediterranean pine trees dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_101', 'mixed forest vegetation formation composed where montane pine trees and/or oromediterranean pine trees dominate', 'mixed forest vegetation formation composed where montane pine trees and/or oromediterranean pine trees dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_102', 'mixed forest vegetation formation composed where white fir and/or red fir tree dominate', 'mixed forest vegetation formation composed where white fir and/or red fir tree dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_103', 'forest where larch and/or cembrus pine trees dominate', 'forest where larch and/or cembrus pine trees dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_104', 'forest where not native coniferous species dominate', 'forest where not native coniferous species dominate', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_105', 'shrub and/or herbaceous vegetation associations', 'shrub and/or herbaceous vegetation associations', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_106', 'natural grassland low productivity grassland often situated in areas of rough uneven', 'natural grassland low productivity grassland often situated in areas of rough uneven', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_107', 'moors and heathland vegetation with low and closed cover dominated by bushes shrubs and herbaceous plants', 'moors and heathland vegetation with low and closed cover dominated by bushes shrubs and herbaceous plants', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_108', 'sclerophyllous vegetation', 'sclerophyllous vegetation', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_109', 'high bush', 'high bush', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_110', 'low bush', 'low bush', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_111', 'transitional woodlands/shrub', 'transitional woodlands/shrub', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_112', 'areas with natural colonization', 'areas with natural colonization', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_113', 'areas with artificial colonization', 'areas with artificial colonization', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_114', 'open spaces with little or no vegetation', 'open spaces with little or no vegetation', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_115', 'beaches dunes and sand plains', 'beaches dunes and sand plains', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_116', 'bare rock scree cliffs rocks and outcrops', 'bare rock scree cliffs rocks and outcrops', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_117', 'sparsely vegetated areas includes steppes tundra and badlands scattered highattitude', 'sparsely vegetated areas includes steppes tundra and badlands scattered highattitude', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_118', 'burnt areas areas affected by recent fires still mainly black', 'burnt areas areas affected by recent fires still mainly black', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_119', 'forests with burnt areas', 'forests with burnt areas', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_120', 'other seminatural areas with burnt spaces', 'other seminatural areas with burnt spaces', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_121', 'degradated land by other facts', 'degradated land by other facts', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_122', 'glaciers and perpetual snow', 'glaciers and perpetual snow', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_123', 'wetlands', 'wetlands', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_124', 'inland wetlands non-forested areas either partially seasonally or permanently waterlogged', 'inland wetlands non-forested areas either partially seasonally or permanently waterlogged', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_125', 'inland marshes low-lying land usually flooded in winter and more or less saturated by water all year round', 'inland marshes low-lying land usually flooded in winter and more or less saturated by water all year round', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_126', 'peatbogs peatland consisting mainly of decomposed moss and vegetable matter may or may not be exploited', 'peatbogs peatland consisting mainly of decomposed moss and vegetable matter may or may not be exploited', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_127', 'coastal wetlands non-wooded areas either tidally seasonally or permanently waterlogged with brackish or saline water', 'coastal wetlands non-wooded areas either tidally seasonally or permanently waterlogged with brackish or saline water', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_128', 'salt marshes vegetated low-lying areas above the high-tide line susceptible to flooding by sea water', 'salt marshes vegetated low-lying areas above the high-tide line susceptible to flooding by sea water', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_129', 'salines salt-pans active or in process of structuring sections of salt marsh exploited for the production of salt by', 'salines salt-pans active or in process of structuring sections of salt marsh exploited for the production of salt by', 'LandUse', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/uso_suolo_130', 'intertidal flats generally unvegetated expanses of mud sand or rock lying between high and low water-marks', 'intertidal flats generally unvegetated expanses of mud sand or rock lying between high and low water-marks', 'LandUse', NULL, NULL, NULL, NULL);

-- Vegetation
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_01', 'unknown', 'unknown', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/CXX9', 'broadleaved evergreen formation', 'broadleaved evergreen formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_03', 'ilex grove', 'ilex grove', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_04', 'predominance of ilex grove with evergreens', 'predominance of ilex grove with evergreens', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_05', 'predominance of ilex grove with deciduous', 'predominance of ilex grove with deciduous', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_06', 'predominance of coark trees', 'predominance of coark trees', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_07', 'predominance of secondary evergreen', 'predominance of secondary evergreen', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_08', 'mixed just evergreen', 'mixed just evergreen', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_09', 'mixed with deciduous', 'mixed with deciduous', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_10', 'eucaliptus plantation', 'eucaliptus plantation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/CXX5', 'formation of broadleaves (winter rest)', 'formation of broadleaves (winter rest)', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_11', 'predominance of bay oak', 'predominance of bay oak', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_12', 'predominance of turkey oak', 'predominance of turkey oak', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_13', 'predominance of british oak', 'predominance of british oak', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_14', 'predominance of durmast', 'predominance of durmast', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_15', 'predominance of fraineto oak', 'predominance of fraineto oak', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_16', 'predominance of robinia', 'predominance of robinia', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_17', 'predominance of elm', 'predominance of elm', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_18', 'predominance of poplar', 'predominance of poplar', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_19', 'predominance of chestnut tree', 'predominance of chestnut tree', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_20', 'predominance of  ash tree and black hornbeam', 'predominance of  ash tree and black hornbeam', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_21', 'predominance of white hornbeam', 'predominance of white hornbeam', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_22', 'predominance of  beech', 'predominance of  beech', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/CXX6', 'beech wood', 'beech wood', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_24', 'beech wood fir wood', 'beech wood fir wood', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_25', 'mixed just deciduous', 'mixed just deciduous', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_26', 'mixed with broadleaved evergreen', 'mixed with broadleaved evergreen', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/CXXA', 'mixed with coniferous', 'mixed with coniferous', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_28', 'predominance of neapolitan alden', 'predominance of neapolitan alden', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/CXXD', 'hygrophilous broadleaved formations', 'hygrophilous broadleaved formations', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_30', 'willow grove', 'willow grove', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_31', 'poplar willow grove', 'poplar willow grove', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_32', 'alder carr', 'alder carr', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_33', 'narrow leaved ash tree formation', 'narrow leaved ash tree formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/CXXA', 'needle leaved thermophile formation', 'needle leaved thermophile formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_34', 'domestic pine', 'domestic pine', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_35', 'pine halepensis', 'pine halepensis', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_36', 'predominance of pinaster', 'predominance of pinaster', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_37', 'cypress grove', 'cypress grove', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_38', 'mixed with broadleaved evergreen', 'mixed with broadleaved evergreen', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_39', 'mixed with broadleaved deciduous', 'mixed with broadleaved deciduous', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_40', 'pine radiata', 'pine radiata', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/CXX3', 'meso and microthermic narrow leaved formation', 'meso and microthermic narrow leaved formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_42', 'scotch fir', 'scotch fir', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_43', 'black pine', 'black pine', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_44', 'pine laricio', 'pine laricio', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_45', 'pine brutia', 'pine brutia', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_46', 'fir wood', 'fir wood', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_47', 'douglasia plantation', 'douglasia plantation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_48', 'peccete', 'peccete', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_49', 'larch', 'larch', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_50', 'closed shrub formation', 'closed shrub formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_51', 'thermoxeropile shrub formation', 'thermoxeropile shrub formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_52', 'mediterranean bush', 'mediterranean bush', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_53', 'low shrubs (open to close phase)', 'low shrubs (open to close phase)', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_54', 'heather', 'heather', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_55', 'broom (genista. ulex)', 'broom (genista. ulex)', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_56', 'mesothermophile arbustive formation', 'mesothermophile arbustive formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_57', 'corilus avellana', 'corilus avellana', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_58', 'broom (cytisus scoparius)', 'broom (cytisus scoparius)', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_59', 'calluna vulgaris', 'calluna vulgaris', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_60', 'brier', 'brier', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_61', 'fernery', 'fernery', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_62', 'mixed', 'mixed', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_63', 'microthermic arbustive formation', 'microthermic arbustive formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_64', 'alder carr', 'alder carr', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_65', 'rhododendron', 'rhododendron', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_66', 'huckleberry', 'huckleberry', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_67', 'mugo-helter', 'mugo-helter', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_68', 'prostrate shrubs formations', 'prostrate shrubs formations', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://data.europa.eu/oxm/lucas2022/E00', 'herbaceous formation', 'herbaceous formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_70', 'herbaceous formation infesting abandoned cultivations', 'herbaceous formation infesting abandoned cultivations', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_71', 'mediterranean grassland', 'mediterranean grassland', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_72', 'mountain grassland', 'mountain grassland', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_73', 'pioneer herbaceous formations on detritus', 'pioneer herbaceous formations on detritus', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_74', 'pioneer herbaceous formations on river bed', 'pioneer herbaceous formations on river bed', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_75', 'high altitude pioneer grassland', 'high altitude pioneer grassland', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_76', 'ruderal and nitrophile herbaceous formation', 'ruderal and nitrophile herbaceous formation', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_77', 'coastal halophite grasses and undershrub', 'coastal halophite grasses and undershrub', 'Vegetation', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/vegetaz_78', 'marsh and aquatic grass', 'marsh and aquatic grass', 'Vegetation', NULL, NULL, NULL, NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LimProfUtile
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_01', 'other causes (describe in a note)', 'other causes (describe in a note)', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_02', 'high compaction', 'high compaction', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_03', 'low airing', 'low airing', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_04', 'impediments: oxigen scarcity and redox phenomenons (water table)', 'impediments: oxigen scarcity and redox phenomenons (water table)', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_05', 'impediments: continuous lithic contact or continuous cemented horizon', 'impediments: continuous lithic contact or continuous cemented horizon', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_06', 'impediments: unfavorable chemism (i,e, nutriments, ,,,)', 'impediments: unfavorable chemism (i,e, nutriments, ,,,)', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_07', 'low water retention', 'low water retention', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_08', 'compaction or paralithic contact', 'compaction or paralithic contact', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_09', 'shrinkage-expansion movements', 'shrinkage-expansion movements', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_10', 'lithic contact with cracks', 'lithic contact with cracks', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_11', 'discontinuous cemented horizon', 'discontinuous cemented horizon', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_12', 'unfavorable chemism (i.e. nutriments. ...)', 'unfavorable chemism (i.e. nutriments. ...)', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_13', 'critic quantity of coarse fragments and concentrations', 'critic quantity of coarse fragments and concentrations', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_14', 'unknown causes', 'unknown causes', 'LimProfUtile', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/prof_ut_lim_15', 'no restrictions and no impediments', 'no restrictions and no impediments', 'LimProfUtile', NULL, NULL, NULL, NULL);

-- TipoFalda
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/falda_tipo_01', 'not expressed', 'not expressed', 'TipoFalda', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/falda_tipo_02', 'confined', 'confined', 'TipoFalda', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/falda_tipo_03', 'not confined', 'not confined', 'TipoFalda', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/falda_tipo_04', 'semiconfined', 'semiconfined', 'TipoFalda', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/falda_tipo_05', 'confined or semiconfined', 'confined or semiconfined', 'TipoFalda', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/falda_tipo_06', 'absent', 'absent', 'TipoFalda', NULL, NULL, NULL, NULL);

-- GroupHydro
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/idr_group_01', 'hydrologic soil group (HSG) A', 'hydrologic soil group (HSG) A', 'GroupHydro', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/idr_group_02', 'hydrologic soil group (HSG) B', 'hydrologic soil group (HSG) B', 'GroupHydro', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/idr_group_03', 'hydrologic soil group (HSG) C', 'hydrologic soil group (HSG) C', 'GroupHydro', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/idr_group_04', 'hydrologic soil group (HSG) D', 'hydrologic soil group (HSG) D', 'GroupHydro', NULL, NULL, NULL, NULL);

-- DrenaggInt
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_int_01', 'excessively drained', 'excessively drained', 'DrenaggInt', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_int_02', 'somewhat excessively drained', 'somewhat excessively drained', 'DrenaggInt', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_int_03', 'well drained', 'well drained', 'DrenaggInt', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_int_04', 'moderately well drained', 'moderately well drained', 'DrenaggInt', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_int_05', 'somewhat poorly drained', 'somewhat poorly drained', 'DrenaggInt', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_int_06', 'poorly drained', 'poorly drained', 'DrenaggInt', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/dren_int_07', 'very poorly drained', 'very poorly drained', 'DrenaggInt', NULL, NULL, NULL, NULL);

-- CapUso
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_01', 'Suitable for Cultivation of Row Crops', 'Suitable for Cultivation of Row Crops', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_02', 'Suitable for Cultivation of Row Crops with some limitations', 'Suitable for Cultivation of Row Crops with some limitations', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_03', 'Suitable for Cultivation of Row Crops with severe limitations', 'Suitable for Cultivation of Row Crops with severe limitations', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_04', 'Suitable for Cultivation of Row Crops with very severe limitations', 'Suitable for Cultivation of Row Crops with very severe limitations', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_05', 'unknown', 'unknown', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_06', 'Unsuited for Cultivation', 'Unsuited for Cultivation', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_07', 'Unsuited for Cultivation with severe limitations', 'Unsuited for Cultivation with severe limitations', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_08', 'Unsuited for Cultivation with very severe limitations', 'Unsuited for Cultivation with very severe limitations', 'CapUso', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_09', 'Suited to recreation, water supply, wildlife or esthetic purposes', 'Suited to recreation, water supply, wildlife or esthetic purposes', 'CapUso', NULL, NULL, NULL, NULL);

-- CapUsoSott
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_sc_01', 'climatic limitation', 'climatic limitation', 'CapUsoSott', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_sc_02', 'erosion risks', 'erosion risks', 'CapUsoSott', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_sc_03', 'soil limitation', 'soil limitation', 'CapUsoSott', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_uso_sc_04', 'water excess', 'water excess', 'CapUsoSott', NULL, NULL, NULL, NULL);

-- CapUsoUnit
-- Domanin Coded Value
-- CREA
-- http://
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_01', 'water availability', 'water availability', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_02', 'rocks', 'rocks', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_03', 'subsoil salinity', 'subsoil salinity', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_04', 'topsoil salinity', 'topsoil salinity', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_05', 'topsoil fragment content', 'topsoil fragment content', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_06', 'topsoil texture', 'topsoil texture', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_07', 'drainage', 'drainage', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_08', 'erosion', 'erosion', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_09', 'topsoil chemical fertility', 'topsoil chemical fertility', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_10', 'climatic interference', 'climatic interference', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_11', 'slope', 'slope', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_12', 'stoniness', 'stoniness', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_13', 'rooting depth', 'rooting depth', 'CapUsoUnit', NULL, NULL, NULL, NULL);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://geonetwork-crea-so.westeurope.cloudapp.azure.com/cap_usi_unit_14', 'flooding risk', 'flooding risk', 'CapUsoUnit', NULL, NULL, NULL, NULL);

-- WRBRversion
-- soilprofile
--
-- CREA based on real URI
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', 'WRB 2006', null, 'wrbversion', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html', 'WRB 2014', null, 'wrbversion', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/', 'WRB 2022', null, 'wrbversion', null, null, null, null);


-- WRBReferenceSoilGroupValue 2014
-- soilprofile
-- UNIROMA
-- http://stats-class.fao.uniroma2.it/WRB/v2014
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Acrisols', 'Acrisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Alisols', 'Alisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Andosols', 'Andosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Anthrosols', 'Anthrosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Arenosols', 'Arenosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Calcisols', 'Calcisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Cambisols', 'Cambisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Chernozems', 'Chernozems', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Cryosols', 'Cryosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Durisols', 'Durisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ferralsols', 'Ferralsols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Fluvisols', 'Fluvisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gleysols', 'Gleysols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gypsisols', 'Gypsisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Histosols', 'Histosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Kastanozems', 'Kastanozems', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Leptosols', 'Leptosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Lixisols', 'Lixisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Luvisols', 'Luvisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Nitisols', 'Nitisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Phaeozems', 'Phaeozems', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Planosols', 'Planosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Plinthosols', 'Plinthosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Podzols', 'Podzols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Regosols', 'Regosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Retisols', 'Retisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Solonchaks', 'Solonchaks', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Solonetz', 'Solonetz', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Stagnosols', 'Stagnosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Technosols', 'Technosols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Umbrisols', 'Umbrisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Vertisols', 'Vertisols', null, 'WRBReferenceSoilGroupValue2014', null, null, null, null);

-- WRBReferenceSoilGroupValue 2022
-- soilprofile
-- ORBL-SOIL
-- https://obrl-soil.github.io/wrbsoil2022/
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-ac', 'Acrisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-al', 'Alisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-an', 'Andosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-at', 'Anthrosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-ar', 'Arenosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-cl', 'Calcisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-cm', 'Cambisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-ch', 'Chernozems', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-cr', 'Cryosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-du', 'Durisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-fr', 'Ferralsols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-fl', 'Fluvisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-gl', 'Gleysols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-gy', 'Gypsisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-hs', 'Histosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-ks', 'Kastanozems', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-lp', 'Leptosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-lx', 'Lixisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-lv', 'Luvisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-nt', 'Nitisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-ph', 'Phaeozems', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-pl', 'Planosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-pt', 'Plinthosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-pz', 'Podzols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-rg', 'Regosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-rt', 'Retisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-sc', 'Solonchaks', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-sn', 'Solonetz', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-st', 'Stagnosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-tc', 'Technosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-um', 'Umbrisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-vr', 'Vertisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);

-- WRBQualifierValue 2014
-- 
-- UNIROMA
-- http://stats-class.fao.uniroma2.it/WRB/v2014
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Abruptic', 'Abruptic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Aceric', 'Aceric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Acric', 'Acric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Acroxic', 'Acroxic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Aeolic', 'Aeolic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Akrofluvic', 'Akrofluvic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Akromineralic', 'Akromineralic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Akroskeletic', 'Akroskeletic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Albic', 'Albic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Alcalic', 'Alcalic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Alic', 'Alic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Aluandic', 'Aluandic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Andic', 'Andic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Anthraquic', 'Anthraquic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Anthric', 'Anthric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Anthromollic', 'Anthromollic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Anthrotoxic', 'Anthrotoxic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Anthroumbric', 'Anthroumbric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Archaic', 'Archaic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Arenic', 'Arenic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Areninovic', 'Areninovic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Argisodic', 'Argisodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Aric', 'Aric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Aridic', 'Aridic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Arzic', 'Arzic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Brunic', 'Brunic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Calcaric', 'Calcaric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Calcic', 'Calcic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Calcifractic', 'Calcifractic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Cambic', 'Cambic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Capillaric', 'Capillaric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Carbic', 'Carbic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Carbonatic', 'Carbonatic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Carbonic', 'Carbonic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Chernic', 'Chernic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Chloridic', 'Chloridic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Chromic', 'Chromic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Clayic', 'Clayic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Clayinovic', 'Clayinovic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Colluvic', 'Colluvic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Columnic', 'Columnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Cryic', 'Cryic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Cutanic', 'Cutanic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Densic', 'Densic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Differentic', 'Differentic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Dolomitic', 'Dolomitic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Drainic', 'Drainic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Duric', 'Duric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Dystric', 'Dystric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ekranic', 'Ekranic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Entic', 'Entic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Escalic', 'Escalic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Eutric', 'Eutric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Eutrisilic', 'Eutrisilic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Evapocrustic', 'Evapocrustic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ferralic', 'Ferralic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ferric', 'Ferric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ferritic', 'Ferritic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Fibric', 'Fibric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Floatic', 'Floatic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Fluvic', 'Fluvic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Folic', 'Folic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Fractic', 'Fractic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Fragic', 'Fragic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Fulvic', 'Fulvic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Garbic', 'Garbic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gelic', 'Gelic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gelistagnic', 'Gelistagnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Geoabruptic', 'Geoabruptic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Geric', 'Geric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gibbsic', 'Gibbsic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gilgaic', 'Gilgaic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Glacic', 'Glacic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gleyic', 'Gleyic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Glossic', 'Glossic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Greyzemic', 'Greyzemic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Grumic', 'Grumic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gypsic', 'Gypsic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gypsifractic', 'Gypsifractic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Gypsiric', 'Gypsiric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Haplic', 'Haplic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hemic', 'Hemic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Histic', 'Histic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hortic', 'Hortic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Humic', 'Humic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hydragric', 'Hydragric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hydric', 'Hydric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hydrophobic', 'Hydrophobic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperalic', 'Hyperalic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperartefactic', 'Hyperartefactic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypercalcic', 'Hypercalcic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperduric', 'Hyperduric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperdystric', 'Hyperdystric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypereutric', 'Hypereutric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperferritic', 'Hyperferritic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypergypsic', 'Hypergypsic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperhumic', 'Hyperhumic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperhydragric', 'Hyperhydragric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypermagnesic', 'Hypermagnesic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypernatric', 'Hypernatric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperorganic', 'Hyperorganic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypersalic', 'Hypersalic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypersideralic', 'Hypersideralic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperspodic', 'Hyperspodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypersulfidic', 'Hypersulfidic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypertechnic', 'Hypertechnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyperthionic', 'Hyperthionic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypocalcic', 'Hypocalcic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypogypsic', 'Hypogypsic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hyposulfidic', 'Hyposulfidic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Hypothionic', 'Hypothionic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Immissic', 'Immissic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Inclinic', 'Inclinic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Infraandic', 'Infraandic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Infraspodic', 'Infraspodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Irragric', 'Irragric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Isolatic', 'Isolatic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Lamellic', 'Lamellic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Lapiadic', 'Lapiadic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Laxic', 'Laxic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Leptic', 'Leptic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Lignic', 'Lignic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Limnic', 'Limnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Linic', 'Linic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Lithic', 'Lithic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Lixic', 'Lixic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Loamic', 'Loamic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Loaminovic', 'Loaminovic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Luvic', 'Luvic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Magnesic', 'Magnesic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Manganiferric', 'Manganiferric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Mawic', 'Mawic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Mazic', 'Mazic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Melanic', 'Melanic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Mesotrophic', 'Mesotrophic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Mineralic', 'Mineralic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Mollic', 'Mollic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Murshic', 'Murshic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Muusic', 'Muusic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Natric', 'Natric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Nechic', 'Nechic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Neocambic', 'Neocambic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Nitic', 'Nitic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Nudiargic', 'Nudiargic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Nudilithic', 'Nudilithic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Nudinatric', 'Nudinatric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Nudipetric', 'Nudipetric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ochric', 'Ochric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Oligeoeutric', 'Oligeoeutric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ombric', 'Ombric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Organotransportic', 'Organotransportic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ornithic', 'Ornithic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Orthidystric', 'Orthidystric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Orthieutric', 'Orthieutric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Orthofluvic', 'Orthofluvic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Orthomineralic', 'Orthomineralic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Orthoskeletic', 'Orthoskeletic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Ortsteinic', 'Ortsteinic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Oxyaquic', 'Oxyaquic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Oxygleyic', 'Oxygleyic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Pachic', 'Pachic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Pellic', 'Pellic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Petric', 'Petric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Petrocalcic', 'Petrocalcic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Petroduric', 'Petroduric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Petrogleyic', 'Petrogleyic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Petrogypsic', 'Petrogypsic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Petroplinthic', 'Petroplinthic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Petrosalic', 'Petrosalic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Phytotoxic', 'Phytotoxic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Pisoplinthic', 'Pisoplinthic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Placic', 'Placic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Plaggic', 'Plaggic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Plinthic', 'Plinthic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Plinthofractic', 'Plinthofractic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Posic', 'Posic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Pretic', 'Pretic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Profondic', 'Profondic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Profundihumic', 'Profundihumic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protic', 'Protic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protoandic', 'Protoandic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protoargic', 'Protoargic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protoaridic', 'Protoaridic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protocalcic', 'Protocalcic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protosalic', 'Protosalic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protosodic', 'Protosodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protospodic', 'Protospodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protostagnic', 'Protostagnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Prototechnic', 'Prototechnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Prototephric', 'Prototephric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Protovertic', 'Protovertic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Puffic', 'Puffic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Radiotoxic', 'Radiotoxic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Raptic', 'Raptic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Reductaquic', 'Reductaquic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Reductic', 'Reductic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Reductigleyic', 'Reductigleyic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Relictigleyic', 'Relictigleyic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Relictistagnic', 'Relictistagnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Relictiturbic', 'Relictiturbic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Relocatic', 'Relocatic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Rendzic', 'Rendzic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Retic', 'Retic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Rheic', 'Rheic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Rhodic', 'Rhodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Rockic', 'Rockic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Rubic', 'Rubic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Rustic', 'Rustic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Salic', 'Salic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Sapric', 'Sapric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Sideralic', 'Sideralic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Silandic', 'Silandic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Siltic', 'Siltic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Siltinovic', 'Siltinovic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Skeletic', 'Skeletic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Sodic', 'Sodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Sombric', 'Sombric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Someric', 'Someric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Somerimollic', 'Somerimollic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Somerirendzic', 'Somerirendzic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Someriumbric', 'Someriumbric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Spodic', 'Spodic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Spolic', 'Spolic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Stagnic', 'Stagnic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Subaquatic', 'Subaquatic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Sulfatic', 'Sulphatic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Sulfidic', 'Sulfidic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Takyric', 'Takyric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Technic', 'Technic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Technoleptic', 'Technoleptic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Technolithic', 'Technolithic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Technoskeletic', 'Technoskeletic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Tephric', 'Tephric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Terric', 'Terric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Thionic', 'Thionic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Thixotropic', 'Thixotropic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Tidalic', 'Tidalic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Tonguic', 'Tonguic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Tonguichernic', 'Tonguichernic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Tonguimollic', 'Tonguimollic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Tonguiumbric', 'Tonguiumbric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Totilamellic', 'Totilamellic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Toxic', 'Toxic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Transportic', 'Transportic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Turbic', 'Turbic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Umbric', 'Umbric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Urbic', 'Urbic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Uterquic', 'Uterquic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Vermic', 'Vermic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Vertic', 'Vertic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Vetic', 'Vetic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Vitric', 'Vitric', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Xanthic', 'Xanthic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Yermic', 'Yermic', null, 'WRBQualifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://stats-class.fao.uniroma2.it/WRB/v2014/Zootoxic', 'Zootoxic', null, 'WRBQualifierValue2014', null, null, null, null);

-- WRBQualifierValue 2022
-- 
-- ORBL-SOIL
-- https://obrl-soil.github.io/wrbsoil2022/
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ap', 'Abruptic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ae', 'Aceric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ac', 'Acric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ao', 'Acroxic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-at', 'Activic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ay', 'Aeolic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ab', 'Albic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ax', 'Alcalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-al', 'Alic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-aa', 'Aluandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-an', 'Andic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-aq', 'Anthraquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ak', 'Anthric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ah', 'Archaic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ar', 'Arenic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ad', 'Arenicolic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ai', 'Aric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-az', 'Arzic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-bc', 'Biocrustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-br', 'Brunic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-by', 'Bryic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ca', 'Calcaric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cc', 'Calcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cm', 'Cambic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cp', 'Capillaric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cb', 'Carbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cn', 'Carbonatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cx', 'Carbonic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ch', 'Chernic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cl', 'Chloridic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cr', 'Chromic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cq', 'Claric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ce', 'Clayic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cs', 'Coarsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-co', 'Cohesic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cu', 'Columnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cd', 'Cordic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cy', 'Cryic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ct', 'Cutanic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-dn', 'Densic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-df', 'Differentic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-do', 'Dolomitic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ds', 'Dorsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-dr', 'Drainic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-du', 'Duric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-dy', 'Dystric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ek', 'Ekranic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ed', 'Endic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-et', 'Entic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ep', 'Epic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ec', 'Escalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-eu', 'Eutric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-es', 'Eutrosilic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ev', 'Evapocrustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fl', 'Ferralic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fr', 'Ferric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fe', 'Ferritic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fi', 'Fibric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ft', 'Floatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fv', 'Fluvic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fc', 'Fractic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fg', 'Fragic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ga', 'Garbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ge', 'Gelic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gt', 'Gelistagnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gr', 'Geric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gi', 'Gibbsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gg', 'Gilgaic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gc', 'Glacic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gl', 'Gleyic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gs', 'Glossic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gz', 'Greyzemic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gm', 'Grumic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gy', 'Gypsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gp', 'Gypsiric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ha', 'Haplic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hm', 'Hemic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hi', 'Histic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ht', 'Hortic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hu', 'Humic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hg', 'Hydragric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hy', 'Hydric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hf', 'Hydrophobic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-jl', 'Hyperalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ja', 'Hyperartefactic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypercalcic-jc', 'Hypercalcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypereutric-je', 'Hypereutric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypergypsic-jy', 'Hypergypsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypernatric-jn', 'Hypernatric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-jo', 'Hyperorganic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypersalic-jz', 'Hypersalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hyperspodic-jp', 'Hyperspodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-im', 'Immissic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ic', 'Inclinic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ia', 'Infraandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-is', 'Infraspodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ir', 'Irragric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-il', 'Isolatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ip', 'Isopteric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ka', 'Kalaic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ll', 'Lamellic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ld', 'Lapiadic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-la', 'Laxic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-le', 'Leptic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lg', 'Lignic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lm', 'Limnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ln', 'Limonic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lc', 'Linic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-li', 'Lithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lh', 'Litholinic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lx', 'Lixic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lo', 'Loamic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lv', 'Luvic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mg', 'Magnesic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ma', 'Mahic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mw', 'Mawic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mz', 'Mazic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mi', 'Mineralic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mc', 'Mochipic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mo', 'Mollic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mm', 'Mulmic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mh', 'Murshic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mu', 'Muusic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-nr', 'Naramic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-na', 'Natric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ne', 'Nechic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#neobrunic-nb', 'Neobrunic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#neocambic-nc', 'Neocambic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ni', 'Nitic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-nv', 'Novic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ng', 'Nudiargic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#nudilithic-nt', 'Nudilithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#nudinatric-nn', 'Nudinatric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oh', 'Ochric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-om', 'Ombric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oc', 'Ornithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#orthofluvic-of', 'Orthofluvic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-os', 'Ortsteinic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oa', 'Oxyaquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oy', 'Oxygleyic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ph', 'Pachic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pb', 'Panpaic ', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pe', 'Pellic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-p', 'Pelocrustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pt', 'Petric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pc', 'Petrocalcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pd', 'Petroduric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pg', 'Petrogypsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pp', 'Petroplinthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ps', 'Petrosalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-px', 'Pisoplinthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pi', 'Placic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pa', 'Plaggic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pl', 'Plinthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-po', 'Posic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pk', 'Pretic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pn', 'Profondic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pr', 'Protic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protoandic-qa', 'Protoandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-qg', 'Protoargic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protocalcic-qc', 'Protocalcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protospodic-qp', 'Protospodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protovertic-qv', 'Protovertic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pu', 'Puffic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-py', 'Pyric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rp', 'Raptic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ra', 'Reductaquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rd', 'Reductic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ry', 'Reductigleyic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rc', 'Relocatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rz', 'Rendzic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rt', 'Retic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rh', 'Rheic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ro', 'Rhodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rk', 'Rockic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ru', 'Rubic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rs', 'Rustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sz', 'Salic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sa', 'Sapric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sh', 'Saprolithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-se', 'Sideralic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sn', 'Silandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sl', 'Siltic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sk', 'Skeletic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-so', 'Sodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sv', 'Solimovic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sb', 'Sombric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-si', 'Someric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sd', 'Spodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sp', 'Spolic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-st', 'Stagnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sq', 'Subaquatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sf', 'Sulfidic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-su', 'Sulphatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ty', 'Takyric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-te', 'Technic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tf', 'Tephric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tr', 'Terric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ti', 'Thionic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tp', 'Thixotropic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-th', 'Thyric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-td', 'Tidalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-to', 'Tonguic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tx', 'Toxic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tn', 'Transportic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ts', 'Tsitelic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tu', 'Turbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-um', 'Umbric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ub', 'Urbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-uq', 'Uterquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-vm', 'Vermic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-vr', 'Vertic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-vi', 'Vitric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-wa', 'Wapnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-xa', 'Xanthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ye', 'Yermic', null, 'WRBQualifierValue2022', null, null, null, null);

-- WRBSpecifierValue 2022
-- 
-- ORBL-SOIL
-- https://obrl-soil.github.io/wrbsoil2022/
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Amphi', 'Amphi', 'The layer starts > 0 and < 50 cm from the (mineral) soil surface and  has its lower limit > 50 and < 100 cm of the (mineral) soil surface; and no such layer occurs < 1 cm of  the (mineral) soil surface; and no such layer occurs between 99 and 100 cm of the (mineral) soil  surface or directly above a limitig layer', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Ano', 'Ano', 'The layer starts at the (mineral) soil surface and has its lower limit > 50  and < 100 cm of the (mineral) soil surface; and no such layer occurs between 99 and 100 cm of the  (mineral) soil surface or directly above a limiting layer. ', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Bathy', 'Bathy', 'Specifier can be used to construct additional subqualifiers. The Bathy- subqualifier extends to a  greater depth than specified for the qualifier. I', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Endo', 'Endo', 'The layer starts ≥ 50 cm from the (mineral) soil surface; and no such  layer occurs < 50 cm of the (mineral) soil surface.', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Epi', 'Epi', 'The layer has its lower limit ≤ 50 cm of the (mineral) soil surface; and no  such layer occurs between 50 and 100 cm of the (mineral) soil surface; not used if the definition of the  qualifier or of the horizon requires that the layer starts at the (mineral) soil surface; if a limiting layer starts ≤ 50 cm from the mineral soil surface, the qualifier referring to the limiting layer receives the  Epi- specifier and all other qualifiers remain without specifier. ', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Kato', 'Kato', 'The layer starts > 0 and < 50 cm from the (mineral) soil surface and  has its lower limit ≥ 100 cm of the (mineral) soil surface or at a limiting layer starting > 50 cm from  the (mineral) soil surface; and no such layer occurs < 1 cm of the (mineral) soil surface. ', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Panto', 'Panto', 'The layer starts at the (mineral) soil surface and has its lower limit ≥ 100 cm of the (mineral) soil surface or at a limiting layer starting > 50 cm from the (mineral) soil surface.', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Poly', 'Poly', 'Diagnostic horizons: two or more diagnostic horizons are present at the depth required by the  qualifier definition, interrupted by layers that do not fulfil the criteria of the respective diagnostic  horizon;b. other layers: two or more layers within 100 cm of the (mineral) soil surface fulfil the criteria of the  qualifier, interrupted by layers that do not fulfil the criteria of the respective qualifier; and the  thickness criterion is fulfilled by the sum of the thicknesses of the layers; it may or may not be fulfilled by the single layers.', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Supra', 'Supra', 'Specifier can be constructed to describe the soil material above, if  the thickness or depth requirements of a qualifier or of its respective diagnostics are not fulfilled, but all  other criteria are fulfilled throughout in the soil material above', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Thapto', 'Thapto', 'Specifier can be used to construct optional or additional  subqualifiers. If used with a principal qualifier, the Thapto- subqualifier must shift to the supplementary  qualifiers and be placed within the list of the supplementary qualifiers according to the alphabetical position  of the qualifier, not the subqualifier. ', 'WRBSpecifierValue2022', null, null, null, null);

-- WRBSpecifierValue 2014
-- 
-- ORBL-SOIL
-- https:// --- MISTO
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://openknowledge.fao.org/server/api/core/bitstreams/bcdecec7-f45f-4dc5-beb1-97022d29fab4/content#Amphi', 'Amphi', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://openknowledge.fao.org/server/api/core/bitstreams/bcdecec7-f45f-4dc5-beb1-97022d29fab4/content#Ano', 'Ano', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/bathi', 'Bathy', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/endo', 'Endo', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/epi', 'Epi', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://openknowledge.fao.org/server/api/core/bitstreams/bcdecec7-f45f-4dc5-beb1-97022d29fab4/content#Kato', 'Kato', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://openknowledge.fao.org/server/api/core/bitstreams/bcdecec7-f45f-4dc5-beb1-97022d29fab4/content#Panto', 'Panto', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://openknowledge.fao.org/server/api/core/bitstreams/bcdecec7-f45f-4dc5-beb1-97022d29fab4/content#Supra', 'Supra', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/thapto', 'Thapto', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/hyper', 'Hyper', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/hypo', 'Hypo', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/ortho', 'Ortho', null, 'WRBSpecifierValue2014', null, null, null, null);
INSERT INTO so.codelist(id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBSpecifierValue/proto', 'Proto', null, 'WRBSpecifierValue2014', null, null, null, null);
