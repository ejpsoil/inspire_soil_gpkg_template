<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation layerId="soilderivedobject_400edfe0_1a33_46b2_a140_e8724dd33dee" referencingLayer="isbasedonsoilderivedobject_96334304_9dce_492a_9974_e4c27bc848ce" strength="Association" providerKey="ogr" id="soilderivedobject_isbasedonsoilderivedobject" name="soilderivedobject_isbasedonsoilderivedobject" layerName="soilderivedobject" referencedLayer="soilderivedobject_400edfe0_1a33_46b2_a140_e8724dd33dee" dataSource="./INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=soilderivedobject">
      <fieldRef referencingField="related_id" referencedField="guidkey"/>
    </relation>
    <relation layerId="soilderivedobject_400edfe0_1a33_46b2_a140_e8724dd33dee" referencingLayer="isbasedonsoilderivedobject_96334304_9dce_492a_9974_e4c27bc848ce" strength="Association" providerKey="ogr" id="soilderivedobject_isbasedonsoilderivedobject_2" name="soilderivedobject_isbasedonsoilderivedobject_2" layerName="soilderivedobject" referencedLayer="soilderivedobject_400edfe0_1a33_46b2_a140_e8724dd33dee" dataSource="./INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=soilderivedobject">
      <fieldRef referencingField="base_id" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="base_id">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" name="ReferencedLayerId"/>
            <Option type="QString" value="soilderivedobject" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilderivedobject_isbasedonsoilderivedobject_2" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="related_id">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" name="ReferencedLayerId"/>
            <Option type="QString" value="soilderivedobject" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilderivedobject_isbasedonsoilderivedobject" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="id" name=""/>
    <alias index="1" field="base_id" name="Base Soil Derived Object"/>
    <alias index="2" field="related_id" name="Derived Soil Derived Object"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="base_id"/>
    <policy policy="DefaultValue" field="related_id"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="id"/>
    <default expression="" applyOnUpdate="0" field="base_id"/>
    <default expression="" applyOnUpdate="0" field="related_id"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" constraints="3" field="id" unique_strength="1"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" field="base_id" unique_strength="0"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" field="related_id" unique_strength="0"/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont italic="0" strikethrough="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="0" name="id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="1" name="base_id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="2" name="related_id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
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
    <field reuseLastValue="0" name="base_id"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="related_id"/>
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
