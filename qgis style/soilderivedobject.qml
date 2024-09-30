<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <renderer-v2 enableorderby="0" forceraster="0" type="singleSymbol" referencescale="-1" symbollevels="0">
    <symbols>
      <symbol clip_to_extent="1" frame_rate="10" type="fill" alpha="1" name="0" force_rhr="0" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </data_defined_properties>
        <layer pass="0" locked="0" class="SimpleFill" enabled="1" id="{c784b414-fc10-4ba7-80cc-f5888a2bb8c0}">
          <Option type="Map">
            <Option value="3x:0,0,0,0,0,0" type="QString" name="border_width_map_unit_scale"/>
            <Option value="190,178,151,255" type="QString" name="color"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="123,123,123,255" type="QString" name="outline_color"/>
            <Option value="dash" type="QString" name="outline_style"/>
            <Option value="0.26" type="QString" name="outline_width"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="no" type="QString" name="style"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <referencedLayers/>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
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
    <field name="accessuri" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
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
    <alias field="accessuri" name="Uri" index="5"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="Duplicate"/>
    <policy field="inspireid_localid" policy="Duplicate"/>
    <policy field="inspireid_namespace" policy="Duplicate"/>
    <policy field="inspireid_versionid" policy="Duplicate"/>
    <policy field="accessuri" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="id"/>
    <default expression="" applyOnUpdate="0" field="guidkey"/>
    <default expression="" applyOnUpdate="0" field="inspireid_localid"/>
    <default expression="" applyOnUpdate="0" field="inspireid_namespace"/>
    <default expression="" applyOnUpdate="0" field="inspireid_versionid"/>
    <default expression="" applyOnUpdate="0" field="accessuri"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="1" field="id" constraints="3"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="1" field="guidkey" constraints="2"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="inspireid_localid" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="inspireid_namespace" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="inspireid_versionid" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="accessuri" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="inspireid_localid"/>
    <constraint exp="" desc="" field="inspireid_namespace"/>
    <constraint exp="" desc="" field="inspireid_versionid"/>
    <constraint exp="" desc="" field="accessuri"/>
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
      <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="id" index="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
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
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="accessuri" index="5">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Tab" showLabel="1" columnCount="1" groupBox="0" visibilityExpression="" name="Based On Observed Soil Profile">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="soilderivedobject_isbasedonobservedsoilprofile_2" relationWidgetTypeId="relation_editor" relation="soilderivedobject_isbasedonobservedsoilprofile_2">
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
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Tab" showLabel="1" columnCount="1" groupBox="0" visibilityExpression="" name="Based On Soil Body">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="soilderivedobject_isbasedonsoilbody_2" relationWidgetTypeId="relation_editor" relation="soilderivedobject_isbasedonsoilbody_2">
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
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Tab" showLabel="1" columnCount="1" groupBox="0" visibilityExpression="" name="Based On Soil Derived Object">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="soilderivedobject_isbasedonsoilderivedobject" relationWidgetTypeId="relation_editor" relation="soilderivedobject_isbasedonsoilderivedobject">
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
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name=" RELATIONS">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorContainer horizontalStretch="0" collapsed="1" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Datastream">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" label="" nmRelationId="" showLabel="0" name="soilderivedobject_datastream_7" relationWidgetTypeId="relation_editor" relation="soilderivedobject_datastream_7">
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
    <field editable="1" name="accessuri"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="inspireid_localid"/>
    <field editable="1" name="inspireid_namespace"/>
    <field editable="1" name="inspireid_versionid"/>
  </editable>
  <labelOnTop>
    <field name="accessuri" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="inspireid_localid" labelOnTop="0"/>
    <field name="inspireid_namespace" labelOnTop="0"/>
    <field name="inspireid_versionid" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="accessuri"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="inspireid_localid"/>
    <field reuseLastValue="0" name="inspireid_namespace"/>
    <field reuseLastValue="0" name="inspireid_versionid"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="soilderivedobject_isbasedonobservedsoilprofile_2">
      <config type="Map">
        <Option value="false" type="bool" name="force-suppress-popup"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="soilderivedobject_isbasedonsoilbody_2">
      <config type="Map">
        <Option value="false" type="bool" name="force-suppress-popup"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="soilderivedobject_isbasedonsoilderivedobject">
      <config type="Map">
        <Option value="false" type="bool" name="force-suppress-popup"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="soilderivedobject_isbasedonsoilderivedobject_2">
      <config type="Map">
        <Option value="false" type="bool" name="force-suppress-popup"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>COALESCE( "inspireid_localid", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>2</layerGeometryType>
</qgis>
