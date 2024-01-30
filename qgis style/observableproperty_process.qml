<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="observableproperty_observableproperty_process" providerKey="ogr" referencedLayer="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" layerName="observableproperty" name="observableproperty_observableproperty_process" dataSource="./INSPIRE_Selection_4.gpkg|layername=observableproperty" referencingLayer="observableproperty_process_dbb706f2_690c_482d_8d97_d29ea9500844" layerId="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idobservedproperty"/>
    </relation>
    <relation id="process_observableproperty_process_2" providerKey="ogr" referencedLayer="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" layerName="process" name="process_observableproperty_process_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=process" referencingLayer="observableproperty_process_dbb706f2_690c_482d_8d97_d29ea9500844" layerId="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idprocess"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="idprocess">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=process" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" name="ReferencedLayerId" type="QString"/>
            <Option value="process" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="process_observableproperty_process_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idobservedproperty">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=observableproperty" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" name="ReferencedLayerId" type="QString"/>
            <Option value="observableproperty" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="observableproperty_observableproperty_process" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="Process" field="idprocess"/>
    <alias index="1" name="Observable Properrty" field="idobservedproperty"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="idprocess"/>
    <policy policy="DefaultValue" field="idobservedproperty"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="idprocess"/>
    <default applyOnUpdate="0" expression="" field="idobservedproperty"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idprocess"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idobservedproperty"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="idprocess"/>
    <constraint exp="" desc="" field="idobservedproperty"/>
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
      <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="0" name="idprocess" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="1" name="idobservedproperty" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
    <field reuseLastValue="0" name="idobservedproperty"/>
    <field reuseLastValue="0" name="idprocess"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
