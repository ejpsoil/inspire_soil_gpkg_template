<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="otherhorizonnotationtype_9d3923ad_c916_40e0_b96b_7fd6d7c588ef" id="otherhorizonnotationtype_otherhorizon_profileelement" referencingLayer="otherhorizon_profileelement_9b1d14d7_79aa_45ab_a6d8_77949e1aa1ad" layerId="otherhorizonnotationtype_9d3923ad_c916_40e0_b96b_7fd6d7c588ef" providerKey="ogr" dataSource="./INSPIRE_SO_DEMO_V01.gpkg|layername=otherhorizonnotationtype" layerName="otherhorizonnotationtype" name="otherhorizonnotationtype_otherhorizon_profileelement" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idotherhorizonnotationtype"/>
    </relation>
    <relation referencedLayer="profileelement_e3c097e6_b9be_4926_8bd6_13f11448b000" id="profileelement_otherhorizon_profileelement_2" referencingLayer="otherhorizon_profileelement_9b1d14d7_79aa_45ab_a6d8_77949e1aa1ad" layerId="profileelement_e3c097e6_b9be_4926_8bd6_13f11448b000" providerKey="ogr" dataSource="./INSPIRE_SO_DEMO_V01.gpkg|layername=profileelement" layerName="profileelement" name="profileelement_otherhorizon_profileelement_2" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idprofileelement"/>
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
    <field configurationFlags="None" name="idprofileelement">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=profileelement" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" type="QString" name="ReferencedLayerId"/>
            <Option value="profileelement" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="profileelement_otherhorizon_profileelement_2" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idotherhorizonnotationtype">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=otherhorizonnotationtype" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="otherhorizonnotationtype_d52d4ee1_52c4_4eb4_a1aa_f71bcb71bcfb" type="QString" name="ReferencedLayerId"/>
            <Option value="otherhorizonnotationtype" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="otherhorizonnotationtype_otherhorizon_profileelement" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="idprofileelement" index="1" name="Profile Element"/>
    <alias field="idotherhorizonnotationtype" index="2" name="Other Notation Type"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="idprofileelement" policy="DefaultValue"/>
    <policy field="idotherhorizonnotationtype" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="idprofileelement" applyOnUpdate="0" expression=""/>
    <default field="idotherhorizonnotationtype" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="1" notnull_strength="1" exp_strength="0" constraints="3"/>
    <constraint field="idprofileelement" unique_strength="0" notnull_strength="1" exp_strength="0" constraints="1"/>
    <constraint field="idotherhorizonnotationtype" unique_strength="0" notnull_strength="1" exp_strength="0" constraints="1"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="idprofileelement" exp="" desc=""/>
    <constraint field="idotherhorizonnotationtype" exp="" desc=""/>
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
    <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="0" name="id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="1" name="idprofileelement" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="2" name="idotherhorizonnotationtype" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="idotherhorizonnotationtype"/>
    <field editable="1" name="idprofileelement"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idotherhorizonnotationtype"/>
    <field labelOnTop="0" name="idprofileelement"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idotherhorizonnotationtype"/>
    <field reuseLastValue="0" name="idprofileelement"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'otherhorizonnotationtype',&#xd;
							'guidkey',&#xd;
							"idotherhorizonnotationtype"&#xd;
						),&#xd;
					'horizonnotation'&#xd;
					),&#xd;
		'&lt;NULL>')&#xd;
&#xd;
&#xd;
|| ' ' ||&#xd;
regexp_substr(COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'otherhorizonnotationtype',&#xd;
							'guidkey',&#xd;
							"idotherhorizonnotationtype"&#xd;
						),&#xd;
					'diagnostichorizon'&#xd;
					),&#xd;
		'&lt;NULL>'), '[^/]*$')&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
