A set of sql statements to update a plain geopackage template to a INSPIRE Soil template


Open the empty GeoPackage template, which you can find at http://www.geopackage.org/data/empty.gpkg, in for example, [sqlitebrowser](https://sqlitebrowser.org/)  and execute the SQL statements from the create.sql file in the query window.

The code creates all the necessary tables (only Vector part), inserts the correct references into the Geopackage tables, and populates the table with INSPIRE codelist integrated by a series of codelists defined by CREA.

Some constraints have been managed through both form management and trigger creation. On one hand, we aim to assist user data entry, while on the other hand, the presence of triggers at the engine level ensures data integrity in case of massive data entry.


# Create more than one geometric layer linked to the SoilBody table

It is possible to create more than one geometric layer linked to the SoilBody table, to do this use the code provided in SoilBody_newgeom.sql.

Some names in the code need to be changed for it to work correctly, as described below.

1 - SoilBody geometry table 

CREATE TABLE soilbody_newname  ** CHANGE NAME **

2 - gpkg_contents INSERT

'soilbody_newname',   ** CHANGE NAME ** the name should be as entered in point 1
'f_sbsi',  ** CHANGE NAME ID**
'soilbody_newname Table',   ** CHANGE NAME DESCRIPTION  OPTIONAL** the name should be as entered in point 1

3 - Spatial index
CREATE INDEX soiBody_geom_idxsi ON soilbody_newname(geom);  ** CHANGE NAME INDEX ** AND ** CHANGE NAME AFTER ON ** the name should be as entered in point 1

4 - gpkg_geometry_columns INSERT 'soilbody_newname',  ** CHANGE NAME ** the name should be as entered in point 1


# List of created triggers.

SOILSITE
- "soilsiteguid" - INSERT - manages the creation of the GUID during INSERT
- "soilsiteguidupdate" - UPDATE - prevents the modification of the GUID during UPDATE
- "i_ceckvalidperiodsoilsite" - INSERT - checks that the validfrom date is always less than or equal to validto
- "u_ceckvalidperiodsoilsite" - UPDATE - checks that the validfrom date is always less than or equal to validto
- "i_ceckvalidversionsoilsite" - INSERT - checks that beginlifespanversion is always less than or equal to endlifespanversion
- "i_soilinvestigationpurpose" - INSERT - ensures that only valid CODELIST soilinvestigationpurposevalue values are entered in the "soilinvestigationpurpose" field
- "u_soilinvestigationpurpose" - UPDATE - ensures that only valid CODELIST soilinvestigationpurposevalue values are entered in the "soilinvestigationpurpose" field
- "u_begin_today_soilsite" - UPDATE - ensures that the beginlifespanversion is updated to today during the table update
- "u_begin_today_soilsite_error" - UPDATE - ensures that endlifespanversion is greater than today during the update

SOILPLOT
- "soilplotguid" - INSERT - manages the creation of the GUID during INSERT
- "soilplotguidupdate" - UPDATE - prevents the modification of the GUID during UPDATE
- "i_ceckvalidversionsoilplot" - INSERT - checks that the beginlifespanversion date is always less than or equal to endlifespanversion
- "i_soilplottype" - INSERT - ensures that only valid CODELIST soilplottypevalue values are entered in the "soilplottype" field
- "u_soilplottype" - UPDATE - ensures that only valid CODELIST soilplottypevalue values are entered in the "soilplottype" field
- "u_begin_today_soilplot" - UPDATE - ensures that the beginlifespanversion is updated to today during the table update
- "u_begin_today_soilplot_error" - UPDATE - ensures that endlifespanversion is greater than today during the update

SOILPROFILE
- "soilprofileguid" - INSERT - manages the creation of the GUID during INSERT
- "soilprofileguidupdate" - UPDATE - prevents the modification of the GUID during UPDATE
- "i_ceckvalidperiodsoilprofile" - INSERT - checks that the validfrom date is always less than or equal to validto
- "u_ceckvalidperiodsoilprofile" - UPDATE - checks that the validfrom date is always less than or equal to validto
- "i_ceckvalidversionsoilprofile" - INSERT - checks that beginlifespanversion date is always less than or equal to endlifespanversion
- "i_ceckprofileLocation" - INSERT - checks that in the soilprofile table, in the case of a Derived profile, the foreign key for soilplot is NULL
- "u_ceckprofileLocation" - UPDATE - checks that in the soilprofile table, in the case of a Derived profile, the foreign key for soilplot is NULL
- "i_ceckprofileLocationobserved" - INSERT - checks that in the soilprofile table, in the case of an Observed profile, the foreign key for soilplot is NOT NULL
- "u_ceckprofileLocationobserved" - UPDATE - checks that in the soilprofile table, in the case of an Observed profile, the foreign key for soilplot is NOT NULL
- "i_wrbreferencesoilgroup" - INSERT - ensures that only valid CODELIST wrbreferencesoilgroupvalue values are entered in the "wrbreferencesoilgroup" field
- "u_wrbreferencesoilgroup" - UPDATE - ensures that only valid CODELIST wrbreferencesoilgroupvalue values are entered in the "wrbreferencesoilgroup" field
- "u_begin_today_soilprofile" - UPDATE - ensures that beginlifespanversion is updated to today during the table update
- "u_begin_today_soilprofile_error" - UPDATE - ensures that endlifespanversion is greater than today during the update

