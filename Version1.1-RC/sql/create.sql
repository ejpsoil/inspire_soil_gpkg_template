---
-- title: "Howto: produce a GeoPackage template for INSPIRE Soil data"
-- date: 30/01/2024
-- author: Andrea Lachi - andrea.lachi@crea.gov.it
---

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
    validfrom DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null,
    validto DATETIME,
    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null, 
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
WHEN NEW.soilinvestigationpurpose NOT IN (SELECT id FROM codelist WHERE collection = 'SoilInvestigationPurposeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table soilsite: Invalid value for soilinvestigationpurpose. Must be present in id of soilinvestigationpurposevalue codelist.');
END;

CREATE TRIGGER u_soilinvestigationpurpose
BEFORE UPDATE ON soilsite
FOR EACH ROW
WHEN NEW.soilinvestigationpurpose NOT IN (SELECT id FROM codelist WHERE collection = 'SoilInvestigationPurposeValue')
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
    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null,
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
WHEN NEW.soilplottype NOT IN (SELECT id FROM codelist WHERE collection = 'SoilPlotTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table soilplot: Invalid value for soilplottype. Must be present in id of  soilplottypevalue codelist.');
END;

CREATE TRIGGER u_soilplottype
BEFORE UPDATE ON soilplot
FOR EACH ROW
WHEN NEW.soilplottype NOT IN (SELECT id FROM codelist WHERE collection = 'SoilPlotTypeValue')
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
--


CREATE TRIGGER u_begin_today_soilplot_error
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,soilplottype,endlifespanversion
ON soilplot
WHEN  datetime('now') > new.endlifespanversion
BEGIN
   SELECT RAISE(ABORT,'If you change record endlifespanversion must be greater than today');
END;
--


/* 
███████  ██████  ██ ██      ██████  ██████   ██████  ███████ ██ ██      ███████ 
██      ██    ██ ██ ██      ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      
███████ ██    ██ ██ ██      ██████  ██████  ██    ██ █████   ██ ██      █████   
     ██ ██    ██ ██ ██      ██      ██   ██ ██    ██ ██      ██ ██      ██      
███████  ██████  ██ ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████ 
 */

--------------------------------
-- OBSERVED isderived -> 0   
-- DERIVED  isderived -> 1   
--------------------------------

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
	  wrbversion TEXT,  
    wrbreferencesoilgroup TEXT,    -- Codelist wrbreferencesoilgroupvalue
    isoriginalclassification BOOLEAN DEFAULT 1 NOT NULL,

    location TEXT UNIQUE,
	  CHECK ((wrbreferencesoilgroup IS NULL AND wrbversion IS NULL) OR (wrbreferencesoilgroup IS NOT NULL AND wrbversion IS NOT NULL)),
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
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue')AND NEW.wrbreferencesoilgroup NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue2014')AND NEW.wrbreferencesoilgroup NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue2022')AND NEW.wrbreferencesoilgroup NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
END;

CREATE TRIGGER u_wrbreferencesoilgroup
BEFORE UPDATE ON soilprofile
FOR EACH ROW
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue')AND NEW.wrbreferencesoilgroup NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue2014')AND NEW.wrbreferencesoilgroup NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbreferencesoilgroup NOT IN (SELECT id FROM codelist WHERE collection = 'WRBReferenceSoilGroupValue2022')AND NEW.wrbreferencesoilgroup NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
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
--


CREATE TRIGGER u_begin_today_soilprofile_error
AFTER UPDATE
OF inspireid_localid,inspireid_namespace,inspireid_versionid,localidentifier,endlifespanversion,validfrom,validto,isderived,wrbreferencesoilgroup,isoriginalclassification
ON soilprofile
WHEN  datetime('now') > new.endlifespanversion
BEGIN
   SELECT RAISE(ABORT,'If you change record endlifespanversion must be greater than today');
END;
--

CREATE TRIGGER i_wrbproversion
BEFORE INSERT ON soilprofile
FOR EACH ROW
WHEN NEW.wrbversion NOT IN (SELECT id FROM codelist WHERE collection = 'wrbversion') AND NEW.wrbversion NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbversion. Must be present in id of wrbreferencesoilgroupvalue codelist.');
END;
                      
CREATE TRIGGER u_wrbproversion
BEFORE UPDATE ON soilprofile
FOR EACH ROW
WHEN NEW.wrbversion NOT IN (SELECT id FROM codelist WHERE collection = 'wrbversion') AND NEW.wrbversion NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbversion. Must be present in id of wrbreferencesoilgroupvalue codelist.');
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
    othersoilname_type TEXT NOT NULL, --Codelist othersoilnametypevalue
    othersoilname_class TEXT,
    isoriginalclassification  BOOLEAN  DEFAULT 0 NOT NULL,
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
WHEN NEW.othersoilname_type NOT IN (SELECT id FROM codelist WHERE collection = 'OtherSoilNameTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table othersoilnametype: Invalid value for othersoilname_type. Must be present in id of othersoilnametypevalue codelist.');
END;

CREATE TRIGGER u_soilname
BEFORE UPDATE ON othersoilnametype
FOR EACH ROW
WHEN NEW.othersoilname_type NOT IN (SELECT id FROM codelist WHERE collection = 'OtherSoilNameTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table othersoilnametype: Invalid value for othersoilname_type. Must be present in id of othersoilnametypevalue codelist.');
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
  base_id TEXT NOT NULL, -- Derived Profile
  related_id TEXT NOT NULL, -- Observed Profile
  CONSTRAINT unicrelationidf UNIQUE (base_id, related_id),
  FOREIGN KEY (base_id) REFERENCES soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (related_id) REFERENCES soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
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
  NULL -- EPSG spatial reference system code
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
    idsoilbody TEXT NOT NULL,
     FOREIGN KEY (idsoilbody)
      REFERENCES soilbody(guidkey)
      ON DELETE CASCADE 
      ON UPDATE CASCADE
 
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
  FOREIGN KEY (idsoilbody) REFERENCES soilbody (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idsoilprofile) REFERENCES soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
  
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
WHEN (SELECT Round(SUM(lowervalue),2) FROM derivedprofilepresenceinsoilbody WHERE idsoilbody = NEW.idsoilbody) + Round(NEW.lowervalue,2) > 100.00
BEGIN
    SELECT RAISE(ABORT, 'Table derivedprofilepresenceinsoilbody: sum of lowervalue exceeds 100 for the same idsoilbody');
END;

CREATE TRIGGER u_cecklowervaluesum
BEFORE UPDATE ON derivedprofilepresenceinsoilbody
FOR EACH ROW
WHEN (SELECT Round(SUM(lowervalue),2) FROM derivedprofilepresenceinsoilbody WHERE idsoilbody = NEW.idsoilbody) - Round(OLD.lowervalue,2) + Round(NEW.lowervalue,2) > 100.00
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
  'features', -- data type
  't_sdo', -- unique table identifier
  'soilderivedobject Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  3035 -- EPSG spatial reference system code
);

-- Geometry soilderivedobject ---------------------------------------------------------------------------------------
INSERT INTO gpkg_geometry_columns (
  table_name,
  column_name,
  geometry_type_name,
  srs_id,
  z,
  m
) VALUES (
  'soilderivedobject', -- table name
  'geometry', -- geometry column name
  'POLYGON', -- geometry type
  3035, -- EPSG spatial reference system code
  0, -- if the geometry has a Z coordinate (0 = no, 1 = yes, 2 = optional)
  0 -- if the geometry has a M coordinate (0 = no, 1 = yes, 2 = optional)
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
--


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
  FOREIGN KEY (idsoilderivedobject) REFERENCES soilderivedobject (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idsoilprofile) REFERENCES soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE
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

-- Trigger isbasedonobservedsoilprofile ---------------------------------------------------------------------------------------
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
  FOREIGN KEY (idsoilderivedobject) REFERENCES soilderivedobject (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idsoilbody) REFERENCES soilbody (guidkey)  ON DELETE CASCADE ON UPDATE CASCADE
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
  FOREIGN KEY (base_id) REFERENCES soilderivedobject (guidkey)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (related_id) REFERENCES soilderivedobject (guidkey)  ON DELETE CASCADE ON UPDATE CASCADE
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

-----------------------------------
-- profileelementtype -> 0 (HORIZON)
-- profileelementtype -> 1 (LAYER)
-----------------------------------

-- Table profileelement ---------------------------------------------------------------------------------------
CREATE TABLE profileelement
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    inspireid_localid                    TEXT,      
    inspireid_namespace                  TEXT,     
    inspireid_versionid                   TEXT, 
    profileelementdepthrange_uppervalue  INTEGER, 
    profileelementdepthrange_lowervalue  INTEGER,  
    beginlifespanversion DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null, 
    endlifespanversion                   DATETIME,  

    layertype                            TEXT,      -- Codelist layertypevalue 
    layerrocktype                        TEXT,      -- Codelist lithologyvalue 

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


CREATE TRIGGER i_checkgeogenicfieldsnull
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN (NEW.layertype <> 'http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic')
BEGIN
    SELECT CASE
        WHEN (NEW.layerrocktype IS NOT NULL) THEN
            RAISE(ABORT, 'layerrocktype must be NULL when LayerTypeValue is not "geogenic".')
        WHEN (NEW.layergenesisprocess IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisprocess must be NULL when LayerTypeValue is not "geogenic".')
        WHEN (NEW.layergenesisenviroment IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisenviroment must be NULL when LayerTypeValue is not "geogenic".')
        WHEN (NEW.layergenesisprocessstate IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisprocessstate must be NULL when LayerTypeValue is not "geogenic".')
    END;
END;

CREATE TRIGGER u_checkgeogenicfieldsnotnull
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN (NEW.layertype <> 'http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic')
BEGIN
    SELECT CASE
        WHEN (NEW.layerrocktype IS NOT NULL) THEN
            RAISE(ABORT, 'layerrocktype must be NULL when LayerTypeValue is not "geogenic".')
        WHEN (NEW.layergenesisprocess IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisprocess must be NULL when LayerTypeValue is not "geogenic".')
        WHEN (NEW.layergenesisenviroment IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisenviroment must be NULL when LayerTypeValue is not "geogenic".')
        WHEN (NEW.layergenesisprocessstate IS NOT NULL) THEN
            RAISE(ABORT, 'layergenesisprocessstate must be NULL when LayerTypeValue is not "geogenic".')
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
--


CREATE TRIGGER i_layertype
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layertype NOT IN (SELECT id FROM codelist WHERE collection = 'LayerTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layertype. Must be present in id of layertypevalue codelist.');
END;

CREATE TRIGGER u_layertype
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layertype NOT IN (SELECT id FROM codelist WHERE collection = 'LayerTypeValue')
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layertype. Must be present in id of layertypevalue codelist.');
END;
--


CREATE TRIGGER i_layergenesisenviroment
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisenviroment NOT IN (SELECT id FROM codelist WHERE collection = 'EventEnvironmentValue')  AND NEW.layergenesisenviroment NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisenviroment. Must be present in id of eventenvironmentvalue codelist.');
END;

CREATE TRIGGER u_layergenesisenviroment
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisenviroment NOT IN (SELECT id FROM codelist WHERE collection = 'EventEnvironmentValue')  AND NEW.layergenesisenviroment NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisenviroment. Must be present in id of eventenvironmentvalue codelist.');
END;
--


CREATE TRIGGER i_layergenesisprocess
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocess NOT IN (SELECT id FROM codelist WHERE collection = 'EventProcessValue')  AND NEW.layergenesisprocess NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocess. Must be present in id of  eventprocessvalue codelist.');
END;

CREATE TRIGGER u_layergenesisprocess
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocess NOT IN (SELECT id FROM codelist WHERE collection = 'EventProcessValue')  AND NEW.layergenesisprocess NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocess. Must be present in id of eventprocessvalue codelist.');
END;
--


CREATE TRIGGER "i_layergenesisprocessstate"
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocessstate NOT IN (SELECT id FROM codelist WHERE collection = 'LayerGenesisProcessStateValue')  AND NEW.layergenesisprocessstate NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocessstate. Must be present in id of layergenesisprocessstatevalue codelist.');
END;

CREATE TRIGGER u_layergenesisprocessstate
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layergenesisprocessstate NOT IN (SELECT id FROM codelist WHERE collection = 'LayerGenesisProcessStateValue')  AND NEW.layergenesisprocessstate NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layergenesisprocessstate. Must be present in id of layergenesisprocessstatevalue codelist.');
END;
--


CREATE TRIGGER i_layerrocktype
BEFORE INSERT ON profileelement
FOR EACH ROW
WHEN NEW.layerrocktype NOT IN (SELECT id FROM codelist WHERE collection = 'LithologyValue')  AND NEW.layerrocktype NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layerrocktype. Must be present in id of lithologyvalue codelist .');
END;

CREATE TRIGGER u_layerrocktype
BEFORE UPDATE ON profileelement
FOR EACH ROW
WHEN NEW.layerrocktype NOT IN (SELECT id FROM codelist WHERE collection = 'LithologyValue')  AND NEW.layerrocktype NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table profileelement: Invalid value for layerrocktype. Must be present in id of lithologyvalue codelist.');
END;
--


CREATE TRIGGER i_check_depth_range
BEFORE INSERT ON profileelement
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN (NEW.profileelementdepthrange_uppervalue IS NULL AND NEW.profileelementdepthrange_lowervalue IS NULL)
        THEN RAISE(ABORT, 'At least one of profileelementdepthrange_uppervalue and profileelementdepthrange_lowervalue must not be null')
    END;
END;

CREATE TRIGGER u_check_depth_range
BEFORE UPDATE ON profileelement
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN (NEW.profileelementdepthrange_uppervalue IS NULL AND NEW.profileelementdepthrange_lowervalue IS NULL)
        THEN RAISE(ABORT, 'At least one of profileelementdepthrange_uppervalue and profileelementdepthrange_lowervalue must not be null')
    END;
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
--



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
    fractioncontent                 REAL NOT NULL, 
    particlesize_lower                 INTEGER NOT NULL, 
    particlesize_upper                 INTEGER NOT NULL, 
    idprofileelement TEXT NOT NULL,
    CHECK (particlesize_lower >= 0 AND particlesize_lower <= 1999),
    CHECK (particlesize_upper >= 1 AND particlesize_upper <= 2000),
    CHECK (particlesize_lower < particlesize_upper),
    FOREIGN KEY (idprofileelement)
      REFERENCES profileelement(guidkey) 
      ON DELETE CASCADE 
      ON UPDATE CASCADE

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


-- Trigger particlesizefractiontype ---------------------------------------------------------------------------------------
CREATE TRIGGER i_check_fraction_sum
BEFORE INSERT ON particlesizefractiontype
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN (
            SELECT ROUND(SUM(fractioncontent), 1) + ROUND(NEW.fractioncontent, 1)
            FROM particlesizefractiontype
            WHERE idprofileelement = NEW.idprofileelement
        ) > 100 THEN
            RAISE(ABORT, 'The sum of fractioncontent for idprofileelement cannot exceed 100')
    END;
END;


CREATE TRIGGER u_check_fraction_sum
BEFORE UPDATE ON particlesizefractiontype
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN (
            SELECT ROUND(SUM(fractioncontent), 1)
            FROM particlesizefractiontype
            WHERE idprofileelement = NEW.idprofileelement
            AND id <> OLD.id
        ) + ROUND(NEW.fractioncontent, 1) > 100 THEN
            RAISE(ABORT, 'The sum of fractioncontent for idprofileelement cannot exceed 100')
    END;
END;


CREATE TRIGGER i_check_particlesize_overlap
BEFORE INSERT ON particlesizefractiontype
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN EXISTS (
            SELECT 1
            FROM particlesizefractiontype
            WHERE idprofileelement = NEW.idprofileelement
              AND (
                  (NEW.particlesize_lower > particlesize_lower AND NEW.particlesize_lower < particlesize_upper) OR
                  (NEW.particlesize_upper > particlesize_lower AND NEW.particlesize_upper < particlesize_upper) OR
                  (NEW.particlesize_lower <= particlesize_lower AND NEW.particlesize_upper >= particlesize_upper) OR
                  (NEW.particlesize_upper = particlesize_lower) OR
                  (NEW.particlesize_lower = particlesize_upper)
              )
        ) THEN
            RAISE(ABORT, 'New range overlaps with or touches an existing range for the same idprofileelement')
    END;
END;


CREATE TRIGGER u_check_particlesize_overlap
BEFORE UPDATE ON particlesizefractiontype
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN EXISTS (
            SELECT 1
            FROM particlesizefractiontype
            WHERE idprofileelement = NEW.idprofileelement
              AND (
                  (NEW.particlesize_lower > particlesize_lower AND NEW.particlesize_lower < particlesize_upper) OR
                  (NEW.particlesize_upper > particlesize_lower AND NEW.particlesize_upper < particlesize_upper) OR
                  (NEW.particlesize_lower <= particlesize_lower AND NEW.particlesize_upper >= particlesize_upper) OR
                  (NEW.particlesize_upper = particlesize_lower) OR
                  (NEW.particlesize_lower = particlesize_upper)
              )
        ) THEN
            RAISE(ABORT, 'New range overlaps with or touches an existing range for the same idprofileelement')
    END;
END;

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
    faohorizonmaster_1                TEXT NOT NULL, -- Codelist faohorizonmastervalue
    faohorizonmaster_2                TEXT, -- Codelist faohorizonmastervalue
    faohorizonsubordinate_1           TEXT, -- Codelist faohorizonsubordinatevalue
    faohorizonsubordinate_2           TEXT, -- Codelist faohorizonsubordinatevalue
    faohorizonsubordinate_3           TEXT, -- Codelist faohorizonsubordinatevalue
    faohorizonverical                 INTEGER,
    faoprime                          TEXT  NOT NULL,  -- Codelist faoprimevalue
    isoriginalclassification          BOOLEAN  DEFAULT 0 NOT NULL,
    idprofileelement                  TEXT UNIQUE, 
    FOREIGN KEY (idprofileelement) 
      REFERENCES profileelement(guidkey)  ON DELETE CASCADE ON UPDATE CASCADE
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
CREATE TRIGGER i_checkfaoprofileelementtype
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
BEGIN
    SELECT 
        CASE 
            WHEN (SELECT profileelementtype FROM profileelement WHERE profileelement.guidkey = NEW.idprofileelement) = 1
            THEN
                RAISE(ABORT, 'Table faohorizonnotationtype: The associated profileelement must have profileelementtype = 0 (HORIZON)')
        END;
END;

CREATE TRIGGER u_ceckfaoprofileelementtype
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
BEGIN
    SELECT 
        CASE 
            WHEN (SELECT profileelementtype FROM profileelement WHERE profileelement.guidkey = NEW.idprofileelement) = 1
            THEN
                RAISE(ABORT, 'Table faohorizonnotationtype: The associated profileelement must have profileelementtype = 0 (HORIZON)')
        END;
END;
--


CREATE TRIGGER i_faohorizonmaster_1
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonmaster_1 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonMasterValue') AND NEW.faohorizonmaster_1 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.');
END;

CREATE TRIGGER u_faohorizonmaster_1
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonmaster_1 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonMasterValue') AND NEW.faohorizonmaster_1 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.');
END;
--

CREATE TRIGGER i_faohorizonmaster_2
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonmaster_2 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonMasterValue') AND NEW.faohorizonmaster_2 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.');
END;

CREATE TRIGGER u_faohorizonmaster_2
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonmaster_2 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonMasterValue') AND NEW.faohorizonmaster_2 NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonmaster. Must be present in id of faohorizonmastervalue codelist.');
END;
--

CREATE TRIGGER i_faohorizonsubordinate_1
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate_1 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonSubordinateValue') AND NEW.faohorizonsubordinate_1  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;

CREATE TRIGGER u_faohorizonsubordinate_1
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate_1 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonSubordinateValue') AND NEW.faohorizonsubordinate_1  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;
--

CREATE TRIGGER i_faohorizonsubordinate_2
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate_2 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonSubordinateValue') AND NEW.faohorizonsubordinate_2  NOT NULL AND NEW.faohorizonsubordinate_1  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;

CREATE TRIGGER u_faohorizonsubordinate_2
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate_2 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonSubordinateValue') AND NEW.faohorizonsubordinate_2  NOT NULL AND NEW.faohorizonsubordinate_1  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;
--

CREATE TRIGGER i_faohorizonsubordinate_3
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate_3 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonSubordinateValue') AND NEW.faohorizonsubordinate_3  NOT NULL AND NEW.faohorizonsubordinate_2  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;

CREATE TRIGGER u_faohorizonsubordinate_3
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faohorizonsubordinate_3 NOT IN (SELECT id FROM codelist WHERE collection = 'FAOHorizonSubordinateValue') AND NEW.faohorizonsubordinate_3  NOT NULL AND NEW.faohorizonsubordinate_2  NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faohorizonsubordinate. Must be present in id of faohorizonsubordinatevalue codelist.');
END;
--


CREATE TRIGGER i_faoprime
BEFORE INSERT ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faoprime NOT IN (SELECT id FROM codelist WHERE collection = 'FAOPrimeValue') AND NEW.faoprime NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table faohorizonnotationtype: Invalid value for faoprime. Must be present in id of faoprimevalue codelist.');
END;

CREATE TRIGGER u_faoprime
BEFORE UPDATE ON faohorizonnotationtype
FOR EACH ROW
WHEN NEW.faoprime NOT IN (SELECT id FROM codelist WHERE collection = 'FAOPrimeValue') AND NEW.faoprime NOT NULL
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
    guidkey TEXT UNIQUE,
    horizonnotation                      TEXT NOT NULL, --Codelist otherhorizonnotationtypevalue
    diagnostichorizon                    TEXT, -- Codelist wrbdiagnostichorizonvalue 
    isoriginalclassification             BOOLEAN  DEFAULT 0 NOT NULL, 
    otherhorizonnotation TEXT
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
CREATE TRIGGER otherhorizonnotationtypeguid
AFTER INSERT ON otherhorizonnotationtype
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE otherhorizonnotationtype SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER otherhorizonnotationtypeguidupdate
AFTER UPDATE OF guidkey ON otherhorizonnotationtype
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_otherhorizonnotationtype
BEFORE INSERT ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.horizonnotation NOT IN (SELECT id FROM codelist WHERE collection = 'OtherHorizonNotationTypeValue') AND NEW.horizonnotation NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for horizonnotation. Must be present in id of otherhorizonnotationtypevalue codelist.');
END;

CREATE TRIGGER u_otherhorizonnotationtype
BEFORE UPDATE ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.horizonnotation NOT IN (SELECT id FROM codelist WHERE collection = 'OtherHorizonNotationTypeValue') AND NEW.horizonnotation NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for horizonnotation. Must be present in id of otherhorizonnotationtypevalue codelist.');
END;
--


CREATE TRIGGER i_diagnostichorizon
BEFORE INSERT ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.diagnostichorizon NOT IN (SELECT id FROM codelist WHERE collection = NEW.horizonnotation) AND NEW.diagnostichorizon NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for diagnostichorizon. Must be present in the relativecodelist.');
END;

CREATE TRIGGER u_diagnostichorizon
BEFORE UPDATE ON otherhorizonnotationtype
FOR EACH ROW
WHEN NEW.diagnostichorizon NOT IN (SELECT id FROM codelist WHERE collection = NEW.horizonnotation) AND NEW.diagnostichorizon NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizonnotationtype: Invalid value for diagnostichorizon. Must be present in the relativecodelist.');
END;
--


/*
 ██████  ████████ ██   ██ ███████ ██████  ██   ██  ██████  ██████  ██ ███████  ██████  ███    ██         ██████  ██████   ██████  ███████ ██ ██      ███████ ███████ ██      ███████ ███    ███ ███████ ███    ██ ████████ 
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██    ███  ██    ██ ████   ██         ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ████  ████ ██      ████   ██    ██    
██    ██    ██    ███████ █████   ██████  ███████ ██    ██ ██████  ██   ███   ██    ██ ██ ██  ██         ██████  ██████  ██    ██ █████   ██ ██      █████   █████   ██      █████   ██ ████ ██ █████   ██ ██  ██    ██    
██    ██    ██    ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██  ███    ██    ██ ██  ██ ██         ██      ██   ██ ██    ██ ██      ██ ██      ██      ██      ██      ██      ██  ██  ██ ██      ██  ██ ██    ██    
 ██████     ██    ██   ██ ███████ ██   ██ ██   ██  ██████  ██   ██ ██ ███████  ██████  ██   ████ ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████ ███████ ███████ ███████ ██      ██ ███████ ██   ████    ██    
*/


-- Table otherhorizon_profileelement ---------------------------------------------------------------------------------------
CREATE TABLE otherhorizon_profileelement
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  idprofileelement TEXT NOT NULL,
  idotherhorizonnotationtype TEXT NOT NULL,
  CONSTRAINT unicrelationprooth UNIQUE (idprofileelement, idotherhorizonnotationtype),
  FOREIGN KEY (idprofileelement) REFERENCES profileelement (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idotherhorizonnotationtype) REFERENCES otherhorizonnotationtype (guidkey)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- Contents otherhorizon_profileelement ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
table_name,
data_type,
identifier,
description,
last_change
) VALUES (
'otherhorizon_profileelement', -- table name
'attributes', -- data type
't_othproe', -- unique table identifier
'otherhorizon_profileelement Table', -- table description
strftime('%Y-%m-%dT%H:%M:%fZ','now') -- last modification date and time
);

-- Trigger otherhorizon_profileelement ---------------------------------------------------------------------------------------
CREATE TRIGGER   i_ceckothprofileelementtype
BEFORE INSERT ON otherhorizon_profileelement
FOR EACH ROW
WHEN (
    SELECT profileelementtype FROM profileelement WHERE guidkey = NEW.idprofileelement
    ) = 1
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizon_profileelement: The associated profileelement must have profileelementtype = 0 (HORIZON)');
END;

CREATE TRIGGER   u_ceckothprofileelementtype
BEFORE UPDATE ON otherhorizon_profileelement
FOR EACH ROW
WHEN  (
    SELECT profileelementtype FROM profileelement WHERE guidkey = NEW.idprofileelement
    ) = 1
BEGIN
    SELECT RAISE(ABORT, 'Table otherhorizon_profileelement: The associated profileelement must have profileelementtype = 0 (HORIZON)');
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
    guidkey TEXT UNIQUE,
	  wrbversion TEXT DEFAULT 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' NOT NULL,  
    qualifierplace            TEXT NOT NULL, -- Codelist wrbqualifierplacevalue
    wrbqualifier              TEXT NOT NULL,  --Codelist wrbqualifiervalue 
    wrbspecifier_1            TEXT,    -- Codelist wrbspecifiervalue
    wrbspecifier_2 			  TEXT,    -- Codelist wrbspecifiervalue
    UNIQUE (wrbversion, qualifierplace, wrbqualifier, wrbspecifier_1, wrbspecifier_2)
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
CREATE TRIGGER wrbqualifiergrouptypeguid
AFTER INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE wrbqualifiergrouptype SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER wrbqualifiergrouptypeguidupdate
AFTER UPDATE OF guidkey ON wrbqualifiergrouptype
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--

CREATE TRIGGER i_wrbqualifier
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue')AND NEW.wrbqualifier NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue2014')AND NEW.wrbqualifier NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue2022')AND NEW.wrbqualifier NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
END;

