<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation providerKey="ogr" name="soilprofile_wrbqualifiergroup_profile_2" referencingLayer="wrbqualifiergroup_profile_69dcc431_f14a_461e_8eab_3b150bece87e" dataSource="./INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=soilprofile" id="soilprofile_wrbqualifiergroup_profile_2" referencedLayer="soilprofile_1946ea4d_1688_4089_b461_dd7c31a24f04" layerName="soilprofile" layerId="soilprofile_1946ea4d_1688_4089_b461_dd7c31a24f04" strength="Association">
      <fieldRef referencingField="idsoilprofile" referencedField="guidkey"/>
    </relation>
    <relation providerKey="ogr" name="wrbqualifiergrouptype_wrbqualifiergroup_profile" referencingLayer="wrbqualifiergroup_profile_69dcc431_f14a_461e_8eab_3b150bece87e" dataSource="./INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=wrbqualifiergrouptype" id="wrbqualifiergrouptype_wrbqualifiergroup_profile" referencedLayer="wrbqualifiergrouptype_f101b617_c7b6_49fa_8ba0_b92fd8d90b30" layerName="wrbqualifiergrouptype" layerId="wrbqualifiergrouptype_f101b617_c7b6_49fa_8ba0_b92fd8d90b30" strength="Association">
      <fieldRef referencingField="idwrbqualifiergrouptype" referencedField="guidkey"/>
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
    <field name="idsoilprofile" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"/>
            <Option name="AllowNULL" type="bool" value="false"/>
            <Option name="FetchLimitActive" type="bool" value="true"/>
            <Option name="FetchLimitNumber" type="int" value="100"/>
            <Option name="MapIdentification" type="bool" value="false"/>
            <Option name="ReadOnly" type="bool" value="false"/>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile"/>
            <Option name="ReferencedLayerId" type="QString" value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511"/>
            <Option name="ReferencedLayerName" type="QString" value="soilprofile"/>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"/>
            <Option name="Relation" type="QString" value="soilprofile_wrbqualifiergroup_profile_2"/>
            <Option name="ShowForm" type="bool" value="false"/>
            <Option name="ShowOpenFormButton" type="bool" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idwrbqualifiergrouptype" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"/>
            <Option name="AllowNULL" type="bool" value="false"/>
            <Option name="FetchLimitActive" type="bool" value="true"/>
            <Option name="FetchLimitNumber" type="int" value="100"/>
            <Option name="MapIdentification" type="bool" value="false"/>
            <Option name="ReadOnly" type="bool" value="false"/>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/Tutorials/dati_github/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=wrbqualifiergrouptype"/>
            <Option name="ReferencedLayerId" type="QString" value="wrbqualifiergrouptype_f101b617_c7b6_49fa_8ba0_b92fd8d90b30"/>
            <Option name="ReferencedLayerName" type="QString" value="wrbqualifiergrouptype"/>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"/>
            <Option name="Relation" type="QString" value="wrbqualifiergrouptype_wrbqualifiergroup_profile"/>
            <Option name="ShowForm" type="bool" value="false"/>
            <Option name="ShowOpenFormButton" type="bool" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="qualifierposition" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" index="0" field="id"/>
    <alias name="Id Profile" index="1" field="idsoilprofile"/>
    <alias name="Qualifier" index="2" field="idwrbqualifiergrouptype"/>
    <alias name="Position" index="3" field="qualifierposition"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="idsoilprofile"/>
    <policy policy="DefaultValue" field="idwrbqualifiergrouptype"/>
    <policy policy="DefaultValue" field="qualifierposition"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="idsoilprofile" expression=""/>
    <default applyOnUpdate="0" field="idwrbqualifiergrouptype" expression=""/>
    <default applyOnUpdate="0" field="qualifierposition" expression=""/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" exp_strength="0" field="id" unique_strength="1"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="idsoilprofile" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="idwrbqualifiergrouptype" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="qualifierposition" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="id" desc=""/>
    <constraint exp="" field="idsoilprofile" desc=""/>
    <constraint exp="" field="idwrbqualifiergrouptype" desc=""/>
    <constraint exp="" field="qualifierposition" desc=""/>
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
      <labelFont italic="0" description="MS Shell Dlg 2,12,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
    </labelStyle>
    <attributeEditorField name="id" index="0" horizontalStretch="0" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="idsoilprofile" index="1" horizontalStretch="0" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="qualifierposition" index="3" horizontalStretch="0" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="idwrbqualifiergrouptype" index="2" horizontalStretch="0" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont italic="0" description="MS Shell Dlg 2,12,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field name="id" editable="1"/>
    <field name="idsoilprofile" editable="1"/>
    <field name="idwrbqualifiergrouptype" editable="1"/>
    <field name="qualifierposition" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="id" labelOnTop="0"/>
    <field name="idsoilprofile" labelOnTop="0"/>
    <field name="idwrbqualifiergrouptype" labelOnTop="0"/>
    <field name="qualifierposition" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idsoilprofile"/>
    <field reuseLastValue="0" name="idwrbqualifiergrouptype"/>
    <field reuseLastValue="0" name="qualifierposition"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"qualifierposition" &#xd;
&#xd;
|| ' ' ||&#xd;
regexp_substr(COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'wrbqualifiergrouptype',&#xd;
							'guidkey',&#xd;
							"idwrbqualifiergrouptype"&#xd;
						),&#xd;
					'qualifierplace'&#xd;
					),&#xd;
		'&lt;NULL>'), '[^/]*$')&#xd;
&#xd;
		&#xd;
|| ' '||&#xd;
regexp_substr(COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'wrbqualifiergrouptype',&#xd;
							'guidkey',&#xd;
							"idwrbqualifiergrouptype"&#xd;
						),&#xd;
					'wrbqualifier'&#xd;
					),&#xd;
		'&lt;NULL>'), '[^/]*$')&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
