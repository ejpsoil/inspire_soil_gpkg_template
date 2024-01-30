<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers/>
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
    <field configurationFlags="None" name="guidkey">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="qualifierplace">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('WRBQualifierPlaceValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="qualifierposition">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbqualifier">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('WRBQualifierValue')  " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_1">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('WRBSpecifierValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_2">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('WRBSpecifierValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="Qualifier Place" field="qualifierplace"/>
    <alias index="3" name="Qualifier Position" field="qualifierposition"/>
    <alias index="4" name="WBR Qualifier" field="wrbqualifier"/>
    <alias index="5" name="First" field="wrbspecifier_1"/>
    <alias index="6" name="Second" field="wrbspecifier_2"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="Duplicate" field="guidkey"/>
    <policy policy="DefaultValue" field="qualifierplace"/>
    <policy policy="DefaultValue" field="qualifierposition"/>
    <policy policy="DefaultValue" field="wrbqualifier"/>
    <policy policy="DefaultValue" field="wrbspecifier_1"/>
    <policy policy="DefaultValue" field="wrbspecifier_2"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="qualifierplace"/>
    <default applyOnUpdate="0" expression="" field="qualifierposition"/>
    <default applyOnUpdate="0" expression="" field="wrbqualifier"/>
    <default applyOnUpdate="0" expression="" field="wrbspecifier_1"/>
    <default applyOnUpdate="0" expression="" field="wrbspecifier_2"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="qualifierplace"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="qualifierposition"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="wrbqualifier"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="wrbspecifier_1"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="wrbspecifier_2"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="qualifierplace"/>
    <constraint exp="" desc="" field="qualifierposition"/>
    <constraint exp="" desc="" field="wrbqualifier"/>
    <constraint exp="" desc="" field="wrbspecifier_1"/>
    <constraint exp="" desc="" field="wrbspecifier_2"/>
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
    <attributeEditorField showLabel="1" index="2" name="qualifierplace" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="3" name="qualifierposition" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="4" name="wrbqualifier" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="WBR Specifier" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="5" name="wrbspecifier_1" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="6" name="wrbspecifier_2" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
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