CREATE TRIGGER u_wrbqualifier
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue')AND NEW.wrbqualifier NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue2014')AND NEW.wrbqualifier NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbqualifier NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierValue2022')AND NEW.wrbqualifier NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
END;
--


CREATE TRIGGER i_qualifierplace
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.qualifierplace NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierPlaceValue') 
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for qualifierplace. Must be present in id of wrbqualifierplacevalue codelist.');
END;

CREATE TRIGGER u_qualifierplace
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.qualifierplace NOT IN (SELECT id FROM codelist WHERE collection = 'WRBQualifierPlaceValue') 
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for qualifierplace. Must be present in id of wrbqualifierplacevalue codelist.');
END;
--


CREATE TRIGGER i_wrbspecifier_1
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue')AND NEW.wrbspecifier_1 NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2014')AND NEW.wrbspecifier_1 NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2022')AND NEW.wrbspecifier_1 NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
END;


CREATE TRIGGER u_wrbspecifier_1
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue')AND NEW.wrbspecifier_1 NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2014')AND NEW.wrbspecifier_1 NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbspecifier_1 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2022')AND NEW.wrbspecifier_1 NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
END;
--


CREATE TRIGGER i_wrbspecifier_2
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue')AND NEW.wrbspecifier_2 NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2014')AND NEW.wrbspecifier_2 NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2022')AND NEW.wrbspecifier_2 NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
END;


CREATE TRIGGER u_wrbspecifier_2
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN 
  (NEW.wrbversion = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue')AND NEW.wrbspecifier_2 NOT NULL) OR
  (NEW.wrbversion = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2014')AND NEW.wrbspecifier_2 NOT NULL) OR
  (NEW.wrbversion = 'https://obrl-soil.github.io/wrbsoil2022/' AND NEW.wrbspecifier_2 NOT IN (SELECT id FROM codelist WHERE collection = 'WRBSpecifierValue2022')AND NEW.wrbspecifier_2 NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table wrbqualifiergrouptype: Invalid value for wrbversion. Must be present in id of the correct year codelist collection.');
END;
--

CREATE TRIGGER i_wrbqualversion
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbversion NOT IN (SELECT id FROM codelist WHERE collection = 'wrbversion') AND NEW.wrbversion NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbversion. Must be present in id of wrbreferencesoilgroupvalue codelist.');
END;
                      
CREATE TRIGGER u_wrbqualversion
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
WHEN NEW.wrbversion NOT IN (SELECT id FROM codelist WHERE collection = 'wrbversion') AND NEW.wrbversion NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table soilprofile: Invalid value for wrbversion. Must be present in id of wrbreferencesoilgroupvalue codelist.');
END;
--

CREATE TRIGGER i_unique_wrbqualifiergrouptype
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Duplicate entry found for wrbversion, qualifierplace, wrbqualifier, wrbspecifier_1, wrbspecifier_2.')
    FROM wrbqualifiergrouptype
    WHERE wrbversion = NEW.wrbversion
      AND qualifierplace = NEW.qualifierplace
      AND wrbqualifier = NEW.wrbqualifier
      AND (wrbspecifier_1 = NEW.wrbspecifier_1 OR (wrbspecifier_1 IS NULL AND NEW.wrbspecifier_1 IS NULL))
      AND (wrbspecifier_2 = NEW.wrbspecifier_2 OR (wrbspecifier_2 IS NULL AND NEW.wrbspecifier_2 IS NULL))
      AND id != NEW.id
    LIMIT 1;
END;

CREATE TRIGGER u_unique_wrbqualifiergrouptype
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Duplicate entry found for wrbversion, qualifierplace, wrbqualifier, wrbspecifier_1, wrbspecifier_2.')
    FROM wrbqualifiergrouptype
    WHERE wrbversion = NEW.wrbversion
      AND qualifierplace = NEW.qualifierplace
      AND wrbqualifier = NEW.wrbqualifier
      AND (wrbspecifier_1 = NEW.wrbspecifier_1 OR (wrbspecifier_1 IS NULL AND NEW.wrbspecifier_1 IS NULL))
      AND (wrbspecifier_2 = NEW.wrbspecifier_2 OR (wrbspecifier_2 IS NULL AND NEW.wrbspecifier_2 IS NULL))
      AND id != NEW.id
    LIMIT 1;
END;


CREATE TRIGGER i_check_specifiers_not_equal
BEFORE INSERT ON wrbqualifiergrouptype
FOR EACH ROW
BEGIN   
    SELECT RAISE(ABORT, 'wrbspecifier_1 and wrbspecifier_2 must not be equal')
    WHERE NEW.wrbspecifier_1 = NEW.wrbspecifier_2;


    SELECT RAISE(ABORT, 'wrbspecifier_1 must not be NULL when wrbspecifier_2 is not NULL')
    WHERE NEW.wrbspecifier_2 IS NOT NULL AND NEW.wrbspecifier_1 IS NULL;
END;

CREATE TRIGGER u_check_specifiers_not_equal
BEFORE UPDATE ON wrbqualifiergrouptype
FOR EACH ROW
BEGIN

    SELECT RAISE(ABORT, 'wrbspecifier_1 and wrbspecifier_2 must not be equal')
    WHERE NEW.wrbspecifier_1 = NEW.wrbspecifier_2;

    SELECT RAISE(ABORT, 'wrbspecifier_1 must not be NULL when wrbspecifier_2 is not NULL')
    WHERE NEW.wrbspecifier_2 IS NOT NULL AND NEW.wrbspecifier_1 IS NULL;
END;
--

/*
██     ██ ██████  ██████   ██████  ██    ██  █████  ██      ██ ███████ ██ ███████ ██████   ██████  ██████   ██████  ██    ██ ██████          ██████  ██████   ██████  ███████ ██ ██      ███████ 
██     ██ ██   ██ ██   ██ ██    ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██       ██   ██ ██    ██ ██    ██ ██   ██         ██   ██ ██   ██ ██    ██ ██      ██ ██      ██      
██  █  ██ ██████  ██████  ██    ██ ██    ██ ███████ ██      ██ █████   ██ █████   ██████  ██   ███ ██████  ██    ██ ██    ██ ██████          ██████  ██████  ██    ██ █████   ██ ██      █████   
██ ███ ██ ██   ██ ██   ██ ██ ▄▄ ██ ██    ██ ██   ██ ██      ██ ██      ██ ██      ██   ██ ██    ██ ██   ██ ██    ██ ██    ██ ██              ██      ██   ██ ██    ██ ██      ██ ██      ██      
 ███ ███  ██   ██ ██████   ██████   ██████  ██   ██ ███████ ██ ██      ██ ███████ ██   ██  ██████  ██   ██  ██████   ██████  ██      ███████ ██      ██   ██  ██████  ██      ██ ███████ ███████ 
*/


-- Table wrbqualifiergroup_profile ---------------------------------------------------------------------------------------
CREATE TABLE wrbqualifiergroup_profile
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  idsoilprofile TEXT NOT NULL,
  idwrbqualifiergrouptype TEXT NOT NULL,
  qualifierposition      INTEGER NOT NULL,
  CONSTRAINT unicrelationspwbr UNIQUE (idsoilprofile, idwrbqualifiergrouptype),
  FOREIGN KEY (idsoilprofile) REFERENCES soilprofile (guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idwrbqualifiergrouptype) REFERENCES wrbqualifiergrouptype (guidkey)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- Contents wrbqualifiergroup_profile ---------------------------------------------------------------------------------------
INSERT INTO gpkg_contents (
table_name,
data_type,
identifier,
description,
last_change
) VALUES (
'wrbqualifiergroup_profile', -- table name
'attributes', -- data type
't_wrbpro', -- unique table identifier
'wrbqualifiergroup_profile Table', -- table description
strftime('%Y-%m-%dT%H:%M:%fZ','now') -- last modification date and time
);

-- Trigger wrbqualifiergroup_profile ---------------------------------------------------------------------------------------
CREATE TRIGGER i_check_wrbversion_match
BEFORE INSERT ON wrbqualifiergroup_profile
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Mismatch in wrbversion values.')
    WHERE (SELECT wrbversion FROM soilprofile WHERE guidkey = NEW.idsoilprofile) <> 
          (SELECT wrbversion FROM wrbqualifiergrouptype WHERE guidkey = NEW.idwrbqualifiergrouptype);
END;


CREATE TRIGGER u_check_wrbversion_match
BEFORE UPDATE ON wrbqualifiergroup_profile
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Mismatch in wrbversion values.')
    WHERE (SELECT wrbversion FROM soilprofile WHERE guidkey = NEW.idsoilprofile) <> 
          (SELECT wrbversion FROM wrbqualifiergrouptype WHERE guidkey = NEW.idwrbqualifiergrouptype);
END;
--

CREATE TRIGGER i_check_qualifier_position_unique
BEFORE INSERT ON wrbqualifiergroup_profile
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'qualifierposition must be unique for each qualifierplace within the same soilprofile')
    FROM wrbqualifiergroup_profile
    JOIN wrbqualifiergrouptype ON wrbqualifiergroup_profile.idwrbqualifiergrouptype = wrbqualifiergrouptype.guidkey
    WHERE wrbqualifiergroup_profile.idsoilprofile = NEW.idsoilprofile
      AND wrbqualifiergroup_profile.qualifierposition = NEW.qualifierposition
      AND wrbqualifiergrouptype.qualifierplace = (SELECT qualifierplace
                                                  FROM wrbqualifiergrouptype
                                                  WHERE guidkey = NEW.idwrbqualifiergrouptype)
      AND wrbqualifiergroup_profile.id != NEW.id;
END;


CREATE TRIGGER u_check_qualifier_position_unique
BEFORE UPDATE ON wrbqualifiergroup_profile
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'qualifierposition must be unique for each qualifierplace within the same soilprofile')
    FROM wrbqualifiergroup_profile
    JOIN wrbqualifiergrouptype ON wrbqualifiergroup_profile.idwrbqualifiergrouptype = wrbqualifiergrouptype.guidkey
    WHERE wrbqualifiergroup_profile.idsoilprofile = NEW.idsoilprofile
      AND wrbqualifiergroup_profile.qualifierposition = NEW.qualifierposition
      AND wrbqualifiergrouptype.qualifierplace = (SELECT qualifierplace
                                                  FROM wrbqualifiergrouptype
                                                  WHERE guidkey = NEW.idwrbqualifiergrouptype)
      AND wrbqualifiergroup_profile.id != NEW.id;
END;


/*
██████   █████  ████████  █████  ███████ ████████ ██████  ███████  █████  ███    ███ 
██   ██ ██   ██    ██    ██   ██ ██         ██    ██   ██ ██      ██   ██ ████  ████ 
██   ██ ███████    ██    ███████ ███████    ██    ██████  █████   ███████ ██ ████ ██ 
██   ██ ██   ██    ██    ██   ██      ██    ██    ██   ██ ██      ██   ██ ██  ██  ██ 
██████  ██   ██    ██    ██   ██ ███████    ██    ██   ██ ███████ ██   ██ ██      ██ 
*/

-- Table datastream
CREATE TABLE datastream
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    guidkey TEXT UNIQUE,
    idsoilsite            TEXT,
    idsoilprofile         TEXT,
    idsoilderivedobject   TEXT,
    idprofileelement      TEXT,
    iddatastreamcollection            TEXT,
    idprocess               TEXT NOT NULL,
    idobservedproperty      TEXT NOT NULL,
    idsensor            TEXT,

    -- Feature Of Interset ----------------------------------------          
    FOREIGN KEY (idsoilsite)
      REFERENCES soilsite(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (idsoilprofile)
      REFERENCES soilprofile(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (idsoilderivedobject)
      REFERENCES soilderivedobject(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (idprofileelement)
      REFERENCES profileelement(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,
    -------------------------------------------------------------------
    
    FOREIGN KEY (iddatastreamcollection)
      REFERENCES datastreamcollection(guidkey) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (idprocess)
      REFERENCES process(guidkey),
       
    FOREIGN KEY (idobservedproperty)
      REFERENCES observableproperty(guidkey),
      
    FOREIGN KEY (idsensor)
      REFERENCES sensor(guidkey),
    
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
    FOREIGN KEY (idprocess, idobservedproperty) REFERENCES observableproperty_process(idprocess, idobservedproperty)

);
    -- Only one property/process pair can belong to a single feature.
    CREATE UNIQUE INDEX index_ss ON datastream (
        idsoilsite, idprocess, idobservedproperty,
        ifnull(iddatastreamcollection, 0) 
    );

    CREATE UNIQUE INDEX index_sp ON datastream (
        idsoilprofile, idprocess, idobservedproperty,
        ifnull(iddatastreamcollection, 0) 
    );

    CREATE UNIQUE INDEX index_pe ON datastream (
        idprofileelement, idprocess, idobservedproperty,
        ifnull(iddatastreamcollection, 0) 
    );

    CREATE UNIQUE INDEX index_do ON datastream (
        idsoilderivedobject, idprocess, idobservedproperty,
        ifnull(iddatastreamcollection, 0) 
    );


-- Contents datastream ---------------------------------------------------------------------------------------
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
  'datastream', -- table name
  'attributes', -- data type
  't_datas', -- unique table identifier
  'datastream Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger datastream ---------------------------------------------------------------------------------------
CREATE TRIGGER datastreamguid
AFTER INSERT ON datastream
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE datastream SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER datastreamguidupdate
AFTER UPDATE OF guidkey ON datastream
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--

-- Properties can only be those related to their own FOI (8 Trigger)
CREATE TRIGGER i_soilprofile_obspro
BEFORE INSERT ON datastream
FOR EACH ROW
WHEN NEW.idsoilprofile is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'soilprofile')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Soil Profile Parameter.');
END;

CREATE TRIGGER u_soilprofile_obspro
BEFORE UPDATE ON datastream
FOR EACH ROW
WHEN NEW.idsoilprofile is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'soilprofile')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Soil Profile Parameter.');
END;
--

CREATE TRIGGER i_soilsite_obspro
BEFORE INSERT ON datastream
FOR EACH ROW
WHEN NEW.idsoilsite is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'soilsite')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Soil Site Parameter.');
END;

CREATE TRIGGER u_soilsite_obspro
BEFORE UPDATE ON datastream
FOR EACH ROW
WHEN NEW.idsoilsite is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'soilsite')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Soil Site Parameter.');
END;
--

CREATE TRIGGER i_profileelement_obspro
BEFORE INSERT ON datastream
FOR EACH ROW
WHEN NEW.idprofileelement is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'profileelement')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Profile Element Parameter.');
END;

CREATE TRIGGER u_profileelement_obspro
BEFORE UPDATE ON datastream
FOR EACH ROW
WHEN NEW.idprofileelement is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'profileelement')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Profile Element Parameter.');
END;
--

CREATE TRIGGER i_soilderivedobject_obspro
BEFORE INSERT ON datastream
FOR EACH ROW
WHEN NEW.idsoilderivedobject is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'soilderivedobject')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Derived Object Parameter.');
END;

CREATE TRIGGER u_soilderivedobject_obspro
BEFORE UPDATE ON datastream
FOR EACH ROW
WHEN NEW.idsoilderivedobject is NOT NULL AND  NEW.idobservedproperty NOT IN (SELECT guidkey FROM observableproperty WHERE foi = 'soilderivedobject')
BEGIN
    SELECT RAISE(ABORT, 'Invalid value for observedproperty. Must be a valid Derived Object Parameter.');
END;
--


/*
 ██████  ██████  ███████ ███████ ██████  ██    ██  █████  ██████  ██      ███████ ██████  ██████   ██████  ██████  ███████ ██████  ████████ ██    ██         ██████  ██████   ██████   ██████ ███████ ███████ ███████ 
██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██      ██   ██ ██   ██ ██    ██ ██   ██ ██      ██   ██    ██     ██  ██          ██   ██ ██   ██ ██    ██ ██      ██      ██      ██      
██    ██ ██████  ███████ █████   ██████  ██    ██ ███████ ██████  ██      █████   ██████  ██████  ██    ██ ██████  █████   ██████     ██      ████           ██████  ██████  ██    ██ ██      █████   ███████ ███████ 
██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██   ██ ██   ██ ██      ██      ██      ██   ██ ██    ██ ██      ██      ██   ██    ██       ██            ██      ██   ██ ██    ██ ██      ██           ██      ██ 
 ██████  ██████  ███████ ███████ ██   ██   ████   ██   ██ ██████  ███████ ███████ ██      ██   ██  ██████  ██      ███████ ██   ██    ██       ██    ███████ ██      ██   ██  ██████   ██████ ███████ ███████ ███████ 
 */


--Table observableproperty_process
CREATE TABLE observableproperty_process (
    idprocess TEXT NOT NULL,
    idobservedproperty TEXT NOT NULL,
    CONSTRAINT pk_observableproperty_process PRIMARY KEY (idprocess, idobservedproperty),
    
    FOREIGN KEY (idprocess)
      REFERENCES process(guidkey) 
      ON DELETE CASCADE 
      ON UPDATE CASCADE,

    FOREIGN KEY (idobservedproperty)
      REFERENCES observableproperty(guidkey)
      ON DELETE CASCADE 
      ON UPDATE CASCADE
);


-- Contents observableproperty_process ---------------------------------------------------------------------------------------
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
  'observableproperty_process', -- table name
  'attributes', -- data type
  't_obspro', -- unique table identifier
  'observableproperty_process Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);


/* 
 ██████  ██████  ███████ ███████ ██████  ██    ██  █████  ████████ ██  ██████  ███    ██ 
██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██   ██    ██    ██ ██    ██ ████   ██ 
██    ██ ██████  ███████ █████   ██████  ██    ██ ███████    ██    ██ ██    ██ ██ ██  ██ 
██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██   ██    ██    ██ ██    ██ ██  ██ ██ 
 ██████  ██████  ███████ ███████ ██   ██   ████   ██   ██    ██    ██  ██████  ██   ████ 
 */


