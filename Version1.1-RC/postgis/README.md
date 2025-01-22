# Create a INSPIRE Soil PostGIS template using SQL

The file "create_PostGis.sql" contains SQL (DDL) code for defining a data model in PostgreSQL that mirrors the INSPIRE SO Geopackage structure. 
This script creates all necessary tables and populates the table with INSPIRE codelists.

The aim is to eventually provide users with a Server Side database that can simplify data exchange between the two systems. 

In this setup, the presence of Functions and Triggers, functionally corresponding to those in the Geopackage, ensures data integrity at the engine level.


## List of created functions.

**SOILSITE**
- "check_valid_period_soilsite" - checks that the validfrom date should always be previous than or equal to validto.
- "check_valid_versions_soilsite" - checks that beginlifespanversion should always be previous than or equal to endlifespanversion.
- "check_soil_investigation_purpose" - checks that only valid values from the CODELIST soilinvestigationpurposevalue are entered in the "soilinvestigationpurpose" field.
- "update_begin_today_soilsite" - checks that, upon updating the table, beginlifespanversion is updated to today.
- "update_begin_today_soilsite_error" - checks that, upon updating, endlifespanversion is after today.

**SOILPLOT**
- "check_valid_version_soilplot" - checks that the beginlifespanversion date is always less than or equal to endlifespanversion.
- "check_soilplot_type" - checks that only valid values from the CODELIST soilplottypevalue are entered in the "soilplottype" field.
- "update_begin_today_soilplot" - checks that, upon updating the table, beginlifespanversion is updated to today.
- "update_begin_today_soilplot_error" - checks that, upon updating, endlifespanversion is after today.

**SOILPROFILE**
- "check_valid_period_soilprofile" - checks that the validfrom date should always be previous than or equal to validto.
- "check_valid_version_soilprofile" - checks that the beginlifespanversion should always be previous than or equal to endlifespanversion.
- "check_profile_location" - checks that in the soilprofile table, in the case of a Derived profile, the foreign key for soilplot is NULL.
- "check_profile_location_observed" - checks that in the soilprofile table, in the case of an Observed profile, the foreign key for soilplot is NOT NULL.
- "check_wrb_reference_soil_group" - check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbreferencesoilgroup" field.
- "update_begin_today_soilprofile" - checks that, upon updating the table, beginlifespanversion is updated to today.
- "update_begin_today_soilprofile_error" - checks that, upon updating, endlifespanversion is after today.
- "validate_wrbversion_sp" - checks that only valid values from the CODELIST wrbversion are entered in the "wrbversion" field.

**OTHERSOILNAMETYPE**
- "check_soil_name" -Checks that only valid values from the CODELIST othersoilnametypevalue are entered in the "soilname" field.

**ISDERIVEDFROM**
- "check_isderived" - Checks if the value of isderived in soilprofile is equal to 1 because the value of the "base_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type "derived".
- "check_isobserved" - Checks if the value of isderived in soilprofile is equal to 0 because the value of the "related_id" field in the "isderivedfrom" table cannot be inserted because profile is not of type "observed"

**SOILBODY**
- "check_valid_version_soilbody" - Checks that the beginlifespanversion should always be previous than or equal to endlifespanversion.
- "update_begin_today_soilbody" - Checks that, upon updating the table, beginlifespanversion is updated to today.
- "update_begin_today_soilbody_error" - Checks that, upon updating, endlifespanversion is after today.

**DERIVEDPROFILEPRESENCEINSOLIBODY**
- “check_lowervaluesum” - Checks that the sum of "lowervalue" for a soilbody does not exceed 100%.
- "check_isderived_soilbody" - Checks that the soilprofile is of type Derived.

**ISBASEDONOBSERVEDSOILPROFILE**
- "check_isobserved_dobj" - Checks if the value of isderived in soilprofile is equal to 1.

**PROFILEELEMENT**

