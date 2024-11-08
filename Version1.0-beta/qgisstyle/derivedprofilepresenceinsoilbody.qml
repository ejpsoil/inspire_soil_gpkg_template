<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="soilbody_306359d7_50ae_46cc_b878_e8fc0e08e831" layerId="soilbody_306359d7_50ae_46cc_b878_e8fc0e08e831" referencingLayer="derivedprofilepresenceinsoilbody_68bc0ce6_25bc_46ab_82f1_57ba98e5ef74" providerKey="ogr" layerName="soilbody" strength="Association" name="soilbody_derivedprofilepresenceinsoilbody_2" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilbody" id="soilbody_derivedprofilepresenceinsoilbody_2">
      <fieldRef referencedField="guidkey" referencingField="idsoilbody"/>
    </relation>
    <relation referencedLayer="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" layerId="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" referencingLayer="derivedprofilepresenceinsoilbody_68bc0ce6_25bc_46ab_82f1_57ba98e5ef74" providerKey="ogr" layerName="soilprofile" strength="Association" name="soilprofile_derivedprofilepresenceinsoilbody" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilprofile" id="soilprofile_derivedprofilepresenceinsoilbody">
      <fieldRef referencedField="guidkey" referencingField="idsoilprofile"/>
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
    <field configurationFlags="None" name="idsoilbody">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilbody" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilbody_49ee5b40_2f4e_4325_9e05_d4c3f3af67bc" type="QString" name="ReferencedLayerId"/>
            <Option value="soilbody" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilbody_derivedprofilepresenceinsoilbody_2" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
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
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilprofile" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilprofile_45e0cba8_1aea_4f5e_8c05_d955ca7c7659" type="QString" name="ReferencedLayerId"/>
            <Option value="soilprofile" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilprofile_derivedprofilepresenceinsoilbody" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="lowervalue">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uppervalue">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="idsoilbody" name="Soil Body" index="1"/>
    <alias field="idsoilprofile" name="Soil Profile" index="2"/>
    <alias field="lowervalue" name="% Lower Value" index="3"/>
    <alias field="uppervalue" name="% Upper Value" index="4"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="idsoilbody"/>
    <policy policy="DefaultValue" field="idsoilprofile"/>
    <policy policy="DefaultValue" field="lowervalue"/>
    <policy policy="DefaultValue" field="uppervalue"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="idsoilbody" applyOnUpdate="0"/>
    <default expression="" field="idsoilprofile" applyOnUpdate="0"/>
    <default expression="" field="lowervalue" applyOnUpdate="0"/>
    <default expression="" field="uppervalue" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="idsoilbody" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="idsoilprofile" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="lowervalue" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="uppervalue" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="idsoilbody" desc="" exp=""/>
    <constraint field="idsoilprofile" desc="" exp=""/>
    <constraint field="lowervalue" desc="" exp=""/>
    <constraint field="uppervalue" desc="" exp=""/>
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
    <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="id" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idsoilbody" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="idsoilprofile" index="2">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Presence in SoilBody" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="lowervalue" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="uppervalue" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="idsoilbody"/>
    <field editable="1" name="idsoilprofile"/>
    <field editable="1" name="lowervalue"/>
    <field editable="1" name="uppervalue"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idsoilbody"/>
    <field labelOnTop="0" name="idsoilprofile"/>
    <field labelOnTop="0" name="lowervalue"/>
    <field labelOnTop="0" name="uppervalue"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="id" reuseLastValue="0"/>
    <field name="idsoilbody" reuseLastValue="0"/>
    <field name="idsoilprofile" reuseLastValue="0"/>
    <field name="lowervalue" reuseLastValue="0"/>
    <field name="uppervalue" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'SB: '||&#xd;
COALESCE(attribute(get_feature&#xd;
(&#xd;
	'soilbody',  &#xd;
	'guidkey',&#xd;
	"idsoilbody"&#xd;
) &#xd;
,'soilbodylabel' &#xd;
))&#xd;
|| ' SP: ' ||&#xd;
COALESCE(attribute(get_feature&#xd;
(&#xd;
	'soilprofile',  &#xd;
	'guidkey',&#xd;
	"idsoilprofile"&#xd;
) &#xd;
,'localidentifier' &#xd;
)) || ' '|| "lowervalue" || '% ' </previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
