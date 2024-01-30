<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="soilprofile_wrbqualifiergroup_profile_2" providerKey="ogr" referencedLayer="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" layerName="soilprofile" name="soilprofile_wrbqualifiergroup_profile_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilprofile" referencingLayer="wrbqualifiergroup_profile_85dae3db_5d9b_43ae_93bc_85d1ef9d572b" layerId="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idsoilprofile"/>
    </relation>
    <relation id="wrbqualifiergrouptype_wrbqualifiergroup_profile" providerKey="ogr" referencedLayer="wrbqualifiergrouptype_5206378c_2665_4d70_bd6e_8fff263b7fea" layerName="wrbqualifiergrouptype" name="wrbqualifiergrouptype_wrbqualifiergroup_profile" dataSource="./INSPIRE_Selection_4.gpkg|layername=wrbqualifiergrouptype" referencingLayer="wrbqualifiergroup_profile_85dae3db_5d9b_43ae_93bc_85d1ef9d572b" layerId="wrbqualifiergrouptype_5206378c_2665_4d70_bd6e_8fff263b7fea" strength="Composition">
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
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" name="ReferencedLayerId" type="QString"/>
            <Option value="soilprofile" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilprofile_wrbqualifiergroup_profile_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idwrbqualifiergrouptype">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=wrbqualifiergrouptype" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="wrbqualifiergrouptype_5206378c_2665_4d70_bd6e_8fff263b7fea" name="ReferencedLayerId" type="QString"/>
            <Option value="wrbqualifiergrouptype" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="wrbqualifiergrouptype_wrbqualifiergroup_profile" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="Id Profile" field="idsoilprofile"/>
    <alias index="2" name="Id WRB Group Type" field="idwrbqualifiergrouptype"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="idsoilprofile"/>
    <policy policy="DefaultValue" field="idwrbqualifiergrouptype"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="idsoilprofile"/>
    <default applyOnUpdate="0" expression="" field="idwrbqualifiergrouptype"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idsoilprofile"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idwrbqualifiergrouptype"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="idsoilprofile"/>
    <constraint exp="" desc="" field="idwrbqualifiergrouptype"/>
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
    <attributeEditorField showLabel="1" index="1" name="idsoilprofile" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" name="idwrbqualifiergrouptype" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idsoilprofile"/>
    <field reuseLastValue="0" name="idwrbqualifiergrouptype"/>
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
