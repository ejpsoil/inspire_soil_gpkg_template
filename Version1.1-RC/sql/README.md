The `sql` folder contains the informatic code which is behind the INSPIRE Soil Geopackage.  
Using the SQL code in the `create.sql` file, you can recreate the Geopackage containing the full INSPIRE Soil structure.

## Recreating the Geopackage Containing the INSPIRE Soil Structure

To do this:  
1. Open the empty GeoPackage model available at [http://www.geopackage.org/data/empty.gpkg](http://www.geopackage.org/data/empty.gpkg) using a database manager (e.g., DBeaver).  
2. Execute the SQL instructions from the `create.sql` file in the query window.  

- The `create.sql` file includes:  
    - **Data Definition Language (DDL):** Instructions to create tables and their relationships.  
    - **Data Manipulation Language (DML):** Instructions to populate the `codelist` table with the necessary codelists required for its functionality.  

- Some constraints have been managed through both form management and trigger creation, in order to:
    - assist user data entry.  
    - ensures data integrity in case of massive data entry.

---

## Create More Than One Geometric Layer Linked to the SoilBody Table  

It is possible to create more than one geometric layer linked to the SoilBody table, to do this use the code provided in `SoilBody_newgeom.sql`.

Some names in the code need to be changed for it to work correctly, as described below.

1. SoilBody geometry table 

    - CREATE TABLE soilbody_newname  ** CHANGE NAME **

2. gpkg_contents INSERT

    - 'soilbody_newname',   ** CHANGE NAME ** the name should be as entered in point 1
    - 'f_sbsi',  ** CHANGE NAME ID**
    - 'soilbody_newname Table',   ** CHANGE NAME DESCRIPTION  OPTIONAL** the name should be as entered in point 1

3. Spatial index
    - CREATE INDEX soiBody_geom_idxsi ON soilbody_newname(geom);  ** CHANGE NAME INDEX ** AND ** CHANGE NAME AFTER ON ** the name should be as entered in point 1

4. gpkg_geometry_columns INSERT 
    - 'soilbody_newname',  ** CHANGE NAME ** the name should be as entered in point 1

---

## Trigger  

A **Trigger** is procedural code that is automatically executed in response to certain events, for maintaining the integrity of the information in the database. 

Below is the list of triggers implemented for the INSPIRE SO data model, along with a brief description of their functionalities.  


**SOILSITE**
- "soilsiteguid" - INSERT - manages the creation of the GUID in INSERT
- "soilsiteguidupdate" - UPDATE - prevents the modification of the GUID in UPDATE
- "i_ceckvalidperiodsoilsite" - INSERT - checks that the validfrom date should always be previous than or equal to validto
- "u_ceckvalidperiodsoilsite" - UPDATE - checks that the validfrom date should always be previous than or equal to validto
- "i_ceckvalidversionsoilsite" - INSERT - checks that beginlifespanversion should always be previous than or equal to endlifespanversion
- "i_soilinvestigationpurpose" - INSERT - checks that only valid values from the CODELIST soilinvestigationpurposevalue are entered in the "soilinvestigationpurpose" field
- "u_soilinvestigationpurpose" - UPDATE - checks that only valid values from the CODELIST soilinvestigationpurposevalue are entered in the "soilinvestigationpurpose" field
- "u_begin_today_soilsite" - UPDATE - checks that, upon updating the table, beginlifespanversion is updated to today
- "u_begin_today_soilsite_error" - UPDATE - checks that, upon updating, Endlifespanversion is after today

**SOILPLOT**
- "soilplotguid" - INSERT - manages the creation of the GUID in INSERT
- "soilplotguidupdate" - UPDATE - prevents the modification of the GUID in UPDATE
- "i_ceckvalidversionsoilplot" - INSERT - checks that the beginlifespanversion should always be previous than or equal to endlifespanversion
- "i_soilplottype" - INSERT - checks that only valid values from the CODELIST soilplottypevalue are entered in the "soilplottype" field
- "u_soilplottype" - UPDATE - checks that only valid values from the CODELIST soilplottypevalue are entered in the "soilplottype" field
- "u_begin_today_soilplot" - UPDATE - checks that, upon updating the table, beginlifespanversion is updated to today
- "u_begin_today_soilplot_error" - UPDATE - checks that, upon updating, Endlifespanversion is after today

**SOILPROFILE**
- "soilprofileguid" - INSERT - manages the creation of the GUID in INSERT
- "soilprofileguidupdate" - UPDATE - prevents the modification of the GUID in UPDATE
- "i_ceckvalidperiodsoilprofile" - INSERT - checks that the validfrom date should always be previous than or equal to validto.
- "u_ceckvalidperiodsoilprofile" - UPDATE - checks that the validfrom date should always be previous than or equal to validto.
- "i_ceckvalidversionsoilprofile" - INSERT - checks that the beginlifespanversion should always be previous than or equal to endlifespanversion
- "i_ceckprofileLocation" - INSERT - checks that in the soilprofile table, in the case of a Derived profile, the foreign key for soilplot is NULL
- "u_ceckprofileLocation" - UPDATE - checks that in the soilprofile table, in the case of a Derived profile, the foreign key for soilplot is NULL
- "i_ceckprofileLocationobserved" - INSERT - checks that in the soilprofile table, in the case of an Observed profile, the foreign key for soilplot is NOT NULL
- "u_ceckprofileLocationobserved" - UPDATE - checks that in the soilprofile table, in the case of an Observed profile, the foreign key for soilplot is NOT NULL
- "i_wrbreferencesoilgroup" - INSERT - check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbreferencesoilgroup" field
- "u_wrbreferencesoilgroup" - UPDATE - check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbreferencesoilgroup" field
- "u_begin_today_soilprofile" - UPDATE - checks that, upon updating the table, beginlifespanversion is updated to today
- "u_begin_today_soilprofile_error" - UPDATE - checks that, upon updating, Endlifespanversion is after today
- "i_wrbproversion" - INSERT - checks that only valid values from the CODELIST wrbversion are entered in the "wrbversion" field
- "u_wrbproversion" - UPDATE - checks that only valid values from the CODELIST wrbversion are entered in the "wrbversion" field

**OTHERSOILNAMETYPE**
- "i_soilname" - INSERT - Checks that only valid values from the CODELIST othersoilnametypevalue are entered in the "soilname" field
- "u_soilname" - UPDATE - Checks that only valid values from the CODELIST othersoilnametypevalue are entered in the "soilname" field

**ISDERIVEDFROM**
- "i_checkisderived" - INSERT - Checks if the value of isderived in soilprofile is equal to 1 because the value of the "base_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type "derived".
- "u_checkisderived" - UPDATE - Checks if the value of isderived in soilprofile is equal to 1 because the value of the "base_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type "derived".
- "i_checkisobserved" - INSERT - Checks if the value of isderived in soilprofile is equal to 0 because the value of the "related_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type "observed"
- "u_checkisobserved" - UPDATE - Checks if the value of isderived in soilprofile is equal to 0 because the value of the "related_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type "observed"

**SOILBODY**
- "soilbodyguid" - INSERT - Manages the creation of the GUID in INSERT
- "soilbodyguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_ceckvalidversionsoilbody" - INSERT - Checks that the beginlifespanversion should always be previous than or equal to endlifespanversion
- "u_begin_today_soilbody" - UPDATE - Checks that, upon updating the table, beginlifespanversion is updated to today
- "u_begin_today_soilbody_error" - UPDATE - Checks that, upon updating, Endlifespanversion is after today

**DERIVEDPROFILEPRESENCEINSOLIBODY**
- “i_cecklowervaluesum” - INSERT - Checks that the sum of "lowervalue" for a soilbody does not exceed 100%
- “u_cecklowervaluesum” - UPDATE - Checks that the sum of "lowervalue" for a soilbody does not exceed 100%
- "i_checkisderived_soilbody" - INSERT - Checks that the soilprofile is of type Derived
- "u_checkisderived_soilbody" - UPDATE - Checks that the soilprofile is of type Derived

**SOILDERIVEDOBJECT**
- "soilderivedobjectguid" - INSERT - Manages the creation of the GUID in INSERT
- "soilderivedobjectguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE

**ISBASEDONOBSERVEDSOILPROFILE**
- "i_checkisobserved_dobj" - INSERT - Checks if the value of isderived in soilprofile is equal to 1
- "u_checkisobserved_dobj" - UPDATE - Checks if the value of isderived in soilprofile is equal to 1

**PROFILEELEMENT**
- "profileelementguid" - INSERT - Manages the creation of the GUID in INSERT
- "profileelementguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_ceckvalidversionprofileelement" - INSERT - Checks that the beginlifespanversion should always be previous than or equal to endlifespanversion
- "i_ceckvaliddeepprofileelement" - INSERT - Checks that the value of profileelementdepthrange_uppervalue is always less than the value of profileelementdepthrange_lowervalue
- "u_ceckvaliddeepprofileelement" - UPDATE - Checks that the value of profileelementdepthrange_uppervalue is always less than the value of profileelementdepthrange_lowervalue
- "i_checkgeogenicfieldsnull" - INSERT - checks that if in the “layertype” field the value is different from “geogenic” the values ​​in the “layerrocktype”, “layergenesisprocess”, “layergenesisenviroment” and “layergenesisprocessstate” fields are null
- "u_checkgeogenicfieldsnull" - INUPDATE - checks that if in the “layertype” field the value is different from “geogenic” the values ​​in the “layerrocktype”, “layergenesisprocess”, “layergenesisenviroment” and “layergenesisprocessstate” fields are null
- "i_ceckhorizonfields" - INSERT - If we have a HORIZON, the values of the fields "layertype," "layerrocktype," "layergenesisprocess," "layergenesisenviroment," and "layergenesisprocessstate" must be NULL
- "u_ceckhorizonfields" - UPDATE - If we have a HORIZON, the values of the fields "layertype," "layerrocktype," "layergenesisprocess," "layergenesisenviroment," and "layergenesisprocessstate" must be NULL
- "i_layertype" - INSERT - Checks that only valid values from the CODELIST layertypevalue are entered in the "layertype" field
- "u_layertype" - UPDATE - Checks that only valid values from the CODELIST layertypevalue are entered in the "layertype" field
- "i_layergenesisenviroment" - INSERT - Checks that only valid values from the CODELIST eventenvironmentvalue are entered in the "layergenesisenviroment" field
- "u_layergenesisenviroment" - UPDATE - Checks that only valid values from the CODELIST eventenvironmentvalue are entered in the "layergenesisenviroment" field
- "i_layergenesisprocess" - INSERT - Checks that only valid values from the CODELIST eventprocessvalue are entered in the "layergenesisprocess" field
- "u_layergenesisprocess" - UPDATE - Checks that only valid values from the CODELIST eventprocessvalue are entered in the "layergenesisprocess" field
- "i_layergenesisprocessstate" - INSERT - Checks that only valid values from the CODELIST layergenesisprocessstatevalue are entered in the "layergenesisprocessstate" field
- "u_layergenesisprocessstate" - UPDATE - Checks that only valid values from the CODELIST layergenesisprocessstatevalue are entered in the "layergenesisprocessstate" field
- "i_layerrocktype" - INSERT - Checks that only valid values from the CODELIST lithologyvalue are entered in the "layerrocktype" field
- "u_layerrocktype" - UPDATE - Checks that only valid values from the CODELIST lithologyvalue are entered in the "layerrocktype" field
- "i_check_depth_range" - INSERT - checks that at least one of profileelementdepthrange_uppervalue and profileelementdepthrange_lowervalue is not null.
- "u_check_depth_range" - UPDATE - checks that at least one of profileelementdepthrange_uppervalue and profileelementdepthrange_lowervalue is not null.
- "u_begin_today_profileelement" - UPDATE - Checks that, upon updating the table, beginlifespanversion is updated to today
- "u_begin_today_profileelement_error" - UPDATE - Checks that, upon updating, Endlifespanversion is after today

**PARTICLESIZEFRACTIONTYPE**
- "i_check_fraction_sum" - INSERT - checks that the sum of "fractioncontent" does not exceed 100. 
- "u_check_fraction_sum" - UPDATE - checks that the sum of "fractioncontent" does not exceed 100.
- "i_check_particlesize_overlap"  - INSERT - checks that the new range should not overlap or touch an existing range for the sameidprofileelement.
- "u_check_particlesize_overlap"  - UPDATE - checks that the new range should not overlap or touch an existing range for the sameidprofileelement.

**FAOHORIZONNOTATIONTYPE**
- "i_ceckfaoprofileelementtype" - INSERT - Checks that the profileelementtype is = 1, meaning that it is a HORIZON
- "u_ceckfaoprofileelementtype" - UPDATE - Checks that the profileelementtype is = 1, meaning that it is a HORIZON
- "i_faohorizonmaster_1" - INSERT - Checks that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster_1" field
- "u_faohorizonmaster_1" - UPDATE - Checks that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster_1" field
- "i_faohorizonmaster_2" - INSERT - Checks that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster_2" field
- "u_faohorizonmaster_2" - UPDATE - Checks that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster_2" field
- "i_faohorizonsubordinate_1" - INSERT - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_1" field
- "u_faohorizonsubordinate_1" - UPDATE - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_1" field
- "i_faohorizonsubordinate_2" - INSERT - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_2" field
- "u_faohorizonsubordinate_2" - UPDATE - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_2" field
- "i_faohorizonsubordinate_3" - INSERT - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_3" field
- "u_faohorizonsubordinate_3" - UPDATE - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_3" field
- "i_faoprime" - INSERT - Checks that only valid values from the CODELIST faoprimevalue are entered in the "faoprime" field
- "u_faoprime" - UPDATE - Checks that only valid values from the CODELIST faoprimevalue are entered in the "faoprime" field

**OTHERHORIZONNOTATIONTYPE**
- "otherhorizonnotationtypeguid" - INSERT - Manages the creation of the GUID in INSERT
- "otherhorizonnotationtypeguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_otherhorizonnotationtype" - INSERT - Checks that only valid values from the CODELIST otherhorizonnotationtypevalue are entered in the "horizonnotation" field
- "u_otherhorizonnotationtype" - UPDATE - Checks that only valid values from the CODELIST otherhorizonnotationtypevalue are entered in the "horizonnotation" field
- "i_diagnostichorizon" - INSERT - Checks that only valid values from the CODELIST wrbdiagnostichorizon (in case OtherHorizonNotationTypeValue = "WRB") are entered in the "diagnostichorizon" field
- "u_diagnostichorizon" - UPDATE - Checks that only valid values from the CODELIST wrbdiagnostichorizon (in case OtherHorizonNotationTypeValue = "WRB") are entered in the "diagnostichorizon" field

**OTHERHORIZON_PROFILEELEMENT**
- "i_ceckothprofileelementtype" - INSERT - Checks that in the profileelement table, the profileelementtype is = 0, meaning that it is an HORIZON
- "u_ceckothprofileelementtype" - UPDATE - Checks that in the profileelement table, the profileelementtype is = 0, meaning that it is an HORIZON

**WRBQUALIFIERGROUPTYPE**
- "wrbqualifiergrouptypeguid" - INSERT - Manages the creation of the GUID in INSERT
- "wrbqualifiergrouptypeguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_wrbqualifier" - INSERT - Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbqualifier" field
- "u_wrbqualifier" - UPDATE - Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbqualifier" field
- "i_qualifierplace" - INSERT - Checks that only valid values from the CODELIST wrbqualifierplacevalue are entered in the "qualifierplace" field
- "u_qualifierplace" - UPDATE - Checks that only valid values from the CODELIST wrbqualifierplacevalue are entered in the "qualifierplace" field
- "i_wrbspecifier_1" - INSERT - Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbspecifier_1" field
- "u_wrbspecifier_1" - UPDATE - Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbspecifier_1" field
- "i_wrbspecifier_2" - INSERT -Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbspecifier_2" field
- "u_wrbspecifier_2" - UPDATE - Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbspecifier_2" field
- "i_wrbqualversion" - INSERT - Checks that only valid values from the CODELIST wrbversion are entered in the "wrbversion" field
- "u_wrbqualversion" - UPDATE - Checks that only valid values from the CODELIST wrbversion are entered in the "wrbversion" field
- "i_unique_wrbqualifiergrouptype" - INSERT - Check that there are no duplicate rows
- "u_unique_wrbqualifiergrouptype" - UPDATE - Check that there are no duplicate rows
- "i_check_specifiers_not_equal" - INSERT - Checks that wrbspecifier_1 and wrbspecifier_2 are not equal and that if wrbspecifier_2 is not NULL, wrbspecifier_1 must also not be NULL
- "u_check_specifiers_not_equal" - UPDATE - checks that wrbspecifier_1 and wrbspecifier_2 are not equal and that if wrbspecifier_2 is not NULL, wrbspecifier_1 must also not be NULL

**WRBQUALIFIERGROUP_PROFILE**
- "i_check_wrbversion_match" - INSERT - Check for each row that  soilprofile and wrbqualifiergrouptype have the same version as WRB
- "u_check_wrbversion_match" - UPDATE - Check for each row that  soilprofile and wrbqualifiergrouptype have the same version as WRB
- "i_check_qualifier_position_unique" - INSERT - Check if an idwrbqualifiergrouptype and qualifierposition record already exists for the same soilprofile
- "u_check_qualifier_position_unique" - UPDATE - Check if an idwrbqualifiergrouptype and qualifierposition record already exists for the same soilprofile

**DATASTREAM**
- "datastreamguid" - INSERT - Manages the creation of the GUID in INSERT
- "datastreamguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_soilprofile_obspro" INSERT - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilprofile."
- "u_soilprofile_obspro" UPDATE - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilprofile."
- "i_soilsite_obspro" INSERT - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilsite."
- "u_soilsite_obspro" UPDATE - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilsite."
- "i_profileelement_obspro" INSERT - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "profileelement."
- "u_profileelement_obspro" UPDATE – Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "profileelement."
- "i_soilderivedobject_obspro" INSERT - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilderivedobject."
- "u_soilderivedobject_obspro" UPDATE - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilderivedobject."

**OBSERVATION**
- "observationguid" - INSERT - Manages the creation of the GUID in INSERT
- "observationguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_ceckvalidperiodobservation" INSERT - Checks that the result time is earlier than the valid time
- "u_ceckvalidperiodobservation" UPDATE - Checks that the result time is earlier than the valid time
- "i_controlresultvalue" INSERT - Checks that the value is within the Min and Max of the domain specified in the properties.
- "u_controlresultvalue" UPDATE - Checks that the value is within the Min and Max of the domain specified in the properties.
- "i_check_result_value_uri" INSERT – Checks that only one of the fields "result_value" and "result_uri" is populated.
- "u_check_result_value_uri" UPDATE - Checks that only one of the fields "result_value" and "result_uri" is populated.

**DATASTREAMCOLLECTION**
- "datastreamcollectionguid" - INSERT - Manages the creation of the GUID in INSERT
- "datastreamcollectionguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_ceckvalidphetimedatastreamcollection" INSERT - Checks that the "beginphenomenontime" field is earlier than the "endphenomenontime" field
- "u_ceckvalidphetimedatastreamcollection" UPDATE - Checks that the "beginphenomenontime" field is earlier than the "endphenomenontime" field
- "i_ceckvalidrestimedatastreamcollectionINSERT" - Checks that the "beginresulttime" field is earlier than the "endresulttime" field
- "u_ceckvalidrestimedatastreamcollectionUPDATE" - Checks that the "beginresulttime" field is earlier than the "endresulttime" field

**UNITOFMEASURE**
- "uomguid" - INSERT - Manages the creation of the GUID in INSERT
- "uomguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE

**OBSERVABLEPROPERTY**
- "observablepropertyguid" - INSERT - Manages the creation of the GUID in INSERT
- "observablepropertyguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_foi" INSERT - Checks that only valid values from the FOIType are entered in the "foi" field, identifying which type of Feature Of Interest that particular ObservableProperty should be associated with.
- "u_foi" UPDATE - Checks that only valid values from the FOIType are entered in the "foi" field, identifying which type of Feature Of Interest that particular ObservableProperty should be associated with.
- "i_phenomenonType" INSERT - Checks that only valid values from the CODELIST "PhenomenonType" are entered in the "phenomenontype" field.
- "u_phenomenonType" UPDATE - Checks that only valid values from the CODELIST "PhenomenonType" are entered in the "phenomenontype" field.
- "i_basephenomenon" INSERT - Checks that only valid values from the CODELIST are entered in the "basephenomenon" field, with respect to the values entered in the "foi" and "phenomenontype" fields.
-"u_basephenomenon" UPDATE - Checks that only valid values from the CODELIST are entered in the "basephenomenon" field, with respect to the values entered in the "foi" and "phenomenontype" fields.
- "i_ceckdomain" INSERT - Checks that the "domain_max" field is always greater than the "domain_min" field.
- "u_ceckdomain" UPDATE - Checks that the "domain_max" field is always greater than the "domain_min" field.
- "i_ceckdomain_code" INSERT - Checks that in case the "domain_typeofvalue" field takes the value 'result_value', the value of the "domain_code" field is null.
- "u_ceckdomain_code" UPDATE - Checks that in case the "domain_typeofvalue" field takes the value 'result_value', the value of the "domain_code" field is null.
- "i_ceckdomain_value" INSERT - Checks that in case the "domain_typeofvalue" field takes the value result_uri, the values of the "domain_min" and "domain_max" fields are null.
- "u_ceckdomain_value" UPDATE - Checks that in case the "domain_typeofvalue" field takes the value result_uri, the values of the "domain_min" and "domain_max" fields are null.

**SENSOR**
- "sensorguid" - INSERT - Manages the creation of the GUID in INSERT
- "sensorguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE

**THING**
- "thingguid" - INSERT - Manages the creation of the GUID in INSERT
- "thingguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE

**PROCESS**
- "processguid" - INSERT - Manages the creation of the GUID in INSERT
- "processguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE

**DOCUMENTCITATION**
- "documentcitationguid" - INSERT - Manages the creation of the GUID in INSERT
- "documentcitationguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE

**PROCESSPARAMETER**
- "i_name" INSERT - Checks that only valid values from the CODELIST "ProcessParameterNameValue" are entered in the "name" field.
- "u_name" UPDATE - Checks that only valid values from the CODELIST "ProcessParameterNameValue" are entered in the "name" field.

**RELATEDPARTY**
- "relatedpartyguid" - INSERT - Manages the creation of the GUID in INSERT
- "relatedpartyguidupdate" - UPDATE - Prevents the modification of the GUID in UPDATE
- "i_role" INSERT - Checks that only valid values from the CODELIST "ResponsiblePartyRole" are entered in the "role" field.
- "u_role" UPDATE - Checks that only valid values from the CODELIST "ResponsiblePartyRole" are entered in the "role" field.

---

## Codelist Table.

Codelists in the SO (Soil) INSPIRE domain are essential for ensuring a standardized representation of soil data across the European Union. They enable consistent classification and encoding of specific values (e.g., soil types, usage categories) across different languages and applications, ensuring interoperability and semantic integrity in environmental datasets.

Although the codelist table has no relationship with other tables, its presence is crucial for the correct data management and control. Although the codelist table has no relationship with other tables, its presence is crucial for the correct data management and control.. It includes replicates of all  SO domain valid codes extracted from the INSPIRE registry (https://inspire.ec.europa.eu/registry). Essentially, if a coded value is in the table, it is supposed to be valid; if not, the code is to be considered as incorrect, and the relative value isn’t stored.
 
The presence of the codelist table in the Geopackage allows forms for displaying dropdown lists, simplifying the data entry. However, up to now (01/2025), not all the mandatory items foreseen in the INSPIRE SOIL UML structure have been populated into the INSPIRE registry. For those mandatory items foreseen in the INSPIRE SOIL UML structure for which there is not yet a published codelis inside the INSPIRE registry, that is, for WRBdiagnostichorizon, ProcessParameterNameValue, WRBReferenceSoilGroupValue (2014), WRBReferenceSoilGroupValue (2022), WRBQualifierValue (2022), and WRBSpecifierValue (2022)), we made reference to other officially mainatined controlled vocabularies by means of URI.
 
Moreover, internal codelists have also been added to the overmentioned table to manage forms more efficiently.
INSPIRE registry
 

Below is a list of Features with their respective codelists:



### FEATURE soilsite

SoilInvestigationPurposeValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue


### FEATURE soilplot

SoilPlotTypeValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue


### FEATURE  soilprofile

WRBReferenceSoilGroupValue (2006)
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue

WRBReferenceSoilGroupValue (2014)
CODELIST AGROPORTAL
https://agroportal.lirmm.fr/ontologies/AGROVOC/

WRBReferenceSoilGroupValue (2022)
CODELIST ORBL-SOIL
https://obrl-soil.github.io/wrbsoil2022/


### FEATURE othersoilnametype

OtherSoilNameTypeValue
CODELIST ***INSPIRE***
https://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue 


### FEATURE profileelement

LayerTypeValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/LayerTypeValue

LithologyValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/LithologyValue

EventProcessValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/EventProcessValue

EventEnvironmentValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/EventEnvironmentValue

LayerGenesisProcessStateValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue


### FEATURE faohorizonnotationtype

FAOHorizonMaster
CODELIST ***INSPIRE***
https://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue

FAOHorizonSubordinate
CODELIST ***INSPIRE***
https://inspire.ec.europa.eu/codelist/FAOHorizonSubordinateValue

FAOPrime
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/FAOPrimeValue


### FEATURE otherhorizonnotationtype

WRBdiagnostichorizon
CODELIST ORBL
https://obrl-soil.github.io/wrbsoil2022/chapter-03.html#sec-diagh


### FEATURE wrbqualifiergrouptype

WRBQualifierPlaceValue
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue

WRBQualifierValue (2006)
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/WRBQualifierValue

WRBQualifierValue (2022)
CODELIST ORBL-SOIL
https://obrl-soil.github.io/wrbsoil2022/

WRBSpecifiers (2006)
CODELIST ***INSPIRE*** 
http://inspire.ec.europa.eu/codelist/WRBSpecifierValue (Under review)

WRBSpecifierValue (2022)
CODELIST ORBL-SOIL
https://obrl-soil.github.io/wrbsoil2022/


### FEATURE processparameter

ProcessParameterNameValue
CODELIST AGROPRTAL - LOD 
https://agroportal.lirmm.fr/ - https://lod.nal.usda.gov/


### FEATURE relatedparty

ResponsiblePartyRole
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole


## PARAMETER

SoilSiteParameterNameValue
**PARAMETER soilsite**
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/SoilSiteParameterNameValue

SoilProfileParameterNameValue
**PARAMETER soilprofile**
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/SoilProfileParameterNameValue

SoilDerivedObjectParameterNameValue
**PARAMETER soilderivedobject**
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/SoilDerivedObjectParameterNameValue

ProfileElementParameterNameValue
**PARAMETER profileelement**
CODELIST ***INSPIRE***
http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue


