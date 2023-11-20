<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="soilprofile_70463919_e765_4575_a6dd_732282d87450" strength="Composition" dataSource="./Vector.gpkg|layername=soilprofile" referencingLayer="wrbqualifiergrouptype_8401ec45_b4ba_4080_85bc_8713f5992f09" id="soilprofile_wrbqualifiergrouptype" layerId="soilprofile_70463919_e765_4575_a6dd_732282d87450" providerKey="ogr" name="soilprofile_wrbqualifiergrouptype" layerName="soilprofile">
      <fieldRef referencingField="wrbqualifiergroup" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="qualifierplace">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('WRBQualifierPlaceValue') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="qualifierposition">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbqualifier">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('WRBQualifierValue')  " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_1">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('WRBSpecifiers') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_2">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('WRBSpecifiers') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbqualifiergroup">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=soilprofile" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilprofile_70463919_e765_4575_a6dd_732282d87450" name="ReferencedLayerId"/>
            <Option type="QString" value="soilprofile" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilprofile_wrbqualifiergrouptype" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="id" name=""/>
    <alias index="1" field="qualifierplace" name="Qualifier Place"/>
    <alias index="2" field="qualifierposition" name="Qualifier Position"/>
    <alias index="3" field="wrbqualifier" name="WBR Qualifier"/>
    <alias index="4" field="wrbspecifier_1" name="First"/>
    <alias index="5" field="wrbspecifier_2" name="Second"/>
    <alias index="6" field="wrbqualifiergroup" name="Soil Profile"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="qualifierplace" policy="DefaultValue"/>
    <policy field="qualifierposition" policy="DefaultValue"/>
    <policy field="wrbqualifier" policy="DefaultValue"/>
    <policy field="wrbspecifier_1" policy="DefaultValue"/>
    <policy field="wrbspecifier_2" policy="DefaultValue"/>
    <policy field="wrbqualifiergroup" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="qualifierplace" expression="" applyOnUpdate="0"/>
    <default field="qualifierposition" expression="" applyOnUpdate="0"/>
    <default field="wrbqualifier" expression="" applyOnUpdate="0"/>
    <default field="wrbspecifier_1" expression="" applyOnUpdate="0"/>
    <default field="wrbspecifier_2" expression="" applyOnUpdate="0"/>
    <default field="wrbqualifiergroup" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" field="id" notnull_strength="1" exp_strength="0"/>
    <constraint constraints="1" unique_strength="0" field="qualifierplace" notnull_strength="1" exp_strength="0"/>
    <constraint constraints="1" unique_strength="0" field="qualifierposition" notnull_strength="1" exp_strength="0"/>
    <constraint constraints="1" unique_strength="0" field="wrbqualifier" notnull_strength="1" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="wrbspecifier_1" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="wrbspecifier_2" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="wrbqualifiergroup" notnull_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="qualifierplace" exp="" desc=""/>
    <constraint field="qualifierposition" exp="" desc=""/>
    <constraint field="wrbqualifier" exp="" desc=""/>
    <constraint field="wrbspecifier_1" exp="" desc=""/>
    <constraint field="wrbspecifier_2" exp="" desc=""/>
    <constraint field="wrbqualifiergroup" exp="" desc=""/>
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
      <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
    </labelStyle>
    <attributeEditorField index="0" showLabel="1" verticalStretch="0" name="id" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="1" showLabel="1" verticalStretch="0" name="qualifierplace" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="2" showLabel="1" verticalStretch="0" name="qualifierposition" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="3" showLabel="1" verticalStretch="0" name="wrbqualifier" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpressionEnabled="0" showLabel="1" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0" collapsed="0" visibilityExpression="" type="GroupBox" groupBox="1" name="WBR Specidfier" horizontalStretch="0" collapsedExpression="">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField index="4" showLabel="1" verticalStretch="0" name="wrbspecifier_1" horizontalStretch="0">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="5" showLabel="1" verticalStretch="0" name="wrbspecifier_2" horizontalStretch="0">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField index="6" showLabel="1" verticalStretch="0" name="wrbqualifiergroup" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="qualifierplace"/>
    <field editable="1" name="qualifierposition"/>
    <field editable="1" name="wrbqualifier"/>
    <field editable="1" name="wrbqualifiergroup"/>
    <field editable="1" name="wrbspecifier_1"/>
    <field editable="1" name="wrbspecifier_2"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="qualifierplace"/>
    <field labelOnTop="0" name="qualifierposition"/>
    <field labelOnTop="0" name="wrbqualifier"/>
    <field labelOnTop="0" name="wrbqualifiergroup"/>
    <field labelOnTop="0" name="wrbspecifier_1"/>
    <field labelOnTop="0" name="wrbspecifier_2"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="qualifierplace"/>
    <field reuseLastValue="0" name="qualifierposition"/>
    <field reuseLastValue="0" name="wrbqualifier"/>
    <field reuseLastValue="0" name="wrbqualifiergroup"/>
    <field reuseLastValue="0" name="wrbspecifier_1"/>
    <field reuseLastValue="0" name="wrbspecifier_2"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'Pos' || ' ' || COALESCE( "qualifierposition", '&lt;NULL>' )|| ' ' ||&#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"qualifierplace"&#xd;
						),&#xd;
					'label'&#xd;
					),&#xd;
		'&lt;NULL>')&#xd;
		|| ' '||&#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"wrbqualifier"&#xd;
						),&#xd;
					'label'&#xd;
					),&#xd;
		'')&#xd;
		|| ' '||&#xd;
COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"wrbspecifier_1"&#xd;
						),&#xd;
					'label'&#xd;
					),&#xd;
		'')&#xd;
		|| ' '||&#xd;
COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"wrbspecifier_2"&#xd;
						),&#xd;
					'label'&#xd;
					),&#xd;
		'')&#xd;
		&#xd;
		&#xd;
		&#xd;
		&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
