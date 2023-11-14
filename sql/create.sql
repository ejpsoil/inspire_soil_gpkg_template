--- a set of sql statements to update a plain geopackage template to a INSPIRE Soil template

/* 
███████ ██████  ███████  ██████      ██████   ██████  ██████  ███████ 
██      ██   ██ ██      ██                ██ ██  ████      ██ ██      
█████   ██████  ███████ ██   ███      █████  ██ ██ ██  █████  ███████ 
██      ██           ██ ██    ██          ██ ████  ██      ██      ██ 
███████ ██      ███████  ██████      ██████   ██████  ██████  ███████ 
 */

INSERT INTO gpkg_spatial_ref_sys (srs_name, srs_id, organization, organization_coordsys_id, definition, description) VALUES ('EPSG:ETRS89 / LAEA Europe', 3035, 'EPSG', 3035, 'PROJCS["ETRS89 / LAEA Europe", 
  GEOGCS["ETRS89", 
    DATUM["European Terrestrial Reference System 1989", 
      SPHEROid["GRS 1980", 6378137.0, 298.257222101, AUTHORITY["EPSG","7019"]], 
      TOWGS84[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 
      AUTHORITY["EPSG","6258"]], 
    PRIMEM["Greenwich", 0.0, AUTHORITY["EPSG","8901"]], 
    UNIT["degree", 0.017453292519943295], 
    AXIS["Geodetic latitude", NORTH], 
    AXIS["Geodetic longitude", EAST], 
    AUTHORITY["EPSG","4258"]], 
  PROJECTION["Lambert_Azimuthal_Equal_Area", AUTHORITY["EPSG","9820"]], 
  PARAMETER["latitude_of_center", 51.99999999999999], 
  PARAMETER["longitude_of_center", 10.0], 
  PARAMETER["false_easting", 4321000.0], 
  PARAMETER["false_northing", 3210000.0], 
  UNIT["m", 1.0], 
  AXIS["Northing", NORTH], 
  AXIS["Easting", EAST], 
  AUTHORITY["EPSG","3035"]]', 'Use ETRS89 / LCC (code 3034) for conformal mapping at 1:500,000 scale or smaller or ETRS89 / UTM (codes 25828-37 or 3040-49) for conformal mapping at scales larger than 1:500,000.');


/*                  
███████  ██████  ██ ██      ███████ ██ ████████ ███████ 
██      ██    ██ ██ ██      ██      ██    ██    ██      
███████ ██    ██ ██ ██      ███████ ██    ██    █████   
     ██ ██    ██ ██ ██           ██ ██    ██    ██      
███████  ██████  ██ ███████ ███████ ██    ██    ███████
         */                             



-- Table soilsite ---------------------------------------------------------------------------------------
CREATE TABLE soilsite
( 
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    geometry POLYGON NOT NULL, 
    inspireid_localid TEXT, 
    inspireid_namespace TEXT, 
    inspireid_versionid TEXT, 
    soilinvestigationpurpose TEXT NOT NULL, -- Codelist  soilinvestigationpurposevalue
    validfrom DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null,-- DEFAULT CURRENT_TIMESTAMP,
    validto DATETIME,
    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null, -- DEFAULT CURRENT_TIMESTAMP,
    endlifespanversion DATETIME
);

-- spatial index
CREATE INDEX soilsite_geom_idx ON soilsite(geometry);

-- Contents soilsite --------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'soilsite', -- table name
  'features', -- data type
  'f_ss', -- unique table identifier
  'soilsite Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  3035 -- EPSG spatial reference system code
);

-- Geometry soilsite ---------------------------------------------------------------------------------------
INSERT INTO gpkg_geometry_columns (
  table_name,
  column_name,
  geometry_type_name,
  srs_id,
  z,
  m
) VALUES (
  'soilsite', -- table name
  'geometry', -- geometry column name
  'POLYGON', -- geometry type
  3035, -- EPSG spatial reference system code
  0, -- if the geometry has a Z coordinate (0 = no, 1 = yes, 2 = optional)
  0 -- if the geometry has a M coordinate (0 = no, 1 = yes, 2 = optional)
);

-- Trigger soilsite ---------------------------------------------------------------------------------------

CREATE TRIGGER soilsiteguid
AFTER INSERT ON soilsite
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE soilsite SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER soilsiteguidupdate
AFTER UPDATE OF guidkey ON soilsite
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_ceckvalidperiodsoilsite
BEFORE INSERT ON soilsite
WHEN NEW.validfrom > NEW.validto 
BEGIN
    SELECT RAISE(ABORT, 'Table soilsite: validto must be less than validfrom');
END;

CREATE TRIGGER u_ceckvalidperiodsoilsite
BEFORE UPDATE ON soilsite
WHEN NEW.validfrom > NEW.validto 
BEGIN
    SELECT RAISE(ABORT, 'Table soilsite: validto must be less than validfrom');
END; 
--


CREATE TRIGGER i_ceckvalidversionsoilsite
BEFORE INSERT ON soilsite
WHEN NEW.beginlifespanversion > NEW.endlifespanversion
BEGIN
    SELECT RAISE(ABORT, 'Table soilsite: beginlifespanversion must be less than endlifespanversion');
END;
--



CREATE TRIGGER i_soilinvestigationpurpose
BEFORE INSERT ON soilsite
FOR EACH ROW
WHEN NEW.soilinvestigationpurpose NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table soilsite: Invalid value for soilinvestigationpurpose. Must be present in id of soilinvestigationpurposevalue codelist.');
END;

CREATE TRIGGER u_soilinvestigationpurpose
BEFORE UPDATE ON soilsite
FOR EACH ROW
WHEN NEW.soilinvestigationpurpose NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table soilsite: Invalid value for soilinvestigationpurpose. Must be present in id of soilinvestigationpurposevalue codelist.');
END;
--


CREATE TRIGGER u_begin_today_soilsite
AFTER UPDATE 
OF inspireid_localid,inspireid_namespace,inspireid_versionid,soilinvestigationpurpose,validfrom,validto,endlifespanversion
ON soilsite
WHEN  datetime('now') < new.endlifespanversion OR NEW.endlifespanversion IS NULL
BEGIN
   UPDATE soilsite
   SET beginlifespanversion  = strftime('%Y-%m-%dT%H:%M:%fZ', 'now','localtime')
   WHERE id = new.id;
END;
--

CREATE TRIGGER u_begin_today_soilsite_error
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,soilinvestigationpurpose,validfrom,validto,endlifespanversion
ON soilsite
WHEN  datetime('now') > new.endlifespanversion
BEGIN
   SELECT RAISE(ABORT,'If you change record endlifespanversion must be greater than today');
END;
--



--

/* 
███████  ██████  ██ ██      ██████  ██       ██████  ████████ 
██      ██    ██ ██ ██      ██   ██ ██      ██    ██    ██    
███████ ██    ██ ██ ██      ██████  ██      ██    ██    ██    
     ██ ██    ██ ██ ██      ██      ██      ██    ██    ██    
███████  ██████  ██ ███████ ██      ███████  ██████     ██
 */


-- Table soilplot
CREATE TABLE soilplot
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    soilplotlocation POINT NOT NULL, 
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT,
    soilplottype TEXT NOT NULL,  -- Codelist soilplottypevalue
    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null, -- DEFAULT CURRENT_TIMESTAMP,
    endlifespanversion DATETIME,
    locatedon TEXT,
    FOREIGN KEY (locatedon)
      REFERENCES soilsite(guidkey)
      ON UPDATE CASCADE
);

-- spatial index
CREATE INDEX soilplot_geom_idx ON soilplot(soilplotlocation);

-- Contents soilplot ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'soilplot', -- table name
  'features', -- data type
  'f_sp', -- unique table identifier
  'soilplot Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  3035 -- EPSG spatial reference system code
);

-- Geometry soilplot ---------------------------------------------------------------------------------------
INSERT INTO gpkg_geometry_columns (
  table_name,
  column_name,
  geometry_type_name,
  srs_id,
  z,
  m
) VALUES (
  'soilplot', -- table name
  'soilplotlocation', -- geometry column name
  'POINT', -- geometry type
  3035, -- EPSG spatial reference system code
  0, -- if the geometry has a Z coordinate (0 = no, 1 = yes, 2 = optional)
  0 -- if the geometry has a M coordinate (0 = no, 1 = yes, 2 = optional)
);


-- Trigger soilplot ---------------------------------------------------------------------------------------

CREATE TRIGGER soilplotguid
AFTER INSERT ON soilplot
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE soilplot SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER soilplotguidupdate
AFTER UPDATE OF guidkey ON soilplot
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_ceckvalidversionsoilplot
BEFORE INSERT ON soilplot
WHEN NEW.beginlifespanversion > NEW.endlifespanversion
BEGIN
    SELECT RAISE(ABORT, 'Table soilplot: beginlifespanversion must be less than endlifespanversion');
END;
--  


CREATE TRIGGER i_soilplottype
BEFORE INSERT ON soilplot
FOR EACH ROW
WHEN NEW.soilplottype NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table soilplot: Invalid value for soilplottype. Must be present in id of  soilplottypevalue codelist.');
END;

CREATE TRIGGER u_soilplottype
BEFORE UPDATE ON soilplot
FOR EACH ROW
WHEN NEW.soilplottype NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table soilplot: Invalid value for soilplottype. Must be present in id of soilplottypevalue codelist.');
END;
--

CREATE TRIGGER u_begin_today_soilplot
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,soilplottype,endlifespanversion
ON soilplot
WHEN  datetime('now') < new.endlifespanversion OR NEW.endlifespanversion IS NULL
BEGIN

   UPDATE soilplot
   SET beginlifespanversion  = strftime('%Y-%m-%dT%H:%M:%fZ', 'now','localtime')
   WHERE id = new.id;
END;


CREATE TRIGGER u_begin_today_soilplot_error
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,soilplottype,endlifespanversion
ON soilplot
WHEN  datetime('now') > new.endlifespanversion
BEGIN
   SELECT RAISE(ABORT,'If you change record endlifespanversion must be greater than today');
END;


/* 
███████  ██████  ██ ██      ██████  ██████   ██████  ███████ ██ ██      ███████ 
██      ██    ██ ██ ██      ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      
███████ ██    ██ ██ ██      ██████  ██████  ██    ██ █████   ██ ██      █████   
     ██ ██    ██ ██ ██      ██      ██   ██ ██    ██ ██      ██ ██      ██      
███████  ██████  ██ ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████ 
 */


-- OBSERVED isderived -> 0   
-- DERIVED  isderived -> 1   

-- Table soilprofile ---------------------------------------------------------------------------------------
CREATE TABLE soilprofile 
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT,
    localidentifier TEXT,
    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null,
    endlifespanversion DATETIME,
    validfrom DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null,
    validto	DATETIME,
    isderived BOOLEAN DEFAULT 0 NOT NULL, 
    wrbreferencesoilgroup TEXT,    -- Codelist wrbreferencesoilgroupvalue
    isoriginalclassification BOOLEAN DEFAULT 1 NOT NULL,

    location TEXT UNIQUE,
    FOREIGN KEY (location)
      REFERENCES soilplot(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Contents soilprofile ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'soilprofile', -- table name
  'attributes', -- data type
  't_sp', -- unique table identifier
  'soilprofile Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);

-- Trigger soilprofile ---------------------------------------------------------------------------------------

CREATE TRIGGER soilprofileguid
AFTER INSERT ON soilprofile
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE soilprofile SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER soilprofileguidupdate
AFTER UPDATE OF guidkey ON soilprofile
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_ceckvalidperiodsoilprofile
BEFORE INSERT ON soilprofile
WHEN NEW.validfrom > NEW.validto
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: validto must be less than validfrom');
END;

CREATE TRIGGER u_ceckvalidperiodsoilprofile
BEFORE UPDATE ON soilprofile
WHEN NEW.validfrom > NEW.validto
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: validto must be less than validfrom');
END;
--


CREATE TRIGGER i_ceckvalidversionsoilprofile
BEFORE INSERT ON soilprofile
WHEN NEW.beginlifespanversion >= NEW.endlifespanversion
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: beginlifespanversion must be less than endlifespanversion');
END;
--


CREATE TRIGGER i_ceckprofileLocation
BEFORE INSERT ON soilprofile
WHEN NEW.isderived = 1 AND NEW.location IS NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile:  For DERIVED profile  (isderived = 1), location must be NULL'); 
END;

CREATE TRIGGER u_ceckprofileLocation
BEFORE UPDATE ON soilprofile
WHEN NEW.isderived = 1 AND NEW.location IS NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile:  For DERIVED profile  (isderived = 1), location must be NULL'); 
END;
--


CREATE TRIGGER i_ceckprofileLocationobserved
BEFORE INSERT ON soilprofile
WHEN NEW.isderived = 0 AND NEW.location IS  NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile:  For OBSERVED profile  (isderived = 0), location must be NOT NULL'); 
END;
--


CREATE TRIGGER u_ceckprofileLocationobserved
BEFORE INSERT ON soilprofile
WHEN NEW.isderived = 0 AND NEW.location IS  NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile:  For OBSERVED profile  (isderived = 0), location must be NOT NULL'); 
END;
--


CREATE TRIGGER i_wrbreferencesoilgroup
BEFORE INSERT ON soilprofile
FOR EACH ROW
WHEN NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue') AND NEW.wrbreferencesoilgroup NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbreferencesoilgroup. Must be present in id of wrbreferencesoilgroupvalue codelist.');
END;

CREATE TRIGGER u_wrbreferencesoilgroup
BEFORE UPDATE ON soilprofile
FOR EACH ROW
WHEN NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue') AND NEW.wrbreferencesoilgroup NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbreferencesoilgroup. Must be present in id of  wrbreferencesoilgroupvalue codelist.');
END;
--

CREATE TRIGGER u_begin_today_soilprofile
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,localidentifier,endlifespanversion,validfrom,validto,isderived,wrbreferencesoilgroup,isoriginalclassification
ON soilprofile
WHEN  datetime('now') < new.endlifespanversion OR NEW.endlifespanversion IS NULL
BEGIN
   UPDATE soilprofile
   SET beginlifespanversion  = strftime('%Y-%m-%dT%H:%M:%fZ', 'now','localtime')
   WHERE id = new.id;
END;



CREATE TRIGGER u_begin_today_soilprofile_error
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,localidentifier,endlifespanversion,validfrom,validto,isderived,wrbreferencesoilgroup,isoriginalclassification
ON soilprofile
WHEN  datetime('now') > new.endlifespanversion
BEGIN
   SELECT RAISE(ABORT,'If you change record endlifespanversion must be greater than today');
END;
--
                                 

/* 
 ██████  ████████ ██   ██ ███████ ██████  ███████  ██████  ██ ██      ███    ██  █████  ███    ███ ███████ ████████ ██    ██ ██████  ███████ 
██    ██    ██    ██   ██ ██      ██   ██ ██      ██    ██ ██ ██      ████   ██ ██   ██ ████  ████ ██         ██     ██  ██  ██   ██ ██      
██    ██    ██    ███████ █████   ██████  ███████ ██    ██ ██ ██      ██ ██  ██ ███████ ██ ████ ██ █████      ██      ████   ██████  █████   
██    ██    ██    ██   ██ ██      ██   ██      ██ ██    ██ ██ ██      ██  ██ ██ ██   ██ ██  ██  ██ ██         ██       ██    ██      ██      
 ██████     ██    ██   ██ ███████ ██   ██ ███████  ██████  ██ ███████ ██   ████ ██   ██ ██      ██ ███████    ██       ██    ██      ███████ 

 */


-- Table othersoilnametype ---------------------------------------------------------------------------------------
CREATE TABLE othersoilnametype
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    soilname TEXT NOT NULL, --Codelist othersoilnametypevalue
    isoriginalclassification  BOOLEAN, 
    othersoilname TEXT,
    FOREIGN KEY (othersoilname)
      REFERENCES soilprofile(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


-- Contents othersoilnametype ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'othersoilnametype', -- table name
  'attributes', -- data type
  't_osn', -- unique table identifier
  'othersoilnametype Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);


-- Trigger othersoilnametype ---------------------------------------------------------------------------------------


CREATE TRIGGER i_soilname
BEFORE INSERT ON othersoilnametype
FOR EACH ROW
WHEN NEW.soilname NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table othersoilnametype: Invalid value for soilname. Must be present in id of othersoilnametypevalue codelist.');
END;

CREATE TRIGGER u_soilname
BEFORE UPDATE ON othersoilnametype
FOR EACH ROW
WHEN NEW.soilname NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table othersoilnametype: Invalid value for soilname. Must be present in id of othersoilnametypevalue codelist.');
END;
--


/* 
██ ███████ ██████  ███████ ██████  ██ ██    ██ ███████ ██████  ███████ ██████   ██████  ███    ███ 
██ ██      ██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██      ██   ██ ██    ██ ████  ████ 
██ ███████ ██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ █████   ██████  ██    ██ ██ ████ ██ 
██      ██ ██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██      ██   ██ ██    ██ ██  ██  ██ 
██ ███████ ██████  ███████ ██   ██ ██   ████   ███████ ██████  ██      ██   ██  ██████  ██      ██
 */


-- Table isderivedfrom ---------------------------------------------------------------------------------------
CREATE TABLE isderivedfrom 
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  base_id TEXT NOT NULL,
  related_id TEXT NOT NULL,
  CONSTRAINT unicrelationidf UNIQUE (base_id, related_id),
  FOREIGN KEY (base_id) REFERENCES soilprofile (guidkey),
  FOREIGN KEY (related_id) REFERENCES soilprofile (guidkey)
);

-- Contents isderivedfrom ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
table_name,
data_type,
identifier,
description,
last_change
) VALUES (
'isderivedfrom', -- table name
'attributes', -- data type
't_idf', -- unique table identifier
'isderivedfrom Table', -- table description
strftime('%Y-%m-%dT%H:%M:%fZ','now') -- last modification date and time
);


 
-- Trigger isderivedfrom ---------------------------------------------------------------------------------------

CREATE TRIGGER i_checkisderived
BEFORE INSERT ON isderivedfrom
BEGIN
  SELECT
    CASE WHEN NEW.base_id NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 1)
    THEN RAISE(ABORT, 'Table isderivedfrom:  Attention, the value of the "base_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type derived')
    END;                  
END;

CREATE TRIGGER u_checkisderived
BEFORE UPDATE ON isderivedfrom
BEGIN
  SELECT
    CASE WHEN NEW.base_id NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 1)
    THEN RAISE(ABORT, 'Table isderivedfrom:  Attention, the value of the "base_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type derived')
    END;
END;
--
 

CREATE TRIGGER i_checkisobserved
BEFORE INSERT ON isderivedfrom
BEGIN
  SELECT
    CASE WHEN NEW.related_id NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 0)
    THEN RAISE(ABORT, 'Table isderivedfrom:  Attention, the value of the "related_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type observed')
    END;                  
END;

CREATE TRIGGER u_checkisobserved
BEFORE UPDATE ON isderivedfrom
BEGIN
  SELECT
    CASE WHEN NEW.related_id NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 0)
    THEN RAISE(ABORT, 'Table isderivedfrom:  Attention, the value of the "related_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type observed')
    END;
END;
--

/* 
███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██ 
██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██  
███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████   
     ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██    
███████  ██████  ██ ███████ ██████   ██████  ██████     ██   
 */ 
                                                              

-- Table soilbody ---------------------------------------------------------------------------------------
CREATE TABLE soilbody
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    inspireid_localid TEXT,
    inspireid_namespace TEXT,
    inspireid_versionid TEXT, 
    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null,
    endlifespanversion DATETIME,
    soilbodylabel TEXT NOT NULL
);



-- Contents soilbody ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'soilbody', -- table name
  'attributes', -- data type
  'f_sb', -- unique table identifier
  'soilbody Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  3035 -- EPSG spatial reference system code
);



-- Trigger soilbody ---------------------------------------------------------------------------------------

CREATE TRIGGER soilbodyguid
AFTER INSERT ON soilbody
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE soilbody SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER soilbodyguidupdate
AFTER UPDATE OF guidkey ON soilbody
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_ceckvalidversionsoilbody
BEFORE INSERT ON soilbody
WHEN NEW.beginlifespanversion > NEW.endlifespanversion
BEGIN
    SELECT RAISE(ABORT, 'Table soilbody: beginlifespanversion must be less than endlifespanversion');
END;
--


CREATE TRIGGER u_begin_today_soilbody
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,endlifespanversion,soilbodylabel
ON soilbody
WHEN  datetime('now') < new.endlifespanversion OR NEW.endlifespanversion IS NULL
BEGIN
   UPDATE soilbody
   SET beginlifespanversion  = strftime('%Y-%m-%dT%H:%M:%fZ', 'now','localtime')
   WHERE id = new.id;
END;
--


CREATE TRIGGER u_begin_today_soilbody_error
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,endlifespanversion,soilbodylabel
ON soilbody
WHEN  datetime('now') > new.endlifespanversion
BEGIN
   SELECT RAISE(ABORT,'If you change record endlifespanversion must be greater than today');
END;
-- 



/*
███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██          ██████  ███████  ██████  ███    ███ 
██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██          ██       ██      ██    ██ ████  ████ 
███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████           ██   ███ █████   ██    ██ ██ ████ ██ 
     ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██            ██    ██ ██      ██    ██ ██  ██  ██ 
███████  ██████  ██ ███████ ██████   ██████  ██████     ██    ███████  ██████  ███████  ██████  ██      ██ 
*/

-- Table soilbody_geom ---------------------------------------------------------------------------------------

