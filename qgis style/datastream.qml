<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="datastreamcollection_datastream_5" referencedLayer="datastreamcollection_7bccaafa_f387_43d9_885f_19598aaefa7a" layerName="datastreamcollection" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=datastreamcollection" providerKey="ogr" name="datastreamcollection_datastream_5" layerId="datastreamcollection_7bccaafa_f387_43d9_885f_19598aaefa7a" strength="Association">
      <fieldRef referencingField="iddatastreamcollection" referencedField="guidkey"/>
    </relation>
    <relation id="observableproperty_datastream_3" referencedLayer="observableproperty_a6419fbf_f550_4859_9141_c9218696ff8e" layerName="observableproperty" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=observableproperty" providerKey="ogr" name="observableproperty_datastream_3" layerId="observableproperty_a6419fbf_f550_4859_9141_c9218696ff8e" strength="Association">
      <fieldRef referencingField="idobservedproperty" referencedField="guidkey"/>
    </relation>
    <relation id="observableproperty_process_datastream" referencedLayer="observableproperty_process_d4865a19_5d10_45c6_9d4b_789112629ef7" layerName="observableproperty_process" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=observableproperty_process" providerKey="ogr" name="observableproperty_process_datastream" layerId="observableproperty_process_d4865a19_5d10_45c6_9d4b_789112629ef7" strength="Association">
      <fieldRef referencingField="idprocess" referencedField="idprocess"/>
      <fieldRef referencingField="idobservedproperty" referencedField="idobservedproperty"/>
    </relation>
    <relation id="process_datastream_4" referencedLayer="process_8af8852e_58f2_4e0f_b76d_477e53a3eda7" layerName="process" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=process" providerKey="ogr" name="process_datastream_4" layerId="process_8af8852e_58f2_4e0f_b76d_477e53a3eda7" strength="Association">
      <fieldRef referencingField="idprocess" referencedField="guidkey"/>
    </relation>
    <relation id="profileelement_datastream_6" referencedLayer="profileelement_4b65c6a5_d999_46e8_a876_602e1fa2c534" layerName="profileelement" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=profileelement" providerKey="ogr" name="profileelement_datastream_6" layerId="profileelement_4b65c6a5_d999_46e8_a876_602e1fa2c534" strength="Association">
      <fieldRef referencingField="idprofileelement" referencedField="guidkey"/>
    </relation>
    <relation id="sensor_datastream_2" referencedLayer="sensor_725bd0c7_8bcf_46f0_b4c0_21a14f6bf222" layerName="sensor" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=sensor" providerKey="ogr" name="sensor_datastream_2" layerId="sensor_725bd0c7_8bcf_46f0_b4c0_21a14f6bf222" strength="Association">
      <fieldRef referencingField="idsensor" referencedField="guidkey"/>
    </relation>
    <relation id="soilderivedobject_datastream_7" referencedLayer="soilderivedobject_edb4479b_d7d9_4e88_9e5d_5099ce8a64d2" layerName="soilderivedobject" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=soilderivedobject" providerKey="ogr" name="soilderivedobject_datastream_7" layerId="soilderivedobject_edb4479b_d7d9_4e88_9e5d_5099ce8a64d2" strength="Association">
      <fieldRef referencingField="idsoilderivedobject" referencedField="guidkey"/>
    </relation>
    <relation id="soilprofile_datastream_8" referencedLayer="soilprofile_65d5b960_c9f8_4437_a02e_255afe5ec840" layerName="soilprofile" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=soilprofile" providerKey="ogr" name="soilprofile_datastream_8" layerId="soilprofile_65d5b960_c9f8_4437_a02e_255afe5ec840" strength="Association">
      <fieldRef referencingField="idsoilprofile" referencedField="guidkey"/>
    </relation>
    <relation id="soilsite_datastream_9" referencedLayer="soilsite_84472509_40ed_4107_a1e5_08e495974a1d" layerName="soilsite" referencingLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" dataSource="./INSPIRE_SO_12.gpkg|layername=soilsite" providerKey="ogr" name="soilsite_datastream_9" layerId="soilsite_84472509_40ed_4107_a1e5_08e495974a1d" strength="Association">
      <fieldRef referencingField="idsoilsite" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="guidkey" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idsoilsite" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_05 - O&amp;M/INSPIRE_SO_12.gpkg|layername=soilsite" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilsite_84472509_40ed_4107_a1e5_08e495974a1d" name="ReferencedLayerId"/>
            <Option type="QString" value="soilsite" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilsite_datastream_9" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idsoilprofile" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_05 - O&amp;M/INSPIRE_SO_12.gpkg|layername=soilprofile" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilprofile_65d5b960_c9f8_4437_a02e_255afe5ec840" name="ReferencedLayerId"/>
            <Option type="QString" value="soilprofile" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilprofile_datastream_8" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idsoilderivedobject" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" name="ReferencedLayerId"/>
            <Option type="QString" value="soilderivedobject" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilderivedobject_datastream_7" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idprofileelement" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=profileelement" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" name="ReferencedLayerId"/>
            <Option type="QString" value="profileelement" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="profileelement_datastream_6" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="iddatastreamcollection" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=datastreamcollection" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="datastreamcollection_05997361_72ea_40c3_ac61_ca85ad8ea1c8" name="ReferencedLayerId"/>
            <Option type="QString" value="datastreamcollection" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="datastreamcollection_datastream_5" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idprocess" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=process" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" name="ReferencedLayerId"/>
            <Option type="QString" value="process" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="process_datastream_4" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idobservedproperty" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=observableproperty" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" name="ReferencedLayerId"/>
            <Option type="QString" value="observableproperty" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="observableproperty_datastream_3" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idsensor" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=sensor" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="sensor_fb521675_7fbc_4e4a_ad7d_543510fee531" name="ReferencedLayerId"/>
            <Option type="QString" value="sensor" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="sensor_datastream_2" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="idsoilsite" index="2" name="Soil Site"/>
    <alias field="idsoilprofile" index="3" name="Soil Profile"/>
    <alias field="idsoilderivedobject" index="4" name="Soil Derived Object"/>
    <alias field="idprofileelement" index="5" name="Profile Element"/>
    <alias field="iddatastreamcollection" index="6" name="Datastream Collection"/>
    <alias field="idprocess" index="7" name="Process"/>
    <alias field="idobservedproperty" index="8" name="Property"/>
    <alias field="idsensor" index="9" name="Sensor"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="idsoilsite" policy="DefaultValue"/>
    <policy field="idsoilprofile" policy="DefaultValue"/>
    <policy field="idsoilderivedobject" policy="DefaultValue"/>
    <policy field="idprofileelement" policy="DefaultValue"/>
    <policy field="iddatastreamcollection" policy="DefaultValue"/>
    <policy field="idprocess" policy="DefaultValue"/>
    <policy field="idobservedproperty" policy="DefaultValue"/>
    <policy field="idsensor" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="guidkey" applyOnUpdate="0" expression=""/>
    <default field="idsoilsite" applyOnUpdate="0" expression=""/>
    <default field="idsoilprofile" applyOnUpdate="0" expression=""/>
    <default field="idsoilderivedobject" applyOnUpdate="0" expression=""/>
    <default field="idprofileelement" applyOnUpdate="0" expression=""/>
    <default field="iddatastreamcollection" applyOnUpdate="0" expression=""/>
    <default field="idprocess" applyOnUpdate="0" expression=""/>
    <default field="idobservedproperty" applyOnUpdate="0" expression=""/>
    <default field="idsensor" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" notnull_strength="1" constraints="3" exp_strength="0" unique_strength="1"/>
    <constraint field="guidkey" notnull_strength="0" constraints="2" exp_strength="0" unique_strength="1"/>
    <constraint field="idsoilsite" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="idsoilprofile" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="idsoilderivedobject" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="idprofileelement" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="iddatastreamcollection" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="idprocess" notnull_strength="1" constraints="1" exp_strength="0" unique_strength="0"/>
    <constraint field="idobservedproperty" notnull_strength="1" constraints="1" exp_strength="0" unique_strength="0"/>
    <constraint field="idsensor" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="idsoilsite" exp="" desc=""/>
    <constraint field="idsoilprofile" exp="" desc=""/>
    <constraint field="idsoilderivedobject" exp="" desc=""/>
    <constraint field="idprofileelement" exp="" desc=""/>
    <constraint field="iddatastreamcollection" exp="" desc=""/>
    <constraint field="idprocess" exp="" desc=""/>
    <constraint field="idobservedproperty" exp="" desc=""/>
    <constraint field="idsensor" exp="" desc=""/>
  </constraintExpressions>
  <expressionfields/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGIS forms can have a Python function that is called when the form is
