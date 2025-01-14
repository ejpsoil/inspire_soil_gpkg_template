<?xml version="1.0" ?>
<gml:FeatureCollection xmlns:ps="http://inspire.ec.europa.eu/schemas/ps/4.0"
  xmlns:gml="http://www.opengis.net/gml/3.2"
  xmlns:omop="http://inspire.ec.europa.eu/schemas/omop/3.0"
  xmlns:spec="http://www.opengis.net/samplingSpecimen/2.0"
  xmlns:sc="http://www.interactive-instruments.de/ShapeChange/AppInfo"
  xmlns:gmlcov="http://www.opengis.net/gmlcov/1.0"
  xmlns:ompr="http://inspire.ec.europa.eu/schemas/ompr/3.0"
  xmlns:so="http://inspire.ec.europa.eu/schemas/so/4.0"
  xmlns:ge="http://inspire.ec.europa.eu/schemas/ge-core/4.0"
  xmlns:om="http://www.opengis.net/om/2.0" xmlns:base="http://inspire.ec.europa.eu/schemas/base/3.3"
  xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:ns1="http://www.w3.org/1999/xhtml"
  xmlns:gss="http://www.isotc211.org/2005/gss" xmlns:gsr="http://www.isotc211.org/2005/gsr"
  xmlns:gts="http://www.isotc211.org/2005/gts"
  xmlns:ge_gp="http://inspire.ec.europa.eu/schemas/ge_gp/4.0"
  xmlns:swe="http://www.opengis.net/swe/2.0"
  xmlns:base2="http://inspire.ec.europa.eu/schemas/base2/2.0"
  xmlns:ad="http://inspire.ec.europa.eu/schemas/ad/4.0"
  xmlns:au="http://inspire.ec.europa.eu/schemas/au/4.0"
  xmlns:gn="http://inspire.ec.europa.eu/schemas/gn/4.0"
  xmlns:bu-base="http://inspire.ec.europa.eu/schemas/bu-base/4.0"
  xmlns:tn="http://inspire.ec.europa.eu/schemas/tn/4.0"
  xmlns:cp="http://inspire.ec.europa.eu/schemas/cp/4.0"
  xmlns:net="http://inspire.ec.europa.eu/schemas/net/4.0"
  xmlns:sams="http://www.opengis.net/samplingSpatial/2.0"
  xmlns:sam="http://www.opengis.net/sampling/2.0"
  xmlns:hfp="http://www.w3.org/2001/XMLSchema-hasFacetAndProperty"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://inspire.ec.europa.eu/schemas/so/4.0 https://inspire.ec.europa.eu/schemas/so/4.0/Soil.xsd http://www.opengis.net/gml/3.2 http://schemas.opengis.net/gml/3.2.1/gml.xsd http://www.opengis.net/om/2.0 http://schemas.opengis.net/om/2.0/observation.xsd http://inspire.ec.europa.eu/schemas/ompr/3.0 https://inspire.ec.europa.eu/schemas/ompr/3.0/Processes.xsd">
  <gml:featureMember>
    <om:OM_Observation gml:id="_C7CE1620-775B-4F4B-8B32-842A598779D6">
      <om:phenomenonTime>
        <gml:TimeInstant>
          <gml:timePosition>2010-01-29T10:34:11Z</gml:timePosition>
        </gml:TimeInstant>
      </om:phenomenonTime>
      <om:resultTime>
        <gml:TimeInstant>
          <gml:timePosition>2010-01-29T10:34:11Z</gml:timePosition>
        </gml:TimeInstant>
      </om:resultTime>
      <om:procedure xlink:href="#_A6CBC33C-872B-45BB-85BA-18B35FBF6813"/>
      <om:observedProperty
        xlink:href="http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/pHValue"
        xlink:title="pH Value - Count"/>
      <om:featureOfInterest xlink:href="#_005C9FC2-3A78-471C-96CB-D08C27B9BBFA"/>
      <om:result>&lt;gco:Measure uom="null"&gt;0.0&lt;/gco:Measure&gt;</om:result>
    </om:OM_Observation>
  </gml:featureMember>
  <gml:featureMember>
    <om:OM_Observation gml:id="_7F9E0054-C091-42FB-A7CB-D420729C8E40">
      <om:phenomenonTime>
        <gml:TimeInstant>
          <gml:timePosition>2010-01-29T10:34:11Z</gml:timePosition>
        </gml:TimeInstant>
      </om:phenomenonTime>
      <om:resultTime>
        <gml:TimeInstant>
          <gml:timePosition>2010-01-29T10:34:11Z</gml:timePosition>
        </gml:TimeInstant>
      </om:resultTime>
      <om:procedure xlink:href="#_9C6F5F47-352E-463B-9C4E-6320A154040A"/>
      <om:observedProperty
        xlink:href="http://inspire.ec.europa.eu/codelist/ProfileElementParameterNameValue/organicCarbonContent"
        xlink:title="Organic carbon content - Count"/>
      <om:featureOfInterest xlink:href="#_005C9FC2-3A78-471C-96CB-D08C27B9BBFA"/>
      <om:result>&lt;gco:Measure uom="null"&gt;0.0&lt;/gco:Measure&gt;</om:result>
    </om:OM_Observation>
  </gml:featureMember>
  <gml:featureMember>
    <ompr:Process gml:id="_A6CBC33C-872B-45BB-85BA-18B35FBF6813">
      <ompr:inspireId>
        <base:Identifier>
          <base:localId>CRSA_SO_ISO10390pH-H2O</base:localId>
          <base:namespace>https://infosuoli.crea.gov.it/</base:namespace>
          <base:versionId>1</base:versionId>
        </base:Identifier>
      </ompr:inspireId>
      <ompr:name>ISO 10390:2021 (pH-H2O)</ompr:name>
      <ompr:type>pH</ompr:type>
      <ompr:documentation>
        <base2:DocumentCitation>
          <base2:name>Soil, treated biowaste and sludge - Determination of pH</base2:name>
          <base2:shortName>ISO 10390:2021</base2:shortName>
          <base2:date>
            <gmd:CI_Date>
              <gmd:date>
                <gco:DateTime>2021-03-01T00:00:00Z</gco:DateTime>
              </gmd:date>
              <gmd:dateType>
                <gmd:CI_DateTypeCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication"/>
              </gmd:dateType>
            </gmd:CI_Date>
          </base2:date>
          <base2:link>https://www.iso.org/standard/75243.html</base2:link>
        </base2:DocumentCitation>
      </ompr:documentation>
      <ompr:documentation>
        <base2:DocumentCitation>
          <base2:name>Soil, treated biowaste and sludge - Determination of pH</base2:name>
          <base2:shortName>ISO 10390:2021</base2:shortName>
          <base2:date>
            <gmd:CI_Date>
              <gmd:date>
                <gco:DateTime>2021-03-01T00:00:00Z</gco:DateTime>
              </gmd:date>
              <gmd:dateType>
                <gmd:CI_DateTypeCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication"/>
              </gmd:dateType>
            </gmd:CI_Date>
          </base2:date>
          <base2:link>https://www.iso.org/standard/75243.html</base2:link>
        </base2:DocumentCitation>
      </ompr:documentation>
      <ompr:documentation>
        <base2:DocumentCitation>
          <base2:name>Soil, treated biowaste and sludge - Determination of pH</base2:name>
          <base2:shortName>ISO 10390:2021</base2:shortName>
          <base2:date>
            <gmd:CI_Date>
              <gmd:date>
                <gco:DateTime>2021-03-01T00:00:00Z</gco:DateTime>
              </gmd:date>
              <gmd:dateType>
                <gmd:CI_DateTypeCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication"/>
              </gmd:dateType>
            </gmd:CI_Date>
          </base2:date>
          <base2:link>https://www.iso.org/standard/75243.html</base2:link>
        </base2:DocumentCitation>
      </ompr:documentation>
      <ompr:responsibleParty>
        <base2:RelatedParty>
          <base2:individualName>
            <gco:CharacterString>ISO/TC 190/SC 3</gco:CharacterString>
          </base2:individualName>
          <base2:organisationName>
            <gco:CharacterString>International Organization for Standardization</gco:CharacterString>
          </base2:organisationName>
          <base2:role
            xlink:href="http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/author"/>
        </base2:RelatedParty>
      </ompr:responsibleParty>
      <ompr:responsibleParty>
        <base2:RelatedParty>
          <base2:individualName>
            <gco:CharacterString>ISO/TC 190/SC 3</gco:CharacterString>
          </base2:individualName>
          <base2:organisationName>
            <gco:CharacterString>International Organization for Standardization</gco:CharacterString>
          </base2:organisationName>
          <base2:role
            xlink:href="http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/author"/>
        </base2:RelatedParty>
      </ompr:responsibleParty>
      <ompr:responsibleParty>
        <base2:RelatedParty>
          <base2:individualName>
            <gco:CharacterString>ISO/TC 190/SC 3</gco:CharacterString>
          </base2:individualName>
          <base2:organisationName>
            <gco:CharacterString>International Organization for Standardization</gco:CharacterString>
          </base2:organisationName>
          <base2:role
            xlink:href="http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/author"/>
        </base2:RelatedParty>
      </ompr:responsibleParty>
    </ompr:Process>
  </gml:featureMember>

  <gml:featureMember>
    <so:SoilHorizon gml:id="_005C9FC2-3A78-471C-96CB-D08C27B9BBFA">
      <so:particleSizeFraction xsi:nil="true"/>
      <so:profileElementDepthRange>
        <so:RangeType>
          <so:upperValue>20.0</so:upperValue>
          <so:lowerValue>90.0</so:lowerValue>
          <so:uom uom="cm"/>
        </so:RangeType>
      </so:profileElementDepthRange>
      <so:beginLifespanVersion>2010-01-29T10:34:11Z</so:beginLifespanVersion>
      <so:profileElementObservation xlink:href="#_C7CE1620-775B-4F4B-8B32-842A598779D6"/>
      <so:profileElementObservation xlink:href="#_7F9E0054-C091-42FB-A7CB-D420729C8E40"/>
      <so:isPartOf xlink:href="#_E7AF72BE-8954-4847-8BCD-FDDF463D5C55"/>
      <so:FAOHorizonNotation>
        <so:FAOHorizonNotationType>
          <so:FAOHorizonMaster
            xlink:href="http://inspire.ec.europa.eu/codelist/FAOHorizonMasterValue/A"/>
          <so:FAOPrime xlink:href="https://inspire.ec.europa.eu/codelist/FAOPrimeValue/0"/>
          <so:isOriginalClassification>true</so:isOriginalClassification>
        </so:FAOHorizonNotationType>
      </so:FAOHorizonNotation>
    </so:SoilHorizon>
  </gml:featureMember>

  <gml:featureMember>
    <so:DerivedSoilProfile gml:id="_E7AF72BE-8954-4847-8BCD-FDDF463D5C55">
      <so:inspireId>
        <base:Identifier>
          <base:localId>CRSA_SO_62.2PHca15</base:localId>
          <base:namespace>https://infosuoli.crea.gov.it/</base:namespace>
          <base:versionId>1</base:versionId>
        </base:Identifier>
      </so:inspireId>
      <so:localIdentifier>CASALINO</so:localIdentifier>
      <so:WRBSoilName>
        <so:WRBSoilNameType>
          <so:WRBReferenceSoilGroup
            xlink:href="http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue/phaeozem"/>
          <so:isOriginalClassification>true</so:isOriginalClassification>
        </so:WRBSoilNameType>
      </so:WRBSoilName>
      <so:validFrom>2010-01-29T10:34:11Z</so:validFrom>
      <so:beginLifespanVersion>2010-01-29T10:34:11Z</so:beginLifespanVersion>
      <so:isDescribedBy xsi:nil="true"/>
    </so:DerivedSoilProfile>
  </gml:featureMember>



  <gml:featureMember>
    <so:SoilPlot gml:id="_E0569EE2-F1A1-48F0-A1ED-972CE610F907">
      <so:inspireId>
        <base:Identifier>
          <base:localId>CRSA_SO_aSICQ9840_P</base:localId>
          <base:namespace>https://infosuoli.crea.gov.it/</base:namespace>
          <base:versionId>1</base:versionId>
        </base:Identifier>
      </so:inspireId>
      <so:soilPlotLocation>
        <gml:Point srsName="http://www.opengis.net/def/crs/EPSG/0/3035" srsDimension="2">
          <gml:pos>1660431.2296183843 4738258.816842883</gml:pos>
        </gml:Point>
      </so:soilPlotLocation>
      <so:soilPlotType xlink:href="http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue/trialPit"/>
      <so:beginLifespanVersion>1994-09-25T00:00:00Z</so:beginLifespanVersion>
      <so:observedProfile xsi:nil="true"/>
      <so:locatedOn xlink:href="#_1566499F-9490-4D5F-BED3-42DBEE725C36"/>
    </so:SoilPlot>
  </gml:featureMember>
  <gml:featureMember>
    <so:SoilSite gml:id="_1566499F-9490-4D5F-BED3-42DBEE725C36">
      <so:inspireId>
        <base:Identifier>
          <base:localId>CRSA_SO_CRS3035RES100mN1660400E4738200</base:localId>
          <base:namespace>https://infosuoli.crea.gov.it/</base:namespace>
          <base:versionId>1</base:versionId>
        </base:Identifier>
      </so:inspireId>
      <so:geometry>
        <gml:Polygon srsName="http://www.opengis.net/def/crs/EPSG/0/3035" srsDimension="2">
          <gml:exterior>
            <gml:LinearRing>
              <gml:posList>1660399.9999999995 4738200.0 1660399.9999999995 4738300.0
                1660499.9999999995 4738300.0 1660499.9999999995 4738200.0 1660399.9999999995
                4738200.0</gml:posList>
            </gml:LinearRing>
          </gml:exterior>
        </gml:Polygon>
      </so:geometry>
      <so:soilInvestigationPurpose
        xlink:href="http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue/specificSoilSurvey"/>
      <so:validFrom>1994-09-25T00:00:00Z</so:validFrom>
      <so:beginLifespanVersion>1994-09-25T00:00:00Z</so:beginLifespanVersion>
      <so:isObservedOnLocation xlink:href="#_E0569EE2-F1A1-48F0-A1ED-972CE610F907"/>
    </so:SoilSite>
  </gml:featureMember>


</gml:FeatureCollection>