- "check_depth_range_function" -checks that at least one of profileelementdepthrange_uppervalue and profileelementdepthrange_lowervalue is not null.
- "check_horizon_fields" - If we have a HORIZON, the values of the fields "layertype," "layerrocktype," "layergenesisprocess," "layergenesisenviroment," and "layergenesisprocessstate" must be NULL.
- "check_valid_version_profileelement" - Checks that the beginlifespanversion should always be previous than or equal to endlifespanversion.
- "check_valid_deepprofileelement" - Checks that the value of profileelementdepthrange_uppervalue is always less than the value of profileelementdepthrange_lowervalue.
- "check_layertype" - Checks that only valid values from the CODELIST layertypevalue are entered in the "layertype" field.
- "check_layergenesisenviroment" - Checks that only valid values from the CODELIST eventenvironmentvalue are entered in the "layergenesisenviroment" field.
- "check_layergenesisprocess" - Checks that only valid values from the CODELIST eventprocessvalue are entered in the "layergenesisprocess" field.
- "check_layergenesisprocessstate" - Checks that only valid values from the CODELIST layergenesisprocessstatevalue are entered in the "layergenesisprocessstate" field.
- "check_layerrocktype" - Checks that only valid values from the CODELIST lithologyvalue are entered in the "layerrocktype" field.
- "u_begin_today_profileelement" - Checks that, upon updating the table, beginlifespanversion is updated to today.
- "u_begin_today_profileelement_error" - Checks that, upon updating, endlifespanversion is after today.
- "check_geogenic_fields_not_null" - checks that if in the “layertype” field the value is different from “geogenic” the values ​​in the “layerrocktype”, “layergenesisprocess”, “layergenesisenviroment” and “layergenesisprocessstate” fields are null.

**PARTICLESIZEFRACTIONTYPE**
- "check_fraction_sum" - checks that the sum of "fractioncontent" does not exceed 100. 
- "check_particlesize_overlap" - checks that the new range should not overlap or touch an existing range for the sameidprofileelement.

**FAOHORIZONNOTATIONTYPE**
- "check_faoprofileelementtype" - Checks that the profileelementtype is = 1, meaning that it is a HORIZON.
- "check_faohorizonmaster_1" Checks that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster_1" field.
- "check_faohorizonmaster_2" - Checks that only valid values from the CODELIST faohorizonmastervalue are entered in the "faohorizonmaster_2" field.
- "i_faohorizonsubordinate_1" - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_1" field.
- "i_faohorizonsubordinate_2" - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_2" field.
- "i_faohorizonsubordinate_3" - Checks that only valid values from the CODELIST faohorizonsubordinatevalue are entered in the "faohorizonsubordinate_3" field.
- "i_faoprime" - Checks that only valid values from the CODELIST faoprimevalue are entered in the "faoprime" field.

**OTHERHORIZONNOTATIONTYPE**
- "check_horizonnotation_insert" - Checks that only valid values from the CODELIST otherhorizonnotationtypevalue are entered in the "horizonnotation" field.
- "check_diagnostichorizon_insert" - Checks that only valid values from the CODELIST wrbdiagnostichorizon (in case OtherHorizonNotationTypeValue = "WRB") are entered in the "diagnostichorizon" field.

OTHERHORIZON_PROFILEELEMENT
-"check_otherhorizon_profileelement_profileelementtype"  Checks that in the profileelement table, the profileelementtype is = 0, meaning that it is an HORIZON.

