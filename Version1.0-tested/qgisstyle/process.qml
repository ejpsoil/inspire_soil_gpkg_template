<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="documentcitation_49b20ae3_774c_4190_9901_bdb1ee450570" layerId="documentcitation_49b20ae3_774c_4190_9901_bdb1ee450570" referencingLayer="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" providerKey="ogr" layerName="documentcitation" strength="Association" name="documentcitation_process" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=documentcitation" id="documentcitation_process">
      <fieldRef referencedField="guidkey" referencingField="iddocumentcitation2"/>
    </relation>
    <relation referencedLayer="documentcitation_49b20ae3_774c_4190_9901_bdb1ee450570" layerId="documentcitation_49b20ae3_774c_4190_9901_bdb1ee450570" referencingLayer="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" providerKey="ogr" layerName="documentcitation" strength="Association" name="documentcitation_process_2" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=documentcitation" id="documentcitation_process_2">
      <fieldRef referencedField="guidkey" referencingField="iddocumentcitation1"/>
    </relation>
    <relation referencedLayer="relatedparty_9df29c5a_0f14_4dab_86d9_b31f622bb4e7" layerId="relatedparty_9df29c5a_0f14_4dab_86d9_b31f622bb4e7" referencingLayer="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" providerKey="ogr" layerName="relatedparty" strength="Association" name="relatedparty_process_3" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=relatedparty" id="relatedparty_process_3">
      <fieldRef referencedField="guidkey" referencingField="idrelatedparty2"/>
    </relation>
    <relation referencedLayer="relatedparty_9df29c5a_0f14_4dab_86d9_b31f622bb4e7" layerId="relatedparty_9df29c5a_0f14_4dab_86d9_b31f622bb4e7" referencingLayer="process_112ea255_7362_495d_a45e_8fa6ff4f13ba" providerKey="ogr" layerName="relatedparty" strength="Association" name="relatedparty_process_4" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=relatedparty" id="relatedparty_process_4">
      <fieldRef referencedField="guidkey" referencingField="idrelatedparty1"/>
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
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="description">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="type">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idrelatedparty1">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=relatedparty" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" type="QString" name="ReferencedLayerId"/>
            <Option value="relatedparty" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="relatedparty_process_4" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idrelatedparty2">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=relatedparty" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" type="QString" name="ReferencedLayerId"/>
            <Option value="relatedparty" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="relatedparty_process_3" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iddocumentcitation1">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=documentcitation" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" type="QString" name="ReferencedLayerId"/>
            <Option value="documentcitation" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="documentcitation_process_2" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iddocumentcitation2">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=documentcitation" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" type="QString" name="ReferencedLayerId"/>
            <Option value="documentcitation" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="documentcitation_process" type="QString" name="Relation"/>
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
    <alias field="inspireid_localid" name="Local id" index="2"/>
    <alias field="inspireid_namespace" name="Namespace" index="3"/>
    <alias field="inspireid_versionid" name="Version id" index="4"/>
    <alias field="name" name="" index="5"/>
    <alias field="description" name="" index="6"/>
    <alias field="type" name="" index="7"/>
    <alias field="idrelatedparty1" name="Related Party" index="8"/>
    <alias field="idrelatedparty2" name="Related Party 2" index="9"/>
    <alias field="iddocumentcitation1" name="Document Citation" index="10"/>
    <alias field="iddocumentcitation2" name="Document Citation 2" index="11"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="inspireid_localid"/>
    <policy policy="DefaultValue" field="inspireid_namespace"/>
    <policy policy="DefaultValue" field="inspireid_versionid"/>
    <policy policy="DefaultValue" field="name"/>
    <policy policy="DefaultValue" field="description"/>
    <policy policy="DefaultValue" field="type"/>
    <policy policy="DefaultValue" field="idrelatedparty1"/>
    <policy policy="DefaultValue" field="idrelatedparty2"/>
    <policy policy="DefaultValue" field="iddocumentcitation1"/>
    <policy policy="DefaultValue" field="iddocumentcitation2"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="guidkey" applyOnUpdate="0"/>
    <default expression="" field="inspireid_localid" applyOnUpdate="0"/>
    <default expression="" field="inspireid_namespace" applyOnUpdate="0"/>
    <default expression="" field="inspireid_versionid" applyOnUpdate="0"/>
    <default expression="" field="name" applyOnUpdate="0"/>
    <default expression="" field="description" applyOnUpdate="0"/>
    <default expression="" field="type" applyOnUpdate="0"/>
    <default expression="" field="idrelatedparty1" applyOnUpdate="0"/>
    <default expression="" field="idrelatedparty2" applyOnUpdate="0"/>
    <default expression="" field="iddocumentcitation1" applyOnUpdate="0"/>
    <default expression="" field="iddocumentcitation2" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="guidkey" unique_strength="1" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="inspireid_localid" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="inspireid_namespace" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="inspireid_versionid" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="name" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="description" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="type" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="idrelatedparty1" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="idrelatedparty2" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="iddocumentcitation1" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="iddocumentcitation2" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="guidkey" desc="" exp=""/>
    <constraint field="inspireid_localid" desc="" exp=""/>
    <constraint field="inspireid_namespace" desc="" exp=""/>
    <constraint field="inspireid_versionid" desc="" exp=""/>
    <constraint field="name" desc="" exp=""/>
    <constraint field="description" desc="" exp=""/>
    <constraint field="type" desc="" exp=""/>
    <constraint field="idrelatedparty1" desc="" exp=""/>
    <constraint field="idrelatedparty2" desc="" exp=""/>
    <constraint field="iddocumentcitation1" desc="" exp=""/>
    <constraint field="iddocumentcitation2" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGIS forms can have a Python function that is called when the form is