opened.

Use this function to add extra logic to your forms.

Enter the name of the function in the "Python Init function"
field.
An example follows:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
    geom = feature.geometry()
    control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>tablayout</editorlayout>
  <attributeEditorForm>
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="0" showLabel="1" name="id">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" type="GroupBox" collapsedExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" collapsedExpression="" showLabel="1" columnCount="1" name="Feature Of Interest" visibilityExpressionEnabled="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="2" showLabel="1" name="idsoilsite">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="3" showLabel="1" name="idsoilprofile">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="5" showLabel="1" name="idprofileelement">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="4" showLabel="1" name="idsoilderivedobject">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="8" showLabel="1" name="idobservedproperty">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont bold="1" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="7" showLabel="1" name="idprocess">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont bold="1" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="6" showLabel="1" name="iddatastreamcollection">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="9" showLabel="1" name="idsensor">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorRelation horizontalStretch="0" label="Observation" verticalStretch="0" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" nmRelationId="" showLabel="1" relation="datastream_observation" name="datastream_observation">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
      <editor_configuration type="Map">
        <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
        <Option type="QString" value="AllButtons" name="buttons"/>
        <Option type="bool" value="true" name="show_first_feature"/>
      </editor_configuration>
    </attributeEditorRelation>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="iddatastreamcollection"/>
    <field editable="1" name="idobservedproperty"/>
    <field editable="1" name="idprocess"/>
    <field editable="1" name="idprofileelement"/>
    <field editable="1" name="idsensor"/>
    <field editable="1" name="idsoilderivedobject"/>
    <field editable="1" name="idsoilprofile"/>
    <field editable="1" name="idsoilsite"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="iddatastreamcollection"/>
    <field labelOnTop="0" name="idobservedproperty"/>
    <field labelOnTop="0" name="idprocess"/>
    <field labelOnTop="0" name="idprofileelement"/>
    <field labelOnTop="0" name="idsensor"/>
    <field labelOnTop="0" name="idsoilderivedobject"/>
    <field labelOnTop="0" name="idsoilprofile"/>
    <field labelOnTop="0" name="idsoilsite"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="iddatastreamcollection"/>
    <field reuseLastValue="0" name="idobservedproperty"/>
    <field reuseLastValue="0" name="idprocess"/>
    <field reuseLastValue="0" name="idprofileelement"/>
    <field reuseLastValue="0" name="idsensor"/>
    <field reuseLastValue="0" name="idsoilderivedobject"/>
    <field reuseLastValue="0" name="idsoilprofile"/>
    <field reuseLastValue="0" name="idsoilsite"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="datastream_observation">
      <config type="Map">
        <Option type="bool" value="false" name="force-suppress-popup"/>
        <Option type="QString" value="" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>&#xd;
&#xd;
IF( "idprofileelement" is not null, &#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'profileelement',&#xd;
		'guidkey',&#xd;
		"idprofileelement"&#xd;
	) &#xd;
	,'inspireid_localid'&#xd;
	))	&#xd;
&#xd;
||' - ','')&#xd;
&#xd;
&#xd;
&#xd;
||&#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'observableproperty',&#xd;
		'guidkey',&#xd;
		"idobservedproperty"&#xd;
	) &#xd;
	,'name'&#xd;
	))		&#xd;
	&#xd;
|| ' - ' ||&#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'process',&#xd;
		'guidkey',&#xd;
		"idprocess"&#xd;
	) &#xd;
	,'name'&#xd;
	))</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