CREATE TABLE soilbody_geom
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    geom MULTIPOLYGON NOT NULL, 
    idsoilbodylabel TEXT NOT NULL,
     FOREIGN KEY (idsoilbodylabel)
      REFERENCES soilbody(guidkey)

);


-- Contents soilbody_geom ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'soilbody_geom', -- table name
  'features', -- data type
  'f_sbg', -- unique table identifier
  'soilbody_geom Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  3035 -- EPSG spatial reference system code
);


-- spatial index
CREATE INDEX soiBody_geom_idx ON soilbody_geom(geom);


-- Geometry soilbody_geom ---------------------------------------------------------------------------------------
INSERT INTO gpkg_geometry_columns (
  table_name,
  column_name,
  geometry_type_name,
  srs_id,
  z,
  m
) VALUES (
  'soilbody_geom', -- table name
  'geom', -- geometry column name
  'MULTIPOLYGON', -- geometry type
  3035, -- EPSG spatial reference system code
  0, -- if the geometry has a Z coordinate (0 = no, 1 = yes, 2 = optional)
  0 -- if the geometry has a M coordinate (0 = no, 1 = yes, 2 = optional)
);





/* 
██████  ███████ ██████  ██ ██    ██ ███████ ██████  ██████  ██████   ██████  ███████ ██ ██      ███████ ██████  ██████  ███████ ███████ ███████ ███    ██  ██████ ███████ ██ ███    ██ ███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██ 
██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      ██   ██ ██   ██ ██      ██      ██      ████   ██ ██      ██      ██ ████   ██ ██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██  
██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ ██████  ██████  ██    ██ █████   ██ ██      █████   ██████  ██████  █████   ███████ █████   ██ ██  ██ ██      █████   ██ ██ ██  ██ ███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████   
██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██      ██   ██ ██    ██ ██      ██ ██      ██      ██      ██   ██ ██           ██ ██      ██  ██ ██ ██      ██      ██ ██  ██ ██      ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██    
██████  ███████ ██   ██ ██   ████   ███████ ██████  ██      ██   ██  ██████  ██      ██ ███████ ███████ ██      ██   ██ ███████ ███████ ███████ ██   ████  ██████ ███████ ██ ██   ████ ███████  ██████  ██ ███████ ██████   ██████  ██████     ██    
 */


-- Table derivedprofilepresenceinsoilbody ---------------------------------------------------------------------------------------

CREATE TABLE derivedprofilepresenceinsoilbody (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  idsoilbody TEXT NOT NULL,
  idsoilprofile TEXT NOT NULL,
  lowervalue REAL,
  uppervalue REAL,
  CONSTRAINT unicrelationdpsb UNIQUE (idsoilbody, idsoilprofile),
  FOREIGN KEY (idsoilbody) REFERENCES soilbody (guidkey),
  FOREIGN KEY (idsoilprofile) REFERENCES soilprofile (guidkey)
  
);
-- Contents derivedprofilepresenceinsoilbody ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'derivedprofilepresenceinsoilbody', -- table name
  'attributes', -- data type
  't_dppsb', -- unique table identifier
  'derivedprofilepresenceinsoilbody Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);


-- Trigger derivedprofilepresenceinsoilbody ---------------------------------------------------------------------------------------------

CREATE TRIGGER i_cecklowervaluesum
BEFORE INSERT ON derivedprofilepresenceinsoilbody
FOR EACH ROW
WHEN (SELECT SUM(lowervalue) FROM derivedprofilepresenceinsoilbody WHERE idsoilbody = NEW.idsoilbody) + NEW.lowervalue > 100
BEGIN
    SELECT RAISE(ABORT, 'Table derivedprofilepresenceinsoilbody: sum of lowervalue exceeds 100 for the same idsoilbody');
END;

CREATE TRIGGER u_cecklowervaluesum
BEFORE UPDATE ON derivedprofilepresenceinsoilbody
FOR EACH ROW
WHEN (SELECT SUM(lowervalue) FROM derivedprofilepresenceinsoilbody WHERE idsoilbody = NEW.idsoilbody) - OLD.lowervalue + NEW.lowervalue > 100
BEGIN
    SELECT RAISE(ABORT, 'Table derivedprofilepresenceinsoilbody: sum of lowervalue exceeds 100 for the same idsoilbody');
END;
--
 

CREATE TRIGGER "i_checkisderived_soilbody"
BEFORE INSERT ON derivedprofilepresenceinsoilbody
BEGIN
  SELECT
    CASE WHEN NEW.idsoilprofile NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 1)
    THEN RAISE(ABORT, 'Table derivedprofilepresenceinsoilbody:  Attention, the value of the "idsoilprofile" field  cannot be inserted because profile is not of type derived')
    END;
END;

CREATE TRIGGER  u_checkisderived_soilbody
BEFORE UPDATE ON derivedprofilepresenceinsoilbody
BEGIN
  SELECT
    CASE WHEN NEW.idsoilprofile NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 1)
    THEN RAISE(ABORT, 'Table derivedprofilepresenceinsoilbody:  Attention, the value of the "idsoilprofile" field  cannot be inserted because profile is not of type derived')
    END;
END;
--


/* 
███████  ██████  ██ ██      ██████  ███████ ██████  ██ ██    ██ ███████ ██████   ██████  ██████       ██ ███████  ██████ ████████ 
██      ██    ██ ██ ██      ██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██    ██ ██   ██      ██ ██      ██         ██    
███████ ██    ██ ██ ██      ██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ ██    ██ ██████       ██ █████   ██         ██    
     ██ ██    ██ ██ ██      ██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██         ██    
███████  ██████  ██ ███████ ██████  ███████ ██   ██ ██   ████   ███████ ██████   ██████  ██████   █████  ███████  ██████    ██    
 */


-- Table soilderivedobject ---------------------------------------------------------------------------------------
CREATE TABLE soilderivedobject
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    inspireid_localid     TEXT,
    inspireid_namespace   TEXT,
    inspireid_versionid    TEXT,
    accessuri   TEXT,
    geometry POLYGON --envelop
);

-- spatial index
CREATE INDEX SoiDerObj_geom_idx ON soilderivedobject (geometry);

-- Contents soilderivedobject ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'soilderivedobject', -- table name
  'attributes', -- data type
  't_sdo', -- unique table identifier
  'soilderivedobject Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  3035 -- EPSG spatial reference system code
);



-- Trigger soilderivedobject ---------------------------------------------------------------------------------------
CREATE TRIGGER soilderivedobjectguid
AFTER INSERT ON soilderivedobject
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE soilderivedobject SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER soilderivedobjectguidupdate
AFTER UPDATE OF guidkey ON soilderivedobject
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;




/* 
██ ███████ ██████   █████  ███████ ███████ ██████   ██████  ███    ██  ██████  ██████  ███████ ███████ ██████  ██    ██ ███████ ██████  ███████  ██████  ██ ██      ██████  ██████   ██████  ███████ ██ ██      ███████ 
██ ██      ██   ██ ██   ██ ██      ██      ██   ██ ██    ██ ████   ██ ██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██      ██   ██ ██      ██    ██ ██ ██      ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      
██ ███████ ██████  ███████ ███████ █████   ██   ██ ██    ██ ██ ██  ██ ██    ██ ██████  ███████ █████   ██████  ██    ██ █████   ██   ██ ███████ ██    ██ ██ ██      ██████  ██████  ██    ██ █████   ██ ██      █████   
██      ██ ██   ██ ██   ██      ██ ██      ██   ██ ██    ██ ██  ██ ██ ██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██      ██   ██      ██ ██    ██ ██ ██      ██      ██   ██ ██    ██ ██      ██ ██      ██      
██ ███████ ██████  ██   ██ ███████ ███████ ██████   ██████  ██   ████  ██████  ██████  ███████ ███████ ██   ██   ████   ███████ ██████  ███████  ██████  ██ ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████
 */


-- Table isbasedonobservedsoilprofile  ---------------------------------------------------------------------------------------
CREATE TABLE isbasedonobservedsoilprofile 
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  idsoilderivedobject TEXT NOT NULL,
  idsoilprofile TEXT NOT NULL, --idsoilprofile
  CONSTRAINT unicrelationibosp UNIQUE (idsoilderivedobject, idsoilprofile),
  FOREIGN KEY (idsoilderivedobject) REFERENCES soilderivedobject (guidkey),
  FOREIGN KEY (idsoilprofile) REFERENCES soilprofile (guidkey)
);

-- Contents isbasedonobservedsoilprofile  ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
table_name,
data_type,
identifier,
description,
last_change
) VALUES (
'isbasedonobservedsoilprofile', -- table name
'attributes', -- data type
't_objop', -- unique table identifier
'isbasedonobservedsoilprofile Table', -- table description
strftime('%Y-%m-%dT%H:%M:%fZ','now') -- last modification date and time
);


CREATE TRIGGER i_checkisobserved_dobj
BEFORE INSERT ON isbasedonobservedsoilprofile 
BEGIN
  SELECT
    CASE WHEN NEW.idsoilprofile NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 0)
    THEN RAISE(ABORT, 'Table isbasedonobservedsoilprofile :  Attention, the value of the "idsoilprofile" field  cannot be inserted because profile is not of type observed')
    END;                  
END;

CREATE TRIGGER u_checkisobserved_dobj
BEFORE UPDATE ON isbasedonobservedsoilprofile 
BEGIN
  SELECT
    CASE WHEN NEW.idsoilprofile NOT IN (SELECT guidkey FROM soilprofile WHERE isderived = 0)
    THEN RAISE(ABORT, 'Table isbasedonobservedsoilprofile :  Attention, the value of the "idsoilprofile" field  cannot be inserted because profile is not of type observed')
    END;
END;
--


/* 
██ ███████ ██████   █████  ███████ ███████ ██████   ██████  ███    ██ ███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██     
██ ██      ██   ██ ██   ██ ██      ██      ██   ██ ██    ██ ████   ██ ██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██      
██ ███████ ██████  ███████ ███████ █████   ██   ██ ██    ██ ██ ██  ██ ███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████       
██      ██ ██   ██ ██   ██      ██ ██      ██   ██ ██    ██ ██  ██ ██      ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██        
██ ███████ ██████  ██   ██ ███████ ███████ ██████   ██████  ██   ████ ███████  ██████  ██ ███████ ██████   ██████  ██████     ██      
 */


-- Table isbasedonsoilbody ---------------------------------------------------------------------------------------
CREATE TABLE isbasedonsoilbody
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  idsoilderivedobject TEXT NOT NULL,
  idsoilbody TEXT NOT NULL,
  CONSTRAINT unicrelationibosb UNIQUE (idsoilderivedobject, idsoilbody),
  FOREIGN KEY (idsoilderivedobject) REFERENCES soilderivedobject (guidkey),
  FOREIGN KEY (idsoilbody) REFERENCES soilbody (guidkey)
);

-- Contents isbasedonsoilbody ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
table_name,
data_type,
identifier,
description,
last_change
) VALUES (
'isbasedonsoilbody', -- table name
'attributes', -- data type
't_objsb', -- unique table identifier
'isbasedonsoilbody Table', -- table description
strftime('%Y-%m-%dT%H:%M:%fZ','now') -- last modification date and time
);



/* 
██ ███████ ██████   █████  ███████ ███████ ██████   ██████  ███    ██ ███████  ██████  ██ ██      ██████  ███████ ██████  ██ ██    ██ ███████ ██████   ██████  ██████       ██ ███████  ██████ ████████ 
██ ██      ██   ██ ██   ██ ██      ██      ██   ██ ██    ██ ████   ██ ██      ██    ██ ██ ██      ██   ██ ██      ██   ██ ██ ██    ██ ██      ██   ██ ██    ██ ██   ██      ██ ██      ██         ██    
██ ███████ ██████  ███████ ███████ █████   ██   ██ ██    ██ ██ ██  ██ ███████ ██    ██ ██ ██      ██   ██ █████   ██████  ██ ██    ██ █████   ██   ██ ██    ██ ██████       ██ █████   ██         ██    
██      ██ ██   ██ ██   ██      ██ ██      ██   ██ ██    ██ ██  ██ ██      ██ ██    ██ ██ ██      ██   ██ ██      ██   ██ ██  ██  ██  ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██         ██    
██ ███████ ██████  ██   ██ ███████ ███████ ██████   ██████  ██   ████ ███████  ██████  ██ ███████ ██████  ███████ ██   ██ ██   ████   ███████ ██████   ██████  ██████   █████  ███████  ██████    ██    
                       */                                                                                                                                                                                  


-- Table isbasedonsoilderivedobject
CREATE TABLE isbasedonsoilderivedobject (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  base_id TEXT NOT NULL,
  related_id TEXT NOT NULL,
  CONSTRAINT unicrelationibosdo UNIQUE (base_id, related_id),
  FOREIGN KEY (base_id) REFERENCES soilderivedobject (guidkey),
  FOREIGN KEY (related_id) REFERENCES soilderivedobject (guidkey)
);

-- Contents soilderivedobject
INSERT INTO gpkg_contents (
table_name,
data_type,
identifier,
description,
last_change
) VALUES (
'isbasedonsoilderivedobject', -- table name
'attributes', -- data type
't_bo', -- unique table identifier
'isbasedonsoilderivedobject Table', -- table description
strftime('%Y-%m-%dT%H:%M:%fZ','now') -- last modification date and time
);


/* 
██████  ██████   ██████  ███████ ██ ██      ███████ ███████ ██      ███████ ███    ███ ███████ ███    ██ ████████ 
██   ██ ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ████  ████ ██      ████   ██    ██    
██████  ██████  ██    ██ █████   ██ ██      █████   █████   ██      █████   ██ ████ ██ █████   ██ ██  ██    ██    
██      ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ██  ██  ██ ██      ██  ██ ██    ██    
██      ██   ██  ██████  ██      ██ ███████ ███████ ███████ ███████ ███████ ██      ██ ███████ ██   ████    ██   
 */

-- Table profileelement ---------------------------------------------------------------------------------------
CREATE TABLE profileelement
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    inspireid_localid                    TEXT,      
    inspireid_namespace                  TEXT,     
    inspireid_versionid                   TEXT, 
    -- profileElementDepthRange
    profileelementdepthrange_uppervalue  INTEGER NOT NULL, 
    profileelementdepthrange_lowervalue  INTEGER NOT NULL,  

    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null, 
    endlifespanversion                   DATETIME,  

    layertype                            TEXT,      -- Codelist layertypevalue geometry
    layerrocktype                        TEXT,      -- Codelist lithologyvalue (DA 0-N) ma noi mettiamo cardinalità 0..1

    layergenesisprocess                  TEXT,      -- Codelist eventprocessvalue  
    layergenesisenviroment               TEXT,      -- Codelist eventenvironmentvalue 
    layergenesisprocessstate             TEXT,      -- Codelist layergenesisprocessstatevalue

    profileelementtype                   BOOLEAN DEFAULT 0 NOT NULL,
    ispartof TEXT NOT NULL,
    FOREIGN KEY (ispartof)
      REFERENCES soilprofile(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Contents profileelement ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'profileelement', -- table name
  'attributes', -- data type
  't_pe', -- unique table identifier
  'profileelement Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);

-- Trigger profileelement ---------------------------------------------------------------------------------------

CREATE TRIGGER profileelementguid
AFTER INSERT ON profileelement
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE profileelement SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER profileelementguidupdate
AFTER UPDATE OF guidkey ON profileelement
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_ceckvalidversionprofileelement
BEFORE INSERT ON profileelement
WHEN NEW.beginlifespanversion > NEW.endlifespanversion
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: beginlifespanversion must be less than endlifespanversion');
END;
--


CREATE TRIGGER i_ceckvaliddeepprofileelement
BEFORE INSERT ON profileelement
WHEN NEW.profileelementdepthrange_lowervalue <= NEW.profileelementdepthrange_uppervalue
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: profileelementdepthrange_uppervalue must be less than profileelementdepthrange_lowervalue');
END;

CREATE TRIGGER u_ceckvaliddeepprofileelement
BEFORE UPDATE ON profileelement
WHEN NEW.profileelementdepthrange_lowervalue <= NEW.profileelementdepthrange_uppervalue
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: profileelementdepthrange_uppervalue must be less than profileelementdepthrange_lowervalue');
END;
--


CREATE TRIGGER i_checkgeogenicfieldsnotnull
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN (NEW.layertype = 'http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic')
BEGIN
    -- Verifica se i campi non sono NULL, altrimenti solleva un'eccezione
    SELECT CASE
        WHEN (NEW.layerrocktype IS NULL) THEN
            RAISE(ABORT, 'layerrocktype cannot be NULL when LayerTypeValue is "geogenic".')
        WHEN (NEW.layergenesisprocess IS NULL) THEN
            RAISE(ABORT, 'layergenesisprocess cannot be NULL when LayerTypeValue is "geogenic".')
        WHEN (NEW.layergenesisenviroment IS NULL) THEN
            RAISE(ABORT, 'layergenesisenviroment cannot be NULL when LayerTypeValue is "geogenic".')
        WHEN (NEW.layergenesisprocessstate IS NULL) THEN
            RAISE(ABORT, 'layergenesisprocessstate cannot be NULL when LayerTypeValue is "geogenic".')
    END;
END;


CREATE TRIGGER u_checkgeogenicfieldsnotnull
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN (NEW.layertype = 'http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic')
BEGIN
    -- Verifica se i campi non sono NULL, altrimenti solleva un'eccezione
    SELECT CASE
        WHEN (NEW.layerrocktype IS NULL OR length(NEW.layerrocktype )<1) THEN
            RAISE(ABORT, 'layerrocktype cannot be NULL when LayerTypeValue is "geogenic".')
        WHEN (NEW.layergenesisprocess IS NULL OR length(NEW.layergenesisprocess )<1) THEN
            RAISE(ABORT, 'layergenesisprocess cannot be NULL when LayerTypeValue is "geogenic".')
        WHEN (NEW.layergenesisenviroment IS NULL OR length(NEW.layergenesisenviroment )<1) THEN
            RAISE(ABORT, 'layergenesisenviroment cannot be NULL when LayerTypeValue is "geogenic".')
        WHEN (NEW.layergenesisprocessstate IS NULL OR length(NEW.layergenesisprocessstate )<1) THEN
            RAISE(ABORT, 'layergenesisprocessstate cannot be NULL when LayerTypeValue is "geogenic".')
    END;
END;
--

CREATE TRIGGER i_ceckhorizonfields
BEFORE INSERT  ON profileelement
FOR EACH ROW
WHEN (NEW.profileelementtype = 0)
BEGIN
    SELECT CASE
        WHEN (NEW.layertype IS NOT NULL) THEN
            RAISE(ABORT, 'layertype must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layerrocktype IS NOT NULL) THEN
            RAISE(ABORT, 'layerrocktype must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layergenesisprocess IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisprocess must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layergenesisenviroment IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisenviroment must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layergenesisprocessstate IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisprocessstate must be NULL when profilelement is "HORIZON".')
    END;
END;


CREATE TRIGGER u_ceckhorizonfields
BEFORE UPDATE  ON profileelement
FOR EACH ROW
WHEN (NEW.profileelementtype = 0)
BEGIN
    SELECT CASE
        WHEN (NEW.layertype IS NOT NULL OR length(NEW.layertype )<1) THEN
            RAISE(ABORT, 'layertype must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layerrocktype IS NOT NULL OR length(NEW.layerrocktype )<1) THEN
            RAISE(ABORT, 'layerrocktype must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layergenesisprocess IS NOT NULL OR length(NEW.layergenesisprocess )<1) THEN
            RAISE(ABORT, 'layergenesisprocess must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layergenesisenviroment IS NOT NULL OR length(NEW.layergenesisenviroment )<1) THEN
            RAISE(ABORT, 'layergenesisenviroment must be NULL when profilelement is "HORIZON".')
        WHEN (NEW.layergenesisprocessstate IS NOT NULL OR length(NEW.layergenesisprocessstate )<1) THEN
            RAISE(ABORT, 'layergenesisprocessstate must be NULL when profilelement is "HORIZON".')
    END;
END;


CREATE TRIGGER i_layertype
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layertype NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/LayerTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layertype. Must be present in id of layertypevalue codelist.');
END;

CREATE TRIGGER u_layertype
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layertype NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/LayerTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layertype. Must be present in id of layertypevalue codelist.');
END;
--


CREATE TRIGGER i_layergenesisenviroment
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisenviroment NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue')  AND NEW.layergenesisenviroment NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisenviroment. Must be present in id of eventenvironmentvalue codelist.');
END;

CREATE TRIGGER u_layergenesisenviroment
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisenviroment NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue')  AND NEW.layergenesisenviroment NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisenviroment. Must be present in id of eventenvironmentvalue codelist.');
END;
--


CREATE TRIGGER i_layergenesisprocess
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocess NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/EventProcessValue')  AND NEW.layergenesisprocess NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocess. Must be present in id of  eventprocessvalue codelist.');
END;

CREATE TRIGGER u_layergenesisprocess
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocess NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/EventProcessValue')  AND NEW.layergenesisprocess NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocess. Must be present in id of eventprocessvalue codelist.');
END;
--


CREATE TRIGGER "i_layergenesisprocessstate"
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocessstate NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue')  AND NEW.layergenesisprocessstate NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocessstate. Must be present in id of layergenesisprocessstatevalue codelist.');
END;

CREATE TRIGGER u_layergenesisprocessstate
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocessstate NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue')  AND NEW.layergenesisprocessstate NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocessstate. Must be present in id of layergenesisprocessstatevalue codelist.');
END;
--


CREATE TRIGGER i_layerrocktype
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layerrocktype NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/LithologyValue')  AND NEW.layerrocktype NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layerrocktype. Must be present in id of lithologyvalue codelist .');
END;

