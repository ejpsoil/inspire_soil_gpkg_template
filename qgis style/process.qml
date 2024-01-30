<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="documentcitation_process" providerKey="ogr" referencedLayer="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" layerName="documentcitation" name="documentcitation_process" dataSource="./INSPIRE_Selection_4.gpkg|layername=documentcitation" referencingLayer="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" layerId="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="iddocumentcitation2"/>
    </relation>
    <relation id="documentcitation_process_2" providerKey="ogr" referencedLayer="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" layerName="documentcitation" name="documentcitation_process_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=documentcitation" referencingLayer="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" layerId="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="iddocumentcitation1"/>
    </relation>
    <relation id="relatedparty_process_3" providerKey="ogr" referencedLayer="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" layerName="relatedparty" name="relatedparty_process_3" dataSource="./INSPIRE_Selection_4.gpkg|layername=relatedparty" referencingLayer="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" layerId="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idrelatedparty2"/>
    </relation>
    <relation id="relatedparty_process_4" providerKey="ogr" referencedLayer="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" layerName="relatedparty" name="relatedparty_process_4" dataSource="./INSPIRE_Selection_4.gpkg|layername=relatedparty" referencingLayer="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" layerId="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" strength="Association">
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
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="description">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="type">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idrelatedparty1">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=relatedparty" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" name="ReferencedLayerId" type="QString"/>
            <Option value="relatedparty" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="relatedparty_process_4" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idrelatedparty2">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=relatedparty" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="relatedparty_15f394ef_43cd_44d2_99e6_6dbcee041171" name="ReferencedLayerId" type="QString"/>
            <Option value="relatedparty" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="relatedparty_process_3" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iddocumentcitation1">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=documentcitation" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" name="ReferencedLayerId" type="QString"/>
            <Option value="documentcitation" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="documentcitation_process_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iddocumentcitation2">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=documentcitation" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="documentcitation_f547b78e_ac4c_4b31_8ea4_fd313135ed2c" name="ReferencedLayerId" type="QString"/>
            <Option value="documentcitation" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="documentcitation_process" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
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
    <alias index="5" name="" field="name"/>
    <alias index="6" name="" field="description"/>
    <alias index="7" name="" field="type"/>
    <alias index="8" name="Related Party" field="idrelatedparty1"/>
    <alias index="9" name="Related Party 2" field="idrelatedparty2"/>
    <alias index="10" name="Document Citation" field="iddocumentcitation1"/>
    <alias index="11" name="Document Citation 2" field="iddocumentcitation2"/>
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
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="inspireid_localid"/>
    <default applyOnUpdate="0" expression="" field="inspireid_namespace"/>
    <default applyOnUpdate="0" expression="" field="inspireid_versionid"/>
    <default applyOnUpdate="0" expression="" field="name"/>
    <default applyOnUpdate="0" expression="" field="description"/>
    <default applyOnUpdate="0" expression="" field="type"/>
    <default applyOnUpdate="0" expression="" field="idrelatedparty1"/>
    <default applyOnUpdate="0" expression="" field="idrelatedparty2"/>
    <default applyOnUpdate="0" expression="" field="iddocumentcitation1"/>
    <default applyOnUpdate="0" expression="" field="iddocumentcitation2"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="inspireid_localid"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="inspireid_namespace"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="inspireid_versionid"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="name"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="description"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="type"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idrelatedparty1"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="idrelatedparty2"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="iddocumentcitation1"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="iddocumentcitation2"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="inspireid_localid"/>
    <constraint exp="" desc="" field="inspireid_namespace"/>
    <constraint exp="" desc="" field="inspireid_versionid"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="description"/>
    <constraint exp="" desc="" field="type"/>
    <constraint exp="" desc="" field="idrelatedparty1"/>
    <constraint exp="" desc="" field="idrelatedparty2"/>
    <constraint exp="" desc="" field="iddocumentcitation1"/>
    <constraint exp="" desc="" field="iddocumentcitation2"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="0" name="id" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="INSPIRE ID" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="2" name="inspireid_localid" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="3" name="inspireid_namespace" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="4" name="inspireid_versionid" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="5" name="name" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="6" name="description" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="7" name="type" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Related Party" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" index="8" name="idrelatedparty1" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="0" index="9" name="idrelatedparty2" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Document Citation" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" index="10" name="iddocumentcitation1" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="0" index="11" name="iddocumentcitation2" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
    <field reuseLastValue="0" name="description"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="iddocumentcitation1"/>
    <field reuseLastValue="0" name="iddocumentcitation2"/>
    <field reuseLastValue="0" name="idrelatedparty1"/>
    <field reuseLastValue="0" name="idrelatedparty2"/>
    <field reuseLastValue="0" name="inspireid_localid"/>
    <field reuseLastValue="0" name="inspireid_namespace"/>
    <field reuseLastValue="0" name="inspireid_versionid"/>
    <field reuseLastValue="0" name="name"/>
    <field reuseLastValue="0" name="type"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
