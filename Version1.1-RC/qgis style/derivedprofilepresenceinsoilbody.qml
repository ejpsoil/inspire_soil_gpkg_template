<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencingLayer="derivedprofilepresenceinsoilbody_7dc4e225_bde8_418b_bdcf_f8373514b6a5" layerName="soilbody" strength="Association" name="soilbody_derivedprofilepresenceinsoilbody_2" referencedLayer="soilbody_c2b9fea0_0a42_454f_b7a5_47da74d320b6" dataSource="./INSPIRE_SO_07.gpkg|layername=soilbody" layerId="soilbody_c2b9fea0_0a42_454f_b7a5_47da74d320b6" providerKey="ogr" id="soilbody_derivedprofilepresenceinsoilbody_2">
      <fieldRef referencedField="guidkey" referencingField="idsoilbody"/>
    </relation>
    <relation referencingLayer="derivedprofilepresenceinsoilbody_7dc4e225_bde8_418b_bdcf_f8373514b6a5" layerName="soilprofile" strength="Association" name="soilprofile_derivedprofilepresenceinsoilbody" referencedLayer="soilprofile_4533a9b5_5d1e_4a04_a667_5768367b31b7" dataSource="./INSPIRE_SO_07.gpkg|layername=soilprofile" layerId="soilprofile_4533a9b5_5d1e_4a04_a667_5768367b31b7" providerKey="ogr" id="soilprofile_derivedprofilepresenceinsoilbody">
      <fieldRef referencedField="guidkey" referencingField="idsoilprofile"/>
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
    <field name="idsoilbody" configurationFlags="None">
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
    <field name="idsoilprofile" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="false" type="bool" name="ChainFilters"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="isDerived = True" type="QString" name="FilterExpression"/>
            <Option type="invalid" name="FilterFields"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=soilprofile" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilprofile_4533a9b5_5d1e_4a04_a667_5768367b31b7" type="QString" name="ReferencedLayerId"/>
            <Option value="soilprofile" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilprofile_derivedprofilepresenceinsoilbody" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="lowervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="uppervalue" configurationFlags="None">
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
    <policy field="id" policy="Duplicate"/>
    <policy field="idsoilbody" policy="DefaultValue"/>
    <policy field="idsoilprofile" policy="DefaultValue"/>
    <policy field="lowervalue" policy="DefaultValue"/>
    <policy field="uppervalue" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="id"/>
    <default expression="" applyOnUpdate="0" field="idsoilbody"/>
    <default expression="" applyOnUpdate="0" field="idsoilprofile"/>
    <default expression="" applyOnUpdate="0" field="lowervalue"/>
    <default expression="" applyOnUpdate="0" field="uppervalue"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="1" field="id" constraints="3"/>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="0" field="idsoilbody" constraints="1"/>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="0" field="idsoilprofile" constraints="1"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="lowervalue" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="uppervalue" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="idsoilbody"/>
    <constraint exp="" desc="" field="idsoilprofile"/>
    <constraint exp="" desc="" field="lowervalue"/>
    <constraint exp="" desc="" field="uppervalue"/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="id" index="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="idsoilbody" index="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="idsoilprofile" index="2">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Presence in SoilBody">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="lowervalue" index="3">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="uppervalue" index="4">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
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
    <field name="id" labelOnTop="0"/>
    <field name="idsoilbody" labelOnTop="0"/>
    <field name="idsoilprofile" labelOnTop="0"/>
    <field name="lowervalue" labelOnTop="0"/>
    <field name="uppervalue" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idsoilbody"/>
    <field reuseLastValue="0" name="idsoilprofile"/>
    <field reuseLastValue="0" name="lowervalue"/>
    <field reuseLastValue="0" name="uppervalue"/>
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
