<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencingLayer="profileelement_eb6bed83_91c6_4b85_baa7_bbb9469e94e0" layerName="soilprofile" strength="Association" name="soilprofile_profileelement" referencedLayer="soilprofile_4533a9b5_5d1e_4a04_a667_5768367b31b7" dataSource="./INSPIRE_SO_07.gpkg|layername=soilprofile" layerId="soilprofile_4533a9b5_5d1e_4a04_a667_5768367b31b7" providerKey="ogr" id="soilprofile_profileelement">
      <fieldRef referencedField="guidkey" referencingField="ispartof"/>
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
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_localid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_namespace" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_versionid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementdepthrange_uppervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementdepthrange_lowervalue" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="beginlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="allow_null"/>
            <Option value="true" type="bool" name="calendar_popup"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="display_format"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="field_format"/>
            <Option value="false" type="bool" name="field_format_overwrite"/>
            <Option value="false" type="bool" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="endlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="true" type="bool" name="allow_null"/>
            <Option value="true" type="bool" name="calendar_popup"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="display_format"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="field_format"/>
            <Option value="false" type="bool" name="field_format_overwrite"/>
            <Option value="false" type="bool" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layertype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="true" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('LayerTypeValue') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layerrocktype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="true" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('LithologyValue') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layergenesisprocess" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="true" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('EventProcessValue') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layergenesisenviroment" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="true" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('EventEnvironmentValue') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layergenesisprocessstate" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="true" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('LayerGenesisProcessStateValue') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profileelementtype" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option value="" type="QString" name="CheckedState"/>
            <Option value="0" type="int" name="TextDisplayMethod"/>
            <Option value="" type="QString" name="UncheckedState"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="ispartof" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="true" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=soilprofile" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilprofile_4533a9b5_5d1e_4a04_a667_5768367b31b7" type="QString" name="ReferencedLayerId"/>
            <Option value="soilprofile" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilprofile_profileelement" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
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
    <alias field="ispartof" name="Is a part of" index="15"/>
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
    <policy field="ispartof" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="id"/>
    <default expression="" applyOnUpdate="0" field="guidkey"/>
    <default expression="" applyOnUpdate="0" field="inspireid_localid"/>
    <default expression="" applyOnUpdate="0" field="inspireid_namespace"/>
    <default expression="" applyOnUpdate="0" field="inspireid_versionid"/>
    <default expression="" applyOnUpdate="0" field="profileelementdepthrange_uppervalue"/>
    <default expression="" applyOnUpdate="0" field="profileelementdepthrange_lowervalue"/>
    <default expression="" applyOnUpdate="0" field="beginlifespanversion"/>
    <default expression="" applyOnUpdate="0" field="endlifespanversion"/>
    <default expression="" applyOnUpdate="0" field="layertype"/>
    <default expression="" applyOnUpdate="0" field="layerrocktype"/>
    <default expression="" applyOnUpdate="0" field="layergenesisprocess"/>
    <default expression="" applyOnUpdate="0" field="layergenesisenviroment"/>
    <default expression="" applyOnUpdate="0" field="layergenesisprocessstate"/>
    <default expression="" applyOnUpdate="0" field="profileelementtype"/>
    <default expression="" applyOnUpdate="0" field="ispartof"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="1" field="id" constraints="3"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="1" field="guidkey" constraints="2"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="inspireid_localid" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="inspireid_namespace" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="inspireid_versionid" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="profileelementdepthrange_uppervalue" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="2" unique_strength="0" field="profileelementdepthrange_lowervalue" constraints="4"/>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="0" field="beginlifespanversion" constraints="1"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="endlifespanversion" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="layertype" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="layerrocktype" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="layergenesisprocess" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="layergenesisenviroment" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="layergenesisprocessstate" constraints="0"/>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="0" field="profileelementtype" constraints="1"/>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="0" field="ispartof" constraints="1"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="inspireid_localid"/>
    <constraint exp="" desc="" field="inspireid_namespace"/>
    <constraint exp="" desc="" field="inspireid_versionid"/>
    <constraint exp="" desc="" field="profileelementdepthrange_uppervalue"/>
    <constraint exp="&quot;profileelementdepthrange_uppervalue&quot; &lt;= &quot;profileelementdepthrange_lowervalue&quot; or   &quot;profileelementdepthrange_lowervalue&quot; is Null or  &quot;profileelementdepthrange_uppervalue&quot; is Null" desc="" field="profileelementdepthrange_lowervalue"/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="id" index="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="ispartof" index="15">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="profileelementtype" index="14">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="1">
        <labelFont description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" italic="0" bold="1" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="INSPIRE ID">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="inspireid_localid" index="2">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="inspireid_namespace" index="3">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="inspireid_versionid" index="4">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Limits">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="profileelementdepthrange_uppervalue" index="5">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="profileelementdepthrange_lowervalue" index="6">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="1" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="profileelementtype = True" name="Layer Parameters">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="layertype" index="9">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="1" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression=" &quot;layertype&quot; ='http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic'" name="Processes geogenetic">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="layerrocktype" index="10">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="layergenesisprocess" index="11">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="layergenesisenviroment" index="12">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="layergenesisprocessstate" index="13">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Dates">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="beginlifespanversion" index="7">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="endlifespanversion" index="8">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Tab" showLabel="1" columnCount="1" groupBox="0" visibilityExpression="" name="Particle Size fraction">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="profileelement_particlesizefractiontype" relationWidgetTypeId="relation_editor" relation="profileelement_particlesizefractiontype">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="1" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Tab" showLabel="1" columnCount="1" groupBox="0" visibilityExpression="profileelementtype = false" name="FAO Horizon Notation Type">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="profileelement_faohorizonnotationtype" relationWidgetTypeId="relation_editor" relation="profileelement_faohorizonnotationtype">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="1" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Tab" showLabel="1" columnCount="1" groupBox="0" visibilityExpression="profileelementtype = false" name="Other Horizon Notation Type">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="profileelement_otherhorizon_profileelement_2" relationWidgetTypeId="relation_editor" relation="profileelement_otherhorizon_profileelement_2">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="RELATIONS">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorContainer horizontalStretch="0" collapsed="1" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Datastream">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="profileelement_datastream_6" relationWidgetTypeId="relation_editor" relation="profileelement_datastream_6">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
            <Option value="AllButtons" type="QString" name="buttons"/>
            <Option value="true" type="bool" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="beginlifespanversion"/>
    <field editable="1" name="endlifespanversion"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="idsoilprofile"/>
    <field editable="1" name="inspireid_localid"/>
    <field editable="1" name="inspireid_namespace"/>
    <field editable="1" name="inspireid_versionid"/>
    <field editable="1" name="ispartof"/>
    <field editable="1" name="layergenesisenviroment"/>
    <field editable="1" name="layergenesisprocess"/>
    <field editable="1" name="layergenesisprocessstate"/>
    <field editable="1" name="layerrocktype"/>
    <field editable="1" name="layertype"/>
    <field editable="1" name="profileelementdepthrange_lowervalue"/>
    <field editable="1" name="profileelementdepthrange_uppervalue"/>
    <field editable="1" name="profileelementtype"/>
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
    <field reuseLastValue="0" name="beginlifespanversion"/>
    <field reuseLastValue="0" name="endlifespanversion"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idsoilprofile"/>
    <field reuseLastValue="0" name="inspireid_localid"/>
    <field reuseLastValue="0" name="inspireid_namespace"/>
    <field reuseLastValue="0" name="inspireid_versionid"/>
    <field reuseLastValue="0" name="ispartof"/>
    <field reuseLastValue="0" name="layergenesisenviroment"/>
    <field reuseLastValue="0" name="layergenesisprocess"/>
    <field reuseLastValue="0" name="layergenesisprocessstate"/>
    <field reuseLastValue="0" name="layerrocktype"/>
    <field reuseLastValue="0" name="layertype"/>
    <field reuseLastValue="0" name="profileelementdepthrange_lowervalue"/>
    <field reuseLastValue="0" name="profileelementdepthrange_uppervalue"/>
    <field reuseLastValue="0" name="profileelementtype"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "inspireid_localid", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
