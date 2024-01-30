<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilprofile" layerId="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" referencedLayer="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" name="soilprofile_profileelement" layerName="soilprofile" providerKey="ogr" id="soilprofile_profileelement" referencingLayer="profileelement_918dfbb9_c077_4a30_95ac_4ecf73ee27d1" strength="Association">
      <fieldRef referencingField="ispartof" referencedField="guidkey"/>
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
    <field configurationFlags="None" name="guidkey">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="profileelementdepthrange_uppervalue">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="profileelementdepthrange_lowervalue">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="beginlifespanversion">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="endlifespanversion">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="layertype">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('LayerTypeValue') " name="FilterExpression"/>
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
    <field configurationFlags="None" name="layerrocktype">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('LithologyValue') " name="FilterExpression"/>
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
    <field configurationFlags="None" name="layergenesisprocess">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('EventProcessValue') " name="FilterExpression"/>
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
    <field configurationFlags="None" name="layergenesisenviroment">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('EventEnvironmentValue') " name="FilterExpression"/>
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
    <field configurationFlags="None" name="layergenesisprocessstate">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('LayerGenesisProcessStateValue') " name="FilterExpression"/>
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
    <field configurationFlags="None" name="profileelementtype">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option type="QString" value="" name="CheckedState"/>
            <Option type="int" value="0" name="TextDisplayMethod"/>
            <Option type="QString" value="" name="UncheckedState"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="ispartof">
      <editWidget type="RelationReference">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="inspireid_localid" index="2" name=""/>
    <alias field="inspireid_namespace" index="3" name=""/>
    <alias field="inspireid_versionid" index="4" name=""/>
    <alias field="profileelementdepthrange_uppervalue" index="5" name="Upper Value"/>
    <alias field="profileelementdepthrange_lowervalue" index="6" name="Lower Value"/>
    <alias field="beginlifespanversion" index="7" name=""/>
    <alias field="endlifespanversion" index="8" name=""/>
    <alias field="layertype" index="9" name="Type"/>
    <alias field="layerrocktype" index="10" name="Lithology"/>
    <alias field="layergenesisprocess" index="11" name="Event Process"/>
    <alias field="layergenesisenviroment" index="12" name="Event Enviroment"/>
    <alias field="layergenesisprocessstate" index="13" name="Genesys Process State"/>
    <alias field="profileelementtype" index="14" name="Is a Layer"/>
    <alias field="ispartof" index="15" name=""/>
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
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="inspireid_localid" expression=""/>
    <default applyOnUpdate="0" field="inspireid_namespace" expression=""/>
    <default applyOnUpdate="0" field="inspireid_versionid" expression=""/>
    <default applyOnUpdate="0" field="profileelementdepthrange_uppervalue" expression=""/>
    <default applyOnUpdate="0" field="profileelementdepthrange_lowervalue" expression=""/>
    <default applyOnUpdate="0" field="beginlifespanversion" expression=""/>
    <default applyOnUpdate="0" field="endlifespanversion" expression=""/>
    <default applyOnUpdate="0" field="layertype" expression=""/>
    <default applyOnUpdate="0" field="layerrocktype" expression=""/>
    <default applyOnUpdate="0" field="layergenesisprocess" expression=""/>
    <default applyOnUpdate="0" field="layergenesisenviroment" expression=""/>
    <default applyOnUpdate="0" field="layergenesisprocessstate" expression=""/>
    <default applyOnUpdate="0" field="profileelementtype" expression=""/>
    <default applyOnUpdate="0" field="ispartof" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="3" exp_strength="0" unique_strength="1" notnull_strength="1"/>
    <constraint field="guidkey" constraints="2" exp_strength="0" unique_strength="1" notnull_strength="0"/>
    <constraint field="inspireid_localid" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="inspireid_namespace" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="inspireid_versionid" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="profileelementdepthrange_uppervalue" constraints="1" exp_strength="0" unique_strength="0" notnull_strength="1"/>
    <constraint field="profileelementdepthrange_lowervalue" constraints="5" exp_strength="2" unique_strength="0" notnull_strength="1"/>
    <constraint field="beginlifespanversion" constraints="1" exp_strength="0" unique_strength="0" notnull_strength="1"/>
    <constraint field="endlifespanversion" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="layertype" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="layerrocktype" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="layergenesisprocess" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="layergenesisenviroment" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="layergenesisprocessstate" constraints="0" exp_strength="0" unique_strength="0" notnull_strength="0"/>
    <constraint field="profileelementtype" constraints="1" exp_strength="0" unique_strength="0" notnull_strength="1"/>
    <constraint field="ispartof" constraints="1" exp_strength="0" unique_strength="0" notnull_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="inspireid_localid" exp="" desc=""/>
    <constraint field="inspireid_namespace" exp="" desc=""/>
    <constraint field="inspireid_versionid" exp="" desc=""/>
    <constraint field="profileelementdepthrange_uppervalue" exp="" desc=""/>
    <constraint field="profileelementdepthrange_lowervalue" exp="&quot;profileelementdepthrange_uppervalue&quot; &lt;= &quot;profileelementdepthrange_lowervalue&quot; " desc=""/>
    <constraint field="beginlifespanversion" exp="" desc=""/>
    <constraint field="endlifespanversion" exp="" desc=""/>
    <constraint field="layertype" exp="" desc=""/>
    <constraint field="layerrocktype" exp="" desc=""/>
    <constraint field="layergenesisprocess" exp="" desc=""/>
    <constraint field="layergenesisenviroment" exp="" desc=""/>
    <constraint field="layergenesisprocessstate" exp="" desc=""/>
    <constraint field="profileelementtype" exp="" desc=""/>
    <constraint field="ispartof" exp="" desc=""/>
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
      <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
    </labelStyle>
    <attributeEditorField index="0" verticalStretch="0" name="id" showLabel="1" horizontalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="-1" verticalStretch="0" name="idsoilprofile" showLabel="1" horizontalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont bold="1" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="14" verticalStretch="0" name="profileelementtype" showLabel="1" horizontalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont bold="1" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer verticalStretch="0" type="GroupBox" name="INSPIRE ID" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="" groupBox="1" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField index="2" verticalStretch="0" name="inspireid_localid" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="3" verticalStretch="0" name="inspireid_namespace" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="4" verticalStretch="0" name="inspireid_versionid" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer verticalStretch="0" type="GroupBox" name="Limits" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="" groupBox="1" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField index="5" verticalStretch="0" name="profileelementdepthrange_uppervalue" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="6" verticalStretch="0" name="profileelementdepthrange_lowervalue" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField index="10" verticalStretch="0" name="layerrocktype" showLabel="1" horizontalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer verticalStretch="0" type="GroupBox" name="Layer Parameter" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="profileelementtype = True" groupBox="1" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField index="9" verticalStretch="0" name="layertype" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="11" verticalStretch="0" name="layergenesisprocess" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="12" verticalStretch="0" name="layergenesisenviroment" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="13" verticalStretch="0" name="layergenesisprocessstate" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer verticalStretch="0" type="GroupBox" name="Dates" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="" groupBox="1" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField index="7" verticalStretch="0" name="beginlifespanversion" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="8" verticalStretch="0" name="endlifespanversion" showLabel="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer verticalStretch="0" type="Tab" name="Particle Size fraction" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="" groupBox="0" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation relationWidgetTypeId="relation_editor" verticalStretch="0" name="profileelement_particlesizefractiontype" showLabel="0" horizontalStretch="0" nmRelationId="" label="" forceSuppressFormPopup="0" relation="profileelement_particlesizefractiontype">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer verticalStretch="0" type="Tab" name="Datastream" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="" groupBox="0" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation relationWidgetTypeId="relation_editor" verticalStretch="0" name="profileelement_datastream_6" showLabel="0" horizontalStretch="0" nmRelationId="" label="" forceSuppressFormPopup="0" relation="profileelement_datastream_6">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer verticalStretch="0" type="Tab" name="FAO Horizon Notation Type" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="profileelementtype = false" groupBox="0" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation relationWidgetTypeId="relation_editor" verticalStretch="0" name="profileelement_faohorizonnotationtype" showLabel="0" horizontalStretch="0" nmRelationId="" label="" forceSuppressFormPopup="0" relation="profileelement_faohorizonnotationtype">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer verticalStretch="0" type="Tab" name="Other Horizon Notation Type" showLabel="1" horizontalStretch="0" columnCount="1" collapsedExpression="" visibilityExpression="profileelementtype = false" groupBox="0" collapsed="0" collapsedExpressionEnabled="0" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation relationWidgetTypeId="relation_editor" verticalStretch="0" name="profileelement_otherhorizon_profileelement_2" showLabel="0" horizontalStretch="0" nmRelationId="" label="" forceSuppressFormPopup="0" relation="profileelement_otherhorizon_profileelement_2">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
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
  <previewExpression>COALESCE( "inspireid_localid", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
