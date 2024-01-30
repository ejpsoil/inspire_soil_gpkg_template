<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="soilbody_derivedprofilepresenceinsoilbody_2" providerKey="ogr" referencedLayer="soilbody_9e604eb5_eab1_4147_aaa8_8d7a59ca703f" layerName="soilbody" name="soilbody_derivedprofilepresenceinsoilbody_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilbody" referencingLayer="derivedprofilepresenceinsoilbody_4fe2b15a_cf2f_4b4c_a295_47eab82da527" layerId="soilbody_9e604eb5_eab1_4147_aaa8_8d7a59ca703f" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idsoilbody"/>
    </relation>
    <relation id="soilprofile_derivedprofilepresenceinsoilbody" providerKey="ogr" referencedLayer="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" layerName="soilprofile" name="soilprofile_derivedprofilepresenceinsoilbody" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilprofile" referencingLayer="derivedprofilepresenceinsoilbody_4fe2b15a_cf2f_4b4c_a295_47eab82da527" layerId="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" strength="Association">
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
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilbody" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilbody_49ee5b40_2f4e_4325_9e05_d4c3f3af67bc" name="ReferencedLayerId" type="QString"/>
            <Option value="soilbody" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilbody_derivedprofilepresenceinsoilbody_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
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
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilprofile" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilprofile_45e0cba8_1aea_4f5e_8c05_d955ca7c7659" name="ReferencedLayerId" type="QString"/>
            <Option value="soilprofile" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilprofile_derivedprofilepresenceinsoilbody" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="lowervalue">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uppervalue">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="Soil Body" field="idsoilbody"/>
    <alias index="2" name="Soil Profile" field="idsoilprofile"/>
    <alias index="3" name="% Lower Value" field="lowervalue"/>
    <alias index="4" name="% Upper Value" field="uppervalue"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="idsoilbody"/>
    <policy policy="DefaultValue" field="idsoilprofile"/>
    <policy policy="DefaultValue" field="lowervalue"/>
    <policy policy="DefaultValue" field="uppervalue"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="idsoilbody"/>
    <default applyOnUpdate="0" expression="" field="idsoilprofile"/>
    <default applyOnUpdate="0" expression="" field="lowervalue"/>
    <default applyOnUpdate="0" expression="" field="uppervalue"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idsoilbody"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idsoilprofile"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="lowervalue"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="uppervalue"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="0" name="id" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="1" name="idsoilbody" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" name="idsoilprofile" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Presence in SoilBody" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="3" name="lowervalue" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="4" name="uppervalue" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
