<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation name="soilprofile_profileelement" referencingLayer="profileelement_0057e95f_935c_4f95_a2a2_2bf7a03462fa" dataSource="./Vector.gpkg|layername=soilprofile" id="soilprofile_profileelement" layerName="soilprofile" referencedLayer="soilprofile_70463919_e765_4575_a6dd_732282d87450" strength="Association" layerId="soilprofile_70463919_e765_4575_a6dd_732282d87450" providerKey="ogr">
      <fieldRef referencingField="ispartof" referencedField="guidkey"/>
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
    <field name="guidkey" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_localid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_namespace" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_versionid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementdepthrange_uppervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementdepthrange_lowervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="beginlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="false" name="allow_null" type="bool"/>
            <Option value="true" name="calendar_popup" type="bool"/>
            <Option value="yyyy-MM-dd HH:mm:ss" name="display_format" type="QString"/>
            <Option value="yyyy-MM-dd HH:mm:ss" name="field_format" type="QString"/>
            <Option value="false" name="field_format_overwrite" type="bool"/>
            <Option value="false" name="field_iso_format" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="endlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="true" name="allow_null" type="bool"/>
            <Option value="true" name="calendar_popup" type="bool"/>
            <Option value="yyyy-MM-dd HH:mm:ss" name="display_format" type="QString"/>
            <Option value="yyyy-MM-dd HH:mm:ss" name="field_format" type="QString"/>
            <Option value="false" name="field_format_overwrite" type="bool"/>
            <Option value="false" name="field_iso_format" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layertype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('LayerTypeValue') " name="FilterExpression" type="QString"/>
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
    <field name="layerrocktype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('LithologyValue') " name="FilterExpression" type="QString"/>
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
    <field name="layergenesisprocess" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('EventProcessValue') " name="FilterExpression" type="QString"/>
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
    <field name="layergenesisenviroment" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('EventEnvironmentValue') " name="FilterExpression" type="QString"/>
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
    <field name="layergenesisprocessstate" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('LayerGenesisProcessStateValue') " name="FilterExpression" type="QString"/>
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
    <field name="profileelementtype" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option value="" name="CheckedState" type="QString"/>
            <Option value="0" name="TextDisplayMethod" type="int"/>
            <Option value="" name="UncheckedState" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="ispartof" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="guidkey" name="" index="1"/>
    <alias field="inspireid_localid" name="" index="2"/>
    <alias field="inspireid_namespace" name="" index="3"/>
    <alias field="inspireid_versionid" name="" index="4"/>
    <alias field="profileelementdepthrange_uppervalue" name="Upper Value" index="5"/>
    <alias field="profileelementdepthrange_lowervalue" name="Lower Value" index="6"/>
    <alias field="beginlifespanversion" name="" index="7"/>
    <alias field="endlifespanversion" name="" index="8"/>
    <alias field="layertype" name="Type" index="9"/>
    <alias field="layerrocktype" name="Lithology" index="10"/>
    <alias field="layergenesisprocess" name="Event Process" index="11"/>
    <alias field="layergenesisenviroment" name="Event Enviroment" index="12"/>
    <alias field="layergenesisprocessstate" name="Genesys Process State" index="13"/>
    <alias field="profileelementtype" name="Is a Layer" index="14"/>
    <alias field="ispartof" name="" index="15"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="inspireid_localid" policy="DefaultValue"/>
    <policy field="inspireid_namespace" policy="DefaultValue"/>
    <policy field="inspireid_versionid" policy="DefaultValue"/>
    <policy field="profileelementdepthrange_uppervalue" policy="DefaultValue"/>
    <policy field="profileelementdepthrange_lowervalue" policy="DefaultValue"/>
    <policy field="beginlifespanversion" policy="DefaultValue"/>
    <policy field="endlifespanversion" policy="DefaultValue"/>
    <policy field="layertype" policy="DefaultValue"/>
    <policy field="layerrocktype" policy="DefaultValue"/>
    <policy field="layergenesisprocess" policy="DefaultValue"/>
    <policy field="layergenesisenviroment" policy="DefaultValue"/>
    <policy field="layergenesisprocessstate" policy="DefaultValue"/>
    <policy field="profileelementtype" policy="DefaultValue"/>
    <policy field="ispartof" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="guidkey" applyOnUpdate="0" expression=""/>
    <default field="inspireid_localid" applyOnUpdate="0" expression=""/>
    <default field="inspireid_namespace" applyOnUpdate="0" expression=""/>
    <default field="inspireid_versionid" applyOnUpdate="0" expression=""/>
    <default field="profileelementdepthrange_uppervalue" applyOnUpdate="0" expression=""/>
    <default field="profileelementdepthrange_lowervalue" applyOnUpdate="0" expression=""/>
    <default field="beginlifespanversion" applyOnUpdate="0" expression=""/>
    <default field="endlifespanversion" applyOnUpdate="0" expression=""/>
    <default field="layertype" applyOnUpdate="0" expression=""/>
    <default field="layerrocktype" applyOnUpdate="0" expression=""/>
    <default field="layergenesisprocess" applyOnUpdate="0" expression=""/>
    <default field="layergenesisenviroment" applyOnUpdate="0" expression=""/>
    <default field="layergenesisprocessstate" applyOnUpdate="0" expression=""/>
    <default field="profileelementtype" applyOnUpdate="0" expression=""/>
    <default field="ispartof" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" field="id" notnull_strength="1" constraints="3" exp_strength="0"/>
    <constraint unique_strength="1" field="guidkey" notnull_strength="0" constraints="2" exp_strength="0"/>
    <constraint unique_strength="0" field="inspireid_localid" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="inspireid_namespace" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="inspireid_versionid" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="profileelementdepthrange_uppervalue" notnull_strength="1" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" field="profileelementdepthrange_lowervalue" notnull_strength="1" constraints="5" exp_strength="2"/>
    <constraint unique_strength="0" field="beginlifespanversion" notnull_strength="1" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" field="endlifespanversion" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="layertype" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="layerrocktype" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="layergenesisprocess" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="layergenesisenviroment" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="layergenesisprocessstate" notnull_strength="0" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" field="profileelementtype" notnull_strength="1" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" field="ispartof" notnull_strength="1" constraints="1" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="inspireid_localid"/>
    <constraint exp="" desc="" field="inspireid_namespace"/>
    <constraint exp="" desc="" field="inspireid_versionid"/>
    <constraint exp="" desc="" field="profileelementdepthrange_uppervalue"/>
    <constraint exp="&quot;profileelementdepthrange_uppervalue&quot; &lt;= &quot;profileelementdepthrange_lowervalue&quot; " desc="" field="profileelementdepthrange_lowervalue"/>
    <constraint exp="" desc="" field="beginlifespanversion"/>
    <constraint exp="" desc="" field="endlifespanversion"/>
    <constraint exp="" desc="" field="layertype"/>
    <constraint exp="" desc="" field="layerrocktype"/>
    <constraint exp="" desc="" field="layergenesisprocess"/>
    <constraint exp="" desc="" field="layergenesisenviroment"/>
    <constraint exp="" desc="" field="layergenesisprocessstate"/>
    <constraint exp="" desc="" field="profileelementtype"/>
    <constraint exp="" desc="" field="ispartof"/>
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
      <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
    </labelStyle>
    <attributeEditorField name="id" verticalStretch="0" index="0" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="idsoilprofile" verticalStretch="0" index="-1" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="1" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" bold="1"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="profileelementtype" verticalStretch="0" index="14" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="1" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" bold="1"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" collapsedExpression="" visibilityExpression="" visibilityExpressionEnabled="0" name="INSPIRE ID" verticalStretch="0" columnCount="1" type="GroupBox" showLabel="1" collapsedExpressionEnabled="0" horizontalStretch="0" groupBox="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField name="inspireid_localid" verticalStretch="0" index="2" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_namespace" verticalStretch="0" index="3" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_versionid" verticalStretch="0" index="4" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" collapsedExpression="" visibilityExpression="" visibilityExpressionEnabled="0" name="Limits" verticalStretch="0" columnCount="1" type="GroupBox" showLabel="1" collapsedExpressionEnabled="0" horizontalStretch="0" groupBox="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField name="profileelementdepthrange_uppervalue" verticalStretch="0" index="5" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="profileelementdepthrange_lowervalue" verticalStretch="0" index="6" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField name="layerrocktype" verticalStretch="0" index="10" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" collapsedExpression="" visibilityExpression="profileelementtype = True" visibilityExpressionEnabled="1" name="Layer Parameter" verticalStretch="0" columnCount="1" type="GroupBox" showLabel="1" collapsedExpressionEnabled="0" horizontalStretch="0" groupBox="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField name="layertype" verticalStretch="0" index="9" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="layergenesisprocess" verticalStretch="0" index="11" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="layergenesisenviroment" verticalStretch="0" index="12" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="layergenesisprocessstate" verticalStretch="0" index="13" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" collapsedExpression="" visibilityExpression="" visibilityExpressionEnabled="0" name="Dates" verticalStretch="0" columnCount="1" type="GroupBox" showLabel="1" collapsedExpressionEnabled="0" horizontalStretch="0" groupBox="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField name="beginlifespanversion" verticalStretch="0" index="7" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="endlifespanversion" verticalStretch="0" index="8" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" collapsedExpression="" visibilityExpression="" visibilityExpressionEnabled="0" name="Particle Size fraction" verticalStretch="0" columnCount="1" type="Tab" showLabel="1" collapsedExpressionEnabled="0" horizontalStretch="0" groupBox="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation label="" relationWidgetTypeId="relation_editor" name="profileelement_particlesizefractiontype" verticalStretch="0" relation="profileelement_particlesizefractiontype" forceSuppressFormPopup="0" showLabel="0" horizontalStretch="0" nmRelationId="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" name="allow_add_child_feature_with_no_geometry" type="bool"/>
          <Option value="AllButtons" name="buttons" type="QString"/>
          <Option value="true" name="show_first_feature" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" collapsedExpression="" visibilityExpression="profileelementtype = false" visibilityExpressionEnabled="1" name="FAO Horizon Notation Type" verticalStretch="0" columnCount="1" type="Tab" showLabel="1" collapsedExpressionEnabled="0" horizontalStretch="0" groupBox="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation label="" relationWidgetTypeId="relation_editor" name="profileelement_faohorizonnotationtype" verticalStretch="0" relation="profileelement_faohorizonnotationtype" forceSuppressFormPopup="0" showLabel="0" horizontalStretch="0" nmRelationId="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" name="allow_add_child_feature_with_no_geometry" type="bool"/>
          <Option value="AllButtons" name="buttons" type="QString"/>
          <Option value="true" name="show_first_feature" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" collapsedExpression="" visibilityExpression="profileelementtype = false" visibilityExpressionEnabled="1" name="Other Horizon Notation Type" verticalStretch="0" columnCount="1" type="Tab" showLabel="1" collapsedExpressionEnabled="0" horizontalStretch="0" groupBox="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation label="" relationWidgetTypeId="relation_editor" name="profileelement_otherhorizonnotationtype" verticalStretch="0" relation="profileelement_otherhorizonnotationtype" forceSuppressFormPopup="0" showLabel="0" horizontalStretch="0" nmRelationId="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" style="" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" name="allow_add_child_feature_with_no_geometry" type="bool"/>
          <Option value="AllButtons" name="buttons" type="QString"/>
          <Option value="true" name="show_first_feature" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="beginlifespanversion" editable="1"/>
    <field name="endlifespanversion" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="idsoilprofile" editable="1"/>
    <field name="inspireid_localid" editable="1"/>
    <field name="inspireid_namespace" editable="1"/>
    <field name="inspireid_versionid" editable="1"/>
    <field name="ispartof" editable="1"/>
    <field name="layergenesisenviroment" editable="1"/>
    <field name="layergenesisprocess" editable="1"/>
    <field name="layergenesisprocessstate" editable="1"/>
    <field name="layerrocktype" editable="1"/>
    <field name="layertype" editable="1"/>
    <field name="profileelementdepthrange_lowervalue" editable="1"/>
    <field name="profileelementdepthrange_uppervalue" editable="1"/>
    <field name="profileelementtype" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="beginlifespanversion" labelOnTop="0"/>
    <field name="endlifespanversion" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="idsoilprofile" labelOnTop="0"/>
    <field name="inspireid_localid" labelOnTop="0"/>
    <field name="inspireid_namespace" labelOnTop="0"/>
    <field name="inspireid_versionid" labelOnTop="0"/>
    <field name="ispartof" labelOnTop="0"/>
    <field name="layergenesisenviroment" labelOnTop="0"/>
    <field name="layergenesisprocess" labelOnTop="0"/>
    <field name="layergenesisprocessstate" labelOnTop="0"/>
    <field name="layerrocktype" labelOnTop="0"/>
    <field name="layertype" labelOnTop="0"/>
    <field name="profileelementdepthrange_lowervalue" labelOnTop="0"/>
    <field name="profileelementdepthrange_uppervalue" labelOnTop="0"/>
    <field name="profileelementtype" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="beginlifespanversion" reuseLastValue="0"/>
    <field name="endlifespanversion" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="idsoilprofile" reuseLastValue="0"/>
    <field name="inspireid_localid" reuseLastValue="0"/>
    <field name="inspireid_namespace" reuseLastValue="0"/>
    <field name="inspireid_versionid" reuseLastValue="0"/>
    <field name="ispartof" reuseLastValue="0"/>
    <field name="layergenesisenviroment" reuseLastValue="0"/>
    <field name="layergenesisprocess" reuseLastValue="0"/>
    <field name="layergenesisprocessstate" reuseLastValue="0"/>
    <field name="layerrocktype" reuseLastValue="0"/>
    <field name="layertype" reuseLastValue="0"/>
    <field name="profileelementdepthrange_lowervalue" reuseLastValue="0"/>
    <field name="profileelementdepthrange_uppervalue" reuseLastValue="0"/>
    <field name="profileelementtype" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>' SP ' ||&#xd;
COALESCE(attribute(get_feature&#xd;
(&#xd;
	'soilprofile',  &#xd;
	'guidkey',&#xd;
	"ispartof" &#xd;
) &#xd;
,'id' &#xd;
))&#xd;
|| ' - ' ||&#xd;
COALESCE(attribute(get_feature&#xd;
(&#xd;
	'soilprofile',  &#xd;
	'guidkey',&#xd;
	"ispartof" &#xd;
) &#xd;
,'localidentifier' &#xd;
))&#xd;
|| ' (' ||&#xd;
COALESCE( "profileelementdepthrange_uppervalue", '&lt;NULL>' )&#xd;
|| ' - ' || &#xd;
COALESCE( "profileelementdepthrange_lowervalue", '&lt;NULL>' )&#xd;
|| ')'&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