OTHERSOILNAMETYPE
- "i_soilname" - INSERT - Ensures that only valid values from the CODELIST othersoilnametypevalue are entered in the "soilname" field.
- "u_soilname" - UPDATE - Ensures that only valid values from the CODELIST othersoilnametypevalue are entered in the "soilname" field.

ISDERIVEDFROM
- "i_checkisderived" - INSERT - Checks if the value of isderived in the soilprofile is equal to 1 because a soil profile of type "derived" cannot be generated from other profiles of type "derived."
- "u_checkisderived" - UPDATE - Checks if the value of isderived in the soilprofile is equal to 1 because a soil profile of type "derived" cannot be generated from other profiles of type "derived."
- "i_checkisobserved" - INSERT - Checks if the value of isderived in the soilprofile is equal to 0 because a soil profile of type "derived" cannot be generated from other profiles of type "derived."
- "u_checkisobserved" - UPDATE - Checks if the value of isderived in the soilprofile is equal to 0 because a soil profile of type "derived" cannot be generated from other profiles of type "derived."

SOILBODY
- "soilbodyguid" - INSERT - Manages the creation of the GUID during INSERT.
- "soilbodyguidupdate" - UPDATE - Prevents the modification of the GUID during UPDATE.
- "i_ceckvalidversionsoilbody" - INSERT - Checks that the beginlifespanversion date is always less than or equal to endlifespanversion.
- "u_begin_today_soilbody" - UPDATE - Ensures that the beginlifespanversion is updated to today during the table update.
- "u_begin_today_soilbody_error" - UPDATE - Ensures that endlifespanversion is greater than today during the update.

DERIVEDPROFILEPRESENCEINSOLIBODY
- "i_cecklowervaluesum" - INSERT - Checks that the sum of "lowervalue" for a soilbody does not exceed 100%.
- "u_cecklowervaluesum" - UPDATE - Checks that the sum of "lowervalue" for a soilbody does not exceed 100%.
- "i_checkisderived_soilbody" - INSERT - Checks that the soilprofile is of type Derived.
- "u_checkisderived_soilbody" - UPDATE - Checks that the soilprofile is of type Derived.

SOILDERIVEDOBJECT
- "soilderivedobjectguid" - INSERT - Manages the creation of the GUID during INSERT.
- "soilderivedobjectguidupdate" - UPDATE - Prevents the modification of the GUID during UPDATE.

ISBASEDONOBSERVEDSOILPROFILE
- "i_checkisobserved_dobj" - INSERT - Checks if the value of isderived in soilprofile is equal to 1.
- "u_checkisobserved_dobj" - UPDATE - Checks if the value of isderived in soilprofile is equal to 1.

PROFILEELEMENT
- "profileelementguid" - INSERT - Manages the creation of the GUID during INSERT.
- "profileelementguidupdate" - UPDATE - Prevents the modification of the GUID during UPDATE.
UML Model Constraint: If LayerTypeValue = Geogenic, the following fields cannot be NULL – layerrocktype/layergenesisprocess/layergenesisenviroment/layergenesisprocessstate**
- "i_checkgeogenicfieldsnotnull" – INSERT – If LayerTypeValue = Geogenic...
- "u_checkgeogenicfieldsnotnull" – UPDATE – If LayerTypeValue = Geogenic...
- "i_ceckhorizonfields" – INSERT - If we have a HORIZON, the values of the fields "layertype", "layerrocktype", "layergenesisprocess", "layergenesisenviroment", and "layergenesisprocessstate" must be NULL.
- "u_ceckhorizonfields" – UPDATE - If we have a HORIZON, the values of the fields "layertype", "layerrocktype", "layergenesisprocess", "layergenesisenviroment", and "layergenesisprocessstate" must be NULL.
- "i_checkvalidversionprofileelement" - INSERT - Checks that the beginlifespanversion date is always less than or equal to endlifespanversion.
- "i_checkvaliddeepprofileelement" - INSERT - Checks that the value of profileelementdepthrange_uppervalue is always less than the value of profileelementdepthrange_lowervalue.
- "u_checkvaliddeepprofileelement" - UPDATE - Checks that the value of profileelementdepthrange_uppervalue is always less than the value of profileelementdepthrange_lowervalue.
- "i_layertype" - INSERT - Ensures that only valid values from the CODELIST layertypevalue are entered in the "layertype" field.
- "u_layertype" - UPDATE - Ensures that only valid values from the CODELIST layertypevalue are entered in the "layertype" field.
- "i_layergenesisenviroment" - INSERT - Ensures that only valid values from the CODELIST eventenvironmentvalue are entered in the "layergenesisenviroment" field.
- "u_layergenesisenviroment" - UPDATE - Ensures that only valid values from the CODELIST eventenvironmentvalue are entered in the "layergenesisenviroment" field.
- "i_layergenesisprocess" - INSERT - Ensures that only valid values from the CODELIST eventprocessvalue are entered in the "layergenesisprocess" field.
- "u_layergenesisprocess" - UPDATE - Ensures that only valid values from the CODELIST eventprocessvalue are entered in the "layergenesisprocess" field.
- "i_layergenesisprocessstate" - INSERT - Ensures that only valid values from the CODELIST layergenesisprocessstatevalue are entered in the "layergenesisprocessstate" field.
- "u_layergenesisprocessstate" - UPDATE - Ensures that only valid values from the CODELIST layergenesisprocessstatevalue are entered in the "layergenesisprocessstate" field.
- "i_layerrocktype" - INSERT - Ensures that only valid values from the CODELIST lithologyvalue are entered in the "layerrocktype" field.
- "u_layerrocktype" - UPDATE - Ensures that only valid values from the CODELIST lithologyvalue are entered in the "layerrocktype" field.
- "u_begin_today_profileelement" - UPDATE - Ensures that beginlifespanversion is updated to today during the table update.
- "u_begin_today_profileelement_error" - UPDATE - Ensures that endlifespanversion is greater than today during the update.

