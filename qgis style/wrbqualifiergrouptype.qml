<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Fields|Forms" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="guidkey">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="qualifierplace">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="false"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue') "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_6dff4a6f_20e9_4a3d_912e_3af2836047d1"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="qualifierposition">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbqualifier">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="false"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/WRBQualifierValue')  "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_6dff4a6f_20e9_4a3d_912e_3af2836047d1"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_1">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="true"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers') "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_6dff4a6f_20e9_4a3d_912e_3af2836047d1"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_2">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="true"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('https://crea.gov.it/infosuoli/vocabularies/WRBSpecifiers') "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_6dff4a6f_20e9_4a3d_912e_3af2836047d1"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbqualifiergroup">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"/>
            <Option name="AllowNULL" type="bool" value="false"/>
            <Option name="FetchLimitActive" type="bool" value="true"/>
            <Option name="FetchLimitNumber" type="int" value="100"/>
            <Option name="MapIdentification" type="bool" value="false"/>
            <Option name="ReadOnly" type="bool" value="false"/>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=soilprofile"/>
            <Option name="ReferencedLayerId" type="QString" value="soilprofile_22025b68_6999_464c_bf4d_549fdc6f07f9"/>
            <Option name="ReferencedLayerName" type="QString" value="soilprofile"/>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"/>
            <Option name="Relation" type="QString" value="soilprofile_wrbqualifiergrouptype"/>
            <Option name="ShowForm" type="bool" value="false"/>
            <Option name="ShowOpenFormButton" type="bool" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="qualifierplace" index="2" name="Qualifier Place"/>
    <alias field="qualifierposition" index="3" name="Qualifier Position"/>
    <alias field="wrbqualifier" index="4" name="WBR Qualifier"/>
    <alias field="wrbspecifier_1" index="5" name="First"/>
    <alias field="wrbspecifier_2" index="6" name="Second"/>
    <alias field="wrbqualifiergroup" index="7" name="WBR Qualifier Group Type"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="qualifierplace" policy="DefaultValue"/>
    <policy field="qualifierposition" policy="DefaultValue"/>
    <policy field="wrbqualifier" policy="DefaultValue"/>
    <policy field="wrbspecifier_1" policy="DefaultValue"/>
    <policy field="wrbspecifier_2" policy="DefaultValue"/>
    <policy field="wrbqualifiergroup" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="guidkey" expression="" applyOnUpdate="0"/>
    <default field="qualifierplace" expression="" applyOnUpdate="0"/>
    <default field="qualifierposition" expression="" applyOnUpdate="0"/>
    <default field="wrbqualifier" expression="" applyOnUpdate="0"/>
    <default field="wrbspecifier_1" expression="" applyOnUpdate="0"/>
    <default field="wrbspecifier_2" expression="" applyOnUpdate="0"/>
    <default field="wrbqualifiergroup" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="guidkey" constraints="2" unique_strength="1" exp_strength="0" notnull_strength="0"/>
    <constraint field="qualifierplace" constraints="1" unique_strength="0" exp_strength="0" notnull_strength="1"/>
    <constraint field="qualifierposition" constraints="1" unique_strength="0" exp_strength="0" notnull_strength="1"/>
    <constraint field="wrbqualifier" constraints="1" unique_strength="0" exp_strength="0" notnull_strength="1"/>
    <constraint field="wrbspecifier_1" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="wrbspecifier_2" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="wrbqualifiergroup" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="0" name="id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="2" name="qualifierplace" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="3" name="qualifierposition" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="4" name="wrbqualifier" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" collapsed="0" name="WBR Specidfier" showLabel="1" groupBox="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="5" name="wrbspecifier_1" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="6" name="wrbspecifier_2" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" index="7" name="wrbqualifiergroup" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
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
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="qualifierplace" reuseLastValue="0"/>
    <field name="qualifierposition" reuseLastValue="0"/>
    <field name="wrbqualifier" reuseLastValue="0"/>
    <field name="wrbqualifiergroup" reuseLastValue="0"/>
    <field name="wrbspecifier_1" reuseLastValue="0"/>
    <field name="wrbspecifier_2" reuseLastValue="0"/>
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
