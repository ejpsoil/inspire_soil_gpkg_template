<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="datastreamcollection_66a8e55e_91f7_44dc_b064_d371aca3302d" layerId="datastreamcollection_66a8e55e_91f7_44dc_b064_d371aca3302d" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="datastreamcollection" strength="Association" name="datastreamcollection_datastream_5" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=datastreamcollection" id="datastreamcollection_datastream_5">
      <fieldRef referencedField="guidkey" referencingField="iddatastreamcollection"/>
    </relation>
    <relation referencedLayer="observableproperty_54541782_41af_4d65_9367_01527efa7b4d" layerId="observableproperty_54541782_41af_4d65_9367_01527efa7b4d" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="observableproperty" strength="Association" name="observableproperty_datastream_3" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=observableproperty" id="observableproperty_datastream_3">
      <fieldRef referencedField="guidkey" referencingField="idobservedproperty"/>
    </relation>
    <relation referencedLayer="observableproperty_process_3ba623a4_cb8f_4168_960e_a3378b4ab90e" layerId="observableproperty_process_3ba623a4_cb8f_4168_960e_a3378b4ab90e" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="observableproperty_process" strength="Association" name="observableproperty_process_datastream" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=observableproperty_process" id="observableproperty_process_datastream">
      <fieldRef referencedField="idprocess" referencingField="idprocess"/>
      <fieldRef referencedField="idobservedproperty" referencingField="idobservedproperty"/>
    </relation>
    <relation referencedLayer="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" layerId="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="process" strength="Association" name="process_datastream_4" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=process" id="process_datastream_4">
      <fieldRef referencedField="guidkey" referencingField="idprocess"/>
    </relation>
    <relation referencedLayer="profileelement_918dfbb9_c077_4a30_95ac_4ecf73ee27d1" layerId="profileelement_918dfbb9_c077_4a30_95ac_4ecf73ee27d1" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="profileelement" strength="Association" name="profileelement_datastream_6" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=profileelement" id="profileelement_datastream_6">
      <fieldRef referencedField="guidkey" referencingField="idprofileelement"/>
    </relation>
    <relation referencedLayer="sensor_b58c0e37_7115_4f1b_a4a0_2ab86fb7579c" layerId="sensor_b58c0e37_7115_4f1b_a4a0_2ab86fb7579c" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="sensor" strength="Association" name="sensor_datastream_2" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=sensor" id="sensor_datastream_2">
      <fieldRef referencedField="guidkey" referencingField="idsensor"/>
    </relation>
    <relation referencedLayer="soilderivedobject_714705ec_5e61_41a4_916d_a469c9208809" layerId="soilderivedobject_714705ec_5e61_41a4_916d_a469c9208809" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="soilderivedobject" strength="Association" name="soilderivedobject_datastream_7" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilderivedobject" id="soilderivedobject_datastream_7">
      <fieldRef referencedField="guidkey" referencingField="idsoilderivedobject"/>
    </relation>
    <relation referencedLayer="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" layerId="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="soilprofile" strength="Association" name="soilprofile_datastream_8" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilprofile" id="soilprofile_datastream_8">
      <fieldRef referencedField="guidkey" referencingField="idsoilprofile"/>
    </relation>
    <relation referencedLayer="soilsite_e76d731e_35c8_47af_9414_d0972a59cd4c" layerId="soilsite_e76d731e_35c8_47af_9414_d0972a59cd4c" referencingLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" providerKey="ogr" layerName="soilsite" strength="Association" name="soilsite_datastream_9" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilsite" id="soilsite_datastream_9">
      <fieldRef referencedField="guidkey" referencingField="idsoilsite"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="guidkey">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilsite">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="true" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilsite" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilsite_e1854895_b3fd_41ff_ac7e_3581994b0560" type="QString" name="ReferencedLayerId"/>
            <Option value="soilsite" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilsite_datastream_9" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilprofile">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="true" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" type="QString" name="ReferencedLayerId"/>
            <Option value="soilprofile" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilprofile_datastream_8" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilderivedobject">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="true" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" type="QString" name="ReferencedLayerId"/>
            <Option value="soilderivedobject" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilderivedobject_datastream_7" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idprofileelement">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="true" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=profileelement" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" type="QString" name="ReferencedLayerId"/>
            <Option value="profileelement" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="profileelement_datastream_6" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iddatastreamcollection">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="true" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=datastreamcollection" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="datastreamcollection_05997361_72ea_40c3_ac61_ca85ad8ea1c8" type="QString" name="ReferencedLayerId"/>
            <Option value="datastreamcollection" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="datastreamcollection_datastream_5" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idprocess">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=process" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" type="QString" name="ReferencedLayerId"/>
            <Option value="process" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="process_datastream_4" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idobservedproperty">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=observableproperty" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" type="QString" name="ReferencedLayerId"/>
            <Option value="observableproperty" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="observableproperty_datastream_3" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsensor">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="true" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=sensor" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="sensor_fb521675_7fbc_4e4a_ad7d_543510fee531" type="QString" name="ReferencedLayerId"/>
            <Option value="sensor" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="sensor_datastream_2" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="guidkey" name="" index="1"/>
    <alias field="idsoilsite" name="Soil Site" index="2"/>
    <alias field="idsoilprofile" name="Soil Profile" index="3"/>
    <alias field="idsoilderivedobject" name="Soil Derived Object" index="4"/>
    <alias field="idprofileelement" name="Profile Element" index="5"/>
    <alias field="iddatastreamcollection" name="Datastream Collection" index="6"/>
    <alias field="idprocess" name="Process" index="7"/>
    <alias field="idobservedproperty" name="Property" index="8"/>
    <alias field="idsensor" name="Sensor" index="9"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="idsoilsite"/>
    <policy policy="DefaultValue" field="idsoilprofile"/>
    <policy policy="DefaultValue" field="idsoilderivedobject"/>
    <policy policy="DefaultValue" field="idprofileelement"/>
    <policy policy="DefaultValue" field="iddatastreamcollection"/>
    <policy policy="DefaultValue" field="idprocess"/>
    <policy policy="DefaultValue" field="idobservedproperty"/>
    <policy policy="DefaultValue" field="idsensor"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="guidkey" applyOnUpdate="0"/>
    <default expression="" field="idsoilsite" applyOnUpdate="0"/>
    <default expression="" field="idsoilprofile" applyOnUpdate="0"/>
    <default expression="" field="idsoilderivedobject" applyOnUpdate="0"/>
    <default expression="" field="idprofileelement" applyOnUpdate="0"/>
    <default expression="" field="iddatastreamcollection" applyOnUpdate="0"/>
    <default expression="" field="idprocess" applyOnUpdate="0"/>
    <default expression="" field="idobservedproperty" applyOnUpdate="0"/>
    <default expression="" field="idsensor" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="guidkey" unique_strength="1" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="idsoilsite" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="idsoilprofile" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="idsoilderivedobject" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="idprofileelement" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="iddatastreamcollection" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="idprocess" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="idobservedproperty" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="idsensor" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="guidkey" desc="" exp=""/>
    <constraint field="idsoilsite" desc="" exp=""/>
    <constraint field="idsoilprofile" desc="" exp=""/>
    <constraint field="idsoilderivedobject" desc="" exp=""/>
    <constraint field="idprofileelement" desc="" exp=""/>
    <constraint field="iddatastreamcollection" desc="" exp=""/>
    <constraint field="idprocess" desc="" exp=""/>
    <constraint field="idobservedproperty" desc="" exp=""/>
    <constraint field="idsensor" desc="" exp=""/>
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
    <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="id" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Feature Of Interest" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idsoilsite" index="2">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idsoilprofile" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idprofileelement" index="5">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idsoilderivedobject" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idobservedproperty" index="8">
      <labelStyle overrideLabelFont="1" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" italic="0" bold="1" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idprocess" index="7">
      <labelStyle overrideLabelFont="1" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" italic="0" bold="1" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="iddatastreamcollection" index="6">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idsensor" index="9">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorRelation showLabel="1" forceSuppressFormPopup="0" horizontalStretch="0" relation="datastream_observation" verticalStretch="0" nmRelationId="" name="datastream_observation" label="" relationWidgetTypeId="relation_editor">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <editor_configuration type="Map">
        <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
        <Option value="AllButtons" type="QString" name="buttons"/>
        <Option value="true" type="bool" name="show_first_feature"/>
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
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="iddatastreamcollection" reuseLastValue="0"/>
    <field name="idobservedproperty" reuseLastValue="0"/>
    <field name="idprocess" reuseLastValue="0"/>
    <field name="idprofileelement" reuseLastValue="0"/>
    <field name="idsensor" reuseLastValue="0"/>
    <field name="idsoilderivedobject" reuseLastValue="0"/>
    <field name="idsoilprofile" reuseLastValue="0"/>
    <field name="idsoilsite" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="datastream_observation">
      <config type="Map">
        <Option value="false" type="bool" name="force-suppress-popup"/>
        <Option value="" type="QString" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>IF( "datastreamcollection" is not null, &#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'datastreamcollection',&#xd;
		'guidkey',&#xd;
		"iddatastreamcollection"&#xd;
	) &#xd;
	,'name'&#xd;
	))	&#xd;
&#xd;
||' - ','')&#xd;
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
