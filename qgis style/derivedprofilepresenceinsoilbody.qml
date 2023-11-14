<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
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
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilbody" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilbody_49ee5b40_2f4e_4325_9e05_d4c3f3af67bc" name="ReferencedLayerId"/>
            <Option type="QString" value="soilbody" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilbody_derivedprofilepresenceinsoilbody_2" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idsoilprofile" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilprofile" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilprofile_45e0cba8_1aea_4f5e_8c05_d955ca7c7659" name="ReferencedLayerId"/>
            <Option type="QString" value="soilprofile" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilprofile_derivedprofilepresenceinsoilbody" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="lowervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="uppervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="id" index="0"/>
    <alias name="Soil Body" field="idsoilbody" index="1"/>
    <alias name="Soil Profile" field="idsoilprofile" index="2"/>
    <alias name="% Lower Value" field="lowervalue" index="3"/>
    <alias name="% Upper Value" field="uppervalue" index="4"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="idsoilbody" policy="DefaultValue"/>
    <policy field="idsoilprofile" policy="DefaultValue"/>
    <policy field="lowervalue" policy="DefaultValue"/>
    <policy field="uppervalue" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="idsoilbody" expression=""/>
    <default applyOnUpdate="0" field="idsoilprofile" expression=""/>
    <default applyOnUpdate="0" field="lowervalue" expression=""/>
    <default applyOnUpdate="0" field="uppervalue" expression=""/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" constraints="3" unique_strength="1" field="id"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0" field="idsoilbody"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0" field="idsoilprofile"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="lowervalue"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="uppervalue"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="idsoilbody" exp=""/>
    <constraint desc="" field="idsoilprofile" exp=""/>
    <constraint desc="" field="lowervalue" exp=""/>
    <constraint desc="" field="uppervalue" exp=""/>
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
      <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" name="id" showLabel="1" verticalStretch="0" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" name="idsoilbody" showLabel="1" verticalStretch="0" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" name="idsoilprofile" showLabel="1" verticalStretch="0" index="2">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="1" type="GroupBox" name="Presence in SoilBody" visibilityExpression="" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" name="lowervalue" showLabel="1" verticalStretch="0" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" name="uppervalue" showLabel="1" verticalStretch="0" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="id" editable="1"/>
    <field name="idsoilbody" editable="1"/>
    <field name="idsoilprofile" editable="1"/>
    <field name="lowervalue" editable="1"/>
    <field name="uppervalue" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="id" labelOnTop="0"/>
    <field name="idsoilbody" labelOnTop="0"/>
    <field name="idsoilprofile" labelOnTop="0"/>
    <field name="lowervalue" labelOnTop="0"/>
    <field name="uppervalue" labelOnTop="0"/>
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