**WRBQUALIFIERGROUPTYPE**
- "check_wrbqualifiergrouptype_wrbqualifier" - Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbqualifier" field.
- "check_qualifierplace_wrbqualifiergrouptype" - INSERT - Checks that only valid values from the CODELIST wrbqualifierplacevalue are entered in the "qualifierplace" field.
- "check_wrbspecifier_1_wrbqualifiergrouptype" - INSERT - Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbspecifier_1" field.
- "check_wrbspecifier_2_wrbqualifiergrouptype" - INSERT -Check that only valid values ​​from the CODELIST of the version selected in the wrbversion field are entered in the "wrbspecifier_2" field.
- "validate_wrbversion_gt" - INSERT - Checks that only valid values from the CODELIST wrbversion are entered in the "wrbversion" field.
- "check_unique_wrbqualifiergrouptype" - Check that there are no duplicate rows.
- "check_specifiers_not_equal" - Checks that wrbspecifier_1 and wrbspecifier_2 are not equal and that if wrbspecifier_2 is not NULL, wrbspecifier_1 must also not be NULL.

**WRBQUALIFIERGROUP_PROFILE**
- "check_wrbversion_match" - Check for each row that  soilprofile and wrbqualifiergrouptype have the same version as WRB.
- "check_qualifier_position_unique"  Check if an idwrbqualifiergrouptype and qualifierposition record already exists for the same soilprofile.

**DATASTREAM**
- "check_soilprofile_obspro" - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilprofile".
- "check_soilsite_obspro" - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilsite".
- "check_profileelement_obspro" - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "profileelement".
- "check_soilderivedobject_obspro" - Checks that in the "foi" field of the "observableproperty" defined by the inserted link, there is the value "soilderivedobject".

**OBSERVATION**
- "check_validperiod_observation" - Checks that the result time is earlier than the valid time.
- "control_result_value" - Checks that the value is within the Min and Max of the domain specified in the properties.
- "check_result_value_uri"  Checks that only one of the fields "result_value" and "result_uri" is populated.

**DATASTREAMCOLLECTION**
- "check_valid_phenomenon_time" - Checks that the "beginphenomenontime" field is earlier than the "endphenomenontime" field.
- "check_valid_result_time" - Checks that the "beginresulttime" field is earlier than the "endresulttime" field.

**OBSERVABLEPROPERTY**
- "check_foi" - Checks that only valid values from the FOIType are entered in the "foi" field, identifying which type of Feature Of Interest that particular ObservableProperty should be associated with.
- "check_phenomenon_type" - Checks that only valid values from the CODELIST "PhenomenonType" are entered in the "phenomenontype" field.
- "check_base_phenomenon" - Checks that only valid values from the CODELIST are entered in the "basephenomenon" field, with respect to the values entered in the "foi" and "phenomenontype" fields.
- "check_domain" - Checks that the "domain_max" field is always greater than the "domain_min" field.
- "check_domain_code" INSERT - Checks that in case the "domain_typeofvalue" field takes the value 'result_value', the value of the "domain_code" field is null.
- "check_domain_value" - Checks that in case the "domain_typeofvalue" field takes the value result_uri, the values of the "domain_min" and "domain_max" fields are null.

**RELATEDPARTY**
- "check_role" - Checks that only valid values from the CODELIST "ResponsiblePartyRole" are entered in the "role" field.

**PROCESSPARAMETER**
- "i_name" INSERT - Checks that only valid values from the CODELIST "ProcessParameterNameValue" are entered in the "name" field.


## Codelist Table.

Codelists in the SO (Soil) INSPIRE domain are essential for ensuring a standardized representation of soil data across the European Union. They enable consistent classification and encoding of specific values (e.g., soil types, usage categories) across different languages and applications, ensuring interoperability and semantic integrity in environmental datasets.
 
Although the codelist table has no relationships with other tables, it's presence is crucial for the correct data management and control. It includes replicates of all  SO domain valid codes extracted from the INSPIRE registry (https://inspire.ec.europa.eu/registry). Essentially, if a coded value is in the table, it is supposed to be valid; if not, the code is to be considered as incorrect, and the relative value isn’t stored.
 
The presence of the codelist table in the Geopackage allows forms for displaying dropdown lists, simplifying the data entry. However, up to now (01/2025), not every Geopackage mandatory codelists have been populated into the INSPIRE registry, in those cases, we referred a few lists thanks to other controlled vocabularies by means of URI.
 
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

