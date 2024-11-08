<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="soilderivedobject_714705ec_5e61_41a4_916d_a469c9208809" layerId="soilderivedobject_714705ec_5e61_41a4_916d_a469c9208809" referencingLayer="isbasedonsoilderivedobject_70ae8764_d045_4bf3_86ce_b5b019ac23b9" providerKey="ogr" layerName="soilderivedobject" strength="Association" name="soilderivedobject_isbasedonsoilderivedobject" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilderivedobject" id="soilderivedobject_isbasedonsoilderivedobject">
      <fieldRef referencedField="guidkey" referencingField="related_id"/>
    </relation>
    <relation referencedLayer="soilderivedobject_714705ec_5e61_41a4_916d_a469c9208809" layerId="soilderivedobject_714705ec_5e61_41a4_916d_a469c9208809" referencingLayer="isbasedonsoilderivedobject_70ae8764_d045_4bf3_86ce_b5b019ac23b9" providerKey="ogr" layerName="soilderivedobject" strength="Association" name="soilderivedobject_isbasedonsoilderivedobject_2" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilderivedobject" id="soilderivedobject_isbasedonsoilderivedobject_2">
      <fieldRef referencedField="guidkey" referencingField="base_id"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="base_id">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" type="QString" name="ReferencedLayerId"/>
            <Option value="soilderivedobject" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilderivedobject_isbasedonsoilderivedobject_2" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="related_id">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" type="QString" name="ReferencedLayerId"/>
            <Option value="soilderivedobject" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilderivedobject_isbasedonsoilderivedobject" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="base_id" name="Base Soil Derived Object" index="1"/>
    <alias field="related_id" name="Derived Soil Derived Object" index="2"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="base_id"/>
    <policy policy="DefaultValue" field="related_id"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="base_id" applyOnUpdate="0"/>
    <default expression="" field="related_id" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="base_id" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="related_id" unique_strength="0" notnull_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="base_id" desc="" exp=""/>
    <constraint field="related_id" desc="" exp=""/>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="base_id" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="related_id" index="2">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="base_id"/>
    <field editable="1" name="id"/>
    <field editable="1" name="related_id"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="base_id"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="related_id"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="base_id" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="related_id" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'Derived From: '&#xd;
|| COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'soilderivedobject',  &#xd;
		'guidkey',&#xd;
		"base_id"&#xd;
	) &#xd;
	,'inspireid_localid' &#xd;
	)&#xd;
)</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