CREATE TRIGGER u_layerrocktype
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layerrocktype NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/LithologyValue')  AND NEW.layerrocktype NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layerrocktype. Must be present in id of lithologyvalue codelist.');
END;
--


CREATE TRIGGER u_begin_today_profileelement
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,profileelementdepthrange_uppervalue,profileelementdepthrange_lowervalue,endlifespanversion,layertype,layerrocktype,layergenesisprocess,layergenesisenviroment,layergenesisprocessstate,profileelementtype
ON profileelement
WHEN  datetime('now') < new.endlifespanversion OR NEW.endlifespanversion IS NULL
BEGIN
   UPDATE profileelement
   SET beginlifespanversion  = strftime('%Y-%m-%dT%H:%M:%fZ', 'now','localtime')
   WHERE id = new.id;
END;
--


CREATE TRIGGER u_begin_today_profileelement_error
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,profileelementdepthrange_uppervalue,profileelementdepthrange_lowervalue,endlifespanversion,layertype,layerrocktype,layergenesisprocess,layergenesisenviroment,layergenesisprocessstate,profileelementtype
ON profileelement
WHEN  datetime('now') > new.endlifespanversion
BEGIN
   SELECT RAISE(ABORT,'If you change record endlifespanversion must be greater than today');
END;


/* 
██████   █████  ██████  ████████ ██  ██████ ██      ███████ ███████ ██ ███████ ███████ ███████ ██████   █████   ██████ ████████ ██  ██████  ███    ██ ████████ ██    ██ ██████  ███████ 
██   ██ ██   ██ ██   ██    ██    ██ ██      ██      ██      ██      ██    ███  ██      ██      ██   ██ ██   ██ ██         ██    ██ ██    ██ ████   ██    ██     ██  ██  ██   ██ ██      
██████  ███████ ██████     ██    ██ ██      ██      █████   ███████ ██   ███   █████   █████   ██████  ███████ ██         ██    ██ ██    ██ ██ ██  ██    ██      ████   ██████  █████   
██      ██   ██ ██   ██    ██    ██ ██      ██      ██           ██ ██  ███    ██      ██      ██   ██ ██   ██ ██         ██    ██ ██    ██ ██  ██ ██    ██       ██    ██      ██      
██      ██   ██ ██   ██    ██    ██  ██████ ███████ ███████ ███████ ██ ███████ ███████ ██      ██   ██ ██   ██  ██████    ██    ██  ██████  ██   ████    ██       ██    ██      ███████
 */


-- Table particlesizefractiontype ---------------------------------------------------------------------------------------
CREATE TABLE particlesizefractiontype
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    fractioncontent                 REAL, 
    pariclesize_min                 REAL, 
    pariclesize_max                  REAL, 
    idprofileelement TEXT NOT NULL,
    FOREIGN KEY (idprofileelement)
      REFERENCES profileelement(guidkey)

);

-- Contents particlesizefractiontype ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'particlesizefractiontype', -- table name
  'attributes', -- data type
  't_psft', -- unique table identifier
  'particlesizefractiontype Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);



/* 
███████  █████   ██████  ██   ██  ██████  ██████  ██ ███████  ██████  ███    ██ ███    ██  ██████  ████████  █████  ████████ ██  ██████  ███    ██ ████████ ██    ██ ██████  ███████ 
██      ██   ██ ██    ██ ██   ██ ██    ██ ██   ██ ██    ███  ██    ██ ████   ██ ████   ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ████   ██    ██     ██  ██  ██   ██ ██      
█████   ███████ ██    ██ ███████ ██    ██ ██████  ██   ███   ██    ██ ██ ██  ██ ██ ██  ██ ██    ██    ██    ███████    ██    ██ ██    ██ ██ ██  ██    ██      ████   ██████  █████   
██      ██   ██ ██    ██ ██   ██ ██    ██ ██   ██ ██  ███    ██    ██ ██  ██ ██ ██  ██ ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ██  ██ ██    ██       ██    ██      ██      
██      ██   ██  ██████  ██   ██  ██████  ██   ██ ██ ███████  ██████  ██   ████ ██   ████  ██████     ██    ██   ██    ██    ██  ██████  ██   ████    ██       ██    ██      ███████ 
 */


-- Table faohorizonnotationtype ---------------------------------------------------------------------------------------
CREATE TABLE faohorizonnotationtype
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    faohorizondiscontinuity           INTEGER, 
    faohorizonmaster                  TEXT, -- Codelist faohorizonmastervalue
    faohorizonsubordinate             TEXT, -- Codelist faohorizonsubordinatevalue
    faohorizonverical                INTEGER,
    faoprime                          TEXT,  -- Codelist faoprimevalue
    isoriginalclassification          BOOLEAN,
    idprofileelement TEXT UNIQUE, 
    FOREIGN KEY (idprofileelement) 
      REFERENCES profileelement(guidkey)  
);


-- Contents faohorizonnotationtype ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'faohorizonnotationtype', -- table name
  'attributes', -- data type
  't_faohnt', -- unique table identifier
  'faohorizonnotationtype Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);

-- Trigger faohorizonnotationtype ---------------------------------------------------------------------------------------


CREATE TRIGGER "i_ceckfaoprofileelementtype"
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.idprofileelement IS NOT NULL AND (
    SELECT profileelementtype FROM profileelement WHERE id = NEW.idprofileelement
    ) <> 1
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: The associated profileelement must have profileelementtype = 0 (HORIZON)');
END;

CREATE TRIGGER u_ceckfaoprofileelementtype
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.idprofileelement IS NOT NULL AND (
    SELECT profileelementtype FROM profileelement WHERE id = NEW.idprofileelement
    ) <> 1
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: The associated profileelement must have profileelementtype = 0 (HORIZON)');
END;
--


CREATE TRIGGER i_faohorizonmaster
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonmaster NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster') AND NEW.faohorizonmaster NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.');
END;

CREATE TRIGGER u_faohorizonmaster
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonmaster NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster') AND NEW.faohorizonmaster NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.');
END;
--


CREATE TRIGGER i_faohorizonsubordinate
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate') AND NEW.faohorizonsubordinate  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;

CREATE TRIGGER u_faohorizonsubordinate
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate') AND NEW.faohorizonsubordinate  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;
--


CREATE TRIGGER i_faoprime
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faoprime NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/FAOPrime') AND NEW.faoprime NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faoprime. Must be present in id of faoprimevalue codelist.');
END;

CREATE TRIGGER u_faoprime
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faoprime NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/FAOPrime') AND NEW.faoprime NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faoprime. Must be present in id of faoprimevalue codelist.');
END;
--


/* 
 ██████  ████████ ██   ██ ███████ ██████  ██   ██  ██████  ██████  ██ ███████  ██████  ███    ██ ███    ██  ██████  ████████  █████  ████████ ██  ██████  ███    ██ ████████ ██    ██ ██████  ███████ 
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██    ███  ██    ██ ████   ██ ████   ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ████   ██    ██     ██  ██  ██   ██ ██      
██    ██    ██    ███████ █████   ██████  ███████ ██    ██ ██████  ██   ███   ██    ██ ██ ██  ██ ██ ██  ██ ██    ██    ██    ███████    ██    ██ ██    ██ ██ ██  ██    ██      ████   ██████  █████   
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██  ███    ██    ██ ██  ██ ██ ██  ██ ██ ██    ██    ██    ██   ██    ██    ██ ██    ██ ██  ██ ██    ██       ██    ██      ██      
 ██████     ██    ██   ██ ███████ ██   ██ ██   ██  ██████  ██   ██ ██ ███████  ██████  ██   ████ ██   ████  ██████     ██    ██   ██    ██    ██  ██████  ██   ████    ██       ██    ██      ███████
 */


-- Table otherhorizonnotationtype ---------------------------------------------------------------------------------------
CREATE TABLE otherhorizonnotationtype
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    horizonnotation                      TEXT, --Codelist otherhorizonnotationtypevalue
    diagnostichorizon                    TEXT, -- Codelist wrbdiagnostichorizon 
    isoriginalclassification             BOOLEAN, 
    otherhorizonnotation TEXT,
    FOREIGN KEY (otherhorizonnotation)
      REFERENCES profileelement(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


-- Contents otherhorizonnotationtype ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'otherhorizonnotationtype', -- table name
  'attributes', -- data type
  't_ohnt', -- unique table identifier
  'otherhorizonnotationtype Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);


-- Trigger otherhorizonnotationtype ---------------------------------------------------------------------------------------

CREATE TRIGGER   i_ceckothprofileelementtype
BEFORE INSERT ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.otherhorizonnotation IS NOT NULL AND (
    SELECT profileelementtype FROM profileelement WHERE id = NEW.otherhorizonnotation
    ) <> 1
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: The associated profileelement must have profileelementtype = 0 (HORIZON)');
END;

CREATE TRIGGER   u_ceckothprofileelementtype
BEFORE UPDATE ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.otherhorizonnotation IS NOT NULL AND (
    SELECT profileelementtype FROM profileelement WHERE id = NEW.otherhorizonnotation
    ) <> 1
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: The associated profileelement must have profileelementtype = 0 (HORIZON)');
END;
--


CREATE TRIGGER i_otherhorizonnotationtype
BEFORE INSERT ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.horizonnotation NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/OtherHorizonNotationTypeValue') AND NEW.horizonnotation NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for horizonnotation. Must be present in id of otherhorizonnotationtypevalue codelist.');
END;

CREATE TRIGGER u_otherhorizonnotationtype
BEFORE UPDATE ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.horizonnotation NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/OtherHorizonNotationTypeValue') AND NEW.horizonnotation NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for horizonnotation. Must be present in id of otherhorizonnotationtypevalue codelist.');
END;
--


CREATE TRIGGER i_diagnostichorizon
BEFORE INSERT ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.diagnostichorizon = 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001' and NEW.horizonnotation NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon') AND NEW.horizonnotation NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for horizonnotation. Must be present in id of otherhorizonnotationtype codelist.');
END;

CREATE TRIGGER u_diagnostichorizon
BEFORE UPDATE ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.diagnostichorizon = 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001' and NEW.horizonnotation NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon') AND NEW.horizonnotation NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for horizonnotation. Must be present in id of otherhorizonnotationtypevalue codelist.');
END;
--



/* 
██     ██ ██████  ██████   ██████  ██    ██  █████  ██      ██ ███████ ██ ███████ ██████   ██████  ██████   ██████  ██    ██ ██████  ████████ ██    ██ ██████  ███████ 
██     ██ ██   ██ ██   ██ ██    ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██       ██   ██ ██    ██ ██    ██ ██   ██    ██     ██  ██  ██   ██ ██      
██  █  ██ ██████  ██████  ██    ██ ██    ██ ███████ ██      ██ █████   ██ █████   ██████  ██   ███ ██████  ██    ██ ██    ██ ██████     ██      ████   ██████  █████   
██ ███ ██ ██   ██ ██   ██ ██ ▄▄ ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██    ██ ██   ██ ██    ██ ██    ██ ██         ██       ██    ██      ██      
 ███ ███  ██   ██ ██████   ██████   ██████  ██   ██ ███████ ██ ██      ██ ███████ ██   ██  ██████  ██   ██  ██████   ██████  ██         ██       ██    ██      ███████ 
 */

-- Table wrbqualifiergrouptype ---------------------------------------------------------------------------------------
CREATE TABLE wrbqualifiergrouptype 
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    qualifierplace            TEXT NOT NULL, -- Codelist wrbqualifierplacevalue
    qualifierposition         INTEGER NOT NULL,
    wrbqualifier              TEXT NOT NULL,  --Codelist wrbqualifiervalue 
    wrbspecifier_1            TEXT,    -- Codelist wrbspecifiervalue
    wrbspecifier_2            TEXT,    -- Codelist wrbspecifiervalue

    wrbqualifiergroup TEXT,  
    FOREIGN KEY (wrbqualifiergroup)
      REFERENCES soilprofile(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Contents wrbqualifiergrouptype ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
  table_name,
  data_type,
  identifier,
  description,
  last_change,
  min_x,
  min_y,
  max_x,
  max_y,
  srs_id
) VALUES (
  'wrbqualifiergrouptype', -- table name
  'attributes', -- data type
  't_wrbqgt', -- unique table identifier
  'wrbqualifiergrouptype Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);


-- Trigger wrbqualifiergrouptype ---------------------------------------------------------------------------------------

CREATE TRIGGER i_wrbqualifier
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue') 
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbqualifier. Must be present in id of wrbqualifiervalue codelist.');
END;

CREATE TRIGGER u_wrbqualifier
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue') 
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbqualifier. Must be present in id of wrbqualifiervalue codelist.');
END;
--

CREATE TRIGGER i_qualifierplace
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.qualifierplace NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue') 
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for qualifierplace. Must be present in id of wrbqualifierplacevalue codelist.');
END;

CREATE TRIGGER u_qualifierplace
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.qualifierplace NOT IN (SELECT id FROM codelist WHERE collection = 'http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue') 
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for qualifierplace. Must be present in id of wrbqualifierplacevalue codelist.');
END;
--

CREATE TRIGGER i_wrbspecifier_1
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers') AND NEW.wrbspecifier_1 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbspecifier_1. Must be present in id of wrbspecifiervalue codelist.');
END;

CREATE TRIGGER u_wrbspecifier_1
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers') AND NEW.wrbspecifier_1 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbspecifier_1. Must be present in id of wrbspecifiervalue codelist.');
END;
--


CREATE TRIGGER i_wrbspecifier_2
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers') AND NEW.wrbspecifier_2 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbspecifier_2. Must be present in id of wrbspecifiervalue codelist.');
END;

CREATE TRIGGER u_wrbspecifier_2
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers') AND NEW.wrbspecifier_2 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbspecifier_2. Must be present in id of wrbspecifiervalue codelist.');
END;
--


/* 
 ██████  ██████  ██████  ███████ ██      ██ ███████ ████████ 
██      ██    ██ ██   ██ ██      ██      ██ ██         ██    
██      ██    ██ ██   ██ █████   ██      ██ ███████    ██    
██      ██    ██ ██   ██ ██      ██      ██      ██    ██    
 ██████  ██████  ██████  ███████ ███████ ██ ███████    ██    
 */

-- soilsite
    -- soilinvestigationpurpose -> Codelist soilinvestigationpurposevalue
-- soilplot
    -- soilplottype -> Codelist soilplottypevalue
-- soilprofile   
    -- othersoilnametype -> Codelist othersoilnametypevalue
-- wrbsoilnametype
    --  wrbreferencesoilgroupvalue -> Codelist wrbreferencesoilgroupvalue
    --  wrbqualifierplacevalue -> Codelist wrbqualifierplacevalue
    --  wrbqualifiervalue -> Codelist wrbqualifiervalue
    --  wrbspecifiervalue -> Codelist wrbspecifiervalue
-- profileelement
    -- otherhorizonNotation -> Codelist otherhorizonnotationtypevalue
    -- layertype -> Codelist layertypevalue
    -- layergenesisenviroment -> Codelist eventenvironmentvalue 
    -- layergenesisprocess -> Codelist eventprocessvalue  
    -- layergenesisprocessstate -> Codelist layergenesisprocessstatevalue
    -- layerrocktype -> Codelist lithologyvalue 
-- faohorizonnotationtype
    -- faohorizonmaster -> Codelist faohorizonmastervalue
    -- faohorizonsubordinate -> Codelist faohorizonsubordinatevalue
    -- faoprime -> Codelist faoprimevalue
-- processparameter
    --name -> Codelist processparameternamevalue 
-- relatedparty
    -- role -> Codelist partyrolevalue 



-- Table Codelist --------------------------------------------------------------------------
CREATE TABLE codelist
(
    id                      TEXT UNIQUE,
    language                TEXT,
    label                   TEXT,
    definition              TEXT,
    description             TEXT,
    collection              TEXT,
    parent                  TEXT,
    successor               TEXT,
    predecessor             TEXT,
    registry                TEXT,
    register                TEXT,
    applicationschema       TEXT,
    theme                   TEXT,
    referencelink           TEXT,
    referencesource         TEXT,
    "governance-level-item" TEXT,
    status                  TEXT
);