FAOHORIZONNOTATIONTYPE
- "i_ceckfaoprofileelementtype" - INSERT - Checks that the profileelementtype is equal to 1, indicating the presence of a HORIZON.
- "u_ceckfaoprofileelementtype" - UPDATE - Checks that the profileelementtype is equal to 1, indicating the presence of a HORIZON.
- "i_faohorizonmaster" - INSERT - Ensures that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster" field.
- "u_faohorizonmaster" - UPDATE - Ensures that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster" field.
- "i_faohorizonsubordinate" - INSERT - Ensures that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate" field.
- "u_faohorizonsubordinate" - UPDATE - Ensures that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate" field.
- "i_faoprime" - INSERT - Ensures that only valid values from the CODELIST faoprimevalue are entered in the "faoprime" field.
- "u_faoprime" - UPDATE - Ensures that only valid values from the CODELIST faoprimevalue are entered in the "faoprime" field.

OTHERHORIZONNOTATIONTYPE
- "i_ceckothprofileelementtype" - INSERT - Checks that in the profileelement table, the profileelementtype is equal to 0, indicating the presence of a HORIZON.
- "u_ceckothprofileelementtype" - UPDATE - Checks that in the profileelement table, the profileelementtype is equal to 0, indicating the presence of a HORIZON.
- "i_otherhorizonnotationtype" - INSERT - Ensures that only valid values from the CODELIST otherhorizonnotationtypevalue are entered in the "horizonnotation" field.
- "u_otherhorizonnotationtype" - UPDATE - Ensures that only valid values from the CODELIST otherhorizonnotationtypevalue are entered in the "horizonnotation" field.
- "i_diagnostichorizon" - INSERT - Ensures that only valid values from the CODELIST wrbdiagnostichorizon are entered in the "diagnostichorizon" field (in case OtherHorizonNotationTypeValue = "WRB").
- "u_diagnostichorizon" - UPDATE - Ensures that only valid values from the CODELIST wrbdiagnostichorizon are entered in the "diagnostichorizon" field (in case OtherHorizonNotationTypeValue = "WRB").

WRBQUALIFIERGROUPTYPE
- "i_wrbqualifier" - INSERT - Ensures that only valid values from the CODELIST wrbqualifiervalue are entered in the "wrbqualifier" field.
- "u_wrbqualifier" - UPDATE - Ensures that only valid values from the CODELIST wrbqualifiervalue are entered in the "wrbqualifier" field.
- "i_qualifierplace" - INSERT - Ensures that only valid values from the CODELIST wrbqualifierplacevalue are entered in the "qualifierplace" field.
- "u_qualifierplace" - UPDATE - Ensures that only valid values from the CODELIST wrbqualifierplacevalue are entered in the "qualifierplace" field.
- "i_wrbspecifier_1" - INSERT - Ensures that only valid values from the CODELIST wrbspecifiervalue are entered in the "wrbspecifier_1" field.
- "u_wrbspecifier_1" - UPDATE - Ensures that only valid values from the CODELIST wrbspecifiervalue are entered in the "wrbspecifier_1" field.
- "i_wrbspecifier_2" - INSERT - Ensures that only valid values from the CODELIST wrbspecifiervalue are entered in the "wrbspecifier_2" field.
- "u_wrbspecifier_2" - UPDATE - Ensures that only valid values from the CODELIST wrbspecifiervalue are entered in the "wrbspecifier_2" field.