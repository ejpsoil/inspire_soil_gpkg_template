/*
███████  ██████  ██ ██      ██████   ██████  ██████  ██    ██     ███    ██ ███████ ██     ██     ██       █████  ██    ██ ███████ ██████  
██      ██    ██ ██ ██      ██   ██ ██    ██ ██   ██  ██  ██      ████   ██ ██      ██     ██     ██      ██   ██  ██  ██  ██      ██   ██ 
███████ ██    ██ ██ ██      ██████  ██    ██ ██   ██   ████       ██ ██  ██ █████   ██  █  ██     ██      ███████   ████   █████   ██████  
     ██ ██    ██ ██ ██      ██   ██ ██    ██ ██   ██    ██        ██  ██ ██ ██      ██ ███ ██     ██      ██   ██    ██    ██      ██   ██ 
███████  ██████  ██ ███████ ██████   ██████  ██████     ██        ██   ████ ███████  ███ ███      ███████ ██   ██    ██    ███████ ██   ██ 
*/                                                                                                                                       



-- Change the name of the feature
-- soilbody new feature -----------------------------------------------------------------------------------------------
CREATE TABLE soilbody_newname -- ** CHANGE NAME **
(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    geom MULTIPOLYGON NOT NULL, 
    idsoilbodylabel         TEXT NOT NULL,
     FOREIGN KEY (idsoilbodylabel)
      REFERENCES soilbody(guidkey)

);



-- Contents soilbody new feature---------------------------------------------------------------------------------------
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
  'soilbody_newname', -- -- ** CHANGE NAME **
  'features', -- data type
  'f_sbsi', -- ** CHANGE NAME ID**
  'soilbody_sicily Table', --  ** CHANGE NAME DESCRIPTION **
  strftime('%Y-%m-%dT%H:%M:%fZ','now'), -- last modification date and time
  NULL, 
  NULL,
  NULL,
  NULL,
  3035 -- EPSG spatial reference system code
);


-- spatial index
CREATE INDEX soiBody_geom_idxsi ON soilbody_newname(geom); -- ** CHANGE NAME INDEX ** AND ** CHANGE NAME AFTER ON **


-- Geometry soilbody new feature- ---------------------------------------------------------------------------------------
INSERT INTO gpkg_geometry_columns (
  table_name,
  column_name,
  geometry_type_name,
  srs_id,
  z,
  m
) VALUES (
  'soilbody_newname',  -- ** CHANGE NAME **
  'geom', -- name of geometry column
  'MULTIPOLYGON', -- type of geometyry
  3035, -- EPSG spatial reference system code
  0, -- if the geometry has a Z coordinate (0 = no, 1 = yes, 2 = optional)
  0 -- if the geometry has a M coordinate (0 = no, 1 = yes, 2 = optional)
);