-- Table observation ---------------------------------------------------------------------------------------
CREATE TABLE observation
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    guidkey TEXT UNIQUE,
    phenomenontime             DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null, 
    resulttime                 DATETIME default (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')) not null,
    validtime                  DATETIME,
    resultquality              TEXT,
    result_value   REAL,
    result_uri  TEXT,
    iddatastream  TEXT,

    FOREIGN KEY (iddatastream)
      REFERENCES datastream(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Contents observation ---------------------------------------------------------------------------------------
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
  'observation', -- table name
  'attributes', -- data type
  't_ob', -- unique table identifier
  'observation Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger observation ---------------------------------------------------------------------------------------
CREATE TRIGGER observationguid
AFTER INSERT ON observation
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE observation SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER observationguidupdate
AFTER UPDATE OF guidkey ON observation
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_ceckvalidperiodobservation
BEFORE INSERT ON observation
WHEN NEW.resulttime > NEW.validtime 
BEGIN
    SELECT RAISE(ABORT, 'Table observation: resulttime must be less than validtime');
END;

CREATE TRIGGER u_ceckvalidperiodobservation
BEFORE UPDATE ON observation
WHEN NEW.resulttime > NEW.validtime 
BEGIN
    SELECT RAISE(ABORT, 'Table observation: resulttime must be less than validtime');
END; 
--


CREATE TRIGGER i_check_result_value_uri
BEFORE INSERT ON observation
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN (NEW.result_value IS NOT NULL AND NEW.result_uri IS NOT NULL) or (NEW.result_value IS  NULL AND NEW.result_uri IS  NULL)  THEN
            RAISE(ABORT, 'Both result_value and result_uri cannot be evaluated at the same time or they cannot be null')
    END;
END;


CREATE TRIGGER u_check_result_value_uri
BEFORE UPDATE ON observation
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN (NEW.result_value IS NOT NULL AND NEW.result_uri IS NOT NULL) or (NEW.result_value IS  NULL AND NEW.result_uri IS  NULL)  THEN
            RAISE(ABORT, 'Both result_value and result_uri cannot be evaluated at the same time or they cannot be null')
    END;
END;
--


CREATE TRIGGER i_controlresultvalue
BEFORE INSERT ON observation
FOR EACH ROW
WHEN NEW.result_value >
    (SELECT  CAST (observableproperty.domain_max AS REAL)
    FROM observation
    JOIN datastream ON observation.iddatastream = datastream.guidkey
    JOIN observableproperty ON datastream.idobservedproperty = observableproperty.guidkey
    WHERE datastream.guidkey = NEW.iddatastream)
    
    OR NEW.result_value <
        
    (SELECT  CAST (observableproperty.domain_min AS REAL)
    FROM observation
    JOIN datastream ON observation.iddatastream = datastream.guidkey
    JOIN observableproperty ON datastream.idobservedproperty = observableproperty.guidkey
    WHERE datastream.guidkey = NEW.iddatastream)
BEGIN
    SELECT RAISE(ABORT, 'Observation ERROR');
END;

CREATE TRIGGER u_controlresultvalue
BEFORE UPDATE ON observation
FOR EACH ROW
WHEN NEW.result_value >
    (SELECT  CAST (observableproperty.domain_max AS REAL)
    FROM observation
    JOIN datastream ON observation.iddatastream = datastream.guidkey
    JOIN observableproperty ON datastream.idobservedproperty = observableproperty.guidkey
    WHERE datastream.guidkey = NEW.iddatastream)
    
    OR NEW.result_value <
        
    (SELECT  CAST (observableproperty.domain_min AS REAL)
    FROM observation
    JOIN datastream ON observation.iddatastream = datastream.guidkey
    JOIN observableproperty ON datastream.idobservedproperty = observableproperty.guidkey
    WHERE datastream.guidkey = NEW.iddatastream)
BEGIN
    SELECT RAISE(ABORT, 'Observation ERROR');
END;
--


/* 
██████   █████  ████████  █████  ███████ ████████ ██████  ███████  █████  ███    ███  ██████  ██████  ██      ██      ███████  ██████ ████████ ██  ██████  ███    ██ 
██   ██ ██   ██    ██    ██   ██ ██         ██    ██   ██ ██      ██   ██ ████  ████ ██      ██    ██ ██      ██      ██      ██         ██    ██ ██    ██ ████   ██ 
██   ██ ███████    ██    ███████ ███████    ██    ██████  █████   ███████ ██ ████ ██ ██      ██    ██ ██      ██      █████   ██         ██    ██ ██    ██ ██ ██  ██ 
██   ██ ██   ██    ██    ██   ██      ██    ██    ██   ██ ██      ██   ██ ██  ██  ██ ██      ██    ██ ██      ██      ██      ██         ██    ██ ██    ██ ██  ██ ██ 
██████  ██   ██    ██    ██   ██ ███████    ██    ██   ██ ███████ ██   ██ ██      ██  ██████  ██████  ███████ ███████ ███████  ██████    ██    ██  ██████  ██   ████                                                                                                                                                                    
 */


-- Table  datastreamcollection ---------------------------------------------------------------------------------------
CREATE TABLE datastreamcollection
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  guidkey TEXT UNIQUE,
  name TEXT,
  description TEXT NOT NULL, 
  observedarea BLOB,
  beginphenomenontime DATETIME,
  endphenomenontime DATETIME,
  beginresulttime DATETIME, 
  endresulttime DATETIME,
  properties BLOB, 
  idthing Text NOT NULL, 
    FOREIGN KEY (idthing)
      REFERENCES thing(guidkey)
);

-- Contents datastreamcollection  ---------------------------------------------------------------------------------------
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
  'datastreamcollection', -- table name
  'attributes', -- data type
  't_dstcoll', -- unique table identifier
  'datastreamcollection Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger datastreamcollection ---------------------------------------------------------------------------------------
CREATE TRIGGER datastreamcollectionguid
AFTER INSERT ON datastreamcollection
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE datastreamcollection SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER datastreamcollectionguidupdate
AFTER UPDATE OF guidkey ON datastreamcollection
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_ceckvalidphetimedatastreamcollection
BEFORE INSERT ON datastreamcollection
WHEN NEW.beginphenomenontime > NEW.endphenomenontime 
BEGIN
    SELECT RAISE(ABORT, 'Table datastreamcollectiomn: beginphenomenontime must be less than endphenomenontime');
END;

CREATE TRIGGER u_ceckvalidphetimedatastreamcollection
BEFORE UPDATE ON datastreamcollection
WHEN NEW.beginphenomenontime > NEW.endphenomenontime 
BEGIN
    SELECT RAISE(ABORT, 'Table datastreamcollectiomn: beginphenomenontime must be less than endphenomenontime');
END;
--


CREATE TRIGGER i_ceckvalidrestimedatastreamcollection
BEFORE INSERT ON datastreamcollection
WHEN NEW.beginresulttime > NEW.endresulttime 
BEGIN
    SELECT RAISE(ABORT, 'Table datastreamcollectiomn: beginresulttime must be less than endresulttime');
END;

CREATE TRIGGER u_ceckvalidrestimedatastreamcollection
BEFORE UPDATE ON datastreamcollection
WHEN NEW.beginresulttime > NEW.endresulttime 
BEGIN
    SELECT RAISE(ABORT, 'Table datastreamcollectiomn: beginresulttime must be less than endresulttime');
END;
--


/* 
██████   █████  ██████   █████  ███    ███ ███████ ████████ ███████ ██████  
██   ██ ██   ██ ██   ██ ██   ██ ████  ████ ██         ██    ██      ██   ██ 
██████  ███████ ██████  ███████ ██ ████ ██ █████      ██    █████   ██████  
██      ██   ██ ██   ██ ██   ██ ██  ██  ██ ██         ██    ██      ██   ██ 
██      ██   ██ ██   ██ ██   ██ ██      ██ ███████    ██    ███████ ██   ██ 
 */


-- Table  parameter ---------------------------------------------------------------------------------------
CREATE TABLE parameter
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name                       TEXT NOT NULL, 
    value                      TEXT NOT NULL, 
    idobservation TEXT,
    FOREIGN KEY (idobservation) 
      REFERENCES observation(guidkey)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Contents parameter ---------------------------------------------------------------------------------------
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
  'parameter', -- table name
  'attributes', -- data type
  't_pa', -- unique table identifier
  'parameter Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);


/* 
██    ██ ███    ██ ██ ████████  ██████  ███████ ███    ███ ███████  █████  ███████ ██    ██ ██████  ███████ 
██    ██ ████   ██ ██    ██    ██    ██ ██      ████  ████ ██      ██   ██ ██      ██    ██ ██   ██ ██      
██    ██ ██ ██  ██ ██    ██    ██    ██ █████   ██ ████ ██ █████   ███████ ███████ ██    ██ ██████  █████   
██    ██ ██  ██ ██ ██    ██    ██    ██ ██      ██  ██  ██ ██      ██   ██      ██ ██    ██ ██   ██ ██      
 ██████  ██   ████ ██    ██     ██████  ██      ██      ██ ███████ ██   ██ ███████  ██████  ██   ██ ███████ 
 */


-- Table  unitofmeasure ---------------------------------------------------------------------------------------
CREATE TABLE unitofmeasure 
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    guidkey TEXT UNIQUE,
    uomname               TEXT,
    uomsymbol             TEXT,
    measuretype           TEXT,
    namestandardunit      TEXT,
    scaletostandardunit   REAL,
    offsettostandardunit  REAL,
    formula               TEXT
);

-- Contents unitofmeasure ---------------------------------------------------------------------------------------
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
  'unitofmeasure', -- table name
  'attributes', -- data type
  't_uom', -- unique table identifier
  'unitofmeasure  Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger unitofmeasure ---------------------------------------------------------------------------------------
CREATE TRIGGER uomguid
AFTER INSERT ON unitofmeasure
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE unitofmeasure SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER uomguidupdate
AFTER UPDATE OF guidkey ON unitofmeasure
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


/* 
 ██████  ██████  ███████ ███████ ██████  ██    ██  █████  ██████  ██      ███████ ██████  ██████   ██████  ██████  ███████ ██████  ████████ ██    ██ 
██    ██ ██   ██ ██      ██      ██   ██ ██    ██ ██   ██ ██   ██ ██      ██      ██   ██ ██   ██ ██    ██ ██   ██ ██      ██   ██    ██     ██  ██  
██    ██ ██████  ███████ █████   ██████  ██    ██ ███████ ██████  ██      █████   ██████  ██████  ██    ██ ██████  █████   ██████     ██      ████   
██    ██ ██   ██      ██ ██      ██   ██  ██  ██  ██   ██ ██   ██ ██      ██      ██      ██   ██ ██    ██ ██      ██      ██   ██    ██       ██    
 ██████  ██████  ███████ ███████ ██   ██   ████   ██   ██ ██████  ███████ ███████ ██      ██   ██  ██████  ██      ███████ ██   ██    ██       ██  
 */

-- Table  observableproperty ---------------------------------------------------------------------------------------
CREATE TABLE observableproperty
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    guidkey TEXT UNIQUE,
    name                      TEXT, 
    --definition                TEXT, 
    --description               TEXT,
    foi                       TEXT,
    phenomenontype            TEXT,
    basephenomenon            TEXT NOT NULL, 
    domain_min                REAL, 
    domain_max                REAL, 
    domain_typeofvalue        TEXT CHECK (domain_typeofvalue IN ('result_value', 'result_uri')),
    domain_code               TEXT,
    iduom                     TEXT,
    CHECK ((domain_min IS NULL AND domain_max IS NULL) OR (domain_min IS NOT NULL AND domain_max IS NOT NULL)),
    FOREIGN KEY (iduom) 
      REFERENCES unitofmeasure(guidkey) 

);

-- Contents observableproperty ---------------------------------------------------------------------------------------
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
  'observableproperty', -- table name
  'attributes', -- data type
  't_op', -- unique table identifier
  'observableproperty Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger observableproperty ---------------------------------------------------------------------------------------
CREATE TRIGGER observablepropertyguid
AFTER INSERT ON observableproperty
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE observableproperty SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER observablepropertyguidupdate
AFTER UPDATE OF guidkey ON observableproperty
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_foi
BEFORE INSERT ON observableproperty
FOR EACH ROW
WHEN NEW.foi NOT IN (SELECT id FROM codelist WHERE collection = 'FOIType')
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: Invalid value for foi. Must be present in id of foi codelist.');
END;

CREATE TRIGGER u_foi
BEFORE UPDATE ON observableproperty
FOR EACH ROW
WHEN NEW.foi NOT IN (SELECT id FROM codelist WHERE collection = 'FOIType')
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: Invalid value for foi. Must be present in id of foi codelist.');
END;
--


CREATE TRIGGER i_phenomenonType
BEFORE INSERT ON observableproperty
FOR EACH ROW
WHEN NEW.phenomenontype NOT IN (SELECT id FROM codelist WHERE collection = 'PhenomenonType')
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: Invalid value for phenomenonType. Must be present in PhenomenonType.');
END;

CREATE TRIGGER u_phenomenonType
BEFORE UPDATE ON observableproperty
FOR EACH ROW
WHEN NEW.phenomenontype NOT IN (SELECT id FROM codelist WHERE collection = 'PhenomenonType')
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: Invalid value for phenomenonType. Must be present in PhenomenonType.');
END;
--


CREATE TRIGGER i_basephenomenon
BEFORE INSERT ON observableproperty
FOR EACH ROW
WHEN NEW.basephenomenon NOT IN (SELECT id FROM codelist WHERE foi_phenomenon IN(NEW.foi ||NEW.phenomenonType))
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: Invalid value for basephenomenon. The values must be present in the PhenomenonTypevalue of the Feature Of Interest and the Phenomenon type defined in the record.');
END;

CREATE TRIGGER u_basephenomenon
BEFORE UPDATE ON observableproperty
FOR EACH ROW
WHEN NEW.basephenomenon NOT IN (SELECT id FROM codelist WHERE foi_phenomenon IN(NEW.foi ||NEW.phenomenonType))
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: Invalid value for basephenomenon. The values must be present in the PhenomenonTypevalue of the Feature Of Interest and the Phenomenon type defined in the record.');
END;
--


CREATE TRIGGER i_ceckdomain
BEFORE INSERT ON observableproperty
WHEN NEW.domain_min > NEW.domain_max 
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: domain_min must be less than domain_max');
END;

CREATE TRIGGER u_ceckdomain
BEFORE UPDATE ON observableproperty
WHEN NEW.domain_min > NEW.domain_max 
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty: domain_min must be less than domain_max');
END; 
--


CREATE TRIGGER i_ceckdomain_code
BEFORE INSERT ON observableproperty
WHEN NEW.domain_typeofvalue = 'result_value' AND NEW.domain_code IS NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty:  For domain_typeofvalue = result_value , domain_code must be NULL'); 
END;

CREATE TRIGGER u_ceckdomain_code
BEFORE UPDATE ON observableproperty
WHEN NEW.domain_typeofvalue = 'result_value' AND NEW.domain_code IS NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty:  For domain_typeofvalue = result_value , domain_code must be NULL'); 
END;
--

CREATE TRIGGER i_ceckdomain_value
BEFORE INSERT ON observableproperty
WHEN NEW.domain_typeofvalue = 'result_uri' AND (NEW.domain_min IS NOT NULL OR NEW.domain_max IS NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty:  For domain_typeofvalue = result_uri , domdomain_min and domain_max  must be NULL'); 
END;

CREATE TRIGGER u_ceckdomain_value
BEFORE UPDATE ON observableproperty
WHEN NEW.domain_typeofvalue = 'result_uri' AND (NEW.domain_min IS NOT NULL OR NEW.domain_max IS NOT NULL)
BEGIN
    SELECT RAISE(ABORT, 'Table observableproperty:  For domain_typeofvalue = result_uri , domdomain_min and domain_max  must be NULL'); 
END;
--


/* 
███████ ███████ ███    ██ ███████  ██████  ██████  
██      ██      ████   ██ ██      ██    ██ ██   ██ 
███████ █████   ██ ██  ██ ███████ ██    ██ ██████  
     ██ ██      ██  ██ ██      ██ ██    ██ ██   ██ 
███████ ███████ ██   ████ ███████  ██████  ██   ██                                                  
 */

-- Table sensor  ---------------------------------------------------------------------------------------
CREATE TABLE sensor 
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  guidkey TEXT UNIQUE,
  name TEXT NOT NULL, 
  description TEXT NOT NULL 
);

-- Contents sensor ---------------------------------------------------------------------------------------
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
  'sensor', -- table name
  'attributes', -- data type
  't_sen', -- unique table identifier
  'sensor Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger sensor ---------------------------------------------------------------------------------------
CREATE TRIGGER sensorguid
AFTER INSERT ON sensor
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE sensor SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER sensorguidupdate
AFTER UPDATE OF guidkey ON sensor
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


/* 
████████ ██   ██ ██ ███    ██  ██████  
   ██    ██   ██ ██ ████   ██ ██       
   ██    ███████ ██ ██ ██  ██ ██   ███ 
   ██    ██   ██ ██ ██  ██ ██ ██    ██ 
   ██    ██   ██ ██ ██   ████  ██████  
 */

-- Table thing  ---------------------------------------------------------------------------------------
CREATE TABLE thing 
(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  guidkey TEXT UNIQUE,
  name TEXT NOT NULL, 
  description TEXT NOT NULL, 
  properties BLOB 
);

-- Contents thing ---------------------------------------------------------------------------------------
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
  'thing', -- table name
  'attributes', -- data type
  't_thi', -- unique table identifier
  'thing Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger thing ---------------------------------------------------------------------------------------
CREATE TRIGGER thingguid
AFTER INSERT ON thing
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE thing SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER thingguidupdate
AFTER UPDATE OF guidkey ON thing
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;


/* 
██████  ██████   ██████   ██████ ███████ ███████ ███████ 
██   ██ ██   ██ ██    ██ ██      ██      ██      ██      
██████  ██████  ██    ██ ██      █████   ███████ ███████ 
██      ██   ██ ██    ██ ██      ██           ██      ██ 
██      ██   ██  ██████   ██████ ███████ ███████ ███████ 
 */


-- Table  process ---------------------------------------------------------------------------------------
 CREATE TABLE process
( 
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey                  TEXT UNIQUE,
    inspireid_localid        TEXT, 
    inspireid_namespace      TEXT, 
    inspireid_versionid      TEXT, 
    name                     TEXT, 
    description              TEXT, 
    type             TEXT NOT NULL, 
    idrelatedparty1  TEXT NOT NULL,
    idrelatedparty2  TEXT,
    iddocumentcitation1 TEXT,
    iddocumentcitation2 TEXT,
    FOREIGN KEY (idrelatedparty1)
      REFERENCES relatedparty(guidkey),
    FOREIGN KEY (idrelatedparty2)
      REFERENCES relatedparty(guidkey),       
    FOREIGN KEY (iddocumentcitation1)
      REFERENCES documentcitation(guidkey),
    FOREIGN KEY (iddocumentcitation2)
      REFERENCES documentcitation(guidkey)
);

-- Contents process ---------------------------------------------------------------------------------------
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
  'process', -- table name
  'attributes', -- data type
  't_pro', -- unique table identifier
  'process Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger process ---------------------------------------------------------------------------------------
CREATE TRIGGER processguid
AFTER INSERT ON process
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE process SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER processguidupdate
AFTER UPDATE OF guidkey ON process
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


/* 
██████   ██████   ██████ ██    ██ ███    ███ ███████ ███    ██ ████████  ██████ ██ ████████  █████  ████████ ██  ██████  ███    ██ 
██   ██ ██    ██ ██      ██    ██ ████  ████ ██      ████   ██    ██    ██      ██    ██    ██   ██    ██    ██ ██    ██ ████   ██ 
██   ██ ██    ██ ██      ██    ██ ██ ████ ██ █████   ██ ██  ██    ██    ██      ██    ██    ███████    ██    ██ ██    ██ ██ ██  ██ 
██   ██ ██    ██ ██      ██    ██ ██  ██  ██ ██      ██  ██ ██    ██    ██      ██    ██    ██   ██    ██    ██ ██    ██ ██  ██ ██ 
██████   ██████   ██████  ██████  ██      ██ ███████ ██   ████    ██     ██████ ██    ██    ██   ██    ██    ██  ██████  ██   ████ 
 */


-- Table  documentcitation
CREATE TABLE documentcitation 
(     
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    name                  TEXT, 
    shortname             TEXT, 
    date                  DATETIME,
    link                  TEXT, 
    specificreference     TEXT 
);

-- Contents documentcitation
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
  'documentcitation', -- table name
  'attributes', -- data type
  't_docc', -- unique table identifier
  'documentcitation Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger documentcitation ---------------------------------------------------------------------------------------
CREATE TRIGGER documentcitationguid
AFTER INSERT ON documentcitation
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE documentcitation SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER documentcitationguidupdate
AFTER UPDATE OF guidkey ON documentcitation
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


/* 
██████  ██████   ██████   ██████ ███████ ███████ ███████ ██████   █████  ██████   █████  ███    ███ ███████ ████████ ███████ ██████  
██   ██ ██   ██ ██    ██ ██      ██      ██      ██      ██   ██ ██   ██ ██   ██ ██   ██ ████  ████ ██         ██    ██      ██   ██ 
██████  ██████  ██    ██ ██      █████   ███████ ███████ ██████  ███████ ██████  ███████ ██ ████ ██ █████      ██    █████   ██████  
██      ██   ██ ██    ██ ██      ██           ██      ██ ██      ██   ██ ██   ██ ██   ██ ██  ██  ██ ██         ██    ██      ██   ██ 
██      ██   ██  ██████   ██████ ███████ ███████ ███████ ██      ██   ██ ██   ██ ██   ██ ██      ██ ███████    ██    ███████ ██   ██ 
 */


-- Table  processparameter ---------------------------------------------------------------------------------------
CREATE TABLE processparameter
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name                             TEXT  NOT NULL,  -- Codelist processparameternamevalue 
    description                      TEXT,  
    idprocess               TEXT,
        FOREIGN KEY (idprocess)
          REFERENCES process(guidkey)
          ON DELETE CASCADE
          ON UPDATE CASCADE

);

-- Contents processparameter ---------------------------------------------------------------------------------------
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
  'processparameter', -- table name
  'attributes', -- data type
  't_prp', -- unique table identifier
  'processparameter Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger processparameter ---------------------------------------------------------------------------------------
CREATE TRIGGER i_name
BEFORE INSERT ON processparameter
FOR EACH ROW
WHEN NEW.name NOT IN (SELECT id FROM codelist WHERE collection = 'ProcessParameterNameValue')
BEGIN
    SELECT RAISE(ABORT, 'Table processparameter: Invalid value for name. Must be present in id of processparameternamevalue codelist.');
END;

CREATE TRIGGER u_name
BEFORE UPDATE ON processparameter
FOR EACH ROW
WHEN NEW.name NOT IN (SELECT id FROM codelist WHERE collection = 'ProcessParameterNameValue')
BEGIN
    SELECT RAISE(ABORT, 'Table processparameter: Invalid value for name. Must be present in id of processparameternamevalue codelist.');
END;
--


/* 
██████  ███████ ██       █████  ████████ ███████ ██████  ██████   █████  ██████  ████████ ██    ██ 
██   ██ ██      ██      ██   ██    ██    ██      ██   ██ ██   ██ ██   ██ ██   ██    ██     ██  ██  
██████  █████   ██      ███████    ██    █████   ██   ██ ██████  ███████ ██████     ██      ████   
██   ██ ██      ██      ██   ██    ██    ██      ██   ██ ██      ██   ██ ██   ██    ██       ██    
██   ██ ███████ ███████ ██   ██    ██    ███████ ██████  ██      ██   ██ ██   ██    ██       ██    

 */


-- Table  relatedparty --------------------------------------------------------------------------------------
CREATE TABLE  relatedparty
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    guidkey TEXT UNIQUE,
    individualname                      TEXT, 
    organizationname                    TEXT, 
    positionname                        TEXT, 
    address                             TEXT, 
    contactinstructions                 TEXT, 
    electronicmailaddress               TEXT, 
    hoursofservice                      TEXT, 
    telephonefacsimile                  INTEGER, 
    telephonevoice                      INTEGER, 
    website                             TEXT, 
    role                                TEXT   -- Codelist ResponsiblePartyRole
);

-- Contents relatedparty --------------------------------------------------------------------------------------
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
  'relatedparty', -- table name
  'attributes', -- data type
  't_rp', -- unique table identifier
  'relatedparty Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL,  
  NULL,
  NULL,
  NULL,
  NULL  -- EPSG spatial reference system code
);

-- Trigger relatedparty ---------------------------------------------------------------------------------------
CREATE TRIGGER relatedpartyguid
AFTER INSERT ON relatedparty
FOR EACH ROW
WHEN (NEW.guidkey IS NULL)
BEGIN
   UPDATE relatedparty SET guidkey = (select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) ) WHERE rowid = NEW.rowid;
END;

CREATE TRIGGER relatedpartyguidupdate
AFTER UPDATE OF guidkey ON relatedparty
BEGIN
    SELECT CASE
        WHEN NEW.guidkey != OLD.guidkey THEN
            RAISE (ABORT, 'Cannot update guidkey column.')
    END;
END;
--


CREATE TRIGGER i_role
BEFORE INSERT ON relatedparty
FOR EACH ROW
WHEN NEW.role NOT IN (SELECT id FROM codelist WHERE collection = 'ResponsiblePartyRole') AND NEW.role NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table relatedparty: Invalid value for role. Must be present in id of responsiblepartyrole codelist.');
END;

CREATE TRIGGER u_role
BEFORE UPDATE ON relatedparty
FOR EACH ROW
WHEN NEW.role NOT IN (SELECT id FROM codelist WHERE collection = 'ResponsiblePartyRole') AND NEW.role NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'Table relatedparty: Invalid value for role. Must be present in id of responsiblepartyrole codelist.');
END;
--


/* 
 ██████  ██████  ██████  ███████ ██      ██ ███████ ████████ 
██      ██    ██ ██   ██ ██      ██      ██ ██         ██    
██      ██    ██ ██   ██ █████   ██      ██ ███████    ██    
██      ██    ██ ██   ██ ██      ██      ██      ██    ██    
 ██████  ██████  ██████  ███████ ███████ ██ ███████    ██    
 */

-- Table codelist -----------------------------------------------------------------------------
create table codelist
(
    id             TEXT,
    label          TEXT,
    definition     TEXT,
    collection     TEXT,
    foi            TEXT,
    phenomenon     TEXT,
    foi_phenomenon TEXT,
    parent         TEXT
);

-- Contents  codelist -----------------------------------------------------------------------------
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
  'codelist', -- table name
  'attributes', -- data type
  't_cod', -- unique table identifier
  'codelist Table', -- table description
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  NULL -- EPSG spatial reference system code
);


-- SoilInvestigationPurposeValue
-- FEATURE soilsite
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue/generalSoilSurvey', 'general soil survey', 'Soil characterisation with unbiased selection of investigation location.', 'SoilInvestigationPurposeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue/specificSoilSurvey', 'specific soil survey', 'Investigation of soil properties at locations biased by a specific purpose.', 'SoilInvestigationPurposeValue', null, null, null, null);


