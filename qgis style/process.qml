<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation name="documentcitation_process" providerKey="ogr" id="documentcitation_process" strength="Association" dataSource="./Python_Test.gpkg|layername=documentcitation" referencedLayer="documentcitation_7bdd83be_95f3_4736_8b44_bdbf8d357a3c" layerId="documentcitation_7bdd83be_95f3_4736_8b44_bdbf8d357a3c" referencingLayer="process_23086fd7_cc0a_4797_958f_7308949ff729" layerName="documentcitation">
      <fieldRef referencedField="guidkey" referencingField="iddocumentcitation2"/>
    </relation>
    <relation name="documentcitation_process_2" providerKey="ogr" id="documentcitation_process_2" strength="Association" dataSource="./Python_Test.gpkg|layername=documentcitation" referencedLayer="documentcitation_7bdd83be_95f3_4736_8b44_bdbf8d357a3c" layerId="documentcitation_7bdd83be_95f3_4736_8b44_bdbf8d357a3c" referencingLayer="process_23086fd7_cc0a_4797_958f_7308949ff729" layerName="documentcitation">
      <fieldRef referencedField="guidkey" referencingField="iddocumentcitation1"/>
    </relation>
    <relation name="relatedparty_process_3" providerKey="ogr" id="relatedparty_process_3" strength="Association" dataSource="./Python_Test.gpkg|layername=relatedparty" referencedLayer="relatedparty_0ba1b03b_2a59_4996_abde_f9cc588f30b3" layerId="relatedparty_0ba1b03b_2a59_4996_abde_f9cc588f30b3" referencingLayer="process_23086fd7_cc0a_4797_958f_7308949ff729" layerName="relatedparty">
      <fieldRef referencedField="guidkey" referencingField="idrelatedparty2"/>
    </relation>
    <relation name="relatedparty_process_4" providerKey="ogr" id="relatedparty_process_4" strength="Association" dataSource="./Python_Test.gpkg|layername=relatedparty" referencedLayer="relatedparty_0ba1b03b_2a59_4996_abde_f9cc588f30b3" layerId="relatedparty_0ba1b03b_2a59_4996_abde_f9cc588f30b3" referencingLayer="process_23086fd7_cc0a_4797_958f_7308949ff729" layerName="relatedparty">
      <fieldRef referencedField="guidkey" referencingField="idrelatedparty1"/>
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
    <field name="name" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="description" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="type" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idrelatedparty1" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage_Soil_Import/Geop_TEST/Python_Test.gpkg|layername=relatedparty" type="QString"/>
            <Option name="ReferencedLayerId" value="relatedparty_0ba1b03b_2a59_4996_abde_f9cc588f30b3" type="QString"/>
            <Option name="ReferencedLayerName" value="relatedparty" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="relatedparty_process_4" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idrelatedparty2" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="true" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage_Soil_Import/Geop_TEST/Python_Test.gpkg|layername=relatedparty" type="QString"/>
            <Option name="ReferencedLayerId" value="relatedparty_0ba1b03b_2a59_4996_abde_f9cc588f30b3" type="QString"/>
            <Option name="ReferencedLayerName" value="relatedparty" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="relatedparty_process_3" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="iddocumentcitation1" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="true" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage_Soil_Import/Geop_TEST/Python_Test.gpkg|layername=documentcitation" type="QString"/>
            <Option name="ReferencedLayerId" value="documentcitation_7bdd83be_95f3_4736_8b44_bdbf8d357a3c" type="QString"/>
            <Option name="ReferencedLayerName" value="documentcitation" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="documentcitation_process_2" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="iddocumentcitation2" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="true" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage_Soil_Import/Geop_TEST/Python_Test.gpkg|layername=documentcitation" type="QString"/>
            <Option name="ReferencedLayerId" value="documentcitation_7bdd83be_95f3_4736_8b44_bdbf8d357a3c" type="QString"/>
            <Option name="ReferencedLayerName" value="documentcitation" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="documentcitation_process" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="id" index="0"/>
    <alias name="" field="guidkey" index="1"/>
    <alias name="Local id" field="inspireid_localid" index="2"/>
    <alias name="Namespace" field="inspireid_namespace" index="3"/>
    <alias name="Version id" field="inspireid_versionid" index="4"/>
    <alias name="" field="name" index="5"/>
    <alias name="" field="description" index="6"/>
    <alias name="" field="type" index="7"/>
    <alias name="Related Party" field="idrelatedparty1" index="8"/>
    <alias name="Related Party 2" field="idrelatedparty2" index="9"/>
    <alias name="Document Citation" field="iddocumentcitation1" index="10"/>
    <alias name="Document Citation 2" field="iddocumentcitation2" index="11"/>
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
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="guidkey" expression="" applyOnUpdate="0"/>
    <default field="inspireid_localid" expression="" applyOnUpdate="0"/>
    <default field="inspireid_namespace" expression="" applyOnUpdate="0"/>
    <default field="inspireid_versionid" expression="" applyOnUpdate="0"/>
    <default field="name" expression="" applyOnUpdate="0"/>
    <default field="description" expression="" applyOnUpdate="0"/>
    <default field="type" expression="" applyOnUpdate="0"/>
    <default field="idrelatedparty1" expression="" applyOnUpdate="0"/>
    <default field="idrelatedparty2" expression="" applyOnUpdate="0"/>
    <default field="iddocumentcitation1" expression="" applyOnUpdate="0"/>
    <default field="iddocumentcitation2" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" field="id" unique_strength="1" exp_strength="0"/>
    <constraint constraints="2" notnull_strength="0" field="guidkey" unique_strength="1" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="inspireid_localid" unique_strength="0" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="inspireid_namespace" unique_strength="0" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="inspireid_versionid" unique_strength="0" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="name" unique_strength="0" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="description" unique_strength="0" exp_strength="0"/>
    <constraint constraints="1" notnull_strength="1" field="type" unique_strength="0" exp_strength="0"/>
    <constraint constraints="1" notnull_strength="1" field="idrelatedparty1" unique_strength="0" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="idrelatedparty2" unique_strength="0" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="iddocumentcitation1" unique_strength="0" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" field="iddocumentcitation2" unique_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="guidkey" exp=""/>
    <constraint desc="" field="inspireid_localid" exp=""/>
    <constraint desc="" field="inspireid_namespace" exp=""/>
    <constraint desc="" field="inspireid_versionid" exp=""/>
    <constraint desc="" field="name" exp=""/>
    <constraint desc="" field="description" exp=""/>
    <constraint desc="" field="type" exp=""/>
    <constraint desc="" field="idrelatedparty1" exp=""/>
    <constraint desc="" field="idrelatedparty2" exp=""/>
    <constraint desc="" field="iddocumentcitation1" exp=""/>
    <constraint desc="" field="iddocumentcitation2" exp=""/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
    </labelStyle>
    <attributeEditorField name="id" verticalStretch="0" horizontalStretch="0" index="0" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer name="INSPIRE ID" verticalStretch="0" collapsedExpression="" groupBox="1" collapsedExpressionEnabled="0" visibilityExpression="" collapsed="0" visibilityExpressionEnabled="0" type="GroupBox" horizontalStretch="0" showLabel="1" columnCount="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
      </labelStyle>
      <attributeEditorField name="inspireid_localid" verticalStretch="0" horizontalStretch="0" index="2" showLabel="1">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_namespace" verticalStretch="0" horizontalStretch="0" index="3" showLabel="1">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_versionid" verticalStretch="0" horizontalStretch="0" index="4" showLabel="1">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField name="name" verticalStretch="0" horizontalStretch="0" index="5" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="description" verticalStretch="0" horizontalStretch="0" index="6" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="type" verticalStretch="0" horizontalStretch="0" index="7" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer name="Related Party" verticalStretch="0" collapsedExpression="" groupBox="1" collapsedExpressionEnabled="0" visibilityExpression="" collapsed="0" visibilityExpressionEnabled="0" type="GroupBox" horizontalStretch="0" showLabel="1" columnCount="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
      </labelStyle>
      <attributeEditorField name="idrelatedparty1" verticalStretch="0" horizontalStretch="0" index="8" showLabel="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="idrelatedparty2" verticalStretch="0" horizontalStretch="0" index="9" showLabel="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer name="Document Citation" verticalStretch="0" collapsedExpression="" groupBox="1" collapsedExpressionEnabled="0" visibilityExpression="" collapsed="0" visibilityExpressionEnabled="0" type="GroupBox" horizontalStretch="0" showLabel="1" columnCount="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
      </labelStyle>
      <attributeEditorField name="iddocumentcitation1" verticalStretch="0" horizontalStretch="0" index="10" showLabel="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="iddocumentcitation2" verticalStretch="0" horizontalStretch="0" index="11" showLabel="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" underline="0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="description" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="iddocumentcitation1" editable="1"/>
    <field name="iddocumentcitation2" editable="1"/>
    <field name="idrelatedparty1" editable="1"/>
    <field name="idrelatedparty2" editable="1"/>
    <field name="inspireid_localid" editable="1"/>
    <field name="inspireid_namespace" editable="1"/>
    <field name="inspireid_versionid" editable="1"/>
    <field name="name" editable="1"/>
    <field name="type" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="description" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="iddocumentcitation1" labelOnTop="0"/>
    <field name="iddocumentcitation2" labelOnTop="0"/>
    <field name="idrelatedparty1" labelOnTop="0"/>
    <field name="idrelatedparty2" labelOnTop="0"/>
    <field name="inspireid_localid" labelOnTop="0"/>
    <field name="inspireid_namespace" labelOnTop="0"/>
    <field name="inspireid_versionid" labelOnTop="0"/>
    <field name="name" labelOnTop="0"/>
    <field name="type" labelOnTop="0"/>
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
