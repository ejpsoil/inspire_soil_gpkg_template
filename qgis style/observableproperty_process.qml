<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="observableproperty_52f5120f_6406_4f30_9d6a_6a2408ea4da4" id="observableproperty_observableproperty_process" referencingLayer="observableproperty_process_9fe326a2_bdac_4d28_af71_64eeb743e976" layerId="observableproperty_52f5120f_6406_4f30_9d6a_6a2408ea4da4" providerKey="ogr" dataSource="./INSPIRE_SO_DEMO_V01.gpkg|layername=observableproperty" layerName="observableproperty" name="observableproperty_observableproperty_process" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idobservedproperty"/>
    </relation>
    <relation referencedLayer="process_16cd52cc_8b30_417e_9d38_3de72c774e16" id="process_observableproperty_process_2" referencingLayer="observableproperty_process_9fe326a2_bdac_4d28_af71_64eeb743e976" layerId="process_16cd52cc_8b30_417e_9d38_3de72c774e16" providerKey="ogr" dataSource="./INSPIRE_SO_DEMO_V01.gpkg|layername=process" layerName="process" name="process_observableproperty_process_2" strength="Association">
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
    <alias field="idprocess" index="0" name="Process"/>
    <alias field="idobservedproperty" index="1" name="Observable Properrty"/>
  </aliases>
  <splitPolicies>
    <policy field="idprocess" policy="DefaultValue"/>
    <policy field="idobservedproperty" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="idprocess" applyOnUpdate="0" expression=""/>
    <default field="idobservedproperty" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="idprocess" unique_strength="0" notnull_strength="1" exp_strength="0" constraints="1"/>
    <constraint field="idobservedproperty" unique_strength="0" notnull_strength="1" exp_strength="0" constraints="1"/>
  </constraints>
  <constraintExpressions>
    <constraint field="idprocess" exp="" desc=""/>
    <constraint field="idobservedproperty" exp="" desc=""/>
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
    <attributeEditorField horizontalStretch="0" index="0" name="idprocess" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="1" name="idobservedproperty" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
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
  <previewExpression>'Proc:'||' '|| &#xd;
COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'process',&#xd;
							'guidkey',&#xd;
							"idprocess"&#xd;
						),&#xd;
					'name'&#xd;
					),&#xd;
		'&lt;NULL>')&#xd;
||' - ObsProp: '|| &#xd;
COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'observableproperty',&#xd;
							'guidkey',&#xd;
							"idobservedproperty"&#xd;
						),&#xd;
					'name'&#xd;
					),&#xd;
		'&lt;NULL>')</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
