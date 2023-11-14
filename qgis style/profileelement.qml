<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation layerName="soilprofile" name="soilprofile_profileelement" dataSource="./Vector.gpkg|layername=soilprofile" layerId="soilprofile_1e35507d_f86e_4ebf_91f3_d88f3396be3b" id="soilprofile_profileelement" referencedLayer="soilprofile_1e35507d_f86e_4ebf_91f3_d88f3396be3b" strength="Association" referencingLayer="profileelement_8af1614f_54a2_483f_83ff_f52e8f55a005" providerKey="ogr">
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
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_localid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_namespace" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_versionid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementdepthrange_uppervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementdepthrange_lowervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="beginlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" value="false" type="bool"/>
            <Option name="calendar_popup" value="true" type="bool"/>
            <Option name="display_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format_overwrite" value="false" type="bool"/>
            <Option name="field_iso_format" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="endlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" value="true" type="bool"/>
            <Option name="calendar_popup" value="true" type="bool"/>
            <Option name="display_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format_overwrite" value="false" type="bool"/>
            <Option name="field_iso_format" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layertype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="false" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/LayerTypeValue') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layerrocktype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/LithologyValue') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layergenesisprocess" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/EventProcessValue') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layergenesisenviroment" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/EventEnvironmentValue') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layergenesisprocessstate" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/LayerGenesisProcessStateValue') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementtype" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" value="" type="QString"/>
            <Option name="TextDisplayMethod" value="0" type="int"/>
            <Option name="UncheckedState" value="" type="QString"/>
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
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="" field="inspireid_localid"/>
    <alias index="3" name="" field="inspireid_namespace"/>
    <alias index="4" name="" field="inspireid_versionid"/>
    <alias index="5" name="Upper Value" field="profileelementdepthrange_uppervalue"/>
    <alias index="6" name="Lower Value" field="profileelementdepthrange_lowervalue"/>
    <alias index="7" name="" field="beginlifespanversion"/>
    <alias index="8" name="" field="endlifespanversion"/>
    <alias index="9" name="Type" field="layertype"/>
    <alias index="10" name="Lithology" field="layerrocktype"/>
    <alias index="11" name="Event Process" field="layergenesisprocess"/>
    <alias index="12" name="Event Enviroment" field="layergenesisenviroment"/>
    <alias index="13" name="Genesys Process State" field="layergenesisprocessstate"/>
    <alias index="14" name="Is a Layer" field="profileelementtype"/>
    <alias index="15" name="" field="ispartof"/>
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
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" field="id" constraints="3"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" field="guidkey" constraints="2"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="inspireid_localid" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="inspireid_namespace" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="inspireid_versionid" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" field="profileelementdepthrange_uppervalue" constraints="1"/>
    <constraint exp_strength="2" notnull_strength="1" unique_strength="0" field="profileelementdepthrange_lowervalue" constraints="5"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" field="beginlifespanversion" constraints="1"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="endlifespanversion" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" field="layertype" constraints="1"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="layerrocktype" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="layergenesisprocess" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="layergenesisenviroment" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="layergenesisprocessstate" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" field="profileelementtype" constraints="1"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" field="ispartof" constraints="1"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="guidkey"/>
    <constraint desc="" exp="" field="inspireid_localid"/>
    <constraint desc="" exp="" field="inspireid_namespace"/>
    <constraint desc="" exp="" field="inspireid_versionid"/>
    <constraint desc="" exp="" field="profileelementdepthrange_uppervalue"/>
    <constraint desc="" exp="&quot;profileelementdepthrange_uppervalue&quot; &lt;= &quot;profileelementdepthrange_lowervalue&quot; " field="profileelementdepthrange_lowervalue"/>
    <constraint desc="" exp="" field="beginlifespanversion"/>
    <constraint desc="" exp="" field="endlifespanversion"/>
    <constraint desc="" exp="" field="layertype"/>
    <constraint desc="" exp="" field="layerrocktype"/>
    <constraint desc="" exp="" field="layergenesisprocess"/>
    <constraint desc="" exp="" field="layergenesisenviroment"/>
    <constraint desc="" exp="" field="layergenesisprocessstate"/>
    <constraint desc="" exp="" field="profileelementtype"/>
    <constraint desc="" exp="" field="ispartof"/>
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
    <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
      <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
    </labelStyle>
    <attributeEditorField name="id" showLabel="1" index="0" horizontalStretch="0" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="idsoilprofile" showLabel="1" index="-1" horizontalStretch="0" verticalStretch="0">
      <labelStyle overrideLabelFont="1" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="1" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="profileelementtype" showLabel="1" index="14" horizontalStretch="0" verticalStretch="0">
      <labelStyle overrideLabelFont="1" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="1" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer name="INSPIRE ID" showLabel="1" columnCount="1" visibilityExpressionEnabled="0" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="" horizontalStretch="0" verticalStretch="0" type="GroupBox" groupBox="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField name="inspireid_localid" showLabel="1" index="2" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_namespace" showLabel="1" index="3" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_versionid" showLabel="1" index="4" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer name="Limits" showLabel="1" columnCount="1" visibilityExpressionEnabled="0" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="" horizontalStretch="0" verticalStretch="0" type="GroupBox" groupBox="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField name="profileelementdepthrange_uppervalue" showLabel="1" index="5" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="profileelementdepthrange_lowervalue" showLabel="1" index="6" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField name="layerrocktype" showLabel="1" index="10" horizontalStretch="0" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer name="Layer Parameter" showLabel="1" columnCount="1" visibilityExpressionEnabled="1" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="profileelementtype = True" horizontalStretch="0" verticalStretch="0" type="GroupBox" groupBox="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField name="layertype" showLabel="1" index="9" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="layergenesisprocess" showLabel="1" index="11" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="layergenesisenviroment" showLabel="1" index="12" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="layergenesisprocessstate" showLabel="1" index="13" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer name="Dates" showLabel="1" columnCount="1" visibilityExpressionEnabled="0" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="" horizontalStretch="0" verticalStretch="0" type="GroupBox" groupBox="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField name="beginlifespanversion" showLabel="1" index="7" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="endlifespanversion" showLabel="1" index="8" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer name="Particle Size fraction" showLabel="1" columnCount="1" visibilityExpressionEnabled="0" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="" horizontalStretch="0" verticalStretch="0" type="Tab" groupBox="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorRelation forceSuppressFormPopup="0" name="profileelement_particlesizefractiontype" showLabel="0" relation="profileelement_particlesizefractiontype" nmRelationId="" label="" relationWidgetTypeId="relation_editor" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
          <Option name="buttons" value="AllButtons" type="QString"/>
          <Option name="show_first_feature" value="true" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer name="FAO Horizon Notation Type" showLabel="1" columnCount="1" visibilityExpressionEnabled="1" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="profileelementtype = false" horizontalStretch="0" verticalStretch="0" type="Tab" groupBox="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorRelation forceSuppressFormPopup="0" name="profileelement_faohorizonnotationtype" showLabel="0" relation="profileelement_faohorizonnotationtype" nmRelationId="" label="" relationWidgetTypeId="relation_editor" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
          <Option name="buttons" value="AllButtons" type="QString"/>
          <Option name="show_first_feature" value="true" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer name="Other Horizon Notation Type" showLabel="1" columnCount="1" visibilityExpressionEnabled="1" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="profileelementtype = false" horizontalStretch="0" verticalStretch="0" type="Tab" groupBox="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorRelation forceSuppressFormPopup="0" name="profileelement_otherhorizonnotationtype" showLabel="0" relation="profileelement_otherhorizonnotationtype" nmRelationId="" label="" relationWidgetTypeId="relation_editor" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
          <Option name="buttons" value="AllButtons" type="QString"/>
          <Option name="show_first_feature" value="true" type="bool"/>
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
