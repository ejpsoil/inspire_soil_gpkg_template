<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" layerId="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" referencingLayer="wrbqualifiergroup_profile_644e5cc9_c6cf_4a66_b3b0_e816c13978ec" providerKey="ogr" layerName="soilprofile" strength="Association" name="soilprofile_wrbqualifiergroup_profile_2" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilprofile" id="soilprofile_wrbqualifiergroup_profile_2">
      <fieldRef referencedField="guidkey" referencingField="idsoilprofile"/>
    </relation>
    <relation referencedLayer="wrbqualifiergrouptype_20324974_9c8e_44b1_b1c6_30025a44b51a" layerId="wrbqualifiergrouptype_20324974_9c8e_44b1_b1c6_30025a44b51a" referencingLayer="wrbqualifiergroup_profile_644e5cc9_c6cf_4a66_b3b0_e816c13978ec" providerKey="ogr" layerName="wrbqualifiergrouptype" strength="Association" name="wrbqualifiergrouptype_wrbqualifiergroup_profile" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=wrbqualifiergrouptype" id="wrbqualifiergrouptype_wrbqualifiergroup_profile">
      <fieldRef referencedField="guidkey" referencingField="idwrbqualifiergrouptype"/>
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
    <field configurationFlags="None" name="idsoilprofile">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" type="QString" name="ReferencedLayerId"/>
            <Option value="soilprofile" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilprofile_wrbqualifiergroup_profile_2" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idwrbqualifiergrouptype">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=wrbqualifiergrouptype" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="wrbqualifiergrouptype_5206378c_2665_4d70_bd6e_8fff263b7fea" type="QString" name="ReferencedLayerId"/>
            <Option value="wrbqualifiergrouptype" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="wrbqualifiergrouptype_wrbqualifiergroup_profile" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="idsoilprofile" name="Id Profile" index="1"/>
    <alias field="idwrbqualifiergrouptype" name="Id WRB Group Type" index="2"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="idsoilprofile"/>
    <policy policy="DefaultValue" field="idwrbqualifiergrouptype"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="idsoilprofile" applyOnUpdate="0"/>
    <default expression="" field="idwrbqualifiergrouptype" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="idsoilprofile" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="idwrbqualifiergrouptype" unique_strength="0" notnull_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="idsoilprofile" desc="" exp=""/>
    <constraint field="idwrbqualifiergrouptype" desc="" exp=""/>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idsoilprofile" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idwrbqualifiergrouptype" index="2">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="idsoilprofile"/>
    <field editable="1" name="idwrbqualifiergrouptype"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idsoilprofile"/>
    <field labelOnTop="0" name="idwrbqualifiergrouptype"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="id" reuseLastValue="0"/>
    <field name="idsoilprofile" reuseLastValue="0"/>
    <field name="idwrbqualifiergrouptype" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'Soil Profile: '&#xd;
|| COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'soilprofile',  &#xd;
		'guidkey',&#xd;
		"idsoilprofile"&#xd;
	) &#xd;
	,'inspireid_localid' &#xd;
	)&#xd;
)&#xd;
/*&#xd;
|| ' - '||&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'wrbqualifiergrouptype',  &#xd;
		'guidkey',&#xd;
		"idwrbqualifiergrouptype"&#xd;
	) &#xd;
	,'wrbqualifier' &#xd;
	)&#xd;
)&#xd;
*/</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
