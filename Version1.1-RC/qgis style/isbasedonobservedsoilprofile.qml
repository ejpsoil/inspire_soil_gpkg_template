<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="soilderivedobject_400edfe0_1a33_46b2_a140_e8724dd33dee" name="soilderivedobject_isbasedonobservedsoilprofile_2" referencingLayer="isbasedonobservedsoilprofile_32c9b637_10af_44f4_8479_f2d50e31efcd" dataSource="./INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=soilderivedobject" layerName="soilderivedobject" strength="Association" id="soilderivedobject_isbasedonobservedsoilprofile_2" layerId="soilderivedobject_400edfe0_1a33_46b2_a140_e8724dd33dee" providerKey="ogr">
      <fieldRef referencingField="idsoilderivedobject" referencedField="guidkey"/>
    </relation>
    <relation referencedLayer="soilprofile_1946ea4d_1688_4089_b461_dd7c31a24f04" name="soilprofile_isbasedonobservedsoilprofile" referencingLayer="isbasedonobservedsoilprofile_32c9b637_10af_44f4_8479_f2d50e31efcd" dataSource="./INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=soilprofile" layerName="soilprofile" strength="Association" id="soilprofile_isbasedonobservedsoilprofile" layerId="soilprofile_1946ea4d_1688_4089_b461_dd7c31a24f04" providerKey="ogr">
      <fieldRef referencingField="idsoilprofile" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilderivedobject">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" type="QString"/>
            <Option name="ReferencedLayerId" value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" type="QString"/>
            <Option name="ReferencedLayerName" value="soilderivedobject" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="soilderivedobject_isbasedonobservedsoilprofile_2" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilprofile">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="ChainFilters" value="false" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="FilterExpression" value="isDerived = False" type="QString"/>
            <Option name="FilterFields"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/Tutorials/dati_github/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=soilprofile" type="QString"/>
            <Option name="ReferencedLayerId" value="soilprofile_1946ea4d_1688_4089_b461_dd7c31a24f04" type="QString"/>
            <Option name="ReferencedLayerName" value="soilprofile" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="soilprofile_isbasedonobservedsoilprofile" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="idsoilderivedobject" name="Soil Derived Object" index="1"/>
    <alias field="idsoilprofile" name="Soil Profile" index="2"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="idsoilderivedobject" policy="DefaultValue"/>
    <policy field="idsoilprofile" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="idsoilderivedobject"/>
    <default applyOnUpdate="0" expression="" field="idsoilprofile"/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="1" constraints="3" exp_strength="0" notnull_strength="1"/>
    <constraint field="idsoilderivedobject" unique_strength="0" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="idsoilprofile" unique_strength="0" constraints="1" exp_strength="0" notnull_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="id" desc=""/>
    <constraint exp="" field="idsoilderivedobject" desc=""/>
    <constraint exp="" field="idsoilprofile" desc=""/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" italic="0" bold="0"/>
    </labelStyle>
    <attributeEditorField name="id" horizontalStretch="0" index="0" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" italic="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="idsoilderivedobject" horizontalStretch="0" index="1" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" italic="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="idsoilprofile" horizontalStretch="0" index="2" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" italic="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="idsoilderivedobject"/>
    <field editable="1" name="idsoilprofile"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idsoilderivedobject"/>
    <field labelOnTop="0" name="idsoilprofile"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="id" reuseLastValue="0"/>
    <field name="idsoilderivedobject" reuseLastValue="0"/>
    <field name="idsoilprofile" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'Based on '|| COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'soilprofile',  &#xd;
		'guidkey',&#xd;
		"idsoilprofile"&#xd;
	) &#xd;
	,'inspireid_localid' &#xd;
	)&#xd;
)&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