--/**
------------------------------------------------------------------------------------------------------
--------------------------------   CODELIST LayerTypeValue     ---------------------------------------
------------------------------------------------------------------------------------------------------


-- Layer Type
-- URI
-- http://inspire.ec.europa.eu/codelist/LayerTypeValue
-- This version
-- http://inspire.ec.europa.eu/codelist/LayerTypeValue:1
-- Label
-- Layer Type
-- Definition
-- A classification of a layer according to the concept that fits the purpose.
-- Description
-- EXAMPLE Topsoil: meaning the upper part of the natural soil that is generally dark coloured and has a higher content of organic matter and nutrients when compared to the (mineral ) horizons below excluding the humus layer.
-- Extensibility item
-- Not extensible
-- Application Schema
-- Soil
-- Theme
-- Soil
-- Governance level
-- Legal (EU)
-- Status
-- Valid


INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/depthInterval', 'en', 'depth interval', 'Fixed depth range where soil is described and/or samples are taken.', 'They are often used in soil monitoring, sampling of contaminated sites and in modelling, and include:  • upper and lower limits of a soil horizon, or of a functional set of horizons • depth increments (also called fixed depths), that are often used for sampling, e.g. 0-30cm, 30-60cm, and so on, • a single depth range in which a soil sample is taken and for which the analytical result is valid, and • soil slicing, that is, profile segmentation according to a specified vector, for instance, either regularly spaced intervals (1cm), or a user-defined vector of segment boundaries (i.e. 0-10, 10-25, 25-50, 50-100). Slicing is used in modelling to generate continuous depth functions for soil properties.', 'http://inspire.ec.europa.eu/codelist/LayerTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic', 'en', 'geogenic', 'Domain of the soil profile composed of material resulting from the same, non-pedogenic process, e.g. sedimentation, that might display an unconformity to possible over- or underlying adjacent domains.', null, 'http://inspire.ec.europa.eu/codelist/LayerTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/subSoil', 'en', 'subsoil', 'Natural soil material below the topsoil and overlying the unweathered parent material.', 'SOURCE ISO 11074 NOTE The subsoil can be: (i) a grouping of one to several horizons underlying the horizons with recent humus accumulation from humifying biomass or (ii) a domain of a soil with a specific vertical extension starting well below the soil surface (e.g. 15-75 cm).', 'http://inspire.ec.europa.eu/codelist/LayerTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/topSoil', 'en', 'topsoil', 'Upper part of a natural soil that is generally dark coloured and has a higher content of organic matter and nutrients when compared to the (mineral) horizons below excluding the humus layer.', 'NOTE 1 For arable lands, topsoil refers to the ploughed soil depth; for grasslands, it is the soil layer with high root content. NOTE 2 The topsoil can be: (i) a grouping of one to several A horizons or (ii) a domain of a soil with a specific vertical extension starting from the surface (e.g. 0-15 cm). NOTE 3 In most soil description guidelines, the topsoil is composed of all A horizons occurring in a soil profile.', 'http://inspire.ec.europa.eu/codelist/LayerTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');


--/**
------------------------------------------------------------------------------------------------------
--------------------------------    CODELIST   eventprocessvalue     ---------------------------------
------------------------------------------------------------------------------------------------------


-- URI
-- http://inspire.ec.europa.eu/codelist/EventProcessValue
-- This version
-- http://inspire.ec.europa.eu/codelist/EventProcessValue:1
-- Label
-- Event Process
-- Definition
-- Terms specifying the process or processes that occurred during an event.
-- Description
-- EXAMPLE: deposition, extrusion, intrusion, cooling.
-- Extensibility item
-- Extensible with values at any level
-- Application Schema
-- Geology
-- Theme
-- Geology
-- Governance level
-- Legal (EU)
-- Status
-- Valid

--/

INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/bolideImpact', 'en', 'bolide impact', 'The impact of an extraterrestrial body on the surface of the earth.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/bolide_impact', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/cometaryImpact', 'en', 'cometary impact', 'the impact of a comet on the surface of the earth', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/bolideImpact', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/meteoriteImpact', 'en', 'meteorite impact', 'the impact of a meteorite on the surface of the earth', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/bolideImpact', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deepWaterOxygenDepletion', 'en', 'deep water oxygen depletion', 'Process of removal of oxygen from from the deep part of a body of water.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/deep_water_oxygen_depletion', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', 'en', 'deformation', 'Movement of rock bodies by displacement on fault or shear zones, or change in shape of a body of earth material.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/deformation', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/ductileFlow', 'en', 'ductile flow', 'deformation without apparent loss of continuity at the scale of observation.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/faulting', 'en', 'faulting', 'The process of fracturing, frictional slip, and displacement accumulation that produces a fault', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/folding', 'en', 'folding', 'deformation in which planar surfaces become regularly curviplanar surfaces with definable limbs (zones of lower curvature) and hinges (zones of higher curvature).', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/fracturing', 'en', 'fracturing', 'The formation of a surface of failure resulting from stress', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/shearing', 'en', 'shearing', 'A deformation in which contiguous parts of a body are displaced relatively to each other in a direction parallel to a surface. The surface may be a discrete fault, or the deformation may be a penetrative strain and the shear surface is a geometric abstraction.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/diageneticProcess', 'en', 'diagenetic process', 'Any chemical, physical, or biological process that affects a sedimentary earth material after initial deposition, and during or after lithification, exclusive of weathering and metamorphism.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/diagenetic_process', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/extinction', 'en', 'extinction', 'Process of disappearance of a species or higher taxon, so that it no longer exists anywhere or in the subsequent fossil record.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/extinction', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/geomagneticProcess', 'en', 'geomagnetic process', 'Process that results in change in Earth''s magnetic field.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/geomagnetic_process', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magneticFieldReversal', 'en', 'magnetic field reversal', 'geomagnetic event', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/geomagneticProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/polarWander', 'en', 'polar wander', 'process of migration of the axis of the earth''s dipole field relative to the rotation axis of the Earth.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/geomagneticProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/humanActivity', 'en', 'human activity', 'Processes of human modification of the earth to produce geologic features.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/human_activity', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/excavation', 'en', 'excavation', 'removal of material, as in a mining operation', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/humanActivity', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/grading', 'en', 'grading', 'leveling of earth surface by rearrangement of prexisting material', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/humanActivity', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/materialTransportAndDeposition', 'en', 'material transport and deposition', 'transport and heaping of material, as in a land fill, mine dump, dredging operations', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/humanActivity', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/mixing', 'en', 'mixing', 'Mixing', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/humanActivity', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticProcess', 'en', 'magmatic process', 'A process involving melted rock (magma).', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/magmatic_process', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/eruption', 'en', 'eruption', 'The ejection of volcanic materials (lava, pyroclasts, and volcanic gases) onto the Earth''s surface, either from a central vent or from a fissure or group of fissures', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/intrusion', 'en', 'intrusion', 'The process of emplacement of magma in pre-existing rock', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticCrystallisation', 'en', 'magmatic crystallisation', 'The process by which matter becomes crystalline, from a gaseous, fluid, or dispersed state', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/melting', 'en', 'melting', 'change of state from a solid to a liquid', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/metamorphicProcess', 'en', 'metamorphic process', 'Mineralogical, chemical, and structural adjustment of solid rocks to physical and chemical conditions that differ from the conditions under which the rocks in question originated, and are generally been imposed at depth, below the surface zones of weathering and cementation.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/metamorphic_process', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/alteration', 'en', 'alteration', 'General term for any change in the mineralogical or chemical composition of a rock. Typically related to interaction with hydrous fluids.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/metamorphicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/contactMetamorphism', 'en', 'contact metamorphism', 'Metamorphism taking place in rocks at or near their contact with a genetically related body of igneous rock', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/metamorphicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/dislocationMetamorphism', 'en', 'dislocation metamorphism', 'Metamorphism concentrated along narrow belts of shearing or crushing without an appreciable rise in temperature', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/metamorphicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelChange', 'en', 'sea level change', 'Process of mean sea level changing relative to some datum.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/sea_level_change', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelFall', 'en', 'sea level fall', 'process of mean sea level falling relative to some datum', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelChange', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelRise', 'en', 'sea level rise', 'process of mean sea level rising relative to some datum', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelChange', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/sedimentaryProcess', 'en', 'sedimentary process', 'A phenomenon that changes the distribution or physical properties of sediment at or near the earth''s surface.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/sedimentary_process', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deposition', 'en', 'deposition', 'Accumulation of material; the constructive process of accumulation of sedimentary particles, chemical precipitation of mineral matter from solution, or the accumulation of organicMaterial on the death of plants and animals.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/sedimentaryProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/erosion', 'en', 'erosion', 'The process of disaggregation of rock and displacement of the resultant particles (sediment) usually by the agents of currents such as, wind, water, or ice by downward or down-slope movement in response to gravity or by living organisms (in the case of bioerosion).', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/sedimentaryProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/speciation', 'en', 'speciation', 'Process that results inappearance of new species.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/speciation', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', 'en', 'tectonic process', 'Processes related to the interaction between or deformation of rigid plates forming the crust of the Earth.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/tectonic_process', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/accretion', 'en', 'accretion', 'The addition of material to a continent. Typically involves convergent or transform motion.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/continentalBreakup', 'en', 'continental breakup', 'Fragmentation of a continental plate into two or more smaller plates; may involve rifting or strike slip faulting.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/continentalCollision', 'en', 'continental collision', 'The amalgamation of two continental plates or blocks along a convergent margin.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/obduction', 'en', 'obduction', 'The overthrusting of continental crust by oceanic crust or mantle rocks at a convergent plate boundary.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/orogenicProcess', 'en', 'orogenic process', 'mountain building process.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/spreading', 'en', 'spreading', 'A process whereby new oceanic crust is formed by upwelling of magma at the center of mid-ocean ridges and by a moving-away of the new material from the site of upwelling at rates of one to ten centimeters per year.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/subduction', 'en', 'subduction', 'The process of one lithospheric plate descending beneath another', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/transformFaulting', 'en', 'transform faulting', 'A strike-slip fault that links two other faults or two other plate boundaries (e.g. two segments of a mid-ocean ridge). Transform faults often exhibit characteristics that distinguish them from transcurrent faults: (1) For transform faults formed at the same time as the faults they link, slip on the transform fault has equal magnitude at all points along the transform; slip magnitude on the transform fault can exceed the length of the transform fault, and slip does not decrease to zero at the fault termini. (2) For transform faults linking two similar features, e.g. if two mid-ocean ridge segments linked by a transform have equal spreading rates, then the length of the transform does not change as slip accrues on it.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/weathering', 'en', 'weathering', 'The process or group of processes by which earth materials exposed to atmospheric agents at or near the Earth''s surface are changed in color, texture, composition, firmness, or form, with little or no transport of the loosened or altered material. Processes typically include oxidation, hydration, and leaching of soluble constituents.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', 'http://resource.geosciml.org/classifier/cgi/eventprocess/weathering', 'CGI Controlled Vocabulary', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/biologicalWeathering', 'en', 'biological weathering', 'breakdown of rocks by biological agents, e.g. the penetrating and expanding force of roots, the presence of moss and lichen causing humic acids to be retained in contact with rock, and the work of animals (worms, moles, rabbits) in modifying surface soil', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/weathering', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/chemicalWeathering', 'en', 'chemical weathering', 'The process of weathering by which chemical reactions (hydrolysis, hydration, oxidation, carbonation, ion exchange, and solution) transform rocks and minerals into new chemical combinations that are stable under conditions prevailing at or near the Earth''s surface; e.g. the alteration of orthoclase to kaolinite.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/weathering', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/physicalWeathering', 'en', 'physical weathering', 'The process of weathering by which frost action, salt-crystal growth, absorption of water, and other physical processes break down a rock to fragments, involving no chemical change', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', 'http://inspire.ec.europa.eu/codelist/EventProcessValue/weathering', null, null, 'http://inspire.ec.europa.eu/registry', 'http://inspire.ec.europa.eu/codelist', 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deepPloughing', 'en', 'deep ploughing', 'mixing of loose surface material by ploughing deeper than frequently done during annual soil cultivation', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionByOrFromMovingIce', 'en', 'deposition by or from moving ice', 'Deposition of sediment from ice by melting or pushing. The material has been transported in the ice after entrainment in the moving ice or after deposition from other moving fluids on the ice.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionFromAir', 'en', 'deposition from air', 'Deposition of sediment from air, in which the sediment has been transported after entrainment in the moving air.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionFromWater', 'en', 'deposition from water', 'Deposition of sediment from water, in which the sediment has been transported after entrainment in the moving water or after deposition from other moving fluids.', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/digging', 'en', 'digging', 'repeated mixing of loose surface material by digging with a spade or similar tool', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/geologicProcess', 'en', 'geologic process', 'process that effects the geologic record', null, 'http://inspire.ec.europa.eu/codelist/EventProcessValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/ge', 'http://inspire.ec.europa.eu/theme/ge', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-technical', 'http://inspire.ec.europa.eu/registry/status/valid');






--/**
-----------------------------------------------------------------------------------------------------------
--------   CODELIST CREA  -------    CODELIST   eventenvironmentvalue     --------   CODELIST CREA  -------
-----------------------------------------------------------------------------------------------------------

-- Event Environment
-- URI
-- http://inspire.ec.europa.eu/codelist/EventEnvironmentValue
-- This version
-- http://inspire.ec.europa.eu/codelist/EventEnvironmentValue:1
-- Label
-- Event Environment
-- Definition
-- Terms for the geologic environments within which geologic events take place.
-- Extensibility item
-- Extensible with values at any level
-- Application Schema
-- Geology
-- Theme
-- Geology
-- Governance level
-- Legal (EU)
-- Status
-- Valid

INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/agriculturalAndForestryLandSetting''', null, 'agricultural and forestry land setting', 'Human influence setting with intensive agricultural activity or forestry land use,  including forest plantations.', 'Human influence setting with intensive agricultural activity or forestry land use,  including forest plantations.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/carbonateShelfSetting', null, 'carbonate shelf setting', 'A type of carbonate platform that is attached to a continental landmass and a region of sedimentation that is analogous to shelf environments for terrigenous clastic deposition. A carbonate shelf may receive some supply of material from the adjacent landmass.', 'A type of carbonate platform that is attached to a continental landmass and a region of sedimentation that is analogous to shelf environments for terrigenous clastic deposition. A carbonate shelf may receive some supply of material from the adjacent landmass.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaSlopeSetting', null, 'delta slope setting', 'Slope setting within the deltaic  system.', 'Slope setting within the deltaic  system.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dwellingAreaSetting', null, 'dwelling area setting', 'Dwelling area setting.', 'Dwelling area setting.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/earthInteriorSetting', null, 'earth interior setting', 'Geologic environments within the solid Earth.', 'Geologic environments within the solid Earth.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/earthSurfaceSetting', null, 'earth surface setting', 'Geologic environments on the surface of the solid Earth.', 'Geologic environments on the surface of the solid Earth.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/extraTerrestrialSetting', null, 'extra-terrestrial setting', 'Material originated outside of the Earth or its atmosphere.', 'Material originated outside of the Earth or its atmosphere.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/fanDeltaSetting', null, 'fan delta setting', 'A debris-flow or sheetflood-dominated alluvial fan build out into a lake or the sea.', 'A debris-flow or sheetflood-dominated alluvial fan build out into a lake or the sea.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/foreshore', null, 'foreshore', 'A foreshore is the region between mean high water and mean low water marks of the tides. Depending on the tidal range this may be a vertical distance of anything from a few tens of centimetres to many meters.', 'A foreshore is the region between mean high water and mean low water marks of the tides. Depending on the tidal range this may be a vertical distance of anything from a few tens of centimetres to many meters.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciofluvialSetting', null, 'glaciofluvial setting', 'A setting influenced by glacial meltwater streams. This setting can be sub- en-, supra- and proglacial.', 'A setting influenced by glacial meltwater streams. This setting can be sub- en-, supra- and proglacial.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciolacustrineSetting', null, 'glaciolacustrine setting', 'Ice margin lakes and other lakes related to glaciers. Where meltwater streams enter the lake, sands and gravels are deposited in deltas. At the lake floor, typivally rhythmites (varves) are deposited.Ice margin lakes and other lakes related to glaciers.', 'Ice margin lakes and other lakes related to glaciers. Where meltwater streams enter the lake, sands and gravels are deposited in deltas. At the lake floor, typivally rhythmites (varves) are deposited.Ice margin lakes and other lakes related to glaciers.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciomarineSetting', null, 'glaciomarine setting', 'A marine environment influenced by glaciers. Dropstone diamictons and dropstone muds are typical deposits in this environment.', 'A marine environment influenced by glaciers. Dropstone diamictons and dropstone muds are typical deposits in this environment.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/graben', null, 'graben', 'An elongate trough or basin, bounded on both sides by high-angle normal faults that dip toward one another. It is a structual form that may or may not be geomorphologically expressed as a rift valley.', 'An elongate trough or basin, bounded on both sides by high-angle normal faults that dip toward one another. It is a structual form that may or may not be geomorphologically expressed as a rift valley.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/halfGraben', null, 'half-graben', 'A elongate , asymmetric trough or basin bounded on one side by a normal fault.', 'A elongate , asymmetric trough or basin bounded on one side by a normal fault.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humanEnvironmentSetting', null, 'human environment setting', 'Human environment setting.', 'Human environment setting.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intracratonicSetting', null, 'intracratonic setting', 'A basin formed within the interior region  of a continent, away from plate boundaries.', 'A basin formed within the interior region  of a continent, away from plate boundaries.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/landReclamationSetting', null, 'land reclamation setting', '''Human influence setting making land capable of more intensive use by changing its general character, as by drainage of excessively wet land, irrigation of arid or semiarid land; or recovery of submerged land from seas, lakes and rivers, restoration after human-induced degradation by removing toxic substances.''', '''Human influence setting making land capable of more intensive use by changing its general character, as by drainage of excessively wet land, irrigation of arid or semiarid land; or recovery of submerged land from seas, lakes and rivers, restoration after human-induced degradation by removing toxic substances.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/miningAreaSetting', null, 'mining area setting', 'Human influence setting in which mineral resources are extracted from the ground.', 'Human influence setting in which mineral resources are extracted from the ground.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/saltPan', null, 'salt pan', 'A small, undrained, shallow depression in which water accumulates and evaporates, leaving a salt deposit.', 'A small, undrained, shallow depression in which water accumulates and evaporates, leaving a salt deposit.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tectonicallyDefinedSetting', null, 'tectonically defined setting', 'Setting defined by relationships to tectonic plates on or in the Earth.', 'Setting defined by relationships to tectonic plates on or in the Earth.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wasteAndMaterialDepositionAreaSetting', null, 'waste and material deposition area setting', 'Human influence setting in which non-natural or natural materials from elsewhere are deposited.', 'Human influence setting in which non-natural or natural materials from elsewhere are deposited.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wetToSubHumidSetting', null, 'wet to sub-humid setting', '''A Wet to sub-humid climate is according Thornthwaite''s climate classification system associated with rain forests (wet), forests (humid) and grassland (sub-humid).''', '''A Wet to sub-humid climate is according Thornthwaite''s climate classification system associated with rain forests (wet), forests (humid) and grassland (sub-humid).''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/fastSpreadingCenterSetting', null, 'fast spreading center setting', 'Spreading center at which the opening rate is greater than 100 mm per year.', 'Spreading center at which the opening rate is greater than 100 mm per year.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mediumRateSpreadingCenterSetting', null, 'medium-rate spreading center setting', 'Spreading center at which the opening rate is between 50 and 100 mm per year.', 'Spreading center at which the opening rate is between 50 and 100 mm per year.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/slowSpreadingCenterSetting', null, 'slow spreading center setting', 'Spreading center at which the opening rate is less than 50 mm per year.', 'Spreading center at which the opening rate is less than 50 mm per year.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dunefieldSetting', null, 'dunefield setting', '''Extensive deposits on sand in an area where the supply is abundant. As a characteristic, individual dunes somewhat resemble barchans but are highly irregular in shape and crowded; erg areas of the Sahara are an example.''', '''Extensive deposits on sand in an area where the supply is abundant. As a characteristic, individual dunes somewhat resemble barchans but are highly irregular in shape and crowded; erg areas of the Sahara are an example.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dustAccumulationSetting', null, 'dust accumulation setting', 'Setting in which finegrained particles accumulate, e.g. loess deposition.', 'Setting in which finegrained particles accumulate, e.g. loess deposition.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/sandPlainSetting', null, 'sand plain setting', 'A sand-covered plain dominated by aeolian processes.', 'A sand-covered plain dominated by aeolian processes.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/gibberPlainSetting', null, 'gibber plain setting', '''A desert plain strewn with wind-abraded pebbles, or gibbers; a gravelly desert.''', '''A desert plain strewn with wind-abraded pebbles, or gibbers; a gravelly desert.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marginalMarineSabkhaSetting', null, 'marginal marine sabkha setting', 'Setting characterized by arid to semi-arid conditions on restricted coastal plains mostly above normal high tide level, with evaporite-saline mineral, tidal-flood, and eolian deposits. Boundaries with intertidal setting and non-tidal terrestrial setting are gradational. (Jackson, 1997, p. 561).', 'Setting characterized by arid to semi-arid conditions on restricted coastal plains mostly above normal high tide level, with evaporite-saline mineral, tidal-flood, and eolian deposits. Boundaries with intertidal setting and non-tidal terrestrial setting are gradational. (Jackson, 1997, p. 561).', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/playaSetting', null, 'playa setting', 'The usually dry and nearly level plain that occupies the lowest parts of closed depressions, such as those occurring on intermontane basin floors. Temporary flooding occurs primarily in response to precipitation-runoff events.', 'The usually dry and nearly level plain that occupies the lowest parts of closed depressions, such as those occurring on intermontane basin floors. Temporary flooding occurs primarily in response to precipitation-runoff events.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierBeachSetting', null, 'barrier beach setting', '''A narrow, elongate sand or gravel ridge rising slightly above the high-tide level and extending generally parallel with the shore, but separated from it by a lagoon (Shepard, 1954, p.1904), estuary, or marsh; it is extended by longshore transport and is rarely more than several kilometers long.''', '''A narrow, elongate sand or gravel ridge rising slightly above the high-tide level and extending generally parallel with the shore, but separated from it by a lagoon (Shepard, 1954, p.1904), estuary, or marsh; it is extended by longshore transport and is rarely more than several kilometers long.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierLagoonSetting', null, 'barrier lagoon setting', 'A lagoon that is roughly parallel to the coast and is separated from the open ocean by a strip of land or by a barrier reef. Tidal influence is typically restricted and the lagoon is commonly hypersaline.', 'A lagoon that is roughly parallel to the coast and is separated from the open ocean by a strip of land or by a barrier reef. Tidal influence is typically restricted and the lagoon is commonly hypersaline.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerBathyalSetting', null, 'lower bathyal setting', 'The ocean environment at depths between 1000 and 3500 metres.', 'The ocean environment at depths between 1000 and 3500 metres.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleBathyalSetting', null, 'middle bathyal setting', 'The ocean environment at water depths between 600 and 1000 metres.', 'The ocean environment at water depths between 600 and 1000 metres.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperBathyalSetting', null, 'upper bathyal setting', 'The ocean environment at water depths between 200 and 600 metres.', 'The ocean environment at water depths between 200 and 600 metres.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/backreefSetting', null, 'backreef setting', '''The landward side of a reef. The term is often used adjectivally to refer to deposits within the restricted lagoon behind a barrier reef, such as the ''back-reef facies'' of lagoonal deposits. In some places, as on a platform-edge reef tract, ''back reef'' refers to the side of the reef away from the open sea, even though no land may be nearby.''', '''The landward side of a reef. The term is often used adjectivally to refer to deposits within the restricted lagoon behind a barrier reef, such as the ''back-reef facies'' of lagoonal deposits. In some places, as on a platform-edge reef tract, ''back reef'' refers to the side of the reef away from the open sea, even though no land may be nearby.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forereefSetting', null, 'forereef setting', '''The seaward side of a reef; the slope covered with deposits of coarse reef talus.''', '''The seaward side of a reef; the slope covered with deposits of coarse reef talus.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/reefFlatSetting', null, 'reef flat setting', 'A stony platform of reef rock, landward of the reef crest at or above the low tide level, occasionally with patches of living coral and associated organisms, and commonly strewn with coral fragments and coral sand.', 'A stony platform of reef rock, landward of the reef crest at or above the low tide level, occasionally with patches of living coral and associated organisms, and commonly strewn with coral fragments and coral sand.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/basinBogSetting', null, 'basin bog setting', 'An ombrotrophic or ombrogene peat/bog whose nutrient supply is exclusively from rain water (including snow and atmospheric fallout) therefore making nutrients extremely oligotrophic.', 'An ombrotrophic or ombrogene peat/bog whose nutrient supply is exclusively from rain water (including snow and atmospheric fallout) therefore making nutrients extremely oligotrophic.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/blanketBog', null, 'blanket bog', '''Topogeneous bog/peat whose moisture content is largely dependent on surface water. It is relatively rich in plant nutrients, nitrogen, and mineral matter, is mildly acidic to nearly neutral, and contains little or no cellulose; forms in topographic depressions with essential stagnat or non-moving minerotrophic water supply''', '''Topogeneous bog/peat whose moisture content is largely dependent on surface water. It is relatively rich in plant nutrients, nitrogen, and mineral matter, is mildly acidic to nearly neutral, and contains little or no cellulose; forms in topographic depressions with essential stagnat or non-moving minerotrophic water supply''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/collisionalSetting', null, 'collisional setting', 'ectonic setting in which two continental crustal plates impact and are sutured together after intervening oceanic crust is entirely consumed at a subduction zone separating the plates. Such collision typically involves major mountain forming events, exemplified by the modern Alpine and Himalayan mountain chains.', 'ectonic setting in which two continental crustal plates impact and are sutured together after intervening oceanic crust is entirely consumed at a subduction zone separating the plates. Such collision typically involves major mountain forming events, exemplified by the modern Alpine and Himalayan mountain chains.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forelandSetting', null, 'foreland setting', 'The exterior area of an orogenic belt where deformation occurs without significant metamorphism. Generally the foreland is closer to the continental interior than other portions of the orogenic belt are.', 'The exterior area of an orogenic belt where deformation occurs without significant metamorphism. Generally the foreland is closer to the continental interior than other portions of the orogenic belt are.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hinterlandTectonicSetting', null, 'hinterland tectonic setting', '''Tectonic setting in the internal part of an orogenic belt, characterized by plastic deformation of rocks accompanied by significant metamorphism, typically involving crystalline basement rocks. Typically denotes the most structurally thickened part of an orogenic belt, between a magmatic arc or collision zone and a more ''external'' foreland setting.''', '''Tectonic setting in the internal part of an orogenic belt, characterized by plastic deformation of rocks accompanied by significant metamorphism, typically involving crystalline basement rocks. Typically denotes the most structurally thickened part of an orogenic belt, between a magmatic arc or collision zone and a more ''external'' foreland setting.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerContinentalCrustalSetting', null, 'lower continental-crustal setting', 'Continental crustal setting characterized by upper amphibolite to granulite facies metamorphism, in situ melting, residual anhydrous metamorphic rocks, and ductile flow of rock bodies.', 'Continental crustal setting characterized by upper amphibolite to granulite facies metamorphism, in situ melting, residual anhydrous metamorphic rocks, and ductile flow of rock bodies.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleContinentalCrustSetting', null, 'middle continental crust setting', 'Continental crustal setting characterized by greenschist to upper amphibolite facies metamorphism, plutonic igneous rocks, and ductile deformation.', 'Continental crustal setting characterized by greenschist to upper amphibolite facies metamorphism, plutonic igneous rocks, and ductile deformation.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperContinentalCrustalSetting', null, 'upper continental crustal setting', 'Continental crustal setting dominated by non metamorphosed to low greenschist facies metamorphic rocks, and brittle deformation.', 'Continental crustal setting dominated by non metamorphosed to low greenschist facies metamorphic rocks, and brittle deformation.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalCrustalSetting', null, 'continental-crustal setting', '''That type of the Earth''s crust which underlies the continents and the continental shelves; it is equivalent to the sial and continental sima and ranges in thickness from about 25 km to more than 70 km under mountain ranges, averaging ~40 km. The density of the continental crust averages ~2.8 g/cm3 and is ~2.7 g.cm3 in the upper layer. The velocities of compressional seismic waves through it average ~6.5 km/s and are less than ~7.0 km/sec.''', '''That type of the Earth''s crust which underlies the continents and the continental shelves; it is equivalent to the sial and continental sima and ranges in thickness from about 25 km to more than 70 km under mountain ranges, averaging ~40 km. The density of the continental crust averages ~2.8 g/cm3 and is ~2.7 g.cm3 in the upper layer. The velocities of compressional seismic waves through it average ~6.5 km/s and are less than ~7.0 km/sec.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanicCrustalSetting', null, 'oceanic-crustal setting', '''That type of the Earth''s crust which underlies the ocean basins. The oceanic crust is 5-10 km thick; it has a density of 2.9 g/cm3, and compressional seismic-wave velocities travelling through it at 4-7.2 km/sec. Setting in crust produced by submarine volcanism at a mid ocean ridge.''', '''That type of the Earth''s crust which underlies the ocean basins. The oceanic crust is 5-10 km thick; it has a density of 2.9 g/cm3, and compressional seismic-wave velocities travelling through it at 4-7.2 km/sec. Setting in crust produced by submarine volcanism at a mid ocean ridge.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/transitionalCrustalSetting', null, 'transitional-crustal setting', 'Crust formed in the transition zone between continental and oceanic crust, during the history of continental rifting that culminates in the formation of a new ocean.', 'Crust formed in the transition zone between continental and oceanic crust, during the history of continental rifting that culminates in the formation of a new ocean.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaDistributaryChannelSetting', null, 'delta distributary channel setting', 'A divergent stream flowing away from the main stream and not returning to it, as in a delta or on an alluvial plain.', 'A divergent stream flowing away from the main stream and not returning to it, as in a delta or on an alluvial plain.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaDistributaryMouthSetting', null, 'delta distributary mouth setting', 'The mouth of a delta distributary channel where fluvial discharge moves from confined to unconfined flow conditions.', 'The mouth of a delta distributary channel where fluvial discharge moves from confined to unconfined flow conditions.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaFrontSetting', null, 'delta front setting', '''A narrow zone where deposition in deltas is most active, consisting of a continuous sheet of sand, and occurring within the effective depth of wave erosion (10 m or less). It is the zone separating the prodelta from the delta plain, and it may or may not be steep''''', '''A narrow zone where deposition in deltas is most active, consisting of a continuous sheet of sand, and occurring within the effective depth of wave erosion (10 m or less). It is the zone separating the prodelta from the delta plain, and it may or may not be steep''''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaPlainSetting', null, 'delta plain setting', '''The level or nearly level surface composing the landward part of a large or compound delta; strictly, an alluvial plain characterized by repeated channel bifurcation and divergence, multiple distributary channels, and interdistributary flood basins.''', '''The level or nearly level surface composing the landward part of a large or compound delta; strictly, an alluvial plain characterized by repeated channel bifurcation and divergence, multiple distributary channels, and interdistributary flood basins.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarineDeltaSetting', null, 'estuarine delta setting', 'A delta that has filled, or is in the process of filling, an estuary.', 'A delta that has filled, or is in the process of filling, an estuary.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/interdistributaryBaySetting', null, 'interdistributary bay setting', 'A pronounced indentation of the delta front between advancing stream distributaries, occupied by shallow water, and either open to the sea or partly enclosed by minor distributaries.', 'A pronounced indentation of the delta front between advancing stream distributaries, occupied by shallow water, and either open to the sea or partly enclosed by minor distributaries.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lacustrineDeltaSetting', null, 'lacustrine delta setting', 'The low, nearly flat, alluvial tract of land at or near the mouth of a river, commonly forming a triangular or fan-shaped plain of considerable area, crossed by many distributaries of the main river, perhaps extending beyond the general trend of the lake shore, resulting from the accumulation of sediment supplied by the river in such quantities that it is not removed by waves or currents. Most deltas are partly subaerial and partly below water.', 'The low, nearly flat, alluvial tract of land at or near the mouth of a river, commonly forming a triangular or fan-shaped plain of considerable area, crossed by many distributaries of the main river, perhaps extending beyond the general trend of the lake shore, resulting from the accumulation of sediment supplied by the river in such quantities that it is not removed by waves or currents. Most deltas are partly subaerial and partly below water.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/prodeltaSetting', null, 'prodelta setting', '''The part of a delta that is below the effective depth of wave erosion, lying beyond the delta front, and sloping gently down to the floor of the basin into which the delta is advancing and where clastic river sediment ceases to be a significant part of the basin-floor deposits; it is entirely below the water level.''', '''The part of a delta that is below the effective depth of wave erosion, lying beyond the delta front, and sloping gently down to the floor of the basin into which the delta is advancing and where clastic river sediment ceases to be a significant part of the basin-floor deposits; it is entirely below the water level.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerDeltaPlainSetting', null, 'lower delta plain setting', 'The part of a delta plain which is penetrated by saline water and is subject to tidal processes.', 'The part of a delta plain which is penetrated by saline water and is subject to tidal processes.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperDeltaPlainSetting', null, 'upper delta plain setting', 'The part of a delta plain essentially unaffected by basinal processes. They do not differ substantially from alluvial environments except that areas of swamp, marsh and lakes are usually more widespread and channels may bifurcate downstream.', 'The part of a delta plain essentially unaffected by basinal processes. They do not differ substantially from alluvial environments except that areas of swamp, marsh and lakes are usually more widespread and channels may bifurcate downstream.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/coastalDuneFieldSetting', null, 'coastal dune field setting', '''A dune field on low-lying land recently abandoned or built up by the sea; the dunes may ascend a cliff and travel inland.''', '''A dune field on low-lying land recently abandoned or built up by the sea; the dunes may ascend a cliff and travel inland.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/contactMetamorphicSetting', null, 'contact metamorphic setting', 'Metamorphism of country rock at the contact of an igneous body.', 'Metamorphism of country rock at the contact of an igneous body.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/crustalSetting', null, 'crustal setting', '''The outermost layer or shell of the Earth, defined according to various criteria, including seismic velocity, density and composition; that part of the Earth above the Mohorovicic discontinuity, made up of the sial and the sima.''', '''The outermost layer or shell of the Earth, defined according to various criteria, including seismic velocity, density and composition; that part of the Earth above the Mohorovicic discontinuity, made up of the sial and the sima.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/highPressureLowTemperatureEarthInteriorSetting', null, 'high pressure low temperature Earth interior setting', '''High pressure environment characterized by geothermal gradient significantly lower than standard continental geotherm; environment in which blueschist facies metamorphic rocks form. Typically associated with subduction zones.''', '''High pressure environment characterized by geothermal gradient significantly lower than standard continental geotherm; environment in which blueschist facies metamorphic rocks form. Typically associated with subduction zones.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hypabyssalSetting', null, 'hypabyssal setting', '''Igneous environment close to the Earth''s surface, characterized by more rapid cooling than plutonic setting to produce generally fine-grained intrusive igneous rock that is commonly associated with co-magmatic volcanic rocks.''', '''Igneous environment close to the Earth''s surface, characterized by more rapid cooling than plutonic setting to produce generally fine-grained intrusive igneous rock that is commonly associated with co-magmatic volcanic rocks.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowPressureHighTemperatureSetting', null, 'low pressure high temperature setting', 'Setting characterized by temperatures significantly higher that those associated with normal continental geothermal gradient.', 'Setting characterized by temperatures significantly higher that those associated with normal continental geothermal gradient.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mantleSetting', null, 'mantle setting', 'The zone of the Earth below the crust and above the core, which is divided into the upper mantle and the lower mantle, with a transition zone separating them.', 'The zone of the Earth below the crust and above the core, which is divided into the upper mantle and the lower mantle, with a transition zone separating them.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/regionalMetamorphicSetting', null, 'regional metamorphic setting', '''Metamorphism not obviously localized along contacts of igneous bodies; includes burial metamorphism and ocean ridge metamorphism.''', '''Metamorphism not obviously localized along contacts of igneous bodies; includes burial metamorphism and ocean ridge metamorphism.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/ultraHighPressureCrustalSetting', null, 'ultra high pressure crustal setting', 'Setting characterized by pressures characteristic of upper mantle, but indicated by mineral assemblage in crustal composition rocks.', 'Setting characterized by pressures characteristic of upper mantle, but indicated by mineral assemblage in crustal composition rocks.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/anoxicSetting', null, 'anoxic setting', 'Setting depleted in oxygen, typically subaqueous.', 'Setting depleted in oxygen, typically subaqueous.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aridOrSemiAridEnvironmentSetting', null, 'arid or Semi Arid environment setting', '''Setting characterized by mean annual precipitation of 10 inches (25 cm) or less. (Jackson, 1997, p. 172). Equivalent to SLTT ''Desert setting'', but use ''Arid'' to emphasize climatic nature of setting definition.''', '''Setting characterized by mean annual precipitation of 10 inches (25 cm) or less. (Jackson, 1997, p. 172). Equivalent to SLTT ''Desert setting'', but use ''Arid'' to emphasize climatic nature of setting definition.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/caveSetting', null, 'cave setting', '''A natural underground open space; it generally has a connection to the surface, is large enough for a person to enter, and extends into darkness. The most common type of cave is formed in limestone by dissolution.''', '''A natural underground open space; it generally has a connection to the surface, is large enough for a person to enter, and extends into darkness. The most common type of cave is formed in limestone by dissolution.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaicSystemSetting', null, 'deltaic system setting', 'Environments at the mouth of a river or stream that enters a standing body of water (ocean or lake). The delta forms a triangular or fan-shaped plain of considerable area. Subaerial parts of the delta are crossed by many distributaries of the main river,', 'Environments at the mouth of a river or stream that enters a standing body of water (ocean or lake). The delta forms a triangular or fan-shaped plain of considerable area. Subaerial parts of the delta are crossed by many distributaries of the main river,', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierRelatedSetting', null, 'glacier related setting', 'Earth surface setting with geography defined by spatial relationship to glaciers (e.g. on top of a glacier, next to a glacier, in front of a glacier...). Processes related to moving ice dominate sediment transport and deposition and landform development.', 'Earth surface setting with geography defined by spatial relationship to glaciers (e.g. on top of a glacier, next to a glacier, in front of a glacier...). Processes related to moving ice dominate sediment transport and deposition and landform development.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hillslopeSetting', null, 'hillslope setting', 'Earth surface setting characterized by surface slope angles high enough that gravity alone becomes a significant factor in geomorphic development, as well as base-of-slope areas influenced by hillslope processes. Hillslope activities include creep, sliding, slumping, falling, and other downslope movements caused by slope collapse induced by gravitational influence on earth materials. May be subaerial or subaqueous.', 'Earth surface setting characterized by surface slope angles high enough that gravity alone becomes a significant factor in geomorphic development, as well as base-of-slope areas influenced by hillslope processes. Hillslope activities include creep, sliding, slumping, falling, and other downslope movements caused by slope collapse induced by gravitational influence on earth materials. May be subaerial or subaqueous.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humidTemperateClimaticSetting', null, 'humid temperate climatic setting', 'Setting with seasonal climate having hot to cold or humid to arid seasons.', 'Setting with seasonal climate having hot to cold or humid to arid seasons.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humidTropicalClimaticSetting', null, 'humid tropical climatic setting', 'Setting with hot, humid climate influenced by equatorial air masses, no winter season.', 'Setting with hot, humid climate influenced by equatorial air masses, no winter season.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/polarClimaticSetting', null, 'polar climatic setting', 'Setting with climate dominated by temperatures below the freezing temperature of water. Includes polar deserts because precipitation is generally scant at high latitude. Climatically controlled by arctic air masses, cold dry environment with short summer.', 'Setting with climate dominated by temperatures below the freezing temperature of water. Includes polar deserts because precipitation is generally scant at high latitude. Climatically controlled by arctic air masses, cold dry environment with short summer.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/shorelineSetting', null, 'shoreline setting', 'Geologic settings characterized by location adjacent to the ocean or a lake. A zone of indefinite width (may be many kilometers), bordering a body of water that extends from the water line inland to the first major change in landform features. Includes settings that may be subaerial, intermittently subaqueous, or shallow subaqueous, but are intrinsically associated with the interface between land areas and water bodies.', 'Geologic settings characterized by location adjacent to the ocean or a lake. A zone of indefinite width (may be many kilometers), bordering a body of water that extends from the water line inland to the first major change in landform features. Includes settings that may be subaerial, intermittently subaqueous, or shallow subaqueous, but are intrinsically associated with the interface between land areas and water bodies.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subaerialSetting', null, 'subaerial setting', 'Setting at the interface between the solid earth and the atmosphere, includes some shallow subaqueous settings in river channels and playas. Characterized by conditions and processes, such as erosion, that exist or operate in the open air on or immediately adjacent to the land surface.', 'Setting at the interface between the solid earth and the atmosphere, includes some shallow subaqueous settings in river channels and playas. Characterized by conditions and processes, such as erosion, that exist or operate in the open air on or immediately adjacent to the land surface.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subaqueousSetting', null, 'subaqueous setting', 'Setting situated in or under permanent, standing water. Used for marine and lacustrine settings, but not for fluvial settings.', 'Setting situated in or under permanent, standing water. Used for marine and lacustrine settings, but not for fluvial settings.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/terrestrialSetting', null, 'terrestrial setting', 'Setting characterized by absence of direct marine influence. Most of the subaerial settings are also terrestrial, but lacustrine settings, while terrestrial, are not subaerial, so the subaerial settings are not included as subcategories.', 'Setting characterized by absence of direct marine influence. Most of the subaerial settings are also terrestrial, but lacustrine settings, while terrestrial, are not subaerial, so the subaerial settings are not included as subcategories.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wetlandSetting', null, 'wetland setting', 'Setting characterized by gentle surface slope, and at least intermittent presence of standing water, which may be fresh, brackish, or saline. Wetland may be terrestrial setting or shoreline setting.', 'Setting characterized by gentle surface slope, and at least intermittent presence of standing water, which may be fresh, brackish, or saline. Wetland may be terrestrial setting or shoreline setting.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarineLagoonSetting', null, 'estuarine lagoon setting', '''A lagoon produced by the temporary sealing of a river estuary by a storm barrier. Such lagoons are usually seasonal and exist until the river breaches the barrier; they occur in regions of low or spasmodic rainfall.''', '''A lagoon produced by the temporary sealing of a river estuary by a storm barrier. Such lagoons are usually seasonal and exist until the river breaches the barrier; they occur in regions of low or spasmodic rainfall.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalRiftSetting', null, 'continental rift setting', 'Extended terrane in a zone of continental breakup, may include incipient oceanic crust. Examples include Red Sea, East Africa Rift, Salton Trough.', 'Extended terrane in a zone of continental breakup, may include incipient oceanic crust. Examples include Red Sea, East Africa Rift, Salton Trough.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/englacialSetting', null, 'englacial setting', '''Contained, embedded, or carried within the body of a glacier or ice sheet; said of meltwater streams, till, drift, moraine.''', '''Contained, embedded, or carried within the body of a glacier or ice sheet; said of meltwater streams, till, drift, moraine.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacialOutwashPlainSetting', null, 'glacial outwash plain setting', '''A broad, gently sloping sheet of outwash deposited by meltwater streams flowing in front of or beyond a glacier, and formed by coalescing outwahs fans; the surface of a broad body of outwash.''', '''A broad, gently sloping sheet of outwash deposited by meltwater streams flowing in front of or beyond a glacier, and formed by coalescing outwahs fans; the surface of a broad body of outwash.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierLateralSetting''', null, 'glacier lateral setting', 'Settings adjacent to edges of confined glacier.', 'Settings adjacent to edges of confined glacier.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/proglacialSetting', null, 'proglacial setting', '''Immediately in front of or just beyond the outer limits of a glacier or ice sheet, generally at or near its lower end; said of lakes, streams, deposits, and other features produced by or derived from the glacier ice.''', '''Immediately in front of or just beyond the outer limits of a glacier or ice sheet, generally at or near its lower end; said of lakes, streams, deposits, and other features produced by or derived from the glacier ice.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subglacialSetting', null, 'subglacial setting', '''Formed or accumulated in or by the bottom parts of a glacier or ice sheet; said of meltwater streams, till, moraine, etc.''', '''Formed or accumulated in or by the bottom parts of a glacier or ice sheet; said of meltwater streams, till, moraine, etc.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/supraglacialSetting', null, 'supraglacial setting', '''''Carried upon, deposited from, or pertaining to the top surface of a glacier or ice sheet; said of meltwater streams, till, drift, etc. '' (Jackson, 1997, p. 639). Dreimanis (1988, p. 39) recommendation that ''supraglacial'' supersede ''superglacial'' is followed.''', '''''Carried upon, deposited from, or pertaining to the top surface of a glacier or ice sheet; said of meltwater streams, till, drift, etc. '' (Jackson, 1997, p. 639). Dreimanis (1988, p. 39) recommendation that ''supraglacial'' supersede ''superglacial'' is followed.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/inactiveSpreadingCenterSetting', null, 'inactive spreading center setting', 'Setting on oceanic crust formed at a spreading center that has been abandoned.', 'Setting on oceanic crust formed at a spreading center that has been abandoned.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/seamountSetting', null, 'seamount setting', 'Setting that consists of a conical mountain on the ocean floor (guyot). Typically characterized by active volcanism, pelagic sedimentation. If the mountain is high enough to reach the photic zone, carbonate production may result in reef building to produce a carbonate platform or atoll setting.', 'Setting that consists of a conical mountain on the ocean floor (guyot). Typically characterized by active volcanism, pelagic sedimentation. If the mountain is high enough to reach the photic zone, carbonate production may result in reef building to produce a carbonate platform or atoll setting.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/algalFlatSetting', null, 'algal flat setting', '''Modern ''algal flats are found on rock or mud in areas flooded only by the highest tides and are often subject to high evaporation rates. Algal flats survive only when an area is salty enough to eliminate snails and other herbivorous animals that eat algae, yet is not so salty that the algae cannot survive. The most common species of algae found on algal flats are blue-green algae of the genera Scytonema and Schizothrix. These algae can tolerate the daily extremes in temperature and oxygen that typify conditions on the flats. Other plants sometimes found on algal flats include one-celled green algae, flagellates, diatoms, bacteria, and isolated scrubby red and black mangroves, as well as patches of saltwort. Animals include false cerith, cerion snails, fiddler crabs, and great land crabs. Flats with well developed algal mats are restricted for the most part to the Keys, with Sugarloaf and Crane Keys offering prime examples of algal flat habitat.'' (Audubon, 1991)''', '''Modern ''algal flats are found on rock or mud in areas flooded only by the highest tides and are often subject to high evaporation rates. Algal flats survive only when an area is salty enough to eliminate snails and other herbivorous animals that eat algae, yet is not so salty that the algae cannot survive. The most common species of algae found on algal flats are blue-green algae of the genera Scytonema and Schizothrix. These algae can tolerate the daily extremes in temperature and oxygen that typify conditions on the flats. Other plants sometimes found on algal flats include one-celled green algae, flagellates, diatoms, bacteria, and isolated scrubby red and black mangroves, as well as patches of saltwort. Animals include false cerith, cerion snails, fiddler crabs, and great land crabs. Flats with well developed algal mats are restricted for the most part to the Keys, with Sugarloaf and Crane Keys offering prime examples of algal flat habitat.'' (Audubon, 1991)''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mudFlatSetting', null, 'mud flat setting', 'A relatively level area of fine grained material (e.g. silt) along a shore (as in a sheltered estuary or chenier-plain) or around an island, alternately covered and uncovered by the tide or covered by shallow water, and barren of vegetation. Includes most tidal flats, but lacks denotation of tidal influence.', 'A relatively level area of fine grained material (e.g. silt) along a shore (as in a sheltered estuary or chenier-plain) or around an island, alternately covered and uncovered by the tide or covered by shallow water, and barren of vegetation. Includes most tidal flats, but lacks denotation of tidal influence.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerMantleSetting', null, 'lower mantle setting', 'That part of the mantle that lies below a depth of about 660 km. With increasing depth, density increases from ~4.4 g/cm3 to ~5.6 g/cm3, and velocity of compressional seismic waves increases from ~10.7 km/s to ~13.7 km/s (Dziewonski and Anderson, 1981).', 'That part of the mantle that lies below a depth of about 660 km. With increasing depth, density increases from ~4.4 g/cm3 to ~5.6 g/cm3, and velocity of compressional seismic waves increases from ~10.7 km/s to ~13.7 km/s (Dziewonski and Anderson, 1981).', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperMantleSetting', null, 'upper mantle setting', 'That part of the mantle which lies above a depth of about 660 km and has a density of 3.4 g/cm3 to 4.0 g/cm3 with increasing depth. Similarly, P-wave velocity increases from about 8 to 11 km/sec with depth and S wave velocity increases from about 4.5 to 6 km/sec with depth. It is presumed to be peridotitic in composition. It includes the subcrustal lithosphere the asthenosphere and the transition zone.', 'That part of the mantle which lies above a depth of about 660 km and has a density of 3.4 g/cm3 to 4.0 g/cm3 with increasing depth. Similarly, P-wave velocity increases from about 8 to 11 km/sec with depth and S wave velocity increases from about 4.5 to 6 km/sec with depth. It is presumed to be peridotitic in composition. It includes the subcrustal lithosphere the asthenosphere and the transition zone.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aboveCarbonateCompensationDepthSetting', null, 'above carbonate compensation depth setting', 'Marine environment in which carbonate sediment does not dissolve before reaching the sea floor and can accumulate.', 'Marine environment in which carbonate sediment does not dissolve before reaching the sea floor and can accumulate.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/abyssalSetting', null, 'abyssal setting', 'The ocean environment at water depths between 3,500 and 6,000 metres.', 'The ocean environment at water depths between 3,500 and 6,000 metres.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/basinPlainSetting', null, 'basin plain setting', '''Near flat areas of ocean floor, slope less than 1:1000; generally receive only distal turbidite and pelagic sediments.''', '''Near flat areas of ocean floor, slope less than 1:1000; generally receive only distal turbidite and pelagic sediments.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/bathyalSetting', null, 'bathyal setting', 'The ocean environment at water depths between 200 and 3500 metres.', 'The ocean environment at water depths between 200 and 3500 metres.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/belowCarbonateCompensationDepthSetting', null, 'below carbonate compensation depth setting', 'Marine environment in which water is deep enough that carbonate sediment goes into solution before it can accumulate on the sea floor.', 'Marine environment in which water is deep enough that carbonate sediment goes into solution before it can accumulate on the sea floor.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/biologicalReefSetting', null, 'biological reef setting', '''A ridgelike or moundlike structure, layered or massive, built by sedentary calcareous organisms, esp. corals, and consisting mostly of their remains; it is wave-resistant and stands topographically above the surrounding contemporaneously deposited sediment.''', '''A ridgelike or moundlike structure, layered or massive, built by sedentary calcareous organisms, esp. corals, and consisting mostly of their remains; it is wave-resistant and stands topographically above the surrounding contemporaneously deposited sediment.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalBorderlandSetting', null, 'continental borderland setting', 'An area of the continental margin between the shoreline and the continental slope that is topographically more complex than the continental shelf. It is characterized by ridges and basins, some of which are below the depth of the continental shelf. An example is the southern California continental borderland (Jackson, 1997, p. 138).', 'An area of the continental margin between the shoreline and the continental slope that is topographically more complex than the continental shelf. It is characterized by ridges and basins, some of which are below the depth of the continental shelf. An example is the southern California continental borderland (Jackson, 1997, p. 138).', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalShelfSetting', null, 'continental shelf setting', '''That part of the ocean floor that is between the shoreline and the continental slope (or, when there is no noticeable continental slope, a depth of 200 m). It is characterized by its gentle slope of 0.1 degree (Jackson, 1997, p. 138). Continental shelves have a classic shoreline-shelf-slope profile termed ''clinoform''.''', '''That part of the ocean floor that is between the shoreline and the continental slope (or, when there is no noticeable continental slope, a depth of 200 m). It is characterized by its gentle slope of 0.1 degree (Jackson, 1997, p. 138). Continental shelves have a classic shoreline-shelf-slope profile termed ''clinoform''.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deepSeaTrenchSetting', null, 'deep sea trench setting', 'Deep ocean basin with steep (average 10 degrees) slope toward land, more gentle slope (average 5 degrees) towards the sea, and abundant seismic activity on landward side of trench. Does not denote water depth, but may be very deep.', 'Deep ocean basin with steep (average 10 degrees) slope toward land, more gentle slope (average 5 degrees) towards the sea, and abundant seismic activity on landward side of trench. Does not denote water depth, but may be very deep.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/epicontinentalMarineSetting', null, 'epicontinental marine setting', 'Marine setting situated within the interior of the continent, rather than at the edge of a continent.', 'Marine setting situated within the interior of the continent, rather than at the edge of a continent.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hadalSetting', null, 'hadal setting', 'The deepest oceanic environment, i.e., over 6,000 m in depth. Always in deep sea trench.', 'The deepest oceanic environment, i.e., over 6,000 m in depth. Always in deep sea trench.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marineCarbonatePlatformSetting', null, 'marine carbonate platform setting', 'A shallow submerged plateau separated from continental landmasses, on which high biological carbonate production rates produce enough sediment to maintain the platform surface near sea level. Grades into atoll as area becomes smaller and ringing coral reefs become more prominent part of the setting.', 'A shallow submerged plateau separated from continental landmasses, on which high biological carbonate production rates produce enough sediment to maintain the platform surface near sea level. Grades into atoll as area becomes smaller and ringing coral reefs become more prominent part of the setting.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/neriticSetting', null, 'neritic setting', 'The ocean environment at depths between low-tide level and 200 metres, or between low-tide level and approximately the edge of the continental shelf.', 'The ocean environment at depths between low-tide level and 200 metres, or between low-tide level and approximately the edge of the continental shelf.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanHighlandSetting', null, 'ocean highland setting', 'Broad category for subaqueous marine settings characterized by significant relief above adjacent sea floor.', 'Broad category for subaqueous marine settings characterized by significant relief above adjacent sea floor.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/slopeRiseSetting', null, 'slope-rise setting', 'The part of a subaqueous basin that is between a bordering shelf setting, which separate the basin from an adjacent landmass, and a very low-relief basin plain setting.', 'The part of a subaqueous basin that is between a bordering shelf setting, which separate the basin from an adjacent landmass, and a very low-relief basin plain setting.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/submarineFanSetting', null, 'submarine fan setting', 'Large fan-shaped cones of sediment on the ocean floor, generally associated with submarine canyons that provide sediment supply to build the fan.', 'Large fan-shaped cones of sediment on the ocean floor, generally associated with submarine canyons that provide sediment supply to build the fan.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/innerNeriticSetting', null, 'inner neritic setting', 'The ocean environment at depths between low tide level and 30 metres.', 'The ocean environment at depths between low tide level and 30 metres.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleNeriticSetting', null, 'middle neritic setting', 'The ocean environment at depths between 30 and 100 metres.', 'The ocean environment at depths between 30 and 100 metres.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/outerNeriticSetting', null, 'outer neritic setting', 'The ocean environment at depths between 100 meters and approximately the edge of the continental shelf or between 100 and 200 meters.', 'The ocean environment at depths between 100 meters and approximately the edge of the continental shelf or between 100 and 200 meters.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/midOceanRidgeSetting', null, 'mid ocean ridge setting', 'Ocean highland associated with a divergent continental margin (spreading center). Setting is characterized by active volcanism, locally steep relief, hydrothermal activity, and pelagic sedimentation.', 'Ocean highland associated with a divergent continental margin (spreading center). Setting is characterized by active volcanism, locally steep relief, hydrothermal activity, and pelagic sedimentation.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanicPlateauSetting', null, 'oceanic plateau setting', 'Region of elevated ocean crust that commonly rises to within 2-3 km of the surface above an abyssal sea floor that lies several km deeper. Climate and water depths are such that a marine carbonate platform does not develop.', 'Region of elevated ocean crust that commonly rises to within 2-3 km of the surface above an abyssal sea floor that lies several km deeper. Climate and water depths are such that a marine carbonate platform does not develop.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerOceanicCrustalSetting', null, 'lower oceanic-crustal setting', 'Setting characterized by dominantly intrusive mafic rocks, with sheeted dike complexes in upper part and gabbroic to ultramafic intrusive or metamorphic rocks in lower part.', 'Setting characterized by dominantly intrusive mafic rocks, with sheeted dike complexes in upper part and gabbroic to ultramafic intrusive or metamorphic rocks in lower part.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperOceanicCrustalSetting', null, 'upper oceanic crustal setting', 'Oceanic crustal setting dominated by extrusive rocks, abyssal oceanic sediment, with increasing mafic intrusive rock in lower part.', 'Oceanic crustal setting dominated by extrusive rocks, abyssal oceanic sediment, with increasing mafic intrusive rock in lower part.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/alluvialFanSetting', null, 'alluvial fan setting', '''A low, outspread, relatively flat to gently sloping mass of loose rock material, shaped like an open fan or a segment of a cone, deposited by a stream (esp. in a semiarid region) at the place where it issues from a narrow mountain valley upon a plain or broad valley, or where a tributary stream is near or at its junction with the main stream, or wherever a constriction in a valley abruptly ceases or the gradient of the stream suddenly decreases; it is steepest near the mouth of the valley where its apex points upstream, and it slopes gently and convexly outward with gradually decreasing gradient.''', '''A low, outspread, relatively flat to gently sloping mass of loose rock material, shaped like an open fan or a segment of a cone, deposited by a stream (esp. in a semiarid region) at the place where it issues from a narrow mountain valley upon a plain or broad valley, or where a tributary stream is near or at its junction with the main stream, or wherever a constriction in a valley abruptly ceases or the gradient of the stream suddenly decreases; it is steepest near the mouth of the valley where its apex points upstream, and it slopes gently and convexly outward with gradually decreasing gradient.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/alluvialPlainSetting', null, 'alluvial plain setting', '''An assemblage landforms produced by alluvial and fluvial processes (braided streams, terraces, etc.,) that form low gradient, regional ramps along the flanks of mountains and extend great distances from their sources (e.g., High Plains of North America). (NRCS GLOSSARY OF LANDFORM AND GEOLOGIC TERMS). A level or gently sloping tract or a slightly undulating land surface produced by extensive deposition of alluvium... Synonym-- wash plain;...river plain; aggraded valley plain;... (Jackson, 1997, p. 17). May include one or more River plain systems.''', '''An assemblage landforms produced by alluvial and fluvial processes (braided streams, terraces, etc.,) that form low gradient, regional ramps along the flanks of mountains and extend great distances from their sources (e.g., High Plains of North America). (NRCS GLOSSARY OF LANDFORM AND GEOLOGIC TERMS). A level or gently sloping tract or a slightly undulating land surface produced by extensive deposition of alluvium... Synonym-- wash plain;...river plain; aggraded valley plain;... (Jackson, 1997, p. 17). May include one or more River plain systems.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/pedimentSetting', null, 'pediment setting', '''A gently sloping erosional surface developed at the foot of a receding hill or mountain slope. The surface may be essentially bare, exposing earth material that extends beneath adjacent uplands; or it may be thinly mantled with alluvium and colluvium, ultimately in transit from upland front to basin or valley lowland. In hill-foot slope terrain the mantle is designated ''pedisediment.'' The term has been used in several geomorphic contexts: Pediments may be classed with respect to (a) landscape positions, for example, intermontane-basin piedmont or valley-border footslope surfaces (respectively, apron and terrace pediments (Cooke and Warren, 1973)); (b) type of material eroded, bedrock or regolith; or (c) combinations of the above. compare - Piedmont slope.''', '''A gently sloping erosional surface developed at the foot of a receding hill or mountain slope. The surface may be essentially bare, exposing earth material that extends beneath adjacent uplands; or it may be thinly mantled with alluvium and colluvium, ultimately in transit from upland front to basin or valley lowland. In hill-foot slope terrain the mantle is designated ''pedisediment.'' The term has been used in several geomorphic contexts: Pediments may be classed with respect to (a) landscape positions, for example, intermontane-basin piedmont or valley-border footslope surfaces (respectively, apron and terrace pediments (Cooke and Warren, 1973)); (b) type of material eroded, bedrock or regolith; or (c) combinations of the above. compare - Piedmont slope.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/activeContinentalMarginSetting', null, 'active continental margin setting', 'Plate margin setting on continental crust.', 'Plate margin setting on continental crust.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/activeSpreadingCenterSetting', null, 'active spreading center setting', 'Divergent plate margin at which new oceanic crust is being formed.', 'Divergent plate margin at which new oceanic crust is being formed.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forearcSetting', null, 'forearc setting', 'Tectonic setting between a subduction-related trench and a volcanic arc.', 'Tectonic setting between a subduction-related trench and a volcanic arc.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subductionZoneSetting', null, 'subduction zone setting', 'Tectonic setting at which a tectonic plate, usually oceanic, is moving down into the mantle beneath another overriding plate.', 'Tectonic setting at which a tectonic plate, usually oceanic, is moving down into the mantle beneath another overriding plate.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/transformPlateBoundarySetting', null, 'transform plate boundary setting', 'Plate boundary at which the adjacent plates are moving laterally relative to each other.', 'Plate boundary at which the adjacent plates are moving laterally relative to each other.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/volcanicArcSetting', null, 'volcanic arc setting', 'A generally curvillinear belt of volcanoes above a subduction zone.', 'A generally curvillinear belt of volcanoes above a subduction zone.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierTerminusSetting', null, 'glacier terminus setting', 'Region of sediment deposition at the glacier terminus due to melting of glacier ice, melt-out, ablation and flow till setting.', 'Region of sediment deposition at the glacier terminus due to melting of glacier ice, melt-out, ablation and flow till setting.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/braidedRiverChannelSetting', null, 'braided river channel setting', 'A stream that divides into or follows an interlacing or tangled network of several small branching and reuniting shallow channels separated from each other by ephemeral branch islands or channel bars, resembling in plan the strands of a complex braid. Such a stream is generally believed to indicate an inability to carry all of its load, such as an overloaded and aggrading stream flowing in a wide channel on a floodplain.', 'A stream that divides into or follows an interlacing or tangled network of several small branching and reuniting shallow channels separated from each other by ephemeral branch islands or channel bars, resembling in plan the strands of a complex braid. Such a stream is generally believed to indicate an inability to carry all of its load, such as an overloaded and aggrading stream flowing in a wide channel on a floodplain.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/meanderingRiverChannelSetting', null, 'meandering river channel setting', 'Produced by a mature stream swinging from side to side as it flows across its floodplain or shifts its course laterally toward the convex side of an original curve.', 'Produced by a mature stream swinging from side to side as it flows across its floodplain or shifts its course laterally toward the convex side of an original curve.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/abandonedRiverChannelSetting', null, 'abandoned river channel setting', 'A drainage channel along which runoff no longer occurs, as on an alluvial fan.', 'A drainage channel along which runoff no longer occurs, as on an alluvial fan.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/cutoffMeanderSetting', null, 'cutoff meander setting', 'The abandoned, bow- or horseshoe-shaped channel of a former meander, left when the stream formed a cutoff across a narrow meander neck. Note that these are typically lakes, thus also lacustrine.', 'The abandoned, bow- or horseshoe-shaped channel of a former meander, left when the stream formed a cutoff across a narrow meander neck. Note that these are typically lakes, thus also lacustrine.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/floodplainSetting', null, 'floodplain setting', 'The surface or strip of relatively smooth land adjacent to a river channel, constructed by the present river in its existing regimen and covered with water when the river overflows its banks. It is built of alluvium carried by the river during floods and deposited in the sluggish water beyond the influence of the swiftest current. A river has one floodplain and may have one or more terraces representing abandoned floodplains.', 'The surface or strip of relatively smooth land adjacent to a river channel, constructed by the present river in its existing regimen and covered with water when the river overflows its banks. It is built of alluvium carried by the river during floods and deposited in the sluggish water beyond the influence of the swiftest current. A river has one floodplain and may have one or more terraces representing abandoned floodplains.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/riverChannelSetting', null, 'river channel setting', '''The bed where a natural body of surface water flows or may flow; a natural passageway or depression of perceptible extent containing continuously or periodically flowing water, or forming a connecting link between two bodies of water; a watercourse.''', '''The bed where a natural body of surface water flows or may flow; a natural passageway or depression of perceptible extent containing continuously or periodically flowing water, or forming a connecting link between two bodies of water; a watercourse.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/springSetting', null, 'spring setting', 'Setting characterized by a place where groundwater flows naturally from a rock or the soil onto the land surface or into a water body.', 'Setting characterized by a place where groundwater flows naturally from a rock or the soil onto the land surface or into a water body.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierIslandCoastlineSetting', null, 'barrier island coastline setting', 'Setting meant to include all the various geographic elements typically associated with a barrier island coastline, including the barrier islands, and geomorphic/geographic elements that are linked by processes associated with the presence of the island (e.g. wash over fans, inlet channel, back barrier lagoon).''', 'Setting meant to include all the various geographic elements typically associated with a barrier island coastline, including the barrier islands, and geomorphic/geographic elements that are linked by processes associated with the presence of the island (e.g. wash over fans, inlet channel, back barrier lagoon).', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/beachSetting', null, 'beach setting', '''The unconsolidated material at the shoreline that covers a gently sloping zone, typically with a concave profile, extending landward from the low-water line to the place where there is a definite change in material or physiographic form (such as a cliff), or to the line of permanent vegetation (usually the effective limit of the highest storm waves); at the shore of a body of water, formed and washed by waves or tides, usually covered by sand or gravel, and lacking a bare rocky surface.''', '''The unconsolidated material at the shoreline that covers a gently sloping zone, typically with a concave profile, extending landward from the low-water line to the place where there is a definite change in material or physiographic form (such as a cliff), or to the line of permanent vegetation (usually the effective limit of the highest storm waves); at the shore of a body of water, formed and washed by waves or tides, usually covered by sand or gravel, and lacking a bare rocky surface.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/carbonateDominatedShorelineSetting', null, 'carbonate dominated shoreline setting', 'A shoreline setting in which terrigenous input is minor compared to local carbonate sediment production. Constructional biogenic activity is an important element in geomorphic development.', 'A shoreline setting in which terrigenous input is minor compared to local carbonate sediment production. Constructional biogenic activity is an important element in geomorphic development.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/coastalPlainSetting', null, 'coastal plain setting', 'A low relief plain bordering a water body extending inland to the nearest elevated land, sloping very gently towards the water body. Distinguished from alluvial plain by presence of relict shoreline-related deposits or morphology.', 'A low relief plain bordering a water body extending inland to the nearest elevated land, sloping very gently towards the water body. Distinguished from alluvial plain by presence of relict shoreline-related deposits or morphology.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarySetting', null, 'estuary setting', 'Environments at the seaward end or the widened funnel-shaped tidal mouth of a river valley where fresh water comes into contact with seawater and where tidal effects are evident (adapted from Glossary of Geology, Jackson, 1997, p. 217).', 'Environments at the seaward end or the widened funnel-shaped tidal mouth of a river valley where fresh water comes into contact with seawater and where tidal effects are evident (adapted from Glossary of Geology, Jackson, 1997, p. 217).', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lagoonalSetting', null, 'lagoonal setting', '''A shallow stretch of salt or brackish water, partly or completely separated from a sea or lake by an offshore reef, barrier island, sand or spit (Jackson, 1997). Water is shallow, tidal and wave-produced effects on sediments; strong light reaches sediment.''', '''A shallow stretch of salt or brackish water, partly or completely separated from a sea or lake by an offshore reef, barrier island, sand or spit (Jackson, 1997). Water is shallow, tidal and wave-produced effects on sediments; strong light reaches sediment.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowEnergyShorelineSetting', null, 'low energy shoreline setting', 'Settings characterized by very low surface slope and proximity to shoreline. Generally within peritidal setting, but characterized by low surface gradients and generally low-energy sedimentary processes.', 'Settings characterized by very low surface slope and proximity to shoreline. Generally within peritidal setting, but characterized by low surface gradients and generally low-energy sedimentary processes.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/rockyCoastSetting', null, 'rocky coast setting', 'Shoreline with significant relief and abundant rock outcrop.', 'Shoreline with significant relief and abundant rock outcrop.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/strandplainSetting', null, 'strandplain setting', 'A prograded shore built seaward by waves and currents, and continuous for some distance along the coast. It is characterized by subparallel beach ridges and swales, in places with associated dunes.', 'A prograded shore built seaward by waves and currents, and continuous for some distance along the coast. It is characterized by subparallel beach ridges and swales, in places with associated dunes.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/supratidalSetting', null, 'supratidal setting', 'Pertaining to the shore area marginal to the littoral zone, just above high-tide level.', 'Pertaining to the shore area marginal to the littoral zone, just above high-tide level.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalSetting', null, 'tidal setting', 'Setting subject to tidal processes.', 'Setting subject to tidal processes.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aeolianProcessSetting', null, 'aeolian process setting', 'Sedimentary setting in which wind is the dominant process producing, transporting, and depositing sediment. Typically has low-relief plain or piedmont slope physiography.', 'Sedimentary setting in which wind is the dominant process producing, transporting, and depositing sediment. Typically has low-relief plain or piedmont slope physiography.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/piedmontSlopeSystemSetting', null, 'piedmont slope system setting', '''Location on gentle slope at the foot of a mountain; generally used in terms of intermontane-basin terrain. Main components include: (a) An erosional surface on bedrock adjacent to the receding mountain front (pediment, rock pediment); (b) A constructional surface comprising individual alluvial fans and interfan valleys, also near the mountain front; and (c) A distal complex of coalescent fans (bajada), and alluvial slopes without fan form. Piedmont slopes grade to basin-floor depressions with alluvial and temporary lake plains or to surfaces associated with through drainage.''', '''Location on gentle slope at the foot of a mountain; generally used in terms of intermontane-basin terrain. Main components include: (a) An erosional surface on bedrock adjacent to the receding mountain front (pediment, rock pediment); (b) A constructional surface comprising individual alluvial fans and interfan valleys, also near the mountain front; and (c) A distal complex of coalescent fans (bajada), and alluvial slopes without fan form. Piedmont slopes grade to basin-floor depressions with alluvial and temporary lake plains or to surfaces associated with through drainage.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intertidalSetting', null, 'intertidal setting', '''Pertaining to the benthic ocean environment or depth zone between high water and low water; also, pertaining to the organisms of that environment.''', '''Pertaining to the benthic ocean environment or depth zone between high water and low water; also, pertaining to the organisms of that environment.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marineSetting', null, 'marine setting', 'Setting characterized by location under the surface of the sea.', 'Setting characterized by location under the surface of the sea.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalChannelSetting', null, 'tidal channel setting', 'A major channel followed by the tidal currents, extending from offshore into a tidal marsh or a tidal flat.', 'A major channel followed by the tidal currents, extending from offshore into a tidal marsh or a tidal flat.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalMarshSetting', null, 'tidal marsh setting', '''A marsh bordering a coast (as in a shallow lagoon or sheltered bay), formed of mud and of the resistant mat of roots of salt-tolerant plants, and regularly inundated during high tides; a marshy tidal flat.''', '''A marsh bordering a coast (as in a shallow lagoon or sheltered bay), formed of mud and of the resistant mat of roots of salt-tolerant plants, and regularly inundated during high tides; a marshy tidal flat.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/backArcSetting', null, 'back arc setting', 'Tectonic setting adjacent to a volcanic arc formed above a subduction zone. The back arc setting is on the opposite side of the volcanic arc from the trench at which oceanic crust is consumed in a subduction zone. Back arc setting includes terrane that is affected by plate margin and arc-related processes.', 'Tectonic setting adjacent to a volcanic arc formed above a subduction zone. The back arc setting is on the opposite side of the volcanic arc from the trench at which oceanic crust is consumed in a subduction zone. Back arc setting includes terrane that is affected by plate margin and arc-related processes.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/extendedTerraneSetting', null, 'extended terrane setting', 'Tectonic setting characterized by extension of the upper crust, manifested by formation of rift valleys or basin and range physiography, with arrays of low to high angle normal faults. Modern examples include the North Sea, East Africa, and the Basin and Range of the North American Cordillera. Typically applied in continental crustal settings.', 'Tectonic setting characterized by extension of the upper crust, manifested by formation of rift valleys or basin and range physiography, with arrays of low to high angle normal faults. Modern examples include the North Sea, East Africa, and the Basin and Range of the North American Cordillera. Typically applied in continental crustal settings.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hotSpotSetting', null, 'hot spot setting', 'Setting in a zone of high heat flow from the mantle. Typically identified in intraplate settings, but hot spot may also interact with active plate margins (Iceland...). Includes surface manifestations like volcanic center, but also includes crust and mantle manifestations as well.', 'Setting in a zone of high heat flow from the mantle. Typically identified in intraplate settings, but hot spot may also interact with active plate margins (Iceland...). Includes surface manifestations like volcanic center, but also includes crust and mantle manifestations as well.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intraplateTectonicSetting', null, 'intraplate tectonic setting', 'Tectonically stable setting far from any active plate margins.', 'Tectonically stable setting far from any active plate margins.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/passiveContinentalMarginSetting', null, 'passive continental margin setting', 'Boundary of continental crust into oceanic crust of an oceanic basin that is not a subduction zone or transform fault system. Generally is rifted margin formed when ocean basin was initially formed.', 'Boundary of continental crust into oceanic crust of an oceanic basin that is not a subduction zone or transform fault system. Generally is rifted margin formed when ocean basin was initially formed.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/plateMarginSetting', null, 'plate margin setting', 'Tectonic setting at the boundary between two tectonic plates.', 'Tectonic setting at the boundary between two tectonic plates.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/plateSpreadingCenterSetting', null, 'plate spreading center setting', 'Tectonic setting where new oceanic crust is being or has been formed at a divergent plate boundary. Includes active and inactive spreading centers.', 'Tectonic setting where new oceanic crust is being or has been formed at a divergent plate boundary. Includes active and inactive spreading centers.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/bogSetting', null, 'bog setting', 'Waterlogged, spongy ground, consisting primarily of mosses, containing acidic, decaying vegetation that may develop into peat.', 'Waterlogged, spongy ground, consisting primarily of mosses, containing acidic, decaying vegetation that may develop into peat.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lacustrineSetting', null, 'lacustrine setting', 'Setting associated with a lake. Always overlaps with terrestrial, may overlap with subaerial, subaqueous, or shoreline.', 'Setting associated with a lake. Always overlaps with terrestrial, may overlap with subaerial, subaqueous, or shoreline.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/riverPlainSystemSetting', null, 'river plain system setting', '''Geologic setting dominated by a river system; river plains may occur in any climatic setting. Includes active channels, abandoned channels, levees, oxbow lakes, flood plain. May be part of an alluvial plain that includes terraces composed of abandoned river plain deposits.''', '''Geologic setting dominated by a river system; river plains may occur in any climatic setting. Includes active channels, abandoned channels, levees, oxbow lakes, flood plain. May be part of an alluvial plain that includes terraces composed of abandoned river plain deposits.''', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalFlatSetting', null, 'tidal flat setting', 'An extensive, nearly horizontal, barren tract of land that is alternately covered and uncovered by the tide, and consisting of unconsolidated sediment (mostly mud and sand). It may form the top surface of a deltaic deposit.', 'An extensive, nearly horizontal, barren tract of land that is alternately covered and uncovered by the tide, and consisting of unconsolidated sediment (mostly mud and sand). It may form the top surface of a deltaic deposit.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/swampOrMarshSetting', null, 'swamp or marsh setting', 'A water-saturated, periodically wet or continually flooded area with the surface not deeply submerged, essentially without the formation of peat. Marshes are characterized by sedges, cattails, rushes, or other aquatic and grasslike vegetation. Swamps are characterized by tree and brush vegetation.', 'A water-saturated, periodically wet or continually flooded area with the surface not deeply submerged, essentially without the formation of peat. Marshes are characterized by sedges, cattails, rushes, or other aquatic and grasslike vegetation. Swamps are characterized by tree and brush vegetation.', 'http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue', null, 'Event Environment', 'Terms for the geologic environments within which geologic events take place.', 'Terms for the geologic environments within which geologic events take place.', 'http://inspire.ec.europa.eu/codelist', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES (null, null, 'Export of entity selection', null, null, null, null, null, null, null, null, null, null, null, null, null, null);









--/**
------------------------------------------------------------------------------------------------------
------------------------    CODELIST   layergenesisprocessstatevalue     -----------------------------
------------------------------------------------------------------------------------------------------

-- Layer Genesis Process State
-- URI
-- http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue
-- This version
-- http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue:1
-- Label
-- Layer Genesis Process State
-- Definition
-- An indication whether the process specified in layerGenesisProcess is ongoing or has ceased.
-- Description
-- Process state gives an idea whether current non-pedogenic processes affect the soil or not. E.g. on current floodplains, input of sediments during seasonal flooding events is received, with comparatively young soil development in it, while in older fluvial sediments that are no longer under a regime of seasonal or irregular flooding, soil development might be more advanced.
-- Extensibility item
-- Not extensible
-- Application Schema
-- Soil
-- Theme
-- Soil
-- Governance level
-- Legal (EU)
-- Status
-- Valid

INSERT INTO codelist(ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue/ongoing', 'en', 'on-going', 'The process has started in the past and is still active.', 'Synonym: current', 'http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist(ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue/terminated', 'en', 'terminated', 'The process is no longer active.', null, 'http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');


--/**
------------------------------------------------------------------------------------------------------
---------------------------------    CODELIST   lithologyvalue     -----------------------------------
------------------------------------------------------------------------------------------------------

-- Lithology
-- URI
-- http://inspire.ec.europa.eu/codelist/LithologyValue
-- This version
-- http://inspire.ec.europa.eu/codelist/LithologyValue:1
-- Label
-- Lithology
-- Definition
-- Terms describing the lithology.
-- Description
-- EXAMPLE: granite, sandstone, schist.
-- Extensibility item
-- Extensible with values at any level
-- Application Schema
-- Geology
-- Theme
-- Geology
-- Governance level
-- Legal (EU)
-- Status
-- Valid


INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/acidicIgneousMaterial', null, 'acidicIgneousMaterial', 'acidicIgneousMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/acidicIgneousRock', null, 'acidicIgneousRock', 'acidicIgneousRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/alkaliFeldsparRhyolite', null, 'alkaliFeldsparRhyolite', 'alkaliFeldsparRhyolite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/amphibolite', null, 'amphibolite', 'amphibolite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/anthropogenicMaterial', null, 'anthropogenicMaterial', 'anthropogenicMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/ashAndLapilli', null, 'ashAndLapilli', 'ashAndLapilli', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/ashBrecciaBombOrBlockTephra', null, 'ashBrecciaBombOrBlockTephra', 'ashBrecciaBombOrBlockTephra', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/basicIgneousMaterial', null, 'basicIgneousMaterial', 'basicIgneousMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/boulderGravelSizeSediment', null, 'boulderGravelSizeSediment', 'boulderGravelSizeSediment', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/breccia', null, 'breccia', 'breccia', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateMudstone', null, 'carbonateMudstone', 'carbonateMudstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateRichMudstone', null, 'carbonateRichMudstone', 'carbonateRichMudstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateSedimentaryMaterial', null, 'carbonateSedimentaryMaterial', 'carbonateSedimentaryMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateSedimentaryRock', null, 'carbonateSedimentaryRock', 'carbonateSedimentaryRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/cataclasiteSeries', null, 'cataclasiteSeries', 'cataclasiteSeries', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chalk', null, 'chalk', 'chalk', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chemicalSedimentaryMaterial', null, 'chemicalSedimentaryMaterial', 'chemicalSedimentaryMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chloriteActinoliteEpidoteMetamorphicRock', null, 'chloriteActinoliteEpidoteMetamorphicRock', 'chloriteActinoliteEpidoteMetamorphicRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/clasticSedimentaryMaterial', null, 'clasticSedimentaryMaterial', 'clasticSedimentaryMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/crystallineCarbonate', null, 'crystallineCarbonate', 'crystallineCarbonate', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/dacite', null, 'dacite', 'dacite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/dolomite', null, 'dolomite', 'dolomite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/eclogite', null, 'eclogite', 'eclogite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/foliatedMetamorphicRock', null, 'foliatedMetamorphicRock', 'foliatedMetamorphicRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/fragmentalIgneousMaterial', null, 'fragmentalIgneousMaterial', 'fragmentalIgneousMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/framestone', null, 'framestone', 'framestone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericConglomerate', null, 'genericConglomerate', 'genericConglomerate', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericMudstone', null, 'genericMudstone', 'genericMudstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericSandstone', null, 'genericSandstone', 'genericSandstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/gneiss', null, 'gneiss', 'gneiss', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/grainstone', null, 'grainstone', 'grainstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granite', null, 'granite', 'granite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granodiorite', null, 'granodiorite', 'granodiorite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granofels', null, 'granofels', 'granofels', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granulite', null, 'granulite', 'granulite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hornfels', null, 'hornfels', 'hornfels', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hybridSediment', null, 'hybridSediment', 'hybridSediment', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hybridSedimentaryRock', null, 'hybridSedimentaryRock', 'hybridSedimentaryRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/igneousMaterial', null, 'igneousMaterial', 'igneousMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/igneousRock', null, 'igneousRock', 'igneousRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureCarbonateSedimentaryRock', null, 'impureCarbonateSedimentaryRock', 'impureCarbonateSedimentaryRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureDolomite', null, 'impureDolomite', 'impureDolomite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureLimestone', null, 'impureLimestone', 'impureLimestone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/intermediateCompositionIgneousMaterial', null, 'intermediateCompositionIgneousMaterial', 'intermediateCompositionIgneousMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/limestone', null, 'limestone', 'limestone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/marble', null, 'marble', 'marble', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/materialFormedInSurficialEnvironment', null, 'materialFormedInSurficialEnvironment', 'materialFormedInSurficialEnvironment', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/metamorphicRock', null, 'metamorphicRock', 'metamorphicRock', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/micaSchist', null, 'micaSchist', 'micaSchist', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/migmatite', null, 'migmatite', 'migmatite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/mineDumpMaterial', null, 'mineDumpMaterial', 'mineDumpMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/monzogranite', null, 'monzogranite', 'monzogranite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/mudSizeSediment', null, 'mudSizeSediment', 'mudSizeSediment', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/naturalUnconsolidatedMaterial', null, 'naturalUnconsolidatedMaterial', 'naturalUnconsolidatedMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/nonClasticSiliceousSedimentaryMaterial', null, 'nonClasticSiliceousSedimentaryMaterial', 'nonClasticSiliceousSedimentaryMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/organicBearingMudstone', null, 'organicBearingMudstone', 'organicBearingMudstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/organicRichSedimentaryMaterial', null, 'organicRichSedimentaryMaterial', 'organicRichSedimentaryMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/packstone', null, 'packstone', 'packstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/peat', null, 'peat', 'peat', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/phyllite', null, 'phyllite', 'phyllite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/sandSizeSediment', null, 'sandSizeSediment', 'sandSizeSediment', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/silicateMudstone', null, 'silicateMudstone', 'silicateMudstone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/skarn', null, 'skarn', 'skarn', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/slate', null, 'slate', 'slate', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/syenogranite', null, 'syenogranite', 'syenogranite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tephra', null, 'tephra', 'tephra', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tonalite', null, 'tonalite', 'tonalite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tuffite', null, 'tuffite', 'tuffite', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/unconsolidatedMaterial', null, 'unconsolidatedMaterial', 'unconsolidatedMaterial', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/waste', null, 'waste', 'waste', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', null, 'https://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', 'https://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', null, 'http://inspire.ec.europa.eu/codelist/LithologyValue', null, null, null, null, null, null, null, null, null, null, null);


------------------------------------------------------------------------------------------------------
--------   CODELIST CREA  -------  CODELIST faohorizonmastervalue  --------   CODELIST CREA  ---------
------------------------------------------------------------------------------------------------------

INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/A', 'en', 'A', 'A horizons', 'A horizons', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/B', 'en', 'B', 'B horizons', 'B horizons', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/C', 'en', 'C', 'C horizons or layers', 'C horizons or layers', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/E', 'en', 'E', 'E horizons', 'E horizons', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/H', 'en', 'H', 'H horizons or layers', 'H horizons or layers', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/I', 'en', 'I', 'I layers', 'I layers', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/L', 'en', 'L', 'L layers', 'L layers', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/O', 'en', 'O', 'O horizons or layers', 'O horizons or layers', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/R', 'en', 'R', 'R layers', 'R layers', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster/W', 'en', 'W', 'W layers', 'W layers', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);

------------------------------------------------------------------------------------------------------
-----   CODELIST CREA  -----     CODELIST faohorizonsubordinatevalue    -----   CODELIST CREA  -------
------------------------------------------------------------------------------------------------------

INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/k', 'en', 'k', 'Accumulation of carbonates', 'Accumulation of carbonates', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/y', 'en', 'y', 'Accumulation of gypsum', 'Accumulation of gypsum', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/j', 'en', 'j', 'Accumulation of jarosite', 'Accumulation of jarosite', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/z', 'en', 'z', 'Accumulation of salts more soluble than gypsum', 'Accumulation of salts more soluble than gypsum', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/q', 'en', 'q', 'Accumulation of pedogenetic silica', 'Accumulation of pedogenetic silica', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/t', 'en', 't', 'Accumulation of silicate clay', 'Accumulation of silicate clay', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/n', 'en', 'n', 'Accumulation of sodium', 'Accumulation of sodium', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/b', 'en', 'b', 'Buried genetic horizon', 'Buried genetic horizon', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/l', 'en', 'l', 'Capillary fringe mottling (gleying)', 'Capillary fringe mottling (gleying)', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/m', 'en', 'm', 'Cementation or induration', 'Cementation or induration', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/c', 'en', 'c', 'concretions or nodules', 'concretions or nodules', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/Lc', 'en', 'Lc', 'Coprogenic material (only with L)', 'Coprogenic material (only with L)', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/w', 'en', 'w', 'Development of color or structure', 'Development of color or structure', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/Ld', 'en', 'Ld', 'Diatomaceous earth (only with L)', 'Diatomaceous earth (only with L)', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/@', 'en', '@', 'evidence of cryoturbation', 'evidence of cryoturbation', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/x', 'en', 'x', 'Fragipan character', 'Fragipan character', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/f', 'en', 'f', 'Frozen soil or water', 'Frozen soil or water', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/r', 'en', 'r', 'Strong reduction', 'Strong reduction', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/a', 'en', 'a', 'highly decomposed organic material', 'highly decomposed organic material', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/u', 'en', 'u', 'human artifacts', 'human artifacts', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/h', 'en', 'h', 'Illuvial accumulation of organic matter', 'Illuvial accumulation of organic matter', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/s', 'en', 's', 'Illuvial accumulation of sesquioxides and organic matter', 'Illuvial accumulation of sesquioxides and organic matter', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/Lm', 'en', 'Lm', 'limnic marl (only with L)', 'limnic marl (only with L)', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/e', 'en', 'e', 'Organic material of intermediate decomposition', 'Organic material of intermediate decomposition', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/d', 'en', 'd', 'Physical root restriction', 'Physical root restriction', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/v', 'en', 'v', 'Plinthite', 'Plinthite', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/o', 'en', 'o', 'Residual accumulation of sesquioxides', 'Residual accumulation of sesquioxides', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/i', 'en', 'i', 'slickensides', 'slickensides', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/Hi', 'en', 'Hi', 'Slightly decomposed organic material', 'Slightly decomposed organic material', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/g', 'en', 'g', 'Stagnic conditions', 'Stagnic conditions', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate/p', 'en', 'p', 'Ploughing or other human disturbance', 'Ploughing or other human disturbance', 'https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);

------------------------------------------------------------------------------------------------------
---- CODELIST CREA -----------      CODELIST faoprimevalue       ----------  CODELIST CREA  ----------
------------------------------------------------------------------------------------------------------

INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOPrime/14375', 'en', '''''''''', 'A prime is used with the master horizon symbol of the lower of two horizons having identical letter designations. The prime is applied to the capital letter designation, and any lower case symbol follows it.', 'A prime is used with the master horizon symbol of the lower of two horizons having identical letter designations. The prime is applied to the capital letter designation, and any lower case symbol follows it.', 'https://crea.gov.it/infosuoli/vocabularies/FAOPrime', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/FAOPrime/14376', 'en', '''''''''''''', 'Rarely, three layers have identical letter symbols; a double prime can be used', 'Rarely, three layers have identical letter symbols; a double prime can be used', 'https://crea.gov.it/infosuoli/vocabularies/FAOPrime', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);



--/**
------------------------------------------------------------------------------------------------------
------------------------------   CODELIST soilinvestigationpurpose    --------------------------------
------------------------------------------------------------------------------------------------------


-- URI
-- http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue
-- This version
-- http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue:1
-- Label
-- Soil Investigation Purpose
-- Definition
-- A code list of possible values indicating the reasons for conducting a survey.
-- Description
-- For soil two main purposes are identified to carry out soil surveys. One is to classify the soil as a result of soil forming processes (generalSurvey) and the other one is to investigate soil for a specific reason (specificSurvey) like a possible contamination as a result of contaminating activities. This information gives the data user an idea about possible bias in the selection of the site and therefore representativeness of the data that were obtained for a special purpose.
-- Extensibility item
-- Not extensible
-- Application Schema
-- Soil
-- Theme
-- Soil
-- Governance level
-- Legal (EU)
-- Status
-- Valid


INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue/generalSoilSurvey', 'en', 'general soil survey', 'Soil characterisation with unbiased selection of investigation location.', 'EXAMPLE Soil characterisation for soil mapping, which involves identifying different soil types.', 'http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue/specificSoilSurvey', 'en', 'specific soil survey', 'Investigation of soil properties at locations biased by a specific purpose.', 'EXAMPLE investigation on potentially contaminated location', 'http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');

--/**
------------------------------------------------------------------------------------------------------
----------------------------------   CODELIST soilplottypevalue    -----------------------------------
------------------------------------------------------------------------------------------------------

-- URI
-- http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue
-- This version
-- http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue:1
-- Label
-- Soil Plot Type
-- Definition
-- A code list of terms specifying on what kind of plot the observation of the soil is made.
-- Description
-- NOTE Trial pits, boreholes or samples can be seen as types of soil plots.
-- Extensibility item
-- Not extensible
-- Application Schema
-- Soil
-- Theme
-- Soil
-- Governance level
-- Legal (EU)
-- Status
-- Valid

INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/borehole', 'en', 'borehole', 'Penetration into the sub-surface with removal of soil/rock material by using, for instance, a hollow tube-shaped tool, in order to carry out profile descriptions, sampling and/or field tests.', 'NOTE 1 generally, it is a vertical penetra-tion. NOTE 2 boring and bore are syno-nyms. SOURCE adapted from ISO 11074', 'http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/sample', 'en', 'sample', 'Exacavation where soil material is removed as a soil sample without doing any soil profile description.', 'EXAMPLE Location from the LUCAS survey SOURCE adopted from ISO/DIS 28258', 'http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/trialPit', 'en', 'trial pit', 'Excavation or other exposition of the soil prepared to carry out profile descriptions, sampling and/or field tests.', 'NOTE synonyms: test pit, trench, soil pit SOURCE adapted from ISO 11074', 'http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');

--/**
------------------------------------------------------------------------------------------------------
-------    Codelist othersoilnametypevalue  VOID
------------------------------------------------------------------------------------------------------

-- URI
-- http://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue
-- This version
-- http://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue:1
-- Label
-- Other Soil Name Type
-- Definition
-- An identification of the soil profile according to a specific classification scheme.
-- Extensibility item
-- Empty code list
-- Application Schema
-- Soil
-- Theme
-- Soil
-- Governance level
-- Legal (EU)
-- Status
-- Valid

INSERT INTO codelist  (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue', 'en', 'VOID', 'VOID', 'An identification of the soil profile according to a specific classification scheme.', 'http://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');

--/**
------------------------------------------------------------------------------------------------------
------------------------------   CODELIST wrbreferencesoilgroupvalue    --------------------------------
------------------------------------------------------------------------------------------------------


-- WRB Reference Soil Group (RSG)
-- URI
-- http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue
-- This version
-- http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue:2
-- Version history
-- http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue:1
-- Label
-- WRB Reference Soil Group (RSG)
-- Definition
-- list of possible reference soil groups (i.e. first level of classification of the World Reference Base for Soil Resources). The allowed values for this code list comprise only the values specified in ―World reference base for soil resources 2006, first update 2007.
-- Description
-- Reference Soil Groups are distinguished by the presence (or absence) of specific diagnostic horizons, properties and/or materials. NOTE The WRB soil classification system comprises 32 different RSGs.
-- Extensibility item
-- Not extensible
-- Application Schema
-- Soil
-- Theme
-- Soil
-- Document
-- World reference base for soil resources 2006, first update 2007, World Soil Resources Reports No. 103, Food and Agriculture Organization of the United Nations, Rome, 2007 (p. 51-66)
-- Governance level
-- Legal (EU)
-- Status
-- Valid


INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/acrisol', 'en', 'Acrisols', 'Soil having an argic horizon, CECclay < 50%.', 'Soils with a clay-enriched subsoil with low base status and low-activity clay', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/albeluvisol', 'en', 'Albeluvisols', 'Soil having an argic horizon and albeluvic tonguin.', 'Soils with a clay-enriched subsoil with albeluvic tonguing', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/alisol', 'en', 'Alisols', 'Soil having an argic horizon with CECclay >24 and BS < 50%.', 'Soils with a clay-enriched subsoil with low base status and high-activity clay', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/andosol', 'en', 'Andosols', 'Soil having an andic or vitric horizon.', 'Soils set by Fe/Al chemistry with allophanes or Al-humus complexes', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/anthrosol', 'en', 'Anthrosols', 'Soils profoundly modified through long-term human activities.', 'Soils with strong human influence and with long and intensive agricultural use', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/arenosol', 'en', 'Arenosols', 'Soil having a coarse texture up to >100 cm depth.', 'Relatively young sandy soils or sandy soils with little or no profile development', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/calcisol', 'en', 'Calcisols', 'Soil having a calcic or petrocalcic horizon.', 'Soil with accumulation of calcium carbonate and no accumulation of more soluble salts or non-saline substances', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/cambisol', 'en', 'Cambisols', 'Soil having a cambic horizon.', 'Moderately developed soils in relatively young soils or soils with little or no profile development', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/chernozem', 'en', 'Chernozems', 'Soil having a chernic or blackish mollic horizon.', 'Soils with accumulation of organic matter, high base status and black mollic horizon', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/cryosol', 'en', 'Cryosols', 'Soil having a cryic horizon.', 'Soils ice-affected by permafrost', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/durisol', 'en', 'Durisols', 'Soil having a duric or petroduric horizon.', 'Soils with accumulation of silica and no accumulation of more soluble salts or non-saline substances', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/ferralsol', 'en', 'Ferralsols', 'Soil having a ferralic horizon.', 'Soils set by Fe/Al chemistry with dominance of kaolinite and sesquioxides', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/fluvisol', 'en', 'Fluvisols', 'Soil having a fluvic materials.', 'Relatively young soils in floodplains or in tidal marshes', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/gleysol', 'en', 'Gleysols', 'Soil having a gleyic properties.', 'Groundwater affected soils', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/gypsisol', 'en', 'Gypsisols', 'Soil having a gypsic or petrogypsic horizon.', 'Soils with accumulation of gypsum and no accumulation of more soluble salts or non-saline substances', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/histosol', 'en', 'Histosols', 'Soil having organic matter >40 cm depth.', 'Soils with thick organic layers', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/kastanozem', 'en', 'Kastanozems', 'Soil having a brownish mollic horizon and secondary CaCO3.', 'Soils with accumulation of organic matter, high base status and brown mollic horizon', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/leptosol', 'en', 'Leptosols', 'Shallow soils, <=25 cm deep', 'Shallow or extremely gravelly soils', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/lixisol', 'en', 'Lixisols', 'Soil having an argic horizon and CECclay <24.', 'Soils with a clay-enriched subsoil with wigh base status and low-activity clay', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/luvisol', 'en', 'Luvisols', 'Soil having an argic horizon and CECclay >24.', 'Soils with a clay-enriched subsoil with wigh base status and high-activity clay', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/nitisol', 'en', 'Nitisols', 'Soil having a nitic horizon.', 'Soils set by Fe/Al chemistry with low-activity clay, P fixation and strongly structured.', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/phaeozem', 'en', 'Phaeozems', 'Soil having a mollic horizon.', 'Soils with accumulation of organic matter, high base status, and any mollic horizon"', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/planosol', 'en', 'Planosols', 'Soil having reducing condition and pedogenetic abrupt textural change.', 'Soils with stagnating water and abrupt textural discontinuity', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/plinthosol', 'en', 'Plinthosols', 'Soil having plinthite or petroplinthite.', 'Soils set by Fe/Al chemistry with accumulation of Fe under hydromorphic conditions', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/podzol', 'en', 'Podzols', 'Soil having a spodic horizon.', 'Soils set by Fe/Al chemistry with cheluviation and chilluviation', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/regosol', 'en', 'Regosols', 'Soil without a diagnostic horizon', 'Relatively young soils with no significant profile development', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/solonchak', 'en', 'Solonchaks', 'Soil having a salic horizon.', 'Soils influenced by water salt enrichment upon evaporation', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/solonetz', 'en', 'Solonetzs', 'Soil having a natric horizon.', 'Alkaline soils with a natric horizon', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/stagnosol', 'en', 'Stagnosols', 'Soil having reducing condition.', 'Soils with stagnating water with moderate textural or structural discontinuity', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/technosol', 'en', 'Technosols', 'Soil having a human artefacts.', 'Soils with strong human influence containing many artefacts', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/umbrisol', 'en', 'Umbrisols', 'Soil having an umbric horizon.', 'Relatively young soils or soils with little or no profile development with an acidic dark topsoil', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/vertisol', 'en', 'Vertisols', 'Soil having a vertic horizon.', 'Soils influenced by alternating wet-dry conditions and rich in swelling clays', 'http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');

--/**
------------------------------------------------------------------------------------------------------
------------------------------   CODELIST wrbqualifierplacevalue    --------------------------------
------------------------------------------------------------------------------------------------------

-- WRB Qualifier Place
-- URI
-- http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue
-- This version
-- http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue:1
-- Label
-- WRB Qualifier Place
-- Definition
-- A code list of values indicating the placement of the Qualifier with regard to the WRB reference soil group (RSG). The placement can be in front of the RSG i.e. 'prefix' or it can be behind the RSG i.e. 'suffix'.
-- Extensibility item
-- Not extensible
-- Application Schema
-- Soil
-- Theme
-- Soil
-- Document
-- World reference base for soil resources 2006, first update 2007, World Soil Resources Reports No. 103, Food and Agriculture Organization of the United Nations, Rome, 2007 (p. 51-66)
-- Governance level
-- Legal (EU)
-- Status
-- Valid


INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/suffix', 'en', 'suffix', 'Suffix', 'The placement of the Qualifier is after the WRB reference soil group (RSG)', 'http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', 'http://inspire.ec.europa.eu/document/WRBQuP', 'World reference base for soil resources 2006, first update 2007, World Soil Resources Reports No. 103, Food and Agriculture Organization of the United Nations, Rome, 2007 (p. 51-66)', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');
INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/prefix', 'en', 'prefix', 'Prefix', 'The placement of the Qualifier is before the WRB reference soil group (RSG)', 'http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', 'http://inspire.ec.europa.eu/document/WRBQuP', 'World reference base for soil resources 2006, first update 2007, World Soil Resources Reports No. 103, Food and Agriculture Organization of the United Nations, Rome, 2007 (p. 51-66)', 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');


------------------------------------------------------------------------------------------------------
------  CODELIST CREA  -----------  CODELIST wrbqualifiervalue    ---------  CODELIST CREA  ----------
------------------------------------------------------------------------------------------------------


INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Abruptic', 'en', 'Abruptic', 'Abruptic', 'Abruptic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aceric', 'en', 'Aceric', 'Aceric', 'Aceric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Acroxic', 'en', 'Acroxic', 'Acroxic', 'Acroxic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Albic', 'en', 'Albic', 'Albic', 'Albic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Alcalic', 'en', 'Alcalic', 'Alcalic', 'Alcalic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Alumic', 'en', 'Alumic', 'Alumic', 'Alumic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Anthric', 'en', 'Anthric', 'Anthric', 'Anthric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Arenic', 'en', 'Arenic', 'Arenic', 'Arenic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aridic', 'en', 'Aridic', 'Aridic', 'Aridic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Brunic', 'en', 'Brunic', 'Brunic', 'Brunic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Calcaric', 'en', 'Calcaric', 'Calcaric', 'Calcaric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Carbonatic', 'en', 'Carbonatic', 'Carbonatic', 'Carbonatic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Chloridic', 'en', 'Chloridic', 'Chloridic', 'Chloridic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Chromic', 'en', 'Chromic', 'Chromic', 'Chromic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Clayic', 'en', 'Clayic', 'Clayic', 'Clayic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Colluvic', 'en', 'Colluvic', 'Colluvic', 'Colluvic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Densic', 'en', 'Densic', 'Densic', 'Densic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Drainic', 'en', 'Drainic', 'Drainic', 'Drainic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Dystric', 'en', 'Dystric', 'Dystric', 'Dystric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endoduric', 'en', 'Endoduric', 'Endoduric', 'Endoduric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endoeutric', 'en', 'Endoeutric', 'Endoeutric', 'Endoeutric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Epidystric', 'en', 'Epidystric', 'Epidystric', 'Epidystric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Epieutric', 'en', 'Epieutric', 'Epieutric', 'Epieutric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Escalic', 'en', 'Escalic', 'Escalic', 'Escalic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Eutric', 'en', 'Eutric', 'Eutric', 'Eutric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ferric', 'en', 'Ferric', 'Ferric', 'Ferric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fragic', 'en', 'Fragic', 'Fragic', 'Fragic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gelic', 'en', 'Gelic', 'Gelic', 'Gelic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Geric', 'en', 'Geric', 'Geric', 'Geric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Glossalbic', 'en', 'Glossalbic', 'Glossalbic', 'Glossalbic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Glossic', 'en', 'Glossic', 'Glossic', 'Glossic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Greyic', 'en', 'Greyic', 'Greyic', 'Greyic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gypsiric', 'en', 'Gypsiric', 'Gypsiric', 'Gypsiric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Haplic', 'en', 'Haplic', 'Haplic', 'Haplic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hortic', 'en', 'Hortic', 'Hortic', 'Hortic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Humic', 'en', 'Humic', 'Humic', 'Humic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperdystric', 'en', 'Hyperdystric', 'Hyperdystric', 'Hyperdystric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypereutric', 'en', 'Hypereutric', 'Hypereutric', 'Hypereutric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperochric', 'en', 'Hyperochric', 'Hyperochric', 'Hyperochric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyposalic', 'en', 'Hyposalic', 'Hyposalic', 'Hyposalic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyposodic', 'en', 'Hyposodic', 'Hyposodic', 'Hyposodic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Lamellic', 'en', 'Lamellic', 'Lamellic', 'Lamellic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Laxic', 'en', 'Laxic', 'Laxic', 'Laxic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Magnesic', 'en', 'Magnesic', 'Magnesic', 'Magnesic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Manganiferric', 'en', 'Manganiferric', 'Manganiferric', 'Manganiferric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Mesotrophic', 'en', 'Mesotrophic', 'Mesotrophic', 'Mesotrophic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Novic', 'en', 'Novic', 'Novic', 'Novic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Nudiargic', 'en', 'Nudiargic', 'Nudiargic', 'Nudiargic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ornithic', 'en', 'Ornithic', 'Ornithic', 'Ornithic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Oxyaquic', 'en', 'Oxyaquic', 'Oxyaquic', 'Oxyaquic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pachic', 'en', 'Pachic', 'Pachic', 'Pachic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pellic', 'en', 'Pellic', 'Pellic', 'Pellic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petrogleyic', 'en', 'Petrogleyic', 'Petrogleyic', 'Petrogleyic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pisocalcic', 'en', 'Pisocalcic', 'Pisocalcic', 'Pisocalcic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Placic', 'en', 'Placic', 'Placic', 'Placic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Plaggic', 'en', 'Plaggic', 'Plaggic', 'Plaggic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Profondic', 'en', 'Profondic', 'Profondic', 'Profondic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Protothionic', 'en', 'Protothionic', 'Protothionic', 'Protothionic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Reductaquic', 'en', 'Reductaquic', 'Reductaquic', 'Reductaquic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Reductic', 'en', 'Reductic', 'Reductic', 'Reductic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Rhodic', 'en', 'Rhodic', 'Rhodic', 'Rhodic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ruptic', 'en', 'Ruptic', 'Ruptic', 'Ruptic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Siltic', 'en', 'Siltic', 'Siltic', 'Siltic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Skeletic', 'en', 'Skeletic', 'Skeletic', 'Skeletic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sodic', 'en', 'Sodic', 'Sodic', 'Sodic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sombric', 'en', 'Sombric', 'Sombric', 'Sombric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sulphatic', 'en', 'Sulphatic', 'Sulphatic', 'Sulphatic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Takyric', 'en', 'Takyric', 'Takyric', 'Takyric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Tephric', 'en', 'Tephric', 'Tephric', 'Tephric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Terric', 'en', 'Terric', 'Terric', 'Terric', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thaptobathyfragic', 'en', 'Thaptobathyfragic', 'Thaptobathyfragic', 'Thaptobathyfragic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thionic', 'en', 'Thionic', 'Thionic', 'Thionic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thixotropic', 'en', 'Thixotropic', 'Thixotropic', 'Thixotropic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Toxic', 'en', 'Toxic', 'Toxic', 'Toxic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Transportic', 'en', 'Transportic', 'Transportic', 'Transportic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Turbic', 'en', 'Turbic', 'Turbic', 'Turbic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Umbriglossic', 'en', 'Umbriglossic', 'Umbriglossic', 'Umbriglossic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Vermic', 'en', 'Vermic', 'Vermic', 'Vermic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Xanthic', 'en', 'Xanthic', 'Xanthic', 'Xanthic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Yermic', 'en', 'Yermic', 'Yermic', 'Yermic', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Bathi', 'en', 'Bathi', 'Bathi', 'Bathi', 'http://inspire.ec.europa.eu/codelist/WRBQualifierValue', null, null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);

------------------------------------------------------------------------------------------------------
------   CREA  -------------     CODELIST wrbspecifiervalue       -------------  CREA  -------------
------------------------------------------------------------------------------------------------------

INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Bathi', 'en', 'Bathi', 'Bathi', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Bathi', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Cumuli', 'en', 'Cumuli', 'Cumuli', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Cumuli', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Endo', 'en', 'Endo', 'Endo', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Endo', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Epi', 'en', 'Epi', 'Epi', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Epi', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Hyper', 'en', 'Hyper', 'Hyper', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Hyper', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Hypo', 'en', 'Hypo', 'Hypo', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Hypo', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Orthi', 'en', 'Orthi', 'Orthi', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Orthi', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Para', 'en', 'Para', 'Para', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Para', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Proto', 'en', 'Proto', 'Proto', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Proto', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, referencesource, referencelink, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers/Thapto', 'en', 'Thapto', 'Thapto', 'WRB Specifiers', 'https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers', null, null, null, null, null, null, null, 'Thapto', null);

------------------------------------------------------------------------------------------------------
---  CODELIST CREA ----   otherhorizonnotationtypevalue -----  CODELIST CREA ------ 
------------------------------------------------------------------------------------------------------

---------------------------  NOT    I N       R E G I S T R Y   -------------------------------------

INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/WRB', 'en', 'WRB', 'WRB Diagnostic Horizon', 'WRB Diagnostic Horizon', 'http://inspire.ec.europa.eu/codelist/OtherHorizonNotationTypeValue', '', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/USDA', 'en', 'USDA', 'USDA Diagnostic Horizon', 'USDA Diagnostic Horizon', 'http://inspire.ec.europa.eu/codelist/OtherHorizonNotationTypeValue', '', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);

------------------------------------------------------------------------------------------------------
-----  CODELIST CREA --------      CODELIST wrbdiagnostichorizon         -------  CODELIST CREA ------ 
------------------------------------------------------------------------------------------------------


INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/albic', 'en', 'albic', 'albico', 'albico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/andic', 'en', 'andic', 'andico', 'andico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/anthraquic', 'en', 'anthraquic', 'antraquico', 'antraquico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/argic', 'en', 'argic', 'argico', 'argico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/calcic', 'en', 'calcic', 'calcico', 'calcico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/cambic', 'en', 'cambic', 'cambico', 'cambico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/chernic', 'en', 'chernic', 'chernico', 'chernico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/cryic', 'en', 'cryic', 'cryico', 'cryico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/duric', 'en', 'duric', 'durico', 'durico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ferralic', 'en', 'ferralic', 'ferralico', 'ferralico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ferric', 'en', 'ferric', 'ferrico', 'ferrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/folistic', 'en', 'folistic', 'folico', 'folico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/fragic', 'en', 'fragic', 'fragico', 'fragico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/fulvic', 'en', 'fulvic', 'fulvico', 'fulvico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/gypsic', 'en', 'gypsic', 'gypsico', 'gypsico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/histic', 'en', 'histic', 'histico', 'histico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/idragric', 'en', 'idragric', 'idragrico', 'idragrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/irragric', 'en', 'irragric', 'irragrico', 'irragrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/melanic', 'en', 'melanic', 'melanico', 'melanico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/mollic', 'en', 'mollic', 'mollico', 'mollico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/natric', 'en', 'natric', 'natrico', 'natrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/nitic', 'en', 'nitic', 'nitico', 'nitico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ochric', 'en', 'ochric', 'ocrico', 'ocrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/ortic', 'en', 'ortic', 'ortico', 'ortico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petrocalcic', 'en', 'petrocalcic', 'petrocalcico', 'petrocalcico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petroduric', 'en', 'petroduric', 'petrodurico', 'petrodurico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petrogypsic', 'en', 'petrogypsic', 'petrogypsico', 'petrogypsico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/petroplinthic', 'en', 'petroplinthic', 'petroplintico', 'petroplintico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/plaggen', 'en', 'plaggen', 'plaggico', 'plaggico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/plinthic', 'en', 'plinthic', 'plintico', 'plintico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/salic', 'en', 'salic', 'salico', 'salico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/spodic', 'en', 'spodic', 'spodico', 'spodico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/sulfuric', 'en', 'sulfuric', 'solforico', 'solforico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/takyric', 'en', 'takyric', 'takyrico', 'takyrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/terric', 'en', 'terric', 'terrico', 'terrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/umbric', 'en', 'umbric', 'umbrico', 'umbrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/vertic', 'en', 'vertic', 'vertico', 'vertico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/vitric', 'en', 'vitric', 'vitrico', 'vitrico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);
INSERT INTO codelist (id, language, label, definition, description, collection, parent, successor, predecessor, registry, register, applicationschema, theme, referencelink, referencesource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon/yermic', 'en', 'yermic', 'yermico', 'yermico', 'https://crea.gov.it/infosuoli/vocabularies/WRBdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50001', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', null);


------------------------------------------------------------------------------------------------------
-----  CODELIST CREA --------      CODELIST usdadiagnostichorizon       -------  CODELIST CREA ------  
------------------------------------------------------------------------------------------------------



INSERT INTO codelist (ID, Language, label, definition, description, collection, parent, successor, predecessor, registry, register, ApplicationSchema, Theme, ReferenceLink, ReferenceSource, "governance-level-item", status) VALUES ('https://crea.gov.it/infosuoli/vocabularies/USDA/diagnostichorizon/12386', 'en', 'Void', 'Void', 'Void', 'https://crea.gov.it/infosuoli/vocabularies/USDA/diagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/50002', null, null, null, null, 'http://inspire.ec.europa.eu/applicationschema/so', 'http://inspire.ec.europa.eu/theme/so', null, null, 'http://inspire.ec.europa.eu/registry/governance-level/eu-legal', 'http://inspire.ec.europa.eu/registry/status/valid');