-- SoilPlotTypeValue
-- FEATURE soilplot
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/borehole', 'borehole', 'Penetration into the sub-surface with removal of soil/rock material by using, for instance, a hollow tube-shaped tool, in order to carry out profile descriptions, sampling and/or field tests.', 'SoilPlotTypeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/sample', 'sample', 'Exacavation where soil material is removed as a soil sample without doing any soil profile description.', 'SoilPlotTypeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/trialPit', 'trial pit', 'Excavation or other exposition of the soil prepared to carry out profile descriptions, sampling and/or field tests.', 'SoilPlotTypeValue', null, null, null, null);

-- *** INTERNAL *** 
-- WRBRversion
-- FEATURE  soilprofile
-- CODELIST for internal management of Qgis forms based on real URI of WRB Classification

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue', 'WRB 2006', null, 'wrbversion', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/WRB_2014-2015','WRB 2014','World reference base for soil resources 2014, Update 2015 (WRB_2014-2015)','wrbversion', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/', 'WRB 2022', null, 'wrbversion', null, null, null, null);


-- WRBReferenceSoilGroupValue (2006)
-- FEATURE soilprofile
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/acrisol', 'Acrisols', 'Soil having an argic horizon, CECclay < 50%.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/albeluvisol', 'Albeluvisols', 'Soil having an argic horizon and albeluvic tonguin.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/alisol', 'Alisols', 'Soil having an argic horizon with CECclay >24 and BS < 50%.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/andosol', 'Andosols', 'Soil having an andic or vitric horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/anthrosol', 'Anthrosols', 'Soils profoundly modified through long-term human activities.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/arenosol', 'Arenosols', 'Soil having a coarse texture up to >100 cm depth.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/calcisol', 'Calcisols', 'Soil having a calcic or petrocalcic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/cambisol', 'Cambisols', 'Soil having a cambic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/chernozem', 'Chernozems', 'Soil having a chernic or blackish mollic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/cryosol', 'Cryosols', 'Soil having a cryic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/durisol', 'Durisols', 'Soil having a duric or petroduric horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/ferralsol', 'Ferralsols', 'Soil having a ferralic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/fluvisol', 'Fluvisols', 'Soil having a fluvic materials.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/gleysol', 'Gleysols', 'Soil having a gleyic properties.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/gypsisol', 'Gypsisols', 'Soil having a gypsic or petrogypsic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/histosol', 'Histosols', 'Soil having organic matter >40 cm depth.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/kastanozem', 'Kastanozems', 'Soil having a brownish mollic horizon and secondary CaCO3.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/leptosol', 'Leptosols', 'Shallow soils, <=25 cm deep', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/lixisol', 'Lixisols', 'Soil having an argic horizon and CECclay <24.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/luvisol', 'Luvisols', 'Soil having an argic horizon and CECclay >24.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/nitisol', 'Nitisols', 'Soil having a nitic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/phaeozem', 'Phaeozems', 'Soil having a mollic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/planosol', 'Planosols', 'Soil having reducing condition and pedogenetic abrupt textural change.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/plinthosol', 'Plinthosols', 'Soil having plinthite or petroplinthite.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/podzol', 'Podzols', 'Soil having a spodic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/regosol', 'Regosols', 'Soil without a diagnostic horizon', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/solonchak', 'Solonchaks', 'Soil having a salic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/solonetz', 'Solonetzs', 'Soil having a natric horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/stagnosol', 'Stagnosols', 'Soil having reducing condition.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/technosol', 'Technosols', 'Soil having a human artefacts.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/umbrisol', 'Umbrisols', 'Soil having an umbric horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/vertisol', 'Vertisols', 'Soil having a vertic horizon.', 'WRBReferenceSoilGroupValue', null, null, null, null);


-- WRBReferenceSoilGroupValue (2014)
-- FEATURE soilprofile
-- CODELIST AGROPRTAL
-- https://agroportal.lirmm.fr/ontologies/AGROVOC

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_101','Acrisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_479c499a','Alisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_404','Andosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_4515b13e','Anthrosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_601','Arenosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_ea60e31f','Calcisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_1224','Cambisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_1533','Chernozems','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_829043c3','Cryosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_51ec138f','Durisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_2858','Ferralsols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_3000','Fluvisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_3276','Gleysols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_61704b51','Gypsisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_3636','Histosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_4079','Kastanozems','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_da0af025','Leptosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_7283bd0a','Lixisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_4470','Luvisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_5185','Nitisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_5755','Phaeozems','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_5953','Planosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_309e7c25','Plinthosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_6044','Podzols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_6492','Regosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_ff831af0','Retisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_7231','Solonchaks','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_7232','Solonetz','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_d9028da2','Stagnosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_3a0750ba','Technosols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_9e95a849','Umbrisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGROVOC/c_8199','Vertisols','','WRBReferenceSoilGroupValue2014', null, null, null, null);



-- WRBReferenceSoilGroupValue (2022)
-- FEATURE soilprofile
-- CODELIST ORBL-SOIL
-- https://obrl-soil.github.io/wrbsoil2022/

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-ac', 'Acrisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-al', 'Alisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-an', 'Andosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-at', 'Anthrosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-ar', 'Arenosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-cl', 'Calcisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-cm', 'Cambisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-ch', 'Chernozems', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-cr', 'Cryosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-du', 'Durisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-fr', 'Ferralsols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-fl', 'Fluvisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-gl', 'Gleysols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-gy', 'Gypsisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-hs', 'Histosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-ks', 'Kastanozems', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-lp', 'Leptosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-lx', 'Lixisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-lv', 'Luvisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-nt', 'Nitisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-ph', 'Phaeozems', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-pl', 'Planosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-pt', 'Plinthosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-pz', 'Podzols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html#sec-key-rg', 'Regosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-rt', 'Retisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-sc', 'Solonchaks', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-sn', 'Solonetz', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-st', 'Stagnosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-tc', 'Technosols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-um', 'Umbrisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-04.html?q=acrisol#sec-key-vr', 'Vertisols', null, 'WRBReferenceSoilGroupValue2022', null, null, null, null);



-- OtherSoilNameTypeValue
-- FEATURE othersoilnametype
-- CODELIST INSPIRE
-- https://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue','Void','Void','OtherSoilNameTypeValue', null, null, null, null);


-- LayerTypeValue
-- FEATURE profileelement
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/LayerTypeValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/depthInterval', 'depth interval', 'Fixed depth range where soil is described and/or samples are taken.', 'LayerTypeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic', 'geogenic', 'Domain of the soil profile composed of material resulting from the same, non-pedogenic process, e.g. sedimentation, that might display an unconformity to possible over- or underlying adjacent domains.', 'LayerTypeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/subSoil', 'subsoil', 'Natural soil material below the topsoil and overlying the unweathered parent material.', 'LayerTypeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerTypeValue/topSoil', 'topsoil', 'Upper part of a natural soil that is generally dark coloured and has a higher content of organic matter and nutrients when compared to the (mineral) horizons below excluding the humus layer.', 'LayerTypeValue', null, null, null, null);


-- LithologyValue
-- FEATURE profileelement
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/LithologyValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/acidicIgneousMaterial', 'acidicIgneousMaterial', 'acidicIgneousMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/acidicIgneousRock', 'acidicIgneousRock', 'acidicIgneousRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/alkaliFeldsparRhyolite', 'alkaliFeldsparRhyolite', 'alkaliFeldsparRhyolite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/amphibolite', 'amphibolite', 'amphibolite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/anthropogenicMaterial', 'anthropogenicMaterial', 'anthropogenicMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/ashAndLapilli', 'ashAndLapilli', 'ashAndLapilli', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/ashBrecciaBombOrBlockTephra', 'ashBrecciaBombOrBlockTephra', 'ashBrecciaBombOrBlockTephra', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/basicIgneousMaterial', 'basicIgneousMaterial', 'basicIgneousMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/boulderGravelSizeSediment', 'boulderGravelSizeSediment', 'boulderGravelSizeSediment', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/breccia', 'breccia', 'breccia', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateMudstone', 'carbonateMudstone', 'carbonateMudstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateRichMudstone', 'carbonateRichMudstone', 'carbonateRichMudstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateSedimentaryMaterial', 'carbonateSedimentaryMaterial', 'carbonateSedimentaryMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateSedimentaryRock', 'carbonateSedimentaryRock', 'carbonateSedimentaryRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/cataclasiteSeries', 'cataclasiteSeries', 'cataclasiteSeries', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chalk', 'chalk', 'chalk', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chemicalSedimentaryMaterial', 'chemicalSedimentaryMaterial', 'chemicalSedimentaryMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/chloriteActinoliteEpidoteMetamorphicRock', 'chloriteActinoliteEpidoteMetamorphicRock', 'chloriteActinoliteEpidoteMetamorphicRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/clasticSedimentaryMaterial', 'clasticSedimentaryMaterial', 'clasticSedimentaryMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/crystallineCarbonate', 'crystallineCarbonate', 'crystallineCarbonate', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/dacite', 'dacite', 'dacite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/dolomite', 'dolomite', 'dolomite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/eclogite', 'eclogite', 'eclogite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/foliatedMetamorphicRock', 'foliatedMetamorphicRock', 'foliatedMetamorphicRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/fragmentalIgneousMaterial', 'fragmentalIgneousMaterial', 'fragmentalIgneousMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/framestone', 'framestone', 'framestone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericConglomerate', 'genericConglomerate', 'genericConglomerate', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericMudstone', 'genericMudstone', 'genericMudstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/genericSandstone', 'genericSandstone', 'genericSandstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/gneiss', 'gneiss', 'gneiss', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/grainstone', 'grainstone', 'grainstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granite', 'granite', 'granite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granodiorite', 'granodiorite', 'granodiorite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granofels', 'granofels', 'granofels', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/granulite', 'granulite', 'granulite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hornfels', 'hornfels', 'hornfels', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hybridSediment', 'hybridSediment', 'hybridSediment', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/hybridSedimentaryRock', 'hybridSedimentaryRock', 'hybridSedimentaryRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/igneousMaterial', 'igneousMaterial', 'igneousMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/igneousRock', 'igneousRock', 'igneousRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureCarbonateSedimentaryRock', 'impureCarbonateSedimentaryRock', 'impureCarbonateSedimentaryRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureDolomite', 'impureDolomite', 'impureDolomite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/impureLimestone', 'impureLimestone', 'impureLimestone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/intermediateCompositionIgneousMaterial', 'intermediateCompositionIgneousMaterial', 'intermediateCompositionIgneousMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/limestone', 'limestone', 'limestone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/marble', 'marble', 'marble', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/materialFormedInSurficialEnvironment', 'materialFormedInSurficialEnvironment', 'materialFormedInSurficialEnvironment', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/metamorphicRock', 'metamorphicRock', 'metamorphicRock', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/micaSchist', 'micaSchist', 'micaSchist', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/migmatite', 'migmatite', 'migmatite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/mineDumpMaterial', 'mineDumpMaterial', 'mineDumpMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/monzogranite', 'monzogranite', 'monzogranite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/mudSizeSediment', 'mudSizeSediment', 'mudSizeSediment', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/naturalUnconsolidatedMaterial', 'naturalUnconsolidatedMaterial', 'naturalUnconsolidatedMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/nonClasticSiliceousSedimentaryMaterial', 'nonClasticSiliceousSedimentaryMaterial', 'nonClasticSiliceousSedimentaryMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/organicBearingMudstone', 'organicBearingMudstone', 'organicBearingMudstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/organicRichSedimentaryMaterial', 'organicRichSedimentaryMaterial', 'organicRichSedimentaryMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/packstone', 'packstone', 'packstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/peat', 'peat', 'peat', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/phyllite', 'phyllite', 'phyllite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/sandSizeSediment', 'sandSizeSediment', 'sandSizeSediment', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/silicateMudstone', 'silicateMudstone', 'silicateMudstone', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/skarn', 'skarn', 'skarn', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/slate', 'slate', 'slate', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/syenogranite', 'syenogranite', 'syenogranite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tephra', 'tephra', 'tephra', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tonalite', 'tonalite', 'tonalite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/tuffite', 'tuffite', 'tuffite', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/unconsolidatedMaterial', 'unconsolidatedMaterial', 'unconsolidatedMaterial', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/waste', 'waste', 'waste', 'LithologyValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', 'https://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', 'https://inspire.ec.europa.eu/codelist/LithologyValue/carbonateWackestone', 'LithologyValue', null, null, null, null);


-- EventProcessValue
-- FEATURE profileelement
-- CODELIST INSPIRE
--http://inspire.ec.europa.eu/codelist/EventProcessValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/bolideImpact', 'bolide impact', 'The impact of an extraterrestrial body on the surface of the earth.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/cometaryImpact', 'cometary impact', 'the impact of a comet on the surface of the earth', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/meteoriteImpact', 'meteorite impact', 'the impact of a meteorite on the surface of the earth', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deepWaterOxygenDepletion', 'deep water oxygen depletion', 'Process of removal of oxygen from from the deep part of a body of water.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deformation', 'deformation', 'Movement of rock bodies by displacement on fault or shear zones, or change in shape of a body of earth material.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/ductileFlow', 'ductile flow', 'deformation without apparent loss of continuity at the scale of observation.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/faulting', 'faulting', 'The process of fracturing, frictional slip, and displacement accumulation that produces a fault', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/folding', 'folding', 'deformation in which planar surfaces become regularly curviplanar surfaces with definable limbs (zones of lower curvature) and hinges (zones of higher curvature).', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/fracturing', 'fracturing', 'The formation of a surface of failure resulting from stress', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/shearing', 'shearing', 'A deformation in which contiguous parts of a body are displaced relatively to each other in a direction parallel to a surface. The surface may be a discrete fault, or the deformation may be a penetrative strain and the shear surface is a geometric abstraction.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/diageneticProcess', 'diagenetic process', 'Any chemical, physical, or biological process that affects a sedimentary earth material after initial deposition, and during or after lithification, exclusive of weathering and metamorphism.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/extinction', 'extinction', 'Process of disappearance of a species or higher taxon, so that it no longer exists anywhere or in the subsequent fossil record.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/geomagneticProcess', 'geomagnetic process', 'Process that results in change in Earth''s magnetic field.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magneticFieldReversal', 'magnetic field reversal', 'geomagnetic event', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/polarWander', 'polar wander', 'process of migration of the axis of the earth''s dipole field relative to the rotation axis of the Earth.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/humanActivity', 'human activity', 'Processes of human modification of the earth to produce geologic features.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/excavation', 'excavation', 'removal of material, as in a mining operation', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/grading', 'grading', 'leveling of earth surface by rearrangement of prexisting material', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/materialTransportAndDeposition', 'material transport and deposition', 'transport and heaping of material, as in a land fill, mine dump, dredging operations', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/mixing', 'mixing', 'Mixing', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticProcess', 'magmatic process', 'A process involving melted rock (magma).', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/eruption', 'eruption', 'The ejection of volcanic materials (lava, pyroclasts, and volcanic gases) onto the Earth''s surface, either from a central vent or from a fissure or group of fissures', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/intrusion', 'intrusion', 'The process of emplacement of magma in pre-existing rock', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/magmaticCrystallisation', 'magmatic crystallisation', 'The process by which matter becomes crystalline, from a gaseous, fluid, or dispersed state', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/melting', 'melting', 'change of state from a solid to a liquid', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/metamorphicProcess', 'metamorphic process', 'Mineralogical, chemical, and structural adjustment of solid rocks to physical and chemical conditions that differ from the conditions under which the rocks in question originated, and are generally been imposed at depth, below the surface zones of weathering and cementation.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/alteration', 'alteration', 'General term for any change in the mineralogical or chemical composition of a rock. Typically related to interaction with hydrous fluids.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/contactMetamorphism', 'contact metamorphism', 'Metamorphism taking place in rocks at or near their contact with a genetically related body of igneous rock', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/dislocationMetamorphism', 'dislocation metamorphism', 'Metamorphism concentrated along narrow belts of shearing or crushing without an appreciable rise in temperature', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelChange', 'sea level change', 'Process of mean sea level changing relative to some datum.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelFall', 'sea level fall', 'process of mean sea level falling relative to some datum', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/seaLevelRise', 'sea level rise', 'process of mean sea level rising relative to some datum', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/sedimentaryProcess', 'sedimentary process', 'A phenomenon that changes the distribution or physical properties of sediment at or near the earth''s surface.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deposition', 'deposition', 'Accumulation of material; the constructive process of accumulation of sedimentary particles, chemical precipitation of mineral matter from solution, or the accumulation of organicMaterial on the death of plants and animals.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/erosion', 'erosion', 'The process of disaggregation of rock and displacement of the resultant particles (sediment) usually by the agents of currents such as, wind, water, or ice by downward or down-slope movement in response to gravity or by living organisms (in the case of bioerosion).', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/speciation', 'speciation', 'Process that results inappearance of new species.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/tectonicProcess', 'tectonic process', 'Processes related to the interaction between or deformation of rigid plates forming the crust of the Earth.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/accretion', 'accretion', 'The addition of material to a continent. Typically involves convergent or transform motion.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/continentalBreakup', 'continental breakup', 'Fragmentation of a continental plate into two or more smaller plates; may involve rifting or strike slip faulting.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/continentalCollision', 'continental collision', 'The amalgamation of two continental plates or blocks along a convergent margin.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/obduction', 'obduction', 'The overthrusting of continental crust by oceanic crust or mantle rocks at a convergent plate boundary.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/orogenicProcess', 'orogenic process', 'mountain building process.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/spreading', 'spreading', 'A process whereby new oceanic crust is formed by upwelling of magma at the center of mid-ocean ridges and by a moving-away of the new material from the site of upwelling at rates of one to ten centimeters per year.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/subduction', 'subduction', 'The process of one lithospheric plate descending beneath another', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/transformFaulting', 'transform faulting', 'A strike-slip fault that links two other faults or two other plate boundaries (e.g. two segments of a mid-ocean ridge). Transform faults often exhibit characteristics that distinguish them from transcurrent faults: (1) For transform faults formed at the same time as the faults they link, slip on the transform fault has equal magnitude at all points along the transform; slip magnitude on the transform fault can exceed the length of the transform fault, and slip does not decrease to zero at the fault termini. (2) For transform faults linking two similar features, e.g. if two mid-ocean ridge segments linked by a transform have equal spreading rates, then the length of the transform does not change as slip accrues on it.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/weathering', 'weathering', 'The process or group of processes by which earth materials exposed to atmospheric agents at or near the Earth''s surface are changed in color, texture, composition, firmness, or form, with little or no transport of the loosened or altered material. Processes typically include oxidation, hydration, and leaching of soluble constituents.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/biologicalWeathering', 'biological weathering', 'breakdown of rocks by biological agents, e.g. the penetrating and expanding force of roots, the presence of moss and lichen causing humic acids to be retained in contact with rock, and the work of animals (worms, moles, rabbits) in modifying surface soil', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/chemicalWeathering', 'chemical weathering', 'The process of weathering by which chemical reactions (hydrolysis, hydration, oxidation, carbonation, ion exchange, and solution) transform rocks and minerals into new chemical combinations that are stable under conditions prevailing at or near the Earth''s surface; e.g. the alteration of orthoclase to kaolinite.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/physicalWeathering', 'physical weathering', 'The process of weathering by which frost action, salt-crystal growth, absorption of water, and other physical processes break down a rock to fragments, involving no chemical change', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/deepPloughing', 'deep ploughing', 'mixing of loose surface material by ploughing deeper than frequently done during annual soil cultivation', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionByOrFromMovingIce', 'deposition by or from moving ice', 'Deposition of sediment from ice by melting or pushing. The material has been transported in the ice after entrainment in the moving ice or after deposition from other moving fluids on the ice.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionFromAir', 'deposition from air', 'Deposition of sediment from air, in which the sediment has been transported after entrainment in the moving air.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/depositionFromWater', 'deposition from water', 'Deposition of sediment from water, in which the sediment has been transported after entrainment in the moving water or after deposition from other moving fluids.', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/digging', 'digging', 'repeated mixing of loose surface material by digging with a spade or similar tool', 'EventProcessValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventProcessValue/geologicProcess', 'geologic process', 'process that effects the geologic record', 'EventProcessValue', null, null, null, null);


