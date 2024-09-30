<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers/>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="guidkey" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="wrbversion" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('wrbversion') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_612657c0_5777_49fb_96f7_0ded0115c241" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/GPKG/INSP_03_TEST_WRB.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="true" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="qualifierplace" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('WRBQualifierPlaceValue') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_612657c0_5777_49fb_96f7_0ded0115c241" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/GPKG/INSP_03_TEST_WRB.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="wrbqualifier" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&#xa;&#xa;CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBQualifierValue') &#xa;  WHEN current_value('wrbversion') = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBQualifierValue2014')  &#xa;  WHEN current_value('wrbversion') = 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBQualifierValue2022')  &#xa;  ELSE 0&#xa;END&#xa;" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_612657c0_5777_49fb_96f7_0ded0115c241" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/GPKG/INSP_03_TEST_WRB.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="wrbspecifier_1" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBSpecifierValue') &#xa;  WHEN current_value('wrbversion') = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBSpecifierValue2014')  &#xa;  WHEN current_value('wrbversion') = 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBSpecifierValue2022')  &#xa;  ELSE 0&#xa;END&#xa;&#xa;" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_612657c0_5777_49fb_96f7_0ded0115c241" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/GPKG/INSP_03_TEST_WRB.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="wrbspecifier_2" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBSpecifierValue') &#xa;  WHEN current_value('wrbversion') = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBSpecifierValue2014')  &#xa;  WHEN current_value('wrbversion') = 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBSpecifierValue2022')  &#xa;  ELSE 0&#xa;END&#xa;&#xa;" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_612657c0_5777_49fb_96f7_0ded0115c241" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/GPKG/INSP_03_TEST_WRB.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="guidkey" name="" index="1"/>
    <alias field="wrbversion" name="WRB Version" index="2"/>
    <alias field="qualifierplace" name="Qualifier Place" index="3"/>
    <alias field="wrbqualifier" name="WBR Qualifier" index="4"/>
    <alias field="wrbspecifier_1" name="First" index="5"/>
    <alias field="wrbspecifier_2" name="Second" index="6"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="guidkey" policy="Duplicate"/>
    <policy field="wrbversion" policy="DefaultValue"/>
    <policy field="qualifierplace" policy="DefaultValue"/>
    <policy field="wrbqualifier" policy="DefaultValue"/>
    <policy field="wrbspecifier_1" policy="DefaultValue"/>
    <policy field="wrbspecifier_2" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="guidkey" applyOnUpdate="0" expression=""/>
    <default field="wrbversion" applyOnUpdate="0" expression=""/>
    <default field="qualifierplace" applyOnUpdate="0" expression=""/>
    <default field="wrbqualifier" applyOnUpdate="0" expression=""/>
    <default field="wrbspecifier_1" applyOnUpdate="0" expression=""/>
    <default field="wrbspecifier_2" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="1" constraints="3" notnull_strength="1" exp_strength="0"/>
    <constraint field="guidkey" unique_strength="1" constraints="2" notnull_strength="0" exp_strength="0"/>
    <constraint field="wrbversion" unique_strength="0" constraints="1" notnull_strength="1" exp_strength="0"/>
    <constraint field="qualifierplace" unique_strength="0" constraints="1" notnull_strength="1" exp_strength="0"/>
    <constraint field="wrbqualifier" unique_strength="0" constraints="1" notnull_strength="1" exp_strength="0"/>
    <constraint field="wrbspecifier_1" unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint field="wrbspecifier_2" unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="wrbversion" exp="" desc=""/>
    <constraint field="qualifierplace" exp="" desc=""/>
    <constraint field="wrbqualifier" exp="" desc=""/>
    <constraint field="wrbspecifier_1" exp="" desc=""/>
    <constraint field="wrbspecifier_2" exp="" desc=""/>
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
      <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
    </labelStyle>
    <attributeEditorField verticalStretch="0" showLabel="1" name="id" horizontalStretch="0" index="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" showLabel="1" name="wrbversion" horizontalStretch="0" index="2">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" showLabel="1" name="qualifierplace" horizontalStretch="0" index="3">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" showLabel="1" name="wrbqualifier" horizontalStretch="0" index="4">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer verticalStretch="0" type="GroupBox" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" columnCount="1" visibilityExpressionEnabled="0" name="WBR Specifier" horizontalStretch="0" groupBox="1" visibilityExpression="">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
      </labelStyle>
      <attributeEditorField verticalStretch="0" showLabel="1" name="wrbspecifier_1" horizontalStretch="0" index="5">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" showLabel="1" name="wrbspecifier_2" horizontalStretch="0" index="6">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="qualifierplace" editable="1"/>
    <field name="qualifierposition" editable="1"/>
    <field name="wrbqualifier" editable="1"/>
    <field name="wrbqualifiergroup" editable="1"/>
    <field name="wrbspecifier_1" editable="1"/>
    <field name="wrbspecifier_2" editable="1"/>
    <field name="wrbversion" editable="1"/>
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
    <field labelOnTop="0" name="wrbversion"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="qualifierplace" reuseLastValue="0"/>
    <field name="qualifierposition" reuseLastValue="0"/>
    <field name="wrbqualifier" reuseLastValue="0"/>
    <field name="wrbqualifiergroup" reuseLastValue="0"/>
    <field name="wrbspecifier_1" reuseLastValue="0"/>
    <field name="wrbspecifier_2" reuseLastValue="0"/>
    <field name="wrbversion" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"wrbversion"&#xd;
						),&#xd;
					'label'&#xd;
					),&#xd;
		'&lt;NULL>')&#xd;
		|| ' '||&#xd;
		&#xd;
if( "qualifierplace" = 'http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/prefix','P','S')&#xd;
&#xd;
&#xd;
||&#xd;
if("wrbspecifier_1"  is not NULL,&#xd;
&#xd;
		' '|| COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"wrbspecifier_1"&#xd;
						),&#xd;
					 'label'&#xd;
					),&#xd;
		'')&#xd;
		,'')&#xd;
		&#xd;
||&#xd;
if("wrbspecifier_2"  is not NULL, &#xd;
&#xd;
		' '|| COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"wrbspecifier_2"&#xd;
						),&#xd;
					 'label'&#xd;
					),&#xd;
		'')&#xd;
		,'')&#xd;
		&#xd;
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
		'')	&#xd;
		&#xd;
		&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
