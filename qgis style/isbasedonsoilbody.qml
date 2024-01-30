<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="soilbody_isbasedonsoilbody" providerKey="ogr" referencedLayer="soilbody_9e604eb5_eab1_4147_aaa8_8d7a59ca703f" layerName="soilbody" name="soilbody_isbasedonsoilbody" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilbody" referencingLayer="isbasedonsoilbody_d543d828_1f29_446c_b33a_60684d945148" layerId="soilbody_9e604eb5_eab1_4147_aaa8_8d7a59ca703f" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idsoilbody"/>
    </relation>
    <relation id="soilderivedobject_isbasedonsoilbody_2" providerKey="ogr" referencedLayer="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" layerName="soilderivedobject" name="soilderivedobject_isbasedonsoilbody_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilderivedobject" referencingLayer="isbasedonsoilbody_d543d828_1f29_446c_b33a_60684d945148" layerId="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idsoilderivedobject"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilderivedobject">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" name="ReferencedLayerId" type="QString"/>
            <Option value="soilderivedobject" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilderivedobject_isbasedonsoilbody_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilbody">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilbody" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilbody_9e604eb5_eab1_4147_aaa8_8d7a59ca703f" name="ReferencedLayerId" type="QString"/>
            <Option value="soilbody" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilbody_isbasedonsoilbody" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="Soil Derived Object" field="idsoilderivedobject"/>
    <alias index="2" name="Soil Body" field="idsoilbody"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="idsoilderivedobject"/>
    <policy policy="DefaultValue" field="idsoilbody"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="idsoilderivedobject"/>
    <default applyOnUpdate="0" expression="" field="idsoilbody"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idsoilderivedobject"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idsoilbody"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="idsoilderivedobject"/>
    <constraint exp="" desc="" field="idsoilbody"/>
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
    <attributeEditorField showLabel="1" index="0" name="id" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="1" name="idsoilderivedobject" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" name="idsoilbody" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="idsoilbody"/>
    <field editable="1" name="idsoilderivedobject"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idsoilbody"/>
    <field labelOnTop="0" name="idsoilderivedobject"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idsoilbody"/>
    <field reuseLastValue="0" name="idsoilderivedobject"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'Based on: '&#xd;
|| COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'soilbody',  &#xd;
		'guidkey',&#xd;
		"idsoilbody"&#xd;
	) &#xd;
	,'inspireid_localid' &#xd;
	)&#xd;
)</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
