<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation strength="Association" referencingLayer="profileelement_0b05668d_30a5_42b6_a5bd_215f15670759" referencedLayer="soilprofile_b6d09b5f_42f3_40ac_b072_29d46030c2f0" layerName="soilprofile" layerId="soilprofile_b6d09b5f_42f3_40ac_b072_29d46030c2f0" providerKey="ogr" id="soilprofile_profileelement" name="soilprofile_profileelement" dataSource="./INSPIRE_SO.gpkg|layername=soilprofile">
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
            <Option type="QString" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" name="LayerSource"/>
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
            <Option type="QString" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" name="LayerSource"/>
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
            <Option type="QString" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" name="LayerSource"/>
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
            <Option type="QString" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" name="LayerSource"/>
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
            <Option type="QString" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" name="LayerSource"/>
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
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=soilprofile" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilprofile_4533a9b5_5d1e_4a04_a667_5768367b31b7" name="ReferencedLayerId"/>
            <Option type="QString" value="soilprofile" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilprofile_profileelement" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="Local id" field="inspireid_localid"/>
    <alias index="3" name="Namespace" field="inspireid_namespace"/>
    <alias index="4" name="Version id" field="inspireid_versionid"/>
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
    <alias index="15" name="Is a part of" field="ispartof"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="inspireid_localid"/>
    <policy policy="DefaultValue" field="inspireid_namespace"/>
    <policy policy="DefaultValue" field="inspireid_versionid"/>
    <policy policy="DefaultValue" field="profileelementdepthrange_uppervalue"/>
    <policy policy="DefaultValue" field="profileelementdepthrange_lowervalue"/>
    <policy policy="DefaultValue" field="beginlifespanversion"/>
    <policy policy="DefaultValue" field="endlifespanversion"/>
    <policy policy="DefaultValue" field="layertype"/>
    <policy policy="DefaultValue" field="layerrocktype"/>
    <policy policy="DefaultValue" field="layergenesisprocess"/>
    <policy policy="DefaultValue" field="layergenesisenviroment"/>
    <policy policy="DefaultValue" field="layergenesisprocessstate"/>
    <policy policy="DefaultValue" field="profileelementtype"/>
    <policy policy="DefaultValue" field="ispartof"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="inspireid_localid"/>
    <default applyOnUpdate="0" expression="" field="inspireid_namespace"/>
    <default applyOnUpdate="0" expression="" field="inspireid_versionid"/>
    <default applyOnUpdate="0" expression="" field="profileelementdepthrange_uppervalue"/>
    <default applyOnUpdate="0" expression="" field="profileelementdepthrange_lowervalue"/>
    <default applyOnUpdate="0" expression="" field="beginlifespanversion"/>
    <default applyOnUpdate="0" expression="" field="endlifespanversion"/>
    <default applyOnUpdate="0" expression="" field="layertype"/>
    <default applyOnUpdate="0" expression="" field="layerrocktype"/>
    <default applyOnUpdate="0" expression="" field="layergenesisprocess"/>
    <default applyOnUpdate="0" expression="" field="layergenesisenviroment"/>
    <default applyOnUpdate="0" expression="" field="layergenesisprocessstate"/>
    <default applyOnUpdate="0" expression="" field="profileelementtype"/>
    <default applyOnUpdate="0" expression="" field="ispartof"/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" exp_strength="0" field="id" unique_strength="1"/>
    <constraint constraints="2" notnull_strength="0" exp_strength="0" field="guidkey" unique_strength="1"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_localid" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_namespace" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_versionid" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="profileelementdepthrange_uppervalue" unique_strength="0"/>
    <constraint constraints="4" notnull_strength="0" exp_strength="2" field="profileelementdepthrange_lowervalue" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="beginlifespanversion" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="endlifespanversion" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="layertype" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="layerrocktype" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="layergenesisprocess" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="layergenesisenviroment" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="layergenesisprocessstate" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="profileelementtype" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="ispartof" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="guidkey"/>
    <constraint desc="" exp="" field="inspireid_localid"/>
    <constraint desc="" exp="" field="inspireid_namespace"/>
    <constraint desc="" exp="" field="inspireid_versionid"/>
    <constraint desc="" exp="" field="profileelementdepthrange_uppervalue"/>
    <constraint desc="" exp="&quot;profileelementdepthrange_uppervalue&quot; &lt;= &quot;profileelementdepthrange_lowervalue&quot; or   &quot;profileelementdepthrange_lowervalue&quot; is Null or  &quot;profileelementdepthrange_uppervalue&quot; is Null" field="profileelementdepthrange_lowervalue"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="0" horizontalStretch="0" name="id" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="15" horizontalStretch="0" name="ispartof" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="14" horizontalStretch="0" name="profileelementtype" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="1" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="INSPIRE ID" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="2" horizontalStretch="0" name="inspireid_localid" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="3" horizontalStretch="0" name="inspireid_namespace" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="4" horizontalStretch="0" name="inspireid_versionid" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Limits" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="5" horizontalStretch="0" name="profileelementdepthrange_uppervalue" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="6" horizontalStretch="0" name="profileelementdepthrange_lowervalue" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="profileelementtype = True" horizontalStretch="0" name="Layer Parameters" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="9" horizontalStretch="0" name="layertype" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;layertype&quot; ='http://inspire.ec.europa.eu/codelist/LayerTypeValue/geogenic'" horizontalStretch="0" name="Processes geogenetic" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" index="10" horizontalStretch="0" name="layerrocktype" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" index="11" horizontalStretch="0" name="layergenesisprocess" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" index="12" horizontalStretch="0" name="layergenesisenviroment" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" index="13" horizontalStretch="0" name="layergenesisprocessstate" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
    </attributeEditorContainer>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Dates" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="7" horizontalStretch="0" name="beginlifespanversion" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="8" horizontalStretch="0" name="endlifespanversion" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" groupBox="0" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Particle Size fraction" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="profileelement_particlesizefractiontype" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="profileelement_particlesizefractiontype" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" groupBox="0" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="profileelementtype = false" horizontalStretch="0" name="FAO Horizon Notation Type" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="profileelement_faohorizonnotationtype" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="profileelement_faohorizonnotationtype" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" groupBox="0" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="profileelementtype = false" horizontalStretch="0" name="Other Horizon Notation Type" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="profileelement_otherhorizon_profileelement_2" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="profileelement_otherhorizon_profileelement_2" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="RELATIONS" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="1" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Datastream" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" relation="profileelement_datastream_6" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="profileelement_datastream_6" nmRelationId="" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
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
    <field labelOnTop="0" name="beginlifespanversion"/>
    <field labelOnTop="0" name="endlifespanversion"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idsoilprofile"/>
    <field labelOnTop="0" name="inspireid_localid"/>
    <field labelOnTop="0" name="inspireid_namespace"/>
    <field labelOnTop="0" name="inspireid_versionid"/>
    <field labelOnTop="0" name="ispartof"/>
    <field labelOnTop="0" name="layergenesisenviroment"/>
    <field labelOnTop="0" name="layergenesisprocess"/>
    <field labelOnTop="0" name="layergenesisprocessstate"/>
    <field labelOnTop="0" name="layerrocktype"/>
    <field labelOnTop="0" name="layertype"/>
    <field labelOnTop="0" name="profileelementdepthrange_lowervalue"/>
    <field labelOnTop="0" name="profileelementdepthrange_uppervalue"/>
    <field labelOnTop="0" name="profileelementtype"/>
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