opened.

Use this function to add extra logic to your forms.

Enter the name of the function in the "Python Init function"
field.
An example follows:
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
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="id" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="INSPIRE ID" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="inspireid_localid" index="2">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="inspireid_namespace" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="inspireid_versionid" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="name" index="5">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="description" index="6">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="type" index="7">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Related Party" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" horizontalStretch="0" verticalStretch="0" name="idrelatedparty1" index="8">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="0" horizontalStretch="0" verticalStretch="0" name="idrelatedparty2" index="9">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Document Citation" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" horizontalStretch="0" verticalStretch="0" name="iddocumentcitation1" index="10">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="0" horizontalStretch="0" verticalStretch="0" name="iddocumentcitation2" index="11">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="description"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="iddocumentcitation1"/>
    <field editable="1" name="iddocumentcitation2"/>
    <field editable="1" name="idrelatedparty1"/>
    <field editable="1" name="idrelatedparty2"/>
    <field editable="1" name="inspireid_localid"/>
    <field editable="1" name="inspireid_namespace"/>
    <field editable="1" name="inspireid_versionid"/>
    <field editable="1" name="name"/>
    <field editable="1" name="type"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="iddocumentcitation1"/>
    <field labelOnTop="0" name="iddocumentcitation2"/>
    <field labelOnTop="0" name="idrelatedparty1"/>
    <field labelOnTop="0" name="idrelatedparty2"/>
    <field labelOnTop="0" name="inspireid_localid"/>
    <field labelOnTop="0" name="inspireid_namespace"/>
    <field labelOnTop="0" name="inspireid_versionid"/>
    <field labelOnTop="0" name="name"/>
    <field labelOnTop="0" name="type"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="description" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="iddocumentcitation1" reuseLastValue="0"/>
    <field name="iddocumentcitation2" reuseLastValue="0"/>
    <field name="idrelatedparty1" reuseLastValue="0"/>
    <field name="idrelatedparty2" reuseLastValue="0"/>
    <field name="inspireid_localid" reuseLastValue="0"/>
    <field name="inspireid_namespace" reuseLastValue="0"/>
    <field name="inspireid_versionid" reuseLastValue="0"/>
    <field name="name" reuseLastValue="0"/>
    <field name="type" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
