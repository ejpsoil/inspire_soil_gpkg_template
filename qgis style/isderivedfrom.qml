<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="soilprofile_isderivedfrom" providerKey="ogr" referencedLayer="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" layerName="soilprofile" name="soilprofile_isderivedfrom" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilprofile" referencingLayer="isderivedfrom_014ff264_0ae2_4426_9d2b_8a82a72dbcbd" layerId="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="related_id"/>
    </relation>
    <relation id="soilprofile_isderivedfrom_2" providerKey="ogr" referencedLayer="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" layerName="soilprofile" name="soilprofile_isderivedfrom_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilprofile" referencingLayer="isderivedfrom_014ff264_0ae2_4426_9d2b_8a82a72dbcbd" layerId="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="base_id"/>
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
    <field configurationFlags="None" name="base_id">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="ChainFilters" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="isDerived = True" name="FilterExpression" type="QString"/>
            <Option name="FilterFields" type="invalid"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" name="ReferencedLayerId" type="QString"/>
            <Option value="soilprofile" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilprofile_isderivedfrom_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="related_id">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="ChainFilters" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="isDerived = False" name="FilterExpression" type="QString"/>
            <Option name="FilterFields" type="invalid"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" name="ReferencedLayerId" type="QString"/>
            <Option value="soilprofile" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilprofile_isderivedfrom" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="Derived Profile" field="base_id"/>
    <alias index="2" name="Observed Profile" field="related_id"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="base_id"/>
    <policy policy="DefaultValue" field="related_id"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="base_id"/>
    <default applyOnUpdate="0" expression="" field="related_id"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="base_id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="related_id"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="base_id"/>
    <constraint exp="" desc="" field="related_id"/>
  </constraintExpressions>
  <expressionfields/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
I moduli di QGIS possono avere una funzione Python che può essere chiamata quando un modulo viene aperto.

Usa questa funzione per aggiungere logica extra ai tuoi moduli.

Inserisci il nome della funzione nel campo "Funzione Python di avvio".

Segue un esempio:
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
    <attributeEditorField showLabel="1" index="1" name="base_id" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" name="related_id" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
    <field reuseLastValue="1" name="base_id"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="related_id"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'DER: '||&#xd;
COALESCE(attribute(get_feature&#xd;
(&#xd;
	'soilprofile',  &#xd;
	'guidkey',&#xd;
	"base_id" &#xd;
) &#xd;
,'localidentifier' &#xd;
))&#xd;
|| ' - OBS: '||&#xd;
COALESCE(attribute(get_feature&#xd;
(&#xd;
	'soilprofile',  &#xd;
	'guidkey',&#xd;
	"related_id" &#xd;
) &#xd;
,'localidentifier' &#xd;
))&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