-- EventEnvironmentValue
-- FEATURE profileelement
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/EventEnvironmentValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/agriculturalAndForestryLandSetting''', 'agricultural and forestry land setting', 'Human influence setting with intensive agricultural activity or forestry land use,  including forest plantations.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/carbonateShelfSetting', 'carbonate shelf setting', 'A type of carbonate platform that is attached to a continental landmass and a region of sedimentation that is analogous to shelf environments for terrigenous clastic deposition. A carbonate shelf may receive some supply of material from the adjacent landmass.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaSlopeSetting', 'delta slope setting', 'Slope setting within the deltaic  system.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dwellingAreaSetting', 'dwelling area setting', 'Dwelling area setting.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/earthInteriorSetting', 'earth interior setting', 'Geologic environments within the solid Earth.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/earthSurfaceSetting', 'earth surface setting', 'Geologic environments on the surface of the solid Earth.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/extraTerrestrialSetting', 'extra-terrestrial setting', 'Material originated outside of the Earth or its atmosphere.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/fanDeltaSetting', 'fan delta setting', 'A debris-flow or sheetflood-dominated alluvial fan build out into a lake or the sea.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/foreshore', 'foreshore', 'A foreshore is the region between mean high water and mean low water marks of the tides. Depending on the tidal range this may be a vertical distance of anything from a few tens of centimetres to many meters.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciofluvialSetting', 'glaciofluvial setting', 'A setting influenced by glacial meltwater streams. This setting can be sub- en-, supra- and proglacial.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciolacustrineSetting', 'glaciolacustrine setting', 'Ice margin lakes and other lakes related to glaciers. Where meltwater streams enter the lake, sands and gravels are deposited in deltas. At the lake floor, typivally rhythmites (varves) are deposited.Ice margin lakes and other lakes related to glaciers.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glaciomarineSetting', 'glaciomarine setting', 'A marine environment influenced by glaciers. Dropstone diamictons and dropstone muds are typical deposits in this environment.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/graben', 'graben', 'An elongate trough or basin, bounded on both sides by high-angle normal faults that dip toward one another. It is a structual form that may or may not be geomorphologically expressed as a rift valley.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/halfGraben', 'half-graben', 'A elongate , asymmetric trough or basin bounded on one side by a normal fault.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humanEnvironmentSetting', 'human environment setting', 'Human environment setting.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intracratonicSetting', 'intracratonic setting', 'A basin formed within the interior region  of a continent, away from plate boundaries.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/landReclamationSetting', 'land reclamation setting', '''Human influence setting making land capable of more intensive use by changing its general character, as by drainage of excessively wet land, irrigation of arid or semiarid land; or recovery of submerged land from seas, lakes and rivers, restoration after human-induced degradation by removing toxic substances.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/miningAreaSetting', 'mining area setting', 'Human influence setting in which mineral resources are extracted from the ground.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/saltPan', 'salt pan', 'A small, undrained, shallow depression in which water accumulates and evaporates, leaving a salt deposit.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tectonicallyDefinedSetting', 'tectonically defined setting', 'Setting defined by relationships to tectonic plates on or in the Earth.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wasteAndMaterialDepositionAreaSetting', 'waste and material deposition area setting', 'Human influence setting in which non-natural or natural materials from elsewhere are deposited.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wetToSubHumidSetting', 'wet to sub-humid setting', '''A Wet to sub-humid climate is according Thornthwaite''s climate classification system associated with rain forests (wet), forests (humid) and grassland (sub-humid).''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/fastSpreadingCenterSetting', 'fast spreading center setting', 'Spreading center at which the opening rate is greater than 100 mm per year.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mediumRateSpreadingCenterSetting', 'medium-rate spreading center setting', 'Spreading center at which the opening rate is between 50 and 100 mm per year.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/slowSpreadingCenterSetting', 'slow spreading center setting', 'Spreading center at which the opening rate is less than 50 mm per year.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dunefieldSetting', 'dunefield setting', '''Extensive deposits on sand in an area where the supply is abundant. As a characteristic, individual dunes somewhat resemble barchans but are highly irregular in shape and crowded; erg areas of the Sahara are an example.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/dustAccumulationSetting', 'dust accumulation setting', 'Setting in which finegrained particles accumulate, e.g. loess deposition.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/sandPlainSetting', 'sand plain setting', 'A sand-covered plain dominated by aeolian processes.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/gibberPlainSetting', 'gibber plain setting', '''A desert plain strewn with wind-abraded pebbles, or gibbers; a gravelly desert.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marginalMarineSabkhaSetting', 'marginal marine sabkha setting', 'Setting characterized by arid to semi-arid conditions on restricted coastal plains mostly above normal high tide level, with evaporite-saline mineral, tidal-flood, and eolian deposits. Boundaries with intertidal setting and non-tidal terrestrial setting are gradational. (Jackson, 1997, p. 561).', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/playaSetting', 'playa setting', 'The usually dry and nearly level plain that occupies the lowest parts of closed depressions, such as those occurring on intermontane basin floors. Temporary flooding occurs primarily in response to precipitation-runoff events.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierBeachSetting', 'barrier beach setting', '''A narrow, elongate sand or gravel ridge rising slightly above the high-tide level and extending generally parallel with the shore, but separated from it by a lagoon (Shepard, 1954, p.1904), estuary, or marsh; it is extended by longshore transport and is rarely more than several kilometers long.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierLagoonSetting', 'barrier lagoon setting', 'A lagoon that is roughly parallel to the coast and is separated from the open ocean by a strip of land or by a barrier reef. Tidal influence is typically restricted and the lagoon is commonly hypersaline.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerBathyalSetting', 'lower bathyal setting', 'The ocean environment at depths between 1000 and 3500 metres.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleBathyalSetting', 'middle bathyal setting', 'The ocean environment at water depths between 600 and 1000 metres.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperBathyalSetting', 'upper bathyal setting', 'The ocean environment at water depths between 200 and 600 metres.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/backreefSetting', 'backreef setting', '''The landward side of a reef. The term is often used adjectivally to refer to deposits within the restricted lagoon behind a barrier reef, such as the ''back-reef facies'' of lagoonal deposits. In some places, as on a platform-edge reef tract, ''back reef'' refers to the side of the reef away from the open sea, even though no land may be nearby.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forereefSetting', 'forereef setting', '''The seaward side of a reef; the slope covered with deposits of coarse reef talus.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/reefFlatSetting', 'reef flat setting', 'A stony platform of reef rock, landward of the reef crest at or above the low tide level, occasionally with patches of living coral and associated organisms, and commonly strewn with coral fragments and coral sand.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/basinBogSetting', 'basin bog setting', 'An ombrotrophic or ombrogene peat/bog whose nutrient supply is exclusively from rain water (including snow and atmospheric fallout) therefore making nutrients extremely oligotrophic.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/blanketBog', 'blanket bog', '''Topogeneous bog/peat whose moisture content is largely dependent on surface water. It is relatively rich in plant nutrients, nitrogen, and mineral matter, is mildly acidic to nearly neutral, and contains little or no cellulose; forms in topographic depressions with essential stagnat or non-moving minerotrophic water supply''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/collisionalSetting', 'collisional setting', 'ectonic setting in which two continental crustal plates impact and are sutured together after intervening oceanic crust is entirely consumed at a subduction zone separating the plates. Such collision typically involves major mountain forming events, exemplified by the modern Alpine and Himalayan mountain chains.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forelandSetting', 'foreland setting', 'The exterior area of an orogenic belt where deformation occurs without significant metamorphism. Generally the foreland is closer to the continental interior than other portions of the orogenic belt are.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hinterlandTectonicSetting', 'hinterland tectonic setting', '''Tectonic setting in the internal part of an orogenic belt, characterized by plastic deformation of rocks accompanied by significant metamorphism, typically involving crystalline basement rocks. Typically denotes the most structurally thickened part of an orogenic belt, between a magmatic arc or collision zone and a more ''external'' foreland setting.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerContinentalCrustalSetting', 'lower continental-crustal setting', 'Continental crustal setting characterized by upper amphibolite to granulite facies metamorphism, in situ melting, residual anhydrous metamorphic rocks, and ductile flow of rock bodies.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleContinentalCrustSetting', 'middle continental crust setting', 'Continental crustal setting characterized by greenschist to upper amphibolite facies metamorphism, plutonic igneous rocks, and ductile deformation.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperContinentalCrustalSetting', 'upper continental crustal setting', 'Continental crustal setting dominated by non metamorphosed to low greenschist facies metamorphic rocks, and brittle deformation.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalCrustalSetting', 'continental-crustal setting', '''That type of the Earth''s crust which underlies the continents and the continental shelves; it is equivalent to the sial and continental sima and ranges in thickness from about 25 km to more than 70 km under mountain ranges, averaging ~40 km. The density of the continental crust averages ~2.8 g/cm3 and is ~2.7 g.cm3 in the upper layer. The velocities of compressional seismic waves through it average ~6.5 km/s and are less than ~7.0 km/sec.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanicCrustalSetting', 'oceanic-crustal setting', '''That type of the Earth''s crust which underlies the ocean basins. The oceanic crust is 5-10 km thick; it has a density of 2.9 g/cm3, and compressional seismic-wave velocities travelling through it at 4-7.2 km/sec. Setting in crust produced by submarine volcanism at a mid ocean ridge.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/transitionalCrustalSetting', 'transitional-crustal setting', 'Crust formed in the transition zone between continental and oceanic crust, during the history of continental rifting that culminates in the formation of a new ocean.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaDistributaryChannelSetting', 'delta distributary channel setting', 'A divergent stream flowing away from the main stream and not returning to it, as in a delta or on an alluvial plain.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaDistributaryMouthSetting', 'delta distributary mouth setting', 'The mouth of a delta distributary channel where fluvial discharge moves from confined to unconfined flow conditions.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaFrontSetting', 'delta front setting', '''A narrow zone where deposition in deltas is most active, consisting of a continuous sheet of sand, and occurring within the effective depth of wave erosion (10 m or less). It is the zone separating the prodelta from the delta plain, and it may or may not be steep''''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaPlainSetting', 'delta plain setting', '''The level or nearly level surface composing the landward part of a large or compound delta; strictly, an alluvial plain characterized by repeated channel bifurcation and divergence, multiple distributary channels, and interdistributary flood basins.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarineDeltaSetting', 'estuarine delta setting', 'A delta that has filled, or is in the process of filling, an estuary.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/interdistributaryBaySetting', 'interdistributary bay setting', 'A pronounced indentation of the delta front between advancing stream distributaries, occupied by shallow water, and either open to the sea or partly enclosed by minor distributaries.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lacustrineDeltaSetting', 'lacustrine delta setting', 'The low, nearly flat, alluvial tract of land at or near the mouth of a river, commonly forming a triangular or fan-shaped plain of considerable area, crossed by many distributaries of the main river, perhaps extending beyond the general trend of the lake shore, resulting from the accumulation of sediment supplied by the river in such quantities that it is not removed by waves or currents. Most deltas are partly subaerial and partly below water.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/prodeltaSetting', 'prodelta setting', '''The part of a delta that is below the effective depth of wave erosion, lying beyond the delta front, and sloping gently down to the floor of the basin into which the delta is advancing and where clastic river sediment ceases to be a significant part of the basin-floor deposits; it is entirely below the water level.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerDeltaPlainSetting', 'lower delta plain setting', 'The part of a delta plain which is penetrated by saline water and is subject to tidal processes.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperDeltaPlainSetting', 'upper delta plain setting', 'The part of a delta plain essentially unaffected by basinal processes. They do not differ substantially from alluvial environments except that areas of swamp, marsh and lakes are usually more widespread and channels may bifurcate downstream.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/coastalDuneFieldSetting', 'coastal dune field setting', '''A dune field on low-lying land recently abandoned or built up by the sea; the dunes may ascend a cliff and travel inland.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/contactMetamorphicSetting', 'contact metamorphic setting', 'Metamorphism of country rock at the contact of an igneous body.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/crustalSetting', 'crustal setting', '''The outermost layer or shell of the Earth, defined according to various criteria, including seismic velocity, density and composition; that part of the Earth above the Mohorovicic discontinuity, made up of the sial and the sima.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/highPressureLowTemperatureEarthInteriorSetting', 'high pressure low temperature Earth interior setting', '''High pressure environment characterized by geothermal gradient significantly lower than standard continental geotherm; environment in which blueschist facies metamorphic rocks form. Typically associated with subduction zones.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hypabyssalSetting', 'hypabyssal setting', '''Igneous environment close to the Earth''s surface, characterized by more rapid cooling than plutonic setting to produce generally fine-grained intrusive igneous rock that is commonly associated with co-magmatic volcanic rocks.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowPressureHighTemperatureSetting', 'low pressure high temperature setting', 'Setting characterized by temperatures significantly higher that those associated with normal continental geothermal gradient.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mantleSetting', 'mantle setting', 'The zone of the Earth below the crust and above the core, which is divided into the upper mantle and the lower mantle, with a transition zone separating them.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/regionalMetamorphicSetting', 'regional metamorphic setting', '''Metamorphism not obviously localized along contacts of igneous bodies; includes burial metamorphism and ocean ridge metamorphism.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/ultraHighPressureCrustalSetting', 'ultra high pressure crustal setting', 'Setting characterized by pressures characteristic of upper mantle, but indicated by mineral assemblage in crustal composition rocks.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/anoxicSetting', 'anoxic setting', 'Setting depleted in oxygen, typically subaqueous.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aridOrSemiAridEnvironmentSetting', 'arid or Semi Arid environment setting', '''Setting characterized by mean annual precipitation of 10 inches (25 cm) or less. (Jackson, 1997, p. 172). Equivalent to SLTT ''Desert setting'', but use ''Arid'' to emphasize climatic nature of setting definition.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/caveSetting', 'cave setting', '''A natural underground open space; it generally has a connection to the surface, is large enough for a person to enter, and extends into darkness. The most common type of cave is formed in limestone by dissolution.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deltaicSystemSetting', 'deltaic system setting', 'Environments at the mouth of a river or stream that enters a standing body of water (ocean or lake). The delta forms a triangular or fan-shaped plain of considerable area. Subaerial parts of the delta are crossed by many distributaries of the main river,', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierRelatedSetting', 'glacier related setting', 'Earth surface setting with geography defined by spatial relationship to glaciers (e.g. on top of a glacier, next to a glacier, in front of a glacier...). Processes related to moving ice dominate sediment transport and deposition and landform development.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hillslopeSetting', 'hillslope setting', 'Earth surface setting characterized by surface slope angles high enough that gravity alone becomes a significant factor in geomorphic development, as well as base-of-slope areas influenced by hillslope processes. Hillslope activities include creep, sliding, slumping, falling, and other downslope movements caused by slope collapse induced by gravitational influence on earth materials. May be subaerial or subaqueous.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humidTemperateClimaticSetting', 'humid temperate climatic setting', 'Setting with seasonal climate having hot to cold or humid to arid seasons.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/humidTropicalClimaticSetting', 'humid tropical climatic setting', 'Setting with hot, humid climate influenced by equatorial air masses, no winter season.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/polarClimaticSetting', 'polar climatic setting', 'Setting with climate dominated by temperatures below the freezing temperature of water. Includes polar deserts because precipitation is generally scant at high latitude. Climatically controlled by arctic air masses, cold dry environment with short summer.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/shorelineSetting', 'shoreline setting', 'Geologic settings characterized by location adjacent to the ocean or a lake. A zone of indefinite width (may be many kilometers), bordering a body of water that extends from the water line inland to the first major change in landform features. Includes settings that may be subaerial, intermittently subaqueous, or shallow subaqueous, but are intrinsically associated with the interface between land areas and water bodies.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subaerialSetting', 'subaerial setting', 'Setting at the interface between the solid earth and the atmosphere, includes some shallow subaqueous settings in river channels and playas. Characterized by conditions and processes, such as erosion, that exist or operate in the open air on or immediately adjacent to the land surface.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subaqueousSetting', 'subaqueous setting', 'Setting situated in or under permanent, standing water. Used for marine and lacustrine settings, but not for fluvial settings.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/terrestrialSetting', 'terrestrial setting', 'Setting characterized by absence of direct marine influence. Most of the subaerial settings are also terrestrial, but lacustrine settings, while terrestrial, are not subaerial, so the subaerial settings are not included as subcategories.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/wetlandSetting', 'wetland setting', 'Setting characterized by gentle surface slope, and at least intermittent presence of standing water, which may be fresh, brackish, or saline. Wetland may be terrestrial setting or shoreline setting.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarineLagoonSetting', 'estuarine lagoon setting', '''A lagoon produced by the temporary sealing of a river estuary by a storm barrier. Such lagoons are usually seasonal and exist until the river breaches the barrier; they occur in regions of low or spasmodic rainfall.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalRiftSetting', 'continental rift setting', 'Extended terrane in a zone of continental breakup, may include incipient oceanic crust. Examples include Red Sea, East Africa Rift, Salton Trough.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/englacialSetting', 'englacial setting', '''Contained, embedded, or carried within the body of a glacier or ice sheet; said of meltwater streams, till, drift, moraine.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacialOutwashPlainSetting', 'glacial outwash plain setting', '''A broad, gently sloping sheet of outwash deposited by meltwater streams flowing in front of or beyond a glacier, and formed by coalescing outwahs fans; the surface of a broad body of outwash.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierLateralSetting''', 'glacier lateral setting', 'Settings adjacent to edges of confined glacier.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/proglacialSetting', 'proglacial setting', '''Immediately in front of or just beyond the outer limits of a glacier or ice sheet, generally at or near its lower end; said of lakes, streams, deposits, and other features produced by or derived from the glacier ice.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subglacialSetting', 'subglacial setting', '''Formed or accumulated in or by the bottom parts of a glacier or ice sheet; said of meltwater streams, till, moraine, etc.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/supraglacialSetting', 'supraglacial setting', '''''Carried upon, deposited from, or pertaining to the top surface of a glacier or ice sheet; said of meltwater streams, till, drift, etc. '' (Jackson, 1997, p. 639). Dreimanis (1988, p. 39) recommendation that ''supraglacial'' supersede ''superglacial'' is followed.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/inactiveSpreadingCenterSetting', 'inactive spreading center setting', 'Setting on oceanic crust formed at a spreading center that has been abandoned.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/seamountSetting', 'seamount setting', 'Setting that consists of a conical mountain on the ocean floor (guyot). Typically characterized by active volcanism, pelagic sedimentation. If the mountain is high enough to reach the photic zone, carbonate production may result in reef building to produce a carbonate platform or atoll setting.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/algalFlatSetting', 'algal flat setting', '''Modern ''algal flats are found on rock or mud in areas flooded only by the highest tides and are often subject to high evaporation rates. Algal flats survive only when an area is salty enough to eliminate snails and other herbivorous animals that eat algae, yet is not so salty that the algae cannot survive. The most common species of algae found on algal flats are blue-green algae of the genera Scytonema and Schizothrix. These algae can tolerate the daily extremes in temperature and oxygen that typify conditions on the flats. Other plants sometimes found on algal flats include one-celled green algae, flagellates, diatoms, bacteria, and isolated scrubby red and black mangroves, as well as patches of saltwort. Animals include false cerith, cerion snails, fiddler crabs, and great land crabs. Flats with well developed algal mats are restricted for the most part to the Keys, with Sugarloaf and Crane Keys offering prime examples of algal flat habitat.'' (Audubon, 1991)''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/mudFlatSetting', 'mud flat setting', 'A relatively level area of fine grained material (e.g. silt) along a shore (as in a sheltered estuary or chenier-plain) or around an island, alternately covered and uncovered by the tide or covered by shallow water, and barren of vegetation. Includes most tidal flats, but lacks denotation of tidal influence.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerMantleSetting', 'lower mantle setting', 'That part of the mantle that lies below a depth of about 660 km. With increasing depth, density increases from ~4.4 g/cm3 to ~5.6 g/cm3, and velocity of compressional seismic waves increases from ~10.7 km/s to ~13.7 km/s (Dziewonski and Anderson, 1981).', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperMantleSetting', 'upper mantle setting', 'That part of the mantle which lies above a depth of about 660 km and has a density of 3.4 g/cm3 to 4.0 g/cm3 with increasing depth. Similarly, P-wave velocity increases from about 8 to 11 km/sec with depth and S wave velocity increases from about 4.5 to 6 km/sec with depth. It is presumed to be peridotitic in composition. It includes the subcrustal lithosphere the asthenosphere and the transition zone.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aboveCarbonateCompensationDepthSetting', 'above carbonate compensation depth setting', 'Marine environment in which carbonate sediment does not dissolve before reaching the sea floor and can accumulate.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/abyssalSetting', 'abyssal setting', 'The ocean environment at water depths between 3,500 and 6,000 metres.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/basinPlainSetting', 'basin plain setting', '''Near flat areas of ocean floor, slope less than 1:1000; generally receive only distal turbidite and pelagic sediments.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/bathyalSetting', 'bathyal setting', 'The ocean environment at water depths between 200 and 3500 metres.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/belowCarbonateCompensationDepthSetting', 'below carbonate compensation depth setting', 'Marine environment in which water is deep enough that carbonate sediment goes into solution before it can accumulate on the sea floor.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/biologicalReefSetting', 'biological reef setting', '''A ridgelike or moundlike structure, layered or massive, built by sedentary calcareous organisms, esp. corals, and consisting mostly of their remains; it is wave-resistant and stands topographically above the surrounding contemporaneously deposited sediment.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalBorderlandSetting', 'continental borderland setting', 'An area of the continental margin between the shoreline and the continental slope that is topographically more complex than the continental shelf. It is characterized by ridges and basins, some of which are below the depth of the continental shelf. An example is the southern California continental borderland (Jackson, 1997, p. 138).', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/continentalShelfSetting', 'continental shelf setting', '''That part of the ocean floor that is between the shoreline and the continental slope (or, when there is no noticeable continental slope, a depth of 200 m). It is characterized by its gentle slope of 0.1 degree (Jackson, 1997, p. 138). Continental shelves have a classic shoreline-shelf-slope profile termed ''clinoform''.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/deepSeaTrenchSetting', 'deep sea trench setting', 'Deep ocean basin with steep (average 10 degrees) slope toward land, more gentle slope (average 5 degrees) towards the sea, and abundant seismic activity on landward side of trench. Does not denote water depth, but may be very deep.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/epicontinentalMarineSetting', 'epicontinental marine setting', 'Marine setting situated within the interior of the continent, rather than at the edge of a continent.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hadalSetting', 'hadal setting', 'The deepest oceanic environment, i.e., over 6,000 m in depth. Always in deep sea trench.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marineCarbonatePlatformSetting', 'marine carbonate platform setting', 'A shallow submerged plateau separated from continental landmasses, on which high biological carbonate production rates produce enough sediment to maintain the platform surface near sea level. Grades into atoll as area becomes smaller and ringing coral reefs become more prominent part of the setting.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/neriticSetting', 'neritic setting', 'The ocean environment at depths between low-tide level and 200 metres, or between low-tide level and approximately the edge of the continental shelf.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanHighlandSetting', 'ocean highland setting', 'Broad category for subaqueous marine settings characterized by significant relief above adjacent sea floor.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/slopeRiseSetting', 'slope-rise setting', 'The part of a subaqueous basin that is between a bordering shelf setting, which separate the basin from an adjacent landmass, and a very low-relief basin plain setting.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/submarineFanSetting', 'submarine fan setting', 'Large fan-shaped cones of sediment on the ocean floor, generally associated with submarine canyons that provide sediment supply to build the fan.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/innerNeriticSetting', 'inner neritic setting', 'The ocean environment at depths between low tide level and 30 metres.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/middleNeriticSetting', 'middle neritic setting', 'The ocean environment at depths between 30 and 100 metres.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/outerNeriticSetting', 'outer neritic setting', 'The ocean environment at depths between 100 meters and approximately the edge of the continental shelf or between 100 and 200 meters.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/midOceanRidgeSetting', 'mid ocean ridge setting', 'Ocean highland associated with a divergent continental margin (spreading center). Setting is characterized by active volcanism, locally steep relief, hydrothermal activity, and pelagic sedimentation.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/oceanicPlateauSetting', 'oceanic plateau setting', 'Region of elevated ocean crust that commonly rises to within 2-3 km of the surface above an abyssal sea floor that lies several km deeper. Climate and water depths are such that a marine carbonate platform does not develop.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowerOceanicCrustalSetting', 'lower oceanic-crustal setting', 'Setting characterized by dominantly intrusive mafic rocks, with sheeted dike complexes in upper part and gabbroic to ultramafic intrusive or metamorphic rocks in lower part.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/upperOceanicCrustalSetting', 'upper oceanic crustal setting', 'Oceanic crustal setting dominated by extrusive rocks, abyssal oceanic sediment, with increasing mafic intrusive rock in lower part.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/alluvialFanSetting', 'alluvial fan setting', '''A low, outspread, relatively flat to gently sloping mass of loose rock material, shaped like an open fan or a segment of a cone, deposited by a stream (esp. in a semiarid region) at the place where it issues from a narrow mountain valley upon a plain or broad valley, or where a tributary stream is near or at its junction with the main stream, or wherever a constriction in a valley abruptly ceases or the gradient of the stream suddenly decreases; it is steepest near the mouth of the valley where its apex points upstream, and it slopes gently and convexly outward with gradually decreasing gradient.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/alluvialPlainSetting', 'alluvial plain setting', '''An assemblage landforms produced by alluvial and fluvial processes (braided streams, terraces, etc.,) that form low gradient, regional ramps along the flanks of mountains and extend great distances from their sources (e.g., High Plains of North America). (NRCS GLOSSARY OF LANDFORM AND GEOLOGIC TERMS). A level or gently sloping tract or a slightly undulating land surface produced by extensive deposition of alluvium... Synonym-- wash plain;...river plain; aggraded valley plain;... (Jackson, 1997, p. 17). May include one or more River plain systems.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/pedimentSetting', 'pediment setting', '''A gently sloping erosional surface developed at the foot of a receding hill or mountain slope. The surface may be essentially bare, exposing earth material that extends beneath adjacent uplands; or it may be thinly mantled with alluvium and colluvium, ultimately in transit from upland front to basin or valley lowland. In hill-foot slope terrain the mantle is designated ''pedisediment.'' The term has been used in several geomorphic contexts: Pediments may be classed with respect to (a) landscape positions, for example, intermontane-basin piedmont or valley-border footslope surfaces (respectively, apron and terrace pediments (Cooke and Warren, 1973)); (b) type of material eroded, bedrock or regolith; or (c) combinations of the above. compare - Piedmont slope.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/activeContinentalMarginSetting', 'active continental margin setting', 'Plate margin setting on continental crust.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/activeSpreadingCenterSetting', 'active spreading center setting', 'Divergent plate margin at which new oceanic crust is being formed.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/forearcSetting', 'forearc setting', 'Tectonic setting between a subduction-related trench and a volcanic arc.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/subductionZoneSetting', 'subduction zone setting', 'Tectonic setting at which a tectonic plate, usually oceanic, is moving down into the mantle beneath another overriding plate.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/transformPlateBoundarySetting', 'transform plate boundary setting', 'Plate boundary at which the adjacent plates are moving laterally relative to each other.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/volcanicArcSetting', 'volcanic arc setting', 'A generally curvillinear belt of volcanoes above a subduction zone.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/glacierTerminusSetting', 'glacier terminus setting', 'Region of sediment deposition at the glacier terminus due to melting of glacier ice, melt-out, ablation and flow till setting.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/braidedRiverChannelSetting', 'braided river channel setting', 'A stream that divides into or follows an interlacing or tangled network of several small branching and reuniting shallow channels separated from each other by ephemeral branch islands or channel bars, resembling in plan the strands of a complex braid. Such a stream is generally believed to indicate an inability to carry all of its load, such as an overloaded and aggrading stream flowing in a wide channel on a floodplain.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/meanderingRiverChannelSetting', 'meandering river channel setting', 'Produced by a mature stream swinging from side to side as it flows across its floodplain or shifts its course laterally toward the convex side of an original curve.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/abandonedRiverChannelSetting', 'abandoned river channel setting', 'A drainage channel along which runoff no longer occurs, as on an alluvial fan.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/cutoffMeanderSetting', 'cutoff meander setting', 'The abandoned, bow- or horseshoe-shaped channel of a former meander, left when the stream formed a cutoff across a narrow meander neck. Note that these are typically lakes, thus also lacustrine.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/floodplainSetting', 'floodplain setting', 'The surface or strip of relatively smooth land adjacent to a river channel, constructed by the present river in its existing regimen and covered with water when the river overflows its banks. It is built of alluvium carried by the river during floods and deposited in the sluggish water beyond the influence of the swiftest current. A river has one floodplain and may have one or more terraces representing abandoned floodplains.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/riverChannelSetting', 'river channel setting', '''The bed where a natural body of surface water flows or may flow; a natural passageway or depression of perceptible extent containing continuously or periodically flowing water, or forming a connecting link between two bodies of water; a watercourse.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/springSetting', 'spring setting', 'Setting characterized by a place where groundwater flows naturally from a rock or the soil onto the land surface or into a water body.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/barrierIslandCoastlineSetting', 'barrier island coastline setting', 'Setting meant to include all the various geographic elements typically associated with a barrier island coastline, including the barrier islands, and geomorphic/geographic elements that are linked by processes associated with the presence of the island (e.g. wash over fans, inlet channel, back barrier lagoon).''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/beachSetting', 'beach setting', '''The unconsolidated material at the shoreline that covers a gently sloping zone, typically with a concave profile, extending landward from the low-water line to the place where there is a definite change in material or physiographic form (such as a cliff), or to the line of permanent vegetation (usually the effective limit of the highest storm waves); at the shore of a body of water, formed and washed by waves or tides, usually covered by sand or gravel, and lacking a bare rocky surface.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/carbonateDominatedShorelineSetting', 'carbonate dominated shoreline setting', 'A shoreline setting in which terrigenous input is minor compared to local carbonate sediment production. Constructional biogenic activity is an important element in geomorphic development.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/coastalPlainSetting', 'coastal plain setting', 'A low relief plain bordering a water body extending inland to the nearest elevated land, sloping very gently towards the water body. Distinguished from alluvial plain by presence of relict shoreline-related deposits or morphology.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/estuarySetting', 'estuary setting', 'Environments at the seaward end or the widened funnel-shaped tidal mouth of a river valley where fresh water comes into contact with seawater and where tidal effects are evident (adapted from Glossary of Geology, Jackson, 1997, p. 217).', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lagoonalSetting', 'lagoonal setting', '''A shallow stretch of salt or brackish water, partly or completely separated from a sea or lake by an offshore reef, barrier island, sand or spit (Jackson, 1997). Water is shallow, tidal and wave-produced effects on sediments; strong light reaches sediment.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lowEnergyShorelineSetting', 'low energy shoreline setting', 'Settings characterized by very low surface slope and proximity to shoreline. Generally within peritidal setting, but characterized by low surface gradients and generally low-energy sedimentary processes.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/rockyCoastSetting', 'rocky coast setting', 'Shoreline with significant relief and abundant rock outcrop.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/strandplainSetting', 'strandplain setting', 'A prograded shore built seaward by waves and currents, and continuous for some distance along the coast. It is characterized by subparallel beach ridges and swales, in places with associated dunes.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/supratidalSetting', 'supratidal setting', 'Pertaining to the shore area marginal to the littoral zone, just above high-tide level.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalSetting', 'tidal setting', 'Setting subject to tidal processes.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/aeolianProcessSetting', 'aeolian process setting', 'Sedimentary setting in which wind is the dominant process producing, transporting, and depositing sediment. Typically has low-relief plain or piedmont slope physiography.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/piedmontSlopeSystemSetting', 'piedmont slope system setting', '''Location on gentle slope at the foot of a mountain; generally used in terms of intermontane-basin terrain. Main components include: (a) An erosional surface on bedrock adjacent to the receding mountain front (pediment, rock pediment); (b) A constructional surface comprising individual alluvial fans and interfan valleys, also near the mountain front; and (c) A distal complex of coalescent fans (bajada), and alluvial slopes without fan form. Piedmont slopes grade to basin-floor depressions with alluvial and temporary lake plains or to surfaces associated with through drainage.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intertidalSetting', 'intertidal setting', '''Pertaining to the benthic ocean environment or depth zone between high water and low water; also, pertaining to the organisms of that environment.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/marineSetting', 'marine setting', 'Setting characterized by location under the surface of the sea.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalChannelSetting', 'tidal channel setting', 'A major channel followed by the tidal currents, extending from offshore into a tidal marsh or a tidal flat.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalMarshSetting', 'tidal marsh setting', '''A marsh bordering a coast (as in a shallow lagoon or sheltered bay), formed of mud and of the resistant mat of roots of salt-tolerant plants, and regularly inundated during high tides; a marshy tidal flat.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/backArcSetting', 'back arc setting', 'Tectonic setting adjacent to a volcanic arc formed above a subduction zone. The back arc setting is on the opposite side of the volcanic arc from the trench at which oceanic crust is consumed in a subduction zone. Back arc setting includes terrane that is affected by plate margin and arc-related processes.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/extendedTerraneSetting', 'extended terrane setting', 'Tectonic setting characterized by extension of the upper crust, manifested by formation of rift valleys or basin and range physiography, with arrays of low to high angle normal faults. Modern examples include the North Sea, East Africa, and the Basin and Range of the North American Cordillera. Typically applied in continental crustal settings.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/hotSpotSetting', 'hot spot setting', 'Setting in a zone of high heat flow from the mantle. Typically identified in intraplate settings, but hot spot may also interact with active plate margins (Iceland...). Includes surface manifestations like volcanic center, but also includes crust and mantle manifestations as well.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/intraplateTectonicSetting', 'intraplate tectonic setting', 'Tectonically stable setting far from any active plate margins.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/passiveContinentalMarginSetting', 'passive continental margin setting', 'Boundary of continental crust into oceanic crust of an oceanic basin that is not a subduction zone or transform fault system. Generally is rifted margin formed when ocean basin was initially formed.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/plateMarginSetting', 'plate margin setting', 'Tectonic setting at the boundary between two tectonic plates.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/plateSpreadingCenterSetting', 'plate spreading center setting', 'Tectonic setting where new oceanic crust is being or has been formed at a divergent plate boundary. Includes active and inactive spreading centers.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/bogSetting', 'bog setting', 'Waterlogged, spongy ground, consisting primarily of mosses, containing acidic, decaying vegetation that may develop into peat.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/lacustrineSetting', 'lacustrine setting', 'Setting associated with a lake. Always overlaps with terrestrial, may overlap with subaerial, subaqueous, or shoreline.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/riverPlainSystemSetting', 'river plain system setting', '''Geologic setting dominated by a river system; river plains may occur in any climatic setting. Includes active channels, abandoned channels, levees, oxbow lakes, flood plain. May be part of an alluvial plain that includes terraces composed of abandoned river plain deposits.''', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/tidalFlatSetting', 'tidal flat setting', 'An extensive, nearly horizontal, barren tract of land that is alternately covered and uncovered by the tide, and consisting of unconsolidated sediment (mostly mud and sand). It may form the top surface of a deltaic deposit.', 'EventEnvironmentValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue/swampOrMarshSetting', 'swamp or marsh setting', 'A water-saturated, periodically wet or continually flooded area with the surface not deeply submerged, essentially without the formation of peat. Marshes are characterized by sedges, cattails, rushes, or other aquatic and grasslike vegetation. Swamps are characterized by tree and brush vegetation.', 'EventEnvironmentValue', null, null, null, null);


-- LayerGenesisProcessStateValue
-- FEATURE profileelement
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue/ongoing', 'on-going', 'The process has started in the past and is still active.', 'LayerGenesisProcessStateValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue/terminated', 'terminated', 'The process is no longer active.', 'LayerGenesisProcessStateValue', null, null, null, null);


-- FAOHorizonMaster
-- FEATURE faohorizonnotationtype
-- CODELIST INSPIRE
-- https://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue

INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/B', 'B', 'B horizons', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/O', 'O', 'O horizons or layers', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/C', 'C', 'C horizons or layers', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/E', 'E', 'E horizons', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/I', 'I', 'I layers', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/W', 'W', 'W layers', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/H', 'H', 'H horizons or layers', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/A', 'A', 'A horizons', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/R', 'R', 'R layers', 'FAOHorizonMasterValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/L', 'L', 'L layers', 'FAOHorizonMasterValue', null, null, null, null);


-- FAOHorizonSubordinate
-- FEATURE faohorizonnotationtype
-- CODELIST INSPIRE
-- https://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue

INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/a', 'a', 'Highly decomposed organic material', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/b', 'b', 'Buried genetic horizon', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/c', 'c', 'Concretions or nodules', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/c-L', 'c-L', 'Coprogenous earth', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/f', 'f', 'Frozen soil', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/d-L', 'd-L', 'Diatomaceous earth', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/e', 'e', 'Moderately decomposed organic material', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/g', 'g', 'Stagnic conditions', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/d', 'd', 'Dense layer (physically root restrictive)', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/i-HO', 'i-HO', 'Slightly decomposed organic material;"Slightly decomposed organic material: In organic soils and used in combination with H or O horizons, it indicates the state of decomposition of the organic material', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/r', 'r', 'Strong reduction', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/u', 'u', 'Urban and other human-made materials', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/x', 'x', 'Fragipan characteristics', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/k', 'k', 'Accumulation of pedogenetic carbonates', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/l', 'l', 'Capillary fringe mottling (gleying)', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/z', 'z', 'Pedogenetic accumulation of salts more soluble than gypsum', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/@', '@', 'Evidence of cryoturbation', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/j', 'j', 'Jarosite accumulation', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/v', 'v', 'Occurrence of plinthite', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/t', 't', 'Illuvial accumulation of silicate clay', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/m-L', 'm-L', 'Marl', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/n', 'n', 'Pedogenetic accumulation of exchangeable sodium', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/h', 'h', 'Accumulation of organic matter', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/w', 'w', 'Development of colour or structure', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/m', 'm', 'Strong cementation or induration (pedogenetic, massive)', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/q', 'q', 'Accumulation of pedogenetic silica', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/o', 'o', 'Residual accumulation of sesquioxides (pedogenetic)', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/p', 'p', 'Ploughing or other human disturbance', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/s', 's', 'Illuvial accumulation of sesquioxides', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/i', 'i', 'Slickensides', 'FAOHorizonSubordinateValue', null, null, null, null);
INSERT INTO "codelist" (ID, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue/y', 'y', 'Pedogenetic accumulation of gypsum', 'FAOHorizonSubordinateValue', null, null, null, null);


-- FAOPrime
-- FEATURE faohorizonnotationtype
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/FAOPrimeValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/0','0','No Prime applies to this layer or horizon', 'FAOPrimeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/1','1','One Prime applies to this layer or horizon', 'FAOPrimeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/2','2','Two Primes apply to this layer or horizon', 'FAOPrimeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/FAOPrimeValue/3','3','Three Primes apply to this layer or horizon', 'FAOPrimeValue', null, null, null, null);


-- *** INTERNAL *** codelist for managing forms 
-- OtherHorizonNotationType
-- FEATURE otherhorizonnotationtype
-- CODELIST for internal management of Qgis forms

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('WRBdiagnostichorizon', 'WRB', 'WRB Diagnostic Horizon', 'OtherHorizonNotationTypeValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('USDAdiagnostichorizon', 'USDA', 'USDA Diagnostic Horizon', 'OtherHorizonNotationTypeValue', null, null, null, null);


-- WRBdiagnostichorizon
-- FEATURE otherhorizonnotationtype
-- CODELIST ORBL
-- https://obrl-soil.github.io/wrbsoil2022/

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-albich','Albic','albico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-anthh','Anthraquic','antraquico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-argich','Argic','argico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-calch','Calcic','calcico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-cambich','Cambic','cambico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-chernh','Chernic','chernico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-cohesich','Cohesic','Cohesico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-cryich','Cryic','cryico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-durich','Duric','durico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-feralh','Ferralic','ferralico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-ferich','Ferric','ferrico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-folich','Folic','Folico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-fragh','Fragic','fragico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-gypsih','Gypsic','gypsico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-histih','Histic','histico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-hydrh','Hydragric','idragrico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-iragh','Irragric','irragrico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-limonich','Limonic','Limonico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-mollh','Mollic','mollico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-natrich','Natric','natrico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-nitich','Nitic','nitico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-panpaich','Panpaic','Panpaico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-hortih','Hortic','ortico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-pcalch','Petrocalcic','petrocalcico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-pdurich','Petroduric','petrodurico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-pgypsich','Petrogypsic','petrogypsico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-pplinthich','Petroplinthic','petroplintico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-pisoph','Pisoplinthic','Pisoplintico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-plaggh','Plaggic','plaggico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-plinth','Plinthic','plintico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-preth','Pretic','Pretico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-protvh','Protovertic','Protovertico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-salich','Salic','salico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-sombrh','Sombric','Sombrico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-spodich','Spodic','spodico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-terich','Terric','terrico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-thionh','Thionic','Tionico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-tsitelich','Tsitelic','Tsitelico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-umbrich','Umbric','umbrico','WRBdiagnostichorizon', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-verth','Vertic','vertico','WRBdiagnostichorizon', null, null, null, null);




-- *** EXAMPLE *** 
-- diagnostichorizon
-- FEATURE otherhorizonnotationtype
-- CODELIST CREA

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://crea.gov.it/infosuoli/vocabularies/USDA/diagnostichorizon/12386', 'Void', 'Void', 'USDAdiagnostichorizon', 'https://crea.gov.it/infosuoli/vocabularies/OtherHorizonNotationType/USDA', null, null, null);



-- WRBQualifierPlaceValue
-- FEATURE wrbqualifiergrouptype
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/suffix', 'suffix', 'Suffix', 'WRBQualifierPlaceValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/prefix', 'prefix', 'Prefix', 'WRBQualifierPlaceValue', null, null, null, null);


-- WRBQualifierValue (2006)
-- FEATURE wrbqualifiergrouptype
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/WRBQualifierValue


INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Nudiargic', 'Nudiargic', 'Having an argic horizon starting at the mineral soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ortsteinic', 'Ortsteinic', 'Having a cemented spodic horizon (ortstein) (in Podzols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aric', 'Aric', 'Having only remnants of diagnostic horizons - disturbed by deep ploughing', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Acric', 'Acric', 'Having an argic horizon that has a CEC (by 1 M NH 4 OAc) of less than 24 cmol c kg -1clay in some part to a maximum depth of 50 cm below its upper limit, either starting within100 cm of the soil surface or within 200 cm of the soil surface if the argic horizon is overlain byloamy sand or coarser textures throughout, and having a base saturation (by 1 M NH 4 OAc) ofless than 50 percent in the major part between 50 and 100 cm from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Alcalic', 'Alcalic', 'Having a pH (1:1 in water) of 8.5 or more throughout within 50 cm of the soilsurface or to continuous rock or a cemented or indurated layer, whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Arzic', 'Arzic', 'Having sulphate-rich groundwater in some layer within 50 cm of the soil surfaceduring some time in most years and containing 15 percent or more gypsum averaged over adepth of 100 cm from the soil surface or to continuous rock or a cemented or indurated layer,whichever is shallower (in Gypsisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Irragric', 'Irragric', 'Having an irragric horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Rheic', 'Rheic', 'Having a histic horizon saturated predominantly with groundwater or flowingsurface water starting within 40 cm of the soil surface (in Histosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Arenic', 'Arenic', 'Having a texture of loamy fine sand or coarser in a layer, 30 cm or more thick,within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Anthric', 'Anthric', 'Having an anthric horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aluandic', 'Aluandic', 'Having one or more layers, cumulatively 15 cm or more thick, with andicproperties and an acid oxalate (pH 3) extractable silica content of less than 0.6 percent, and anAl py54 /Al ox55 of 0.5 or more, within 100 cm of the soil surface (in Andosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aridic', 'Aridic', 'Having aridic properties without a takyric or yermic horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sombric', 'Sombric', 'Having a sombric horizon starting within 150 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Calcaric', 'Calcaric', 'Having calcaric material between 20 and 50 cm from the soil surface or between20 cm and continuous rock or a cemented or indurated layer, whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Alumic', 'Alumic', 'Having an Al saturation (effective) of 50 percent or more in some layer between50 and 100 cm from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Anthraquic', 'Anthraquic', 'Having an anthraquic horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Solodic', 'Solodic', 'Having a layer, 15 cm or more thick within 100 cm of the soil surface, with thecolumnar or prismatic structure of the natric horizon, but lacking its sodium saturationrequirements', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Acroxic', 'Acroxic', 'Having less than 2 cmol c kg -1 fine earth exchangeable bases plus 1 M KClexchangeable Al 3+ in one or more layers with a combined thickness of 30 cm or more within100 cm of the soil surface (in Andosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Andic', 'Andic', 'Having within 100 cm of the soil surface one or more layers with andic or vitricproperties with a combined thickness of 30 cm or more (in Cambisols 15 cm or more), of which15 cm or more (in Cambisols 7.5 cm or more) have andicproperties', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Calcic', 'Calcic', 'Having a calcic horizon or concentrations of secondary carbonates starting within100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Alic', 'Alic', 'Having an argic horizon that has a CEC (by 1 M NH 4 OAc) of 24 cmol c kg -1 clay ormore throughout or to a depth of 50 cm below its upper limit, whichever is shallower, eitherstarting within 100 cm of the soil surface or within 200 cm of the soil surface if the argichorizon is overlain by loamy sand or coarser textures throughout, and having a base saturation(by 1 M NH 4 OAc) of less than 50 percent in the major part between 50 and 100 cm from the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Brunic', 'Brunic', 'Having a layer, 15 cm or more thick, which meets criteria 2-4 of the cambichorizon but fails criterion 1 and does not form part of an albic horizon, starting within 50 cm ofthe soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endoduric', 'Endoduric', 'Having a duric horizon starting between 50 and 100 cm from the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Carbic', 'Carbic', 'Having a spodic horizon that does not turn redder on ignition throughout (inPodzols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Eutric', 'Eutric', 'Having a base saturation (by 1 M NH 4 OAc) of 50 percent or more in the major partbetween 20 and 100 cm from the soil surface or between 20 cm and continuous rock or acemented or indurated layer, or, in a layer, 5 cm or more thick, directly abovecontinuous rock, if the continuous rock starts within 25 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Chloridic', 'Chloridic', 'Having a salic horizon with a soil solution (1:1 in water) with [Cl - ] >> [SO 42- ] >[HCO 3- ] (in Solonchaks only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Clayic', 'Clayic', 'Having a texture of clay in a layer, 30 cm or more thick, within 100 cm of the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Chromic', 'Chromic', 'Having within 150 cm of the soil surface a subsurface layer, 30 cm or more thick,that has a Munsell hue redder than 7.5 YR or that has both, a hue of 7.5 YR and a chroma,moist, of more than 4', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Densic', 'Densic', 'Having natural or artificial compaction within 50 cm of the soil surface to theextent that roots cannot penetrate', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Glossalbic', 'Glossalbic', 'Showing tonguing of an albic into an argic or natric horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Duric', 'Duric', 'Having a duric horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Colluvic', 'Colluvic', 'Having colluvic material, 20 cm or more thick, created by human-induced lateralmovement', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Carbonatic', 'Carbonatic', 'Having a salic horizon with a soil solution (1:1 in water) with a pH of 8.5 ormore and [HCO 3- ] > [SO 42- ] >> [Cl - ] (in Solonchaks only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Dystric', 'Dystric', 'Having a base saturation (by 1 M NH 4 OAc) of less than 50 percent in the majorpart between 20 and 100 cm from the soil surface or between 20 cm and continuous rock or acemented or indurated layer, or, in a layer, 5 cm or more thick, directly abovecontinuous rock, if the continuous rock starts within 25 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thaptandic', 'Thaptandic', 'Having within 100 cm of the soil surface one or more buried layerswith andic or vitric properties with a combined thickness of 30 cm or more (in Cambisols15 cm or more), of which 15 cm or more (in Cambisols 7.5 cm or more) have andic properties', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pisocalcic', 'Pisocalcic', 'Having only concentrations of secondary carbonates starting within 100cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Cambic', 'Cambic', 'Having a cambic horizon, which does not form part of an albic horizon, startingwithin 50 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Cryic', 'Cryic', 'Having a cryic horizon starting within 100 cm of the soil surface or having a cryichorizon starting within 200 cm of the soil surface with evidence of cryoturbation in some layerwithin 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Eutrosilic', 'Eutrosilic', 'Having one or more layers, cumulatively 30 cm or more thick, with andicproperties and a sum of exchangeable bases of 15 cmol c kg -1 fine earth or more within 100 cmof the surface (in Andosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Drainic', 'Drainic', 'Having a histic horizon that is drained artificially starting within 40 cm of the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ferralic', 'Ferralic', 'Having a ferralic horizon starting within 200 cm of the soil surface (in Anthrosolsonly), or having ferralic properties in at least some layer starting within 100 cm of the soilsurface (in other soils)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Cutanic', 'Cutanic', 'Having clay coatings in some parts of an argic horizon either starting within100 cm of the soil surface or within 200 cm of the soil surface if the argic horizon is overlain byloamy sand or coarser textures throughout', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ferric', 'Ferric', 'Having a ferric horizon starting within 100 cm of the soil surface.', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gelistagnic', 'Gelistagnic', 'Having temporary water saturation at the soil surface caused by a frozensubsoil', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fibric', 'Fibric', 'Having, after rubbing, two-thirds or more (by volume) of the organic materialconsisting of recognizable plant tissue within 100 cm of the soil surface (in Histosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Greyic', 'Greyic', 'Having Munsell colours with a chroma of 3 or less when moist, a value of 3 or lesswhen moist and 5 or less when dry and uncoated silt and sand grains on structural faces within5 cm of the mineral soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fluvic', 'Fluvic', 'Having fluvic material in a layer, 25 cm or more thick, within 100 cm of the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Glossic', 'Glossic', 'Showing tonguing of a mollic or umbric horizon into an underlying layer', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gibbsic', 'Gibbsic', 'Having a layer, 30 cm or more thick, containing 25 percent or more gibbsite in thefine earth fraction starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fractiplinthic', 'Fractiplinthic', 'Having a petroplinthic horizon consisting of fractured or broken clods withan average horizontal length of less than 10 cm, starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fractipetric', 'Fractipetric', 'Having a strongly cemented or indurated horizon consisting of fractured orbroken clods with an average horizontal length of less than 10 cm, starting within 100 cm of thesoil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gelic', 'Gelic', 'Having a layer with a soil temperature of 0 ºC or less for two or more consecutiveyears starting within 200 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gleyic', 'Gleyic', 'Having within 100 cm of the mineral soil surface a layer, 25 cm or more thick, thathas reducing conditions in some parts and  a gleyic colour pattern throughout', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Floatic', 'Floatic', 'Having organic material floating on water (in Histosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Folic', 'Folic', 'Having a folic horizon starting within 40 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gypsic', 'Gypsic', 'Having a gypsic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Geric', 'Geric', 'Having geric properties in some layer within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Glacic', 'Glacic', 'Having a layer, 30 cm or more thick, containing 75 percent (by volume) or more icestarting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Garbic', 'Garbic', 'Having a layer, 20 cm or more thick within 100 cm of the soil surface, with20 percent or more (by volume, by weighted average) artefacts containing 35 percent or more(by volume) organic waste materials (in Technosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fulvic', 'Fulvic', 'Having a fulvic horizon starting within 30 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Fragic', 'Fragic', 'Having a fragic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Grumic', 'Grumic', 'Having a soil surface layer with a thickness of 3 cm or more with a strongstructure finer than very coarse granular (in Vertisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Gypsiric', 'Gypsiric', 'Having gypsiric material between 20 and 50 cm from the soil surface or between20 cm and continuous rock or a cemented or indurated layer, whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypereutric', 'Hypereutric', 'Having a base saturation (by 1 M NH 4 OAc) of 50 percent or morethroughout between 20 and 100 cm from the soil surface and 80 percent or more in somelayer within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endogleyic', 'Endogleyic', 'Having between 50 and 100 cm from the mineral soil surface a layer, 25cm or more thick, that has reducing conditions in some parts and a gleyic colour pattern throughout', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hemic', 'Hemic', 'Having, after rubbing, between two-thirds and one-sixth (by volume) of theorganic material consisting of recognizable plant tissue within 100 cm from the soil surface (inHistosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Umbriglossic', 'Umbriglossic', 'Showing tonguing of an umbric horizon into an underlying layer', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endoeutric', 'Endoeutric', 'Having a base saturation (by 1 M NH 4 OAc) of 50 percent or morethroughout between 50 and 100 cm from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endofluvic', 'Endofluvic', 'Having fluvic material in a layer, 25 cm or more thick, between 50 and100 cm from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Epidystric', 'Epidystric', 'Having a base saturation (by 1 M NH 4 OAc) of less than 50 percentthroughout between 20 and 50 cm from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Epieutric', 'Epieutric', 'Having a base saturation (by 1 M NH 4 OAc) of 50 percent or morethroughout between 20 and 50 cm from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Rustic', 'Rustic', 'Having a spodic horizon in which the ratio of the percentage of acid oxalate (pH3)extractable Fe to the percentage of organic carbon is 6 or more throughout (in Podzols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Voronic', 'Voronic', 'Having a voronic horizon (in Chernozems only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Turbic', 'Turbic', 'Having cryoturbation features (mixed material, disrupted soil horizons, involutions,organic intrusions, frost heave, separation of coarse from fine materials, cracks or patternedground) at the soil surface or above a cryic horizon and within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Posic', 'Posic', 'Having a zero or positive charge (pH KCl - pH water ≥ 0, both in 1:1 solution) in a layer,30 cm or more thick, starting within 100 cm of the soil surface (in Plinthosols and Ferralsolsonly)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Leptic', 'Leptic', 'Having continuous rock starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Lixic', 'Lixic', 'Having an argic horizon that has a CEC (by 1 M NH 4 OAc) of less than 24 cmol c kg -1clay in some part to a maximum depth of 50 cm below its upper limit, either startingwithin 100 cm of the soil surface or within 200 cm of the soil surface if the argic horizon isoverlain by loamy sand or coarser textures throughout, and having a base saturation (by 1 MNH 4 OAc) of 50 percent or more in the major part between 50 and 100 cm from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Vetic', 'Vetic', 'Having an ECEC (sum of exchangeable bases plus exchangeable acidity in 1 M KCl)of less than 6 cmol c kg -1 clay in some subsurface layer within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Toxic', 'Toxic', 'Having in some layer within 50 cm of the soil surface toxic concentrations of organicor inorganic substances other than ions of Al, Fe, Na, Ca and Mg', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Magnesic', 'Magnesic', 'Having an exchangeable Ca to Mg ratio of less than 1 in the major part within100 cm of the soil surface or to continuous rock or a cemented or indurated layer, whichever isshallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Xanthic', 'Xanthic', 'Having a ferralic horizon that has in a subhorizon, 30 cm or more thick within150 cm of the soil surface, a Munsell hue of 7.5 YR or yellower and a value, moist, of 4 or moreand a chroma, moist, of 5 or more', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Stagnic', 'Stagnic', 'Having within 100 cm of the mineral soil surface in some parts reducing conditionsfor some time during the year and in 25 percent or more of the soil volume, single or incombination, a stagnic colour pattern or an albic horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pisoplinthic', 'Pisoplinthic', 'Having a pisoplinthic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyposalic', 'Hyposalic', 'Having an EC e of 4 dS m -1 or more at 25 ºC in some layer within 100 cmof the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Puffic', 'Puffic', 'Having a crust pushed up by salt crystals (in Solonchaks only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Mesotrophic', 'Mesotrophic', 'Having a base saturation (by 1 M NH 4 OAc) of less than 75 percent at adepth of 20 cm from the soil surface (in Vertisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Mazic', 'Mazic', 'Massive and hard to very hard in the upper 20 cm of the soil (in Vertisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Plaggic', 'Plaggic', 'Having a plaggic horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hydric', 'Hydric', 'Having within 100 cm of the soil surface one or more layers with a combinedthickness of 35 cm or more, which have a water retention at 1 500 kPa (in undried samples) of100 percent or more (in Andosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pachic', 'Pachic', 'Having a mollic or umbric horizon 50 cm or more thick', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Aceric', 'Aceric', 'Having a pH (1:1 in water) between 3.5 and 5 and jarosite mottles in some layerwithin 100 cm of the soil surface (in Solonchaks only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Albic', 'Albic', 'Having an albic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hortic', 'Hortic', 'Having a hortic horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ekranic', 'Ekranic', 'Having technic hard rock starting within 5 cm of the soil surface and covering95 percent or more of the horizontal extent of the soil (in Technosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ombric', 'Ombric', 'Having a histic horizon saturated predominantly with rainwater starting within 40cm of the soil surface (in Histosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Escalic', 'Escalic', 'Occurring in human-made terraces', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sodic', 'Sodic', 'Having 15 percent or more exchangeable Na plus Mg on the exchange complexwithin 50 cm of the soil surface throughout', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Haplic', 'Haplic', 'Having a typical expression of certain features (typical in the sense that there is nofurther or meaningful characterization) and only used if none of the preceding qualifiers applies', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ornithic', 'Ornithic', 'Having a layer 15 cm or more thick with ornithogenic material starting within50 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperalbic', 'Hyperalbic', 'Having an albic horizon starting within 50 cm of the soil surface andhaving its lower boundary at a depth of 100 cm or more from the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Lignic', 'Lignic', 'Having inclusions of intact wood fragments, which make up one-quarter or more ofthe soil volume, within 50 cm of the soil surface (in Histosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endosalic', 'Endosalic', 'Having a salic horizon starting between 50 and 100 cm from the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Linic', 'Linic', 'Having a continuous, very slowly permeable to impermeable constructedgeomembrane of any thickness starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endostagnic', 'Endostagnic', 'Having between 50 and 100 cm from the mineral soil surface in someparts reducing conditions for some time during the year and in 25 percent or more of thesoil volume, single or in combination, a stagnic colour pattern or an albic horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Natric', 'Natric', 'Having a natric horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Vitric', 'Vitric', 'Having within 100 cm of the soil surface one or more layers with andic or vitricproperties with a combined thickness of 30 cm or more (in Cambisols: 15 cm or more), ofwhich 15 cm or more have vitric properties', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Histic', 'Histic', 'Having a histic horizon starting within 40 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypergypsic', 'Hypergypsic', 'Having a gypsic horizon with 50 percent or more (by mass) gypsum andstarting within 100 cm of the soil surface (in Gypsisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Endoleptic', 'Endoleptic', 'Having continuous rock starting between 50 and 100 cm from the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petroplinthic', 'Petroplinthic', 'Having a petroplinthic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Spolic', 'Spolic', 'Having a layer, 20 cm or more thick within 100 cm of the soil surface, with20 percent or more (by volume, by weighted average) artefacts containing 35 percent or more(by volume) of industrial waste (mine spoil, dredgings, rubble, etc. (in Technosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Luvic', 'Luvic', 'Having an argic horizon that has a CEC (by 1 M NH 4 OAc) of 24 cmol c kg -1 clay ormore throughout or to a depth of 50 cm below its upper limit, whichever is shallower, eitherstarting within 100 cm of the soil surface or within 200 cm of the soil surface if the argichorizon is overlain by loamy sand or coarser textures throughout, and having a base saturation(by 1 M NH 4 OAc) of 50 percent or more in the major part between 50 and 100 cm from the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Lamellic', 'Lamellic', 'Having clay lamellae with a combined thickness of 15 cm or more within 100 cmof the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Melanic', 'Melanic', 'Having a melanic horizon starting within 30 cm of the soil surface (in Andosolsonly)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Ruptic', 'Ruptic', 'Having a lithological discontinuity within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hydragric', 'Hydragric', 'Having an anthraquic horizon and an underlying hydragric horizon, the latterstarting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petric', 'Petric', 'Having a strongly cemented or indurated layer starting within 100 cm of the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Protic', 'Protic', 'Showing no soil horizon development (in Arenosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thionic', 'Thionic', 'Having a thionic horizon or a layer with sulphidic material, 15 cm or more thick,starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Spodic', 'Spodic', 'Having a spodic horizon starting within 200 cm of the mineral soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petroduric', 'Petroduric', 'Having a petroduric horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Subaquatic', 'Subaquatic', 'Being permanently submerged under water not deeper than 200 cm (inFluvisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Technic', 'Technic', 'Having 10 percent or more (by volume, by weighted average) artefacts in theupper 100 cm from the soil surface or to continuous rock or a cemented or indurated layer,whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Reductic', 'Reductic', 'Having reducing conditions in 25 percent or more of the soil volume within 100cm of the soil surface caused by gaseous emissions, e.g. methane or carbon dioxide (inTechnosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Takyric', 'Takyric', 'Having a takyric horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Transportic', 'Transportic', 'Having at the surface a layer, 30 cm or more thick, with solid or liquidmaterial that has been moved from a source area outside the immediate vicinity of the soil byintentional human activity, usually with the aid of machinery, and without substantial reworkingor displacement by natural forces', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Vermic', 'Vermic', 'Having 50 percent or more (by volume, by weighted average) of worm holes,casts, or filled animal burrows in the upper 100 cm of the soil or to continuous rock or acemented or indurated layer, whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Plinthic', 'Plinthic', 'Having a plinthic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypocalcic', 'Hypocalcic', 'Having a calcic horizon with a calcium carbonate equivalent content in thefine earth fraction of less than 25 percent and starting within 100 cm of the soil surface (inCalcisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Rubic', 'Rubic', 'Having within 100 cm of the soil surface a subsurface layer, 30 cm or more thick,with a Munsell hue redder than 10 YR or a chroma, moist, of 5 or more (in Arenosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Nitic', 'Nitic', 'Having a nitic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thaptovitric', 'Thaptovitric', 'Having within 100 cm of the soil surface one or more buried layerswith andic or vitric properties with a combined thickness of 30 cm or more (in Cambisols: 15 cm or more), of which 15 cm or more havevitric properties', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Tephric', 'Tephric', 'Having tephric material to a depth of 30 cm or more from the soil surface or tocontinuous rock, whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperskeletic', 'Hyperskeletic', 'Containing less than 20 percent (by volume) fine earth averaged over adepth of 75 cm from the soil surface or to continuous rock, whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Lithic', 'Lithic', 'Having continuous rock starting within 10 cm of the soil surface (in Leptosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Tidalic', 'Tidalic', 'Being flooded by tidewater but not covered by water at mean low tide', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sulphatic', 'Sulphatic', 'Having a salic horizon with a soil solution (1:1 in water) with [SO 42- ] >> [HCO 3-] > [Cl - ] (in Solonchaks only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Profondic', 'Profondic', 'Having an argic horizon in which the clay content does not decrease by20 percent or more (relative) from its maximum within 150 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Terric', 'Terric', 'Having a terric horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Placic', 'Placic', 'Having, within 100 cm of the soil surface, an iron pan, between 1 and 25 mm thick,that is continuously cemented by a combination of organic matter, Fe and/or Al', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Thixotropic', 'Thixotropic', 'Having in some layer within 50 cm of the soil surface material that changes,under pressure or by rubbing, from a plastic solid into a liquefied stage and back into the solidcondition', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Regic', 'Regic', 'Not having buried horizons (in Anthrosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petrocalcic', 'Petrocalcic', 'Having a petrocalcic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Protothionic', 'Protothionic', 'Having a layer with sulphidic material, 15 cm or more thick, startingwithin 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Skeletic', 'Skeletic', 'Having 40 percent or more (by volume) gravel or other coarse fragments averagedover a depth of 100 cm from the soil surface or to continuous rock or a cemented or induratedlayer, whichever is shallower', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Manganiferric', 'Manganiferric', 'Having a ferric horizon starting within 100 cm of the soil surface in whichhalf or more of the nodules or mottles are black', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hydrophobic', 'Hydrophobic', 'Water-repellent, i.e. water stands on a dry soil for the duration of 60 secondsor more (in Arenosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Oxyaquic', 'Oxyaquic', 'Saturated with oxygen-rich water during a period of 20 or more consecutivedays and not having a gleyic or stagnic colour pattern in some layer within 100 cm of the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Rendzic', 'Rendzic', 'Having a mollic horizon that contains or immediately overlies calcaric materialsor calcareous rock containing 40 percent or more calcium carbonate equivalent', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Humic', 'Humic', 'Having the following organic carbon contents in the fine earth fraction as aweighted average: in Ferralsols and Nitisols, 1.4 percent or more to a depth of 100 cm from themineral soil surface; in Leptosols to which the Hyperskeletic qualifier applies, 2 percent or moreto a depth of 25 cm from the mineral soil surface; in other soils, 1 percent or more to a depth of50 cm from the mineral soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Laxic', 'Laxic', 'Having a bulk density of less than 0.89 kg dm -3 , in a mineral soil layer, 20 cm ormore thick, starting within 75 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Limnic', 'Limnic', 'Having limnic material, cumulatively 10 cm or more thick, within 50 cm of thesoil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperalic', 'Hyperalic', 'Having an argic horizon, either starting within 100 cm of the soil surface orwithin 200 cm of the soil surface if the argic horizon is overlain by loamy sand or coarsertextures throughout, that has a silt to clay ratio of less than 0.6 and an Al saturation (effective)of 50 percent or more, throughout or to a depth of 50 cm below its upper limit, whichever isshallower (in Alisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Yermic', 'Yermic', 'Having a yermic horizon, including a desert pavement', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petrosalic', 'Petrosalic', 'Having, within 100 cm of the soil surface, a layer, 10 cm or more thick, whichis cemented by salts more soluble than gypsum', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Nudilithic', 'Nudilithic', 'Having continuous rock at the soil surface (in Leptosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petrogleyic', 'Petrogleyic', 'Having a layer, 10 cm or more thick, with an oximorphic colour pattern 59 ,15 percent or more (by volume) of which is cemented (bog iron), within 100 cm of the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Rhodic', 'Rhodic', 'Having within 150 cm of the soil surface a subsurface layer, 30 cm or more thick,with a Munsell hue of 2.5 YR or redder, a value, moist, of less than 3.5 anda value, dry, no more than one unit higher than the moist value', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Siltic', 'Siltic', 'Having a texture of silt, silt loam, silty clay loam or silty clay in a layer, 30 cm ormore thick, within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Silandic', 'Silandic', 'Having one or more layers, cumulatively 15 cm or more thick, with andicproperties and an acid oxalate (pH 3) extractable silica (Si ox ) content of 0.6 percent or more, oran Al py to Al ox ratio of less than 0.5 within 100 cm of the soil surface (in Andosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperochric', 'Hyperochric', 'Having a mineral topsoil layer, 5 cm or more thick, with a Munsell value,dry, of 5.5 or more that turns darker on moistening, an organic carbon content of less than0.4 percent, a platy structure in 50 percent or more of the volume, and a surface crust', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Urbic', 'Urbic', 'Having a layer, 20 cm or more thick within 100 cm of the soil surface, with20 percent or more (by volume, by weighted average) artefacts containing 35 percent or more(by volume) of rubble and refuse of human settlements (in Technosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Reductaquic', 'Reductaquic', 'Saturated with water during the thawing period and having at some time ofthe year reducing conditions above a cryic horizon and within 100 cm of the soil surface (inCryosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyperdystric', 'Hyperdystric', 'Having a base saturation (by 1 M NH 4 OAc) of less than 50 percentthroughout between 20 and 100 cm from the soil surface, and less than 20 percent insome layer within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Petrogypsic', 'Petrogypsic', 'Having a petrogypsic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypogypsic', 'Hypogypsic', 'Having a gypsic horizon with a gypsum content in the fine earth fraction ofless than 25 percent and starting within 100 cm of the soil surface (in Gypsisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Vertic', 'Vertic', 'Having a vertic horizon or vertic properties starting within 100 cm of the soilsurface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Pellic', 'Pellic', 'Having in the upper 30 cm of the soil a Munsell value, moist, of 3.5 or less and achroma, moist, of 1.5 or less (in Vertisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Sapric', 'Sapric', 'Having, after rubbing, less than one-sixth (by volume) of the organic materialconsisting of recognizable plant tissue within 100 cm of the soil surface (in Histosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Novic', 'Novic', 'Having above the soil that is classified at the RSG level, a layer with recentsediments (new material), 5 cm or more and less than 50 cm thick', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypersalic', 'Hypersalic', 'Having an EC e of 30 dS m -1 or more at 25 ºC in some layer within100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypoluvic', 'Hypoluvic', 'Having an absolute clay increase of 3 percent or more within 100 cm of the soilsurface (in Arenosols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Mollic', 'Mollic', 'Having a mollic horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Salic', 'Salic', 'Having a salic horizon starting within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Umbric', 'Umbric', 'Having an umbric horizon', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hypercalcic', 'Hypercalcic', 'Having a calcic horizon with 50 percent or more (by mass) calcium carbonateequivalent and starting within 100 cm of the soil surface (in Calcisols only)', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Hyposodic', 'Hyposodic', 'Having 6 percent or more exchangeable Na on the exchange complexin a layer, 20 cm or more thick, within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Abruptic', 'Abruptic', 'Having an abrupt textural change within 100 cm of the soil surface', 'WRBQualifierValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBQualifierValue/Entic', 'Entic', 'Not having an albic horizon and having a loose spodic horizon (in Podzols only)', 'WRBQualifierValue', null, null, null, null);




-- WRBQualifierValue (2022)
-- FEATURE wrbqualifiergrouptype
-- CODELIST ORBL-SOIL
-- https://obrl-soil.github.io/wrbsoil2022/

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ap', 'Abruptic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ae', 'Aceric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ac', 'Acric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ao', 'Acroxic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-at', 'Activic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ay', 'Aeolic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ab', 'Albic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ax', 'Alcalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-al', 'Alic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-aa', 'Aluandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-an', 'Andic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-aq', 'Anthraquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ak', 'Anthric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ah', 'Archaic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ar', 'Arenic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ad', 'Arenicolic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ai', 'Aric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-az', 'Arzic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-bc', 'Biocrustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-br', 'Brunic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-by', 'Bryic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ca', 'Calcaric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cc', 'Calcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cm', 'Cambic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cp', 'Capillaric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cb', 'Carbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cn', 'Carbonatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cx', 'Carbonic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ch', 'Chernic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cl', 'Chloridic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cr', 'Chromic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cq', 'Claric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ce', 'Clayic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cs', 'Coarsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-co', 'Cohesic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cu', 'Columnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cd', 'Cordic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-cy', 'Cryic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ct', 'Cutanic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-dn', 'Densic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-df', 'Differentic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-do', 'Dolomitic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ds', 'Dorsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-dr', 'Drainic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-du', 'Duric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-dy', 'Dystric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ek', 'Ekranic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ed', 'Endic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-et', 'Entic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ep', 'Epic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ec', 'Escalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-eu', 'Eutric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-es', 'Eutrosilic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ev', 'Evapocrustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fl', 'Ferralic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fr', 'Ferric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fe', 'Ferritic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fi', 'Fibric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ft', 'Floatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fv', 'Fluvic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fc', 'Fractic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-fg', 'Fragic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ga', 'Garbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ge', 'Gelic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gt', 'Gelistagnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gr', 'Geric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gi', 'Gibbsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gg', 'Gilgaic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gc', 'Glacic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gl', 'Gleyic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gs', 'Glossic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gz', 'Greyzemic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gm', 'Grumic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gy', 'Gypsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-gp', 'Gypsiric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ha', 'Haplic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hm', 'Hemic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hi', 'Histic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ht', 'Hortic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hu', 'Humic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hg', 'Hydragric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hy', 'Hydric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-hf', 'Hydrophobic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-jl', 'Hyperalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ja', 'Hyperartefactic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypercalcic-jc', 'Hypercalcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypereutric-je', 'Hypereutric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypergypsic-jy', 'Hypergypsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypernatric-jn', 'Hypernatric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-jo', 'Hyperorganic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hypersalic-jz', 'Hypersalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#hyperspodic-jp', 'Hyperspodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-im', 'Immissic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ic', 'Inclinic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ia', 'Infraandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-is', 'Infraspodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ir', 'Irragric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-il', 'Isolatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ip', 'Isopteric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ka', 'Kalaic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ll', 'Lamellic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ld', 'Lapiadic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-la', 'Laxic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-le', 'Leptic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lg', 'Lignic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lm', 'Limnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ln', 'Limonic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lc', 'Linic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-li', 'Lithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lh', 'Litholinic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lx', 'Lixic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lo', 'Loamic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-lv', 'Luvic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mg', 'Magnesic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ma', 'Mahic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mw', 'Mawic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mz', 'Mazic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mi', 'Mineralic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mc', 'Mochipic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mo', 'Mollic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mm', 'Mulmic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mh', 'Murshic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-mu', 'Muusic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-nr', 'Naramic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-na', 'Natric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ne', 'Nechic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#neobrunic-nb', 'Neobrunic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#neocambic-nc', 'Neocambic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ni', 'Nitic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-nv', 'Novic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ng', 'Nudiargic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#nudilithic-nt', 'Nudilithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#nudinatric-nn', 'Nudinatric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oh', 'Ochric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-om', 'Ombric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oc', 'Ornithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#orthofluvic-of', 'Orthofluvic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-os', 'Ortsteinic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oa', 'Oxyaquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-oy', 'Oxygleyic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ph', 'Pachic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pb', 'Panpaic ', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pe', 'Pellic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-p', 'Pelocrustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pt', 'Petric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pc', 'Petrocalcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pd', 'Petroduric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pg', 'Petrogypsic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pp', 'Petroplinthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ps', 'Petrosalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-px', 'Pisoplinthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pi', 'Placic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pa', 'Plaggic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pl', 'Plinthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-po', 'Posic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pk', 'Pretic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pn', 'Profondic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pr', 'Protic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protoandic-qa', 'Protoandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-qg', 'Protoargic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protocalcic-qc', 'Protocalcic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protospodic-qp', 'Protospodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#protovertic-qv', 'Protovertic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-pu', 'Puffic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-py', 'Pyric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rp', 'Raptic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ra', 'Reductaquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rd', 'Reductic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ry', 'Reductigleyic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rc', 'Relocatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rz', 'Rendzic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rt', 'Retic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rh', 'Rheic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ro', 'Rhodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rk', 'Rockic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ru', 'Rubic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-rs', 'Rustic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sz', 'Salic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sa', 'Sapric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sh', 'Saprolithic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-se', 'Sideralic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sn', 'Silandic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sl', 'Siltic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sk', 'Skeletic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-so', 'Sodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sv', 'Solimovic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sb', 'Sombric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-si', 'Someric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sd', 'Spodic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sp', 'Spolic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-st', 'Stagnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sq', 'Subaquatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-sf', 'Sulfidic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-su', 'Sulphatic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ty', 'Takyric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-te', 'Technic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tf', 'Tephric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tr', 'Terric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ti', 'Thionic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tp', 'Thixotropic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-th', 'Thyric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-td', 'Tidalic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-to', 'Tonguic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tx', 'Toxic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tn', 'Transportic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ts', 'Tsitelic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-tu', 'Turbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-um', 'Umbric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ub', 'Urbic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-uq', 'Uterquic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-vm', 'Vermic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-vr', 'Vertic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-vi', 'Vitric', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-wa', 'Wapnic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-xa', 'Xanthic', null, 'WRBQualifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-05.html#sec-ye', 'Yermic', null, 'WRBQualifierValue2022', null, null, null, null);


-- WRBSpecifiers (2006)
-- FEATURE wrbqualifiergrouptype
-- CODELIST INSPIRE 
-- http://inspire.ec.europa.eu/codelist/WRBSpecifierValue (Under review)

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/bathi', 'Bathi', 'Bathi', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/cumuli', 'Cumuli', 'Cumuli', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/endo', 'Endo', 'Endo', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/epi', 'Epi', 'Epi', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/hyper', 'Hyper', 'Hyper', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/hypo', 'Hypo', 'Hypo', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/ortho', 'Ortho', 'Ortho', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/para', 'Para', 'Para', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/proto', 'Proto', 'Proto', 'WRBSpecifierValue', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/WRBSpecifierValue/thapto', 'Thapto', 'Thapto', 'WRBSpecifierValue', null, null, null, null);



-- WRBSpecifierValue (2022)
-- FEATURE wrbqualifiergrouptype
-- CODELIST ORBL-SOIL
-- https://obrl-soil.github.io/wrbsoil2022/

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Amphi', 'Amphi', 'The layer starts > 0 and < 50 cm from the (mineral) soil surface and  has its lower limit > 50 and < 100 cm of the (mineral) soil surface; and no such layer occurs < 1 cm of  the (mineral) soil surface; and no such layer occurs between 99 and 100 cm of the (mineral) soil  surface or directly above a limitig layer', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Ano', 'Ano', 'The layer starts at the (mineral) soil surface and has its lower limit > 50  and < 100 cm of the (mineral) soil surface; and no such layer occurs between 99 and 100 cm of the  (mineral) soil surface or directly above a limiting layer. ', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Bathy', 'Bathy', 'Specifier can be used to construct additional subqualifiers. The Bathy- subqualifier extends to a  greater depth than specified for the qualifier. I', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Endo', 'Endo', 'The layer starts ≥ 50 cm from the (mineral) soil surface; and no such  layer occurs < 50 cm of the (mineral) soil surface.', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Epi', 'Epi', 'The layer has its lower limit ≤ 50 cm of the (mineral) soil surface; and no  such layer occurs between 50 and 100 cm of the (mineral) soil surface; not used if the definition of the  qualifier or of the horizon requires that the layer starts at the (mineral) soil surface; if a limiting layer starts ≤ 50 cm from the mineral soil surface, the qualifier referring to the limiting layer receives the  Epi- specifier and all other qualifiers remain without specifier. ', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Kato', 'Kato', 'The layer starts > 0 and < 50 cm from the (mineral) soil surface and  has its lower limit ≥ 100 cm of the (mineral) soil surface or at a limiting layer starting > 50 cm from  the (mineral) soil surface; and no such layer occurs < 1 cm of the (mineral) soil surface. ', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Panto', 'Panto', 'The layer starts at the (mineral) soil surface and has its lower limit ≥ 100 cm of the (mineral) soil surface or at a limiting layer starting > 50 cm from the (mineral) soil surface.', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Poly', 'Poly', 'Diagnostic horizons: two or more diagnostic horizons are present at the depth required by the  qualifier definition, interrupted by layers that do not fulfil the criteria of the respective diagnostic  horizon;b. other layers: two or more layers within 100 cm of the (mineral) soil surface fulfil the criteria of the  qualifier, interrupted by layers that do not fulfil the criteria of the respective qualifier; and the  thickness criterion is fulfilled by the sum of the thicknesses of the layers; it may or may not be fulfilled by the single layers.', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Supra', 'Supra', 'Specifier can be constructed to describe the soil material above, if  the thickness or depth requirements of a qualifier or of its respective diagnostics are not fulfilled, but all  other criteria are fulfilled throughout in the soil material above', 'WRBSpecifierValue2022', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://obrl-soil.github.io/wrbsoil2022/chapter-06.html#specifiers#Thapto', 'Thapto', 'Specifier can be used to construct optional or additional  subqualifiers. If used with a principal qualifier, the Thapto- subqualifier must shift to the supplementary  qualifiers and be placed within the list of the supplementary qualifiers according to the alphabetical position  of the qualifier, not the subqualifier. ', 'WRBSpecifierValue2022', null, null, null, null);


-- *** INTERNAL *** codelist for managing forms 
-- Define the FOI
-- FEATURE observableproperty
-- CODELIST for internal management of Qgis forms

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('profileelement', 'profileelement', null, 'FOIType', '', null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('soilprofile', 'soilprofile', null, 'FOIType', '', null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('soilderivedobject', 'soilderivedobject', null, 'FOIType', '', null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('soilsite', 'soilsite', null, 'FOIType', '', null, null, null);

-- *** INTERNAL *** codelist for managing forms 
-- Define the PhenomenonType
-- FEATURE observableproperty
-- CODELIST for internal management of Qgis forms

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('chemical', 'chemical', null, 'PhenomenonType', '', null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('biological', 'biological', null, 'PhenomenonType', '', null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('physical', 'physical', null, 'PhenomenonType', '', null, null, null);


-- ProcessParameterNameValue
-- FEATURE processparameter
-- CODELIST AGROPRTAL - LOD 
-- https://agroportal.lirmm.fr/ - https://lod.nal.usda.gov/

INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/UC_SENSE/sensory_perception_process', 'Sensory Assesment', 'Sensory Assesment', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/UC_SENSE/perceived_aroma', 'Aroma method', 'Aroma method', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/55677', 'Smelling', 'Olfactory determination', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/UC_SENSE/perceived_flavor', 'Taste method', 'Taste method', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AGFOOD/Q1W-PVK52ZPF-9', 'Gustation', 'Tasting determination', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/UC_SENSE/perceived_visual_stimulus', 'Visual Observation', 'Visual Observation', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/BDG/CountingUnit', 'Counting', 'Counting', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/28752', 'Estimation', 'Estimation', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/52488', 'Visual Rating', 'Classification, class, category', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/CO_350/CO_350:0000001', 'Visual Scoring', 'Score, rating, grade, grade, judgement', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/UC_SENSE/perceived_texture', 'Texture method', 'Texture method', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/UC_SENSE/perceived_tactile_stimulus', 'By hand', 'Tactile determination', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/UC_SENSE/perceived_mouthfeel', 'By mouth', 'Determination by use of the tongue', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/31779', 'Computation', 'Computation', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/302029', 'Calculation', 'Calculation, processing', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/AFO/p4794', 'Measurement', 'Measurement', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/ONTOBIOTOPE/OBT_000146', 'Field determination', 'Field determination', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/ONTOBIOTOPE/OBT_000103', 'Instrumental', 'Instrumental determination', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://agroportal.lirmm.fr/ontologies/ONTOBIOTOPE/OBT_001169', 'Laboratory determination', 'Laboratory determination', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/17521', 'Sensor', 'Sensor determination', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/136977', 'Expert attribution', 'Expert attribution', 'ProcessParameterNameValue', null, null, null, null);
INSERT INTO codelist (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('https://lod.nal.usda.gov/nalt/52488', 'Classificazione, classe, categoria', 'Classificazione, classe, categoria', 'ProcessParameterNameValue', null, null, null, null);


-- ResponsiblePartyRole
-- FEATURE relatedparty
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole

INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/resourceProvider', 'Resource Provider', 'Party that supplies the resource.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/custodian', 'Custodian', 'Party that accepts accountability and responsibility for the data and ensures appropriate care and maintenance of the resource.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/owner', 'Owner', 'Party that owns the resource.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/user', 'User', 'Party who uses the resource.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/distributor', 'Distributor', 'Party who distributes the resource.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/originator', 'Originator', 'Party who created the resource', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/pointOfContact', 'Point of Contact', 'Party who can be contacted for acquiring knowledge about or acquisition of the resource.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/principalInvestigator', 'Principal Investigator', 'Key party responsible for gathering information and conducting research.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/processor', 'Processor', 'Party who has processed the data in a manner such that the resource has been modified.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/publisher', 'Publisher', 'Party who published the resource.', 'ResponsiblePartyRole', null, null, null, null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/author', 'Author', 'Party who authored the resource.', 'ResponsiblePartyRole', null, null, null, null);


----------------------------------------------------------------
-- PARAMETER --
----------------------------------------------------------------


-- SoilSiteParameterNameValue
-- PARAMETER soilsite
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue

-- CHEMICAL
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalAs', 'Arsenic and compounds (as As)', 'as in E-PRTR, CAS-Nr.: 7440-38-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalBa', 'Barium and compounds (as Ba)', 'CAS-Nr.: 82870-81-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCd', 'Cadmium and compounds (as Cd)', 'as in E-PRTR, CAS-Nr.: 7440-43-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCr', 'Chromium and compounds (as Cr)', 'as in E-PRTR, CAS-Nr.: 7440-47-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCo', 'Cobalt and compounds (as Co)', 'CAS-Nr.: 7440-48-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalCu', 'Copper and compounds (as Cu)', 'as in E-PRTR, CAS-Nr.: 7440-50-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalHg', 'Mercury and compounds (as Hg)', 'as in E-PRTR, CAS-Nr.: 7439-97-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalNi', 'Nickel and compounds (as Ni)', 'as in E-PRTR, CAS-Nr.: 7440-02-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalPb', 'Lead and compounds (as Pb)', 'as in E-PRTR, CAS-Nr.: 7439-92-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalTl', 'Thallium and compounds (as Tl)', 'CAS-Nr.: 82870-81-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalZn', 'Zinc and compounds (as Zn)', 'as in E-PRTR, CAS-Nr.: 7440-66-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalSb', 'Antimony and compounds (as Sb)', 'CAS-Nr.: 7440-36-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalV', 'Vanadium and compounds (as V)', 'CAS-Nr.: 7440-62-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/metalMo', 'Molybdenum and compounds (as Mo)', 'CAS-Nr.: 7439-89-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/organometalSn', 'Organotin compounds (as total Sn)', 'as in E-PRTR, CAS-Nr.: 7440-31-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/organometalTributylSn', 'Tributyltin and compounds (total mass)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/organometalTriphenylSn', 'Triphenyltin and compounds (total mass)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/inorganicAsbestos', 'Asbestos', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/inorganicCN', 'Cyanides (as total CN)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/inorganicF', 'Fluorides (as total F)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticBTEX', 'BTEX', 'as in E-PRTR,  Sum of benzene, toluene. Ethylbenzene and Xylenes', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticBenzene', 'Benzene', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticToluene', 'Toluene', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticEthylbenzene', 'Ethylbenzene', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticXylene', 'Xylene', 'as in E-PRTR, sum of 3 isomers', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/aromaticStyrene', 'Styrene', 'Styrene', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCBs', 'Polychlorinated biphenyls (PCBs)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB28', 'Polychlorinated biphenyl 28', 'CAS-Nr.: 7012-37-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB52', 'Polychlorinated biphenyls 52', 'CAS-Nr.: 35693-99-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB101', 'Polychlorinated biphenyls 101', 'CAS-Nr.: 37680-73-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB138', 'Polychlorinated biphenyls 138', 'CAS-Nr.: 35065-28-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB153', 'Polychlorinated biphenyls 153', 'CAS-Nr.: 35065-27-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB180', 'Polychlorinated biphenyls 180', 'CAS-Nr.: 35065-29-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB77', 'Polychlorinated biphenyls 77', 'as in POP convention, CAS-Nr.: 1336-36-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB81', 'Polychlorinated biphenyls 81', 'as in POP convention, CAS-Nr.: 70362-50-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB126', 'Polychlorinated biphenyls 126', 'as in POP convention, CAS-Nr.: 57465-288', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB169', 'Polychlorinated biphenyls 169', 'as in POP convention, CAS-Nr.: 32774-16-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB105', 'Polychlorinated biphenyls 105', 'as in POP convention, CAS-Nr.: 32598-14-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB114', 'Polychlorinated biphenyls 114', 'as in POP convention, CAS-Nr.: 74472-37-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB118', 'Polychlorinated biphenyls 118', 'as in POP convention, CAS-Nr.: 31508-00-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB123', 'Polychlorinated biphenyls 123', 'as in POP convention, CAS-Nr.: 65510-44-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB156', 'Polychlorinated biphenyls 156', 'as in POP convention, CAS-Nr.: 38380-08-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB157', 'Polychlorinated biphenyls 157', 'as in POP convention, CAS-Nr.: 69782-90-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB167', 'Polychlorinated biphenyls 167', 'as in POP convention, CAS-Nr.: 52663-72-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCB189', 'Polychlorinated biphenyls 189', 'as in POP convention, CAS-Nr.: 39635-31-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticHCB', 'Hexachlorobenzene (HCB)', 'as in E-PRTR, CAS-Nr.: 118-74-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPCDD-PCF', 'PCDD+PCDF (dioxines and furans; as Teq)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-7-8-Tetra-CDD', '2,3,7,8-Tetra-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-Penta-CDD', '1,2,3,7,8-Penta-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-7-8-Hexa-CDD', '1,2,3,4,7,8-Hexa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-6-7-8-Hexa-CDD', '1,2,3,6,7,8-Hexa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-9-Hexa-CDD', '1,2,3,7,8,9-Hexa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-3-6-7-8-Hepta-CDD', '1,2,3,3,6,7,8-Hepta-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-6-7-8-9-Octa-CDD', '1,2,3,4,6,7,8,9-Octa-CDD (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-7-8-Tetra-CDF', '2,3,7,8-Tetra-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-Penta-CDF', '1,2,3,7,8-Penta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-4-7-8-Penta-CDF', '2,3,4,7,8-Penta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-7-8-Hexa-CDF', '1,2,3,4,7,8-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-6-7-8-Hexa-CDF', '1,2,3,6,7,8-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-7-8-9-Hexa-CDF', '1,2,3,7,8,9-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic2-3-4-6-7-8-Hexa-CDF', '2,3,4,6,7,8-Hexa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-6-7-8-Hepta-CDF', '1,2,3,4,6,7,8-Hepta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-7-8-9-Hepta-CDF', '1,2,3,4,7,8,9-Hepta-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic1-2-3-4-6-7-8-9-Octa-CDF', '1,2,3,4,6,7,8,9-Octa-CDF (as concentration ng/kg)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticClbenzenes', 'Chlorobenzenes (total)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticTriClbenzenes', 'Trichlorobenzenes', 'Chlorobenzenes (total)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticPentaClbenzene', 'Pentachlorobenzene', 'as in E-PRTR, CAS-Nr.: 608-93-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticHCBD', 'Hexachlorobutadiene (HCBD)', 'as in E-PRTR, CAS-Nr.: 87-68-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticHBB', 'Hexabromobiphenyl (HBB)', 'as in E-PRTR, CAS-Nr.: 36355-1-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromaticBDPE', 'Brominated diphenylether (sum) / Pentabromodiphenylether', 'as in priority substances EU water policy, CAS-Nr.: ../32534-81-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic6-7BDPE', 'Hexabromodiphenyl ether and heptabromodiphenyl ether', 'as in POP convention', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAromatic4-5BDPE', 'Tetrabromodiphenyl ether and Pentabromodiphenyl ether', 'as in POP convention', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticAOX', 'halogenated organic compounds (as AOX)', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticC10-13', 'Chloro-alkanes C10-C13', 'as in priority substances EU water policy, CAS-Nr.: 85535-84-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticTCE', '{Trichloroethylene}', 'as in E-PRTR,CAS-Nr.:  79-01-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticPCE', '{Tetrachloroethylene (or Perchloroethylene)}', 'as in E-PRTR, CAS-Nr.: 127-18-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticDCM', 'Dichloromethane (DCM)', 'as in E-PRTR, CAS-Nr.: 75-09-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticTriCM', '{Trichloromethane (chloroform)}', 'as in E-PRTR, CAS-Nr.: 67-66-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticEDC', '1,2-dichlorethane (EDC)', 'as in E-PRTR, CAS-Nr.: 107-06-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticTCM', '{Tetrachloromethane (TCM)}', 'as in E-PRTR, CAS-Nr.: 56-23-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticVinylCl', 'Vinylchloride', 'as in E-PRTR, CAS-Nr.: 75-01-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/haloAliphaticPFOS-A', 'Perfluorooctane sulfonic (acid and salts) and Perfluorooctane sulfonyl fluoride', 'as in E-PRTR,', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsTotal', 'Phenols (as total C of phenols)', 'as in E-PRTR,  108-95-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsPCP', 'Pentachlorophenol (PCP)', 'as in E-PRTR, 87-86-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsClPTotal', 'Chlorophenols (total)', 'Chlorophenols (total)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsNonylP', 'Nonylphenols / (4-nonylphenol)', 'as in priority substances EU water policy, CAS-Nr.: 25154-52-3/(104-40-5)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/phenolsOctylP', '{Octylphenols and octylphenolethoxylates}', 'as in E-PRTR, CAS-Nr.: 1806-26-4/ 140-66-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAHsum', 'PAHs sum or report specific releases of', 'as in E-PRTR', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BaP', 'Benzo(a)pyrene', 'as in E-PRTR, CAS-Nr.: 50-32-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BbF', 'Benzo(b)fluoranthene', 'as in E-PRTR, CAS-Nr.: 205-99-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BkF', 'Benzo(k)fluoranthene', 'as in E-PRTR, CAS-Nr.: 207-08-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-IcP', 'Indeno(1,23-cd)pyrene', 'as in E-PRTR, CAS-Nr.: 193-39-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BgP', '{Benzo(g,h,i)perylene}', 'as in E-PRTR, CAS-Nr.: 191-24-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-ANT', 'Anthracene', 'as in E-PRTR, CAS-Nr.: 120-12-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-NAP', 'Naphtalene', 'as in E-PRTR, CAS-Nr.: 91-20-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-ACY', 'Acenaphthylene', 'CAS-Nr.: 208-96-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-ACE', 'Acenaphthene', 'CAS-Nr.: 83-32-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-FLE', 'Fluorene', 'CAS-Nr.: 86-73-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-PHE', 'Phenanthrene', 'CAS-Nr.: 85-01-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-FLA', 'Fluoranthene', 'CAS-Nr.: 206-44-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-PYE', 'Pyrene', 'CAS-Nr.: 129-00-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-BaA', 'Benzo(a)anthracene', 'CAS-Nr.: 56-55-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-CHE', 'Chrysene', 'CAS-Nr.: 218-01-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/PAH-DaA', 'Dibenzo(a,h)anthracene', 'CAS-Nr.: 53-70-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAldrin', 'Aldrin', 'as in E-PRTR, CAS-Nr.: 309-00-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDieldrin', 'Dieldrin', 'as in E-PRTR, CAS-Nr.: 60-57-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideEndrin', 'Endrin', 'as in E-PRTR, CAS-Nr.: 72-20-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideIsodrin', '{Isodrin}', 'as in E-PRTR, 465-73-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideOpDDT', 'op-DDT', 'CAS-Nr.: 789-02-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticidePpDDT', 'pp-DDT', 'CAS-Nr.: 50-29-3', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAlHCH', 'alpha-HCH', 'CAS-Nr.: 319-84-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideBeHCH', 'beta-HCH', 'CAS-Nr.: 319-85-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDeHCH', 'delta-HCH', 'CAS-Nr.: 319-86-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideGaHCH', 'gamma-HCH (Lindan)', 'as in E-PRTR, CAS-Nr.: 58-89-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAtrazin', 'Atrazine', 'as in E-PRTR, 1912-24-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlordane', 'Chlordane', 'as in E-PRTR, 57-74-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlordecone', 'Chlordecone', 'as in E-PRTR, CAS-Nr.:143-50-0', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlorfenvinphos', 'Chlorfenvinphos', 'as in E-PRTR, CAS-Nr.:470-90-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideChlorpyrifos', 'Chlorpyrifos', 'as in E-PRTR, CAS-Nr.:2921-88-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDiuron', 'Diuron', 'as in E-PRTR, CAS-Nr.:330-54-1', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideEndosulphan', 'Endosulphan', 'as in E-PRTR, CAS-Nr.:115-29-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideHeptachlor', 'Heptachlor', 'as in E-PRTR, CAS-Nr.:76-44-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideMirex', 'Mirex', 'as in E-PRTR, CAS-Nr.:2385-85-5', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideSimazine', 'Simazine', 'as in E-PRTR, CAS-Nr.:122-34-9', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideToxaphene', 'Toxaphene', 'as in E-PRTR, CAS-Nr.:8001-35-2', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideIsoproturon', 'Isoproturon', 'as in E-PRTR, CAS-Nr.:34123-59-6', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideDEHP', 'Di-(2-ethyl hexyl) phtalate (DEHP)', 'as in priority substances EU water policy, CAS-Nr.:117-81-7', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideTrifluralin', 'Trifluralin', 'as in E-PRTR, CAS-Nr.:1582-09-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideAlachlor', 'Alachlor', 'as in E-PRTR, CAS-Nr.:15972-60-8', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/pesticideCyclodiene', 'Cyclodiene pesticides', 'as in priority substances EU water policy', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/otherMTBE', 'Methyl tertiary-butyl ether (MTBE)', 'CAS-Nr.:1634-04-4', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/otherMineralOil', 'Mineral oil', 'Mineral oil', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue/otherPhtalatesTotal', 'Phtalates (total)', 'Phtalates (total)', 'SoilSiteParameterNameValue', 'soilsite', 'chemical', 'soilsitechemical', null);


-- SoilProfileParameterNameValue
-- PARAMETER soilprofile
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue

-- CHEMICAL
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/carbonStock', 'carbon stock', 'The total mass of carbon in soil for a given depth.', 'SoilProfileParameterNameValue', 'soilprofile', 'chemical', 'soilprofilechemical', null);
-- PHYSICAL
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/potentialRootDepth', 'potential root depth', 'Potential depth of the soil profile where roots develop (in cm).', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/availableWaterCapacity', 'available water capacity', 'Amount of water that a soil can store that is usable by plants, based on the potential root depth.', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue/waterDrainage', 'water drainage', 'Natural internal water drainage class of the soil profile.', 'SoilProfileParameterNameValue', 'soilprofile', 'physical', 'soilprofilephysical', null);


-- SoilDerivedObjectParameterNameValue
-- PARAMETER soilderivedobject
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue

-- CHEMICAL
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/carbonStock', 'carbon stock', 'The total mass of carbon in soil for a given depth.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/organicCarbonContent', 'organic carbon content', 'Portion of the soil measured as carbon in organic form, excluding living macro and mesofauna and living plant tissue.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/nitrogenContent', 'nitrogen content', 'Total nitrogen content in the soil, including both the organic and inorganic forms.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/pHValue', 'pH value', 'pH value of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/cadmiumContent', 'cadmium content', 'Cadmium content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/chromiumContent', 'chromium content', 'Chromium content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/copperContent', 'copper content', 'Copper content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/leadContent', 'lead content', 'Lead content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/mercuryContent', 'mercury content', 'Mercury content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/nickelContent', 'nickel content', 'Nickel content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/zincContent', 'zinc content', 'Zinc content of the soil derived object.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'chemical', 'soilderivedobjectchemical', null);
-- PHYSICAL
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/potentialRootDepth', 'potential root depth', 'Potential depth of the soil profile where roots develop (in cm).', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'physical', 'soilderivedobjectphysical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/availableWaterCapacity', 'available water capacity', 'Amount of water that a soil can store that is usable by plants, based on the potential root depth.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'physical', 'soilderivedobjectphysical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue/waterDrainage', 'water drainage', 'Natural water drainage class of the soil profile.', 'SoilDerivedObjectParameterNameValue', 'soilderivedobject', 'physical', 'soilderivedobjectphysical', null);


-- ProfileElementParameterNameValue
-- PARAMETER profileelement
-- CODELIST INSPIRE
-- http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue

-- CHEMICAL
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/organicCarbonContent', 'organic carbon content', 'Portion of the soil measured as carbon in organic forms, excluding living macro and mesofauna and living plant tissue.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/nitrogenContent', 'nitrogen content', 'total nitrogen content in the soil, including both the organic and inorganic forms.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/pHValue', 'pH value', 'pH value of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/cadmiumContent', 'cadmium content', 'Cadmium content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/chromiumContent', 'chromium content', 'Chromium content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/copperContent', 'copper content', 'Copper content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/leadContent', 'lead content', 'Lead content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/mercuryContent', 'mercury content', 'Mercury content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);
INSERT INTO "codelist" (id, label, definition, collection, foi, phenomenon, foi_phenomenon, parent) VALUES ('http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/nickelContent', 'nickel content', 'Nickel content of the profile element.', 'ProfileElementParameterNameValue', 'profileelement', 'chemical', 'profileelementchemical', null);


