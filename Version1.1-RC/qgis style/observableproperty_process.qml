<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="observableproperty_observableproperty_process" layerId="observableproperty_a6419fbf_f550_4859_9141_c9218696ff8e" referencingLayer="observableproperty_process_d4865a19_5d10_45c6_9d4b_789112629ef7" referencedLayer="observableproperty_a6419fbf_f550_4859_9141_c9218696ff8e" strength="Association" layerName="observableproperty" dataSource="./INSPIRE_SO_12.gpkg|layername=observableproperty" providerKey="ogr" name="observableproperty_observableproperty_process">
      <fieldRef referencingField="idobservedproperty" referencedField="guidkey"/>
    </relation>
    <relation id="process_observableproperty_process_2" layerId="process_8af8852e_58f2_4e0f_b76d_477e53a3eda7" referencingLayer="observableproperty_process_d4865a19_5d10_45c6_9d4b_789112629ef7" referencedLayer="process_8af8852e_58f2_4e0f_b76d_477e53a3eda7" strength="Association" layerName="process" dataSource="./INSPIRE_SO_12.gpkg|layername=process" providerKey="ogr" name="process_observableproperty_process_2">
      <fieldRef referencingField="idprocess" referencedField="guidkey"/>
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
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_05 - O&amp;M/INSPIRE_SO_12.gpkg|layername=process" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="process_8af8852e_58f2_4e0f_b76d_477e53a3eda7" type="QString" name="ReferencedLayerId"/>
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
    <alias index="0" field="idprocess" name="Process"/>
    <alias index="1" field="idobservedproperty" name="Observable Properrty"/>
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
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" constraints="1" field="idprocess"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" constraints="1" field="idobservedproperty"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="idprocess" desc=""/>
    <constraint exp="" field="idobservedproperty" desc=""/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="1" horizontalStretch="0" name="idobservedproperty" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="0" horizontalStretch="0" name="idprocess" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
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
  <previewExpression>'ObsProp: '|| &#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
&#xd;
						(&#xd;
&#xd;
							'observableproperty',&#xd;
&#xd;
							'guidkey',&#xd;
&#xd;
							"idobservedproperty"&#xd;
&#xd;
						),&#xd;
&#xd;
					'name'&#xd;
&#xd;
					),&#xd;
&#xd;
		'&lt;NULL>')&#xd;
&#xd;
||  ' - Proc:'||' '|| &#xd;&#xd;
COALESCE(attribute(get_feature&#xd;&#xd;
						(&#xd;&#xd;
							'process',&#xd;&#xd;
							'guidkey',&#xd;&#xd;
							"idprocess"&#xd;&#xd;
						),&#xd;&#xd;
					'name'&#xd;&#xd;
					),&#xd;&#xd;
		'&lt;NULL>')&#xd;&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
