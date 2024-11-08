<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="observableproperty_54541782_41af_4d65_9367_01527efa7b4d" layerId="observableproperty_54541782_41af_4d65_9367_01527efa7b4d" referencingLayer="observableproperty_process_3ba623a4_cb8f_4168_960e_a3378b4ab90e" providerKey="ogr" layerName="observableproperty" strength="Association" name="observableproperty_observableproperty_process" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=observableproperty" id="observableproperty_observableproperty_process">
      <fieldRef referencedField="guidkey" referencingField="idobservedproperty"/>
    </relation>
    <relation referencedLayer="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" layerId="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" referencingLayer="observableproperty_process_3ba623a4_cb8f_4168_960e_a3378b4ab90e" providerKey="ogr" layerName="process" strength="Association" name="process_observableproperty_process_2" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=process" id="process_observableproperty_process_2">
      <fieldRef referencedField="guidkey" referencingField="idprocess"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
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
            <Option value="process_observableproperty_process_2" type="QString" name="Relation"/>
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
            <Option value="observableproperty_observableproperty_process" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="idprocess" name="Process" index="0"/>
    <alias field="idobservedproperty" name="Observable Properrty" index="1"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="idprocess"/>
    <policy policy="DefaultValue" field="idobservedproperty"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="idprocess" applyOnUpdate="0"/>
    <default expression="" field="idobservedproperty" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="1" exp_strength="0" field="idprocess" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="idobservedproperty" unique_strength="0" notnull_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint field="idprocess" desc="" exp=""/>
    <constraint field="idobservedproperty" desc="" exp=""/>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idprocess" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idobservedproperty" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="idobservedproperty"/>
    <field editable="1" name="idprocess"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="idobservedproperty"/>
    <field labelOnTop="0" name="idprocess"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="idobservedproperty" reuseLastValue="0"/>
    <field name="idprocess" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
