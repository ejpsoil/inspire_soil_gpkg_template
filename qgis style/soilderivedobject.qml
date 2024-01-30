<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.34.1-Prizren">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <renderer-v2 symbollevels="0" type="singleSymbol" enableorderby="0" referencescale="-1" forceraster="0">
    <symbols>
      <symbol type="fill" alpha="1" is_animated="0" clip_to_extent="1" force_rhr="0" name="0" frame_rate="10">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" name="name" value=""/>
            <Option name="properties"/>
            <Option type="QString" name="type" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer locked="0" id="{c784b414-fc10-4ba7-80cc-f5888a2bb8c0}" enabled="1" pass="0" class="SimpleFill">
          <Option type="Map">
            <Option type="QString" name="border_width_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            <Option type="QString" name="color" value="190,178,151,255"/>
            <Option type="QString" name="joinstyle" value="bevel"/>
            <Option type="QString" name="offset" value="0,0"/>
            <Option type="QString" name="offset_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            <Option type="QString" name="offset_unit" value="MM"/>
            <Option type="QString" name="outline_color" value="123,123,123,255"/>
            <Option type="QString" name="outline_style" value="dash"/>
            <Option type="QString" name="outline_width" value="0.26"/>
            <Option type="QString" name="outline_width_unit" value="MM"/>
            <Option type="QString" name="style" value="no"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <selection mode="Default">
    <selectionColor invalid="1"/>
    <selectionSymbol>
      <symbol type="fill" alpha="1" is_animated="0" clip_to_extent="1" force_rhr="0" name="" frame_rate="10">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" name="name" value=""/>
            <Option name="properties"/>
            <Option type="QString" name="type" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer locked="0" id="{f2333a10-ea78-46bf-80a7-9563156a763d}" enabled="1" pass="0" class="SimpleFill">
          <Option type="Map">
            <Option type="QString" name="border_width_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            <Option type="QString" name="color" value="0,0,255,255"/>
            <Option type="QString" name="joinstyle" value="bevel"/>
            <Option type="QString" name="offset" value="0,0"/>
            <Option type="QString" name="offset_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            <Option type="QString" name="offset_unit" value="MM"/>
            <Option type="QString" name="outline_color" value="35,35,35,255"/>
            <Option type="QString" name="outline_style" value="solid"/>
            <Option type="QString" name="outline_width" value="0.26"/>
            <Option type="QString" name="outline_width_unit" value="MM"/>
            <Option type="QString" name="style" value="solid"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </selectionSymbol>
  </selection>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <referencedLayers/>
  <fieldConfiguration>
    <field configurationFlags="NoFlag" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="guidkey">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="accessuri">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
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
    <alias index="5" name="Uri" field="accessuri"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="Duplicate" field="guidkey"/>
    <policy policy="Duplicate" field="inspireid_localid"/>
    <policy policy="Duplicate" field="inspireid_namespace"/>
    <policy policy="Duplicate" field="inspireid_versionid"/>
    <policy policy="Duplicate" field="accessuri"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="inspireid_localid"/>
    <default applyOnUpdate="0" expression="" field="inspireid_namespace"/>
    <default applyOnUpdate="0" expression="" field="inspireid_versionid"/>
    <default applyOnUpdate="0" expression="" field="accessuri"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" constraints="3" unique_strength="1" field="id"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="2" unique_strength="1" field="guidkey"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="inspireid_localid"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="inspireid_namespace"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="inspireid_versionid"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="accessuri"/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
    </labelStyle>
    <attributeEditorField verticalStretch="0" index="0" name="id" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" type="GroupBox" verticalStretch="0" collapsedExpressionEnabled="0" name="INSPIRE ID" showLabel="1" horizontalStretch="0" collapsedExpression="" groupBox="1" visibilityExpression="" visibilityExpressionEnabled="0" columnCount="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
      <attributeEditorField verticalStretch="0" index="2" name="inspireid_localid" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" index="3" name="inspireid_namespace" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" index="4" name="inspireid_versionid" showLabel="1" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField verticalStretch="0" index="5" name="accessuri" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" type="Tab" verticalStretch="0" collapsedExpressionEnabled="0" name="Based On Observed Soil Profile" showLabel="1" horizontalStretch="0" collapsedExpression="" groupBox="0" visibilityExpression="" visibilityExpressionEnabled="0" columnCount="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" nmRelationId="" relation="soilderivedobject_isbasedonobservedsoilprofile_2" name="soilderivedobject_isbasedonobservedsoilprofile_2" showLabel="0" horizontalStretch="0" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" name="allow_add_child_feature_with_no_geometry" value="false"/>
          <Option type="QString" name="buttons" value="AllButtons"/>
          <Option type="bool" name="show_first_feature" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" type="Tab" verticalStretch="0" collapsedExpressionEnabled="0" name="Based On Soil Body" showLabel="1" horizontalStretch="0" collapsedExpression="" groupBox="0" visibilityExpression="" visibilityExpressionEnabled="0" columnCount="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" nmRelationId="" relation="soilderivedobject_isbasedonsoilbody_2" name="soilderivedobject_isbasedonsoilbody_2" showLabel="0" horizontalStretch="0" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" name="allow_add_child_feature_with_no_geometry" value="false"/>
          <Option type="QString" name="buttons" value="AllButtons"/>
          <Option type="bool" name="show_first_feature" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" type="Tab" verticalStretch="0" collapsedExpressionEnabled="0" name="Based On Soil Derived Object" showLabel="1" horizontalStretch="0" collapsedExpression="" groupBox="0" visibilityExpression="" visibilityExpressionEnabled="0" columnCount="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" nmRelationId="" relation="soilderivedobject_isbasedonsoilderivedobject" name="soilderivedobject_isbasedonsoilderivedobject" showLabel="0" horizontalStretch="0" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" name="allow_add_child_feature_with_no_geometry" value="false"/>
          <Option type="QString" name="buttons" value="AllButtons"/>
          <Option type="bool" name="show_first_feature" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" type="Tab" verticalStretch="0" collapsedExpressionEnabled="0" name="Datastream" showLabel="1" horizontalStretch="0" collapsedExpression="" groupBox="0" visibilityExpression="" visibilityExpressionEnabled="0" columnCount="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" nmRelationId="" relation="soilderivedobject_datastream_7" name="soilderivedobject_datastream_7" showLabel="1" horizontalStretch="0" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" italic="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" name="allow_add_child_feature_with_no_geometry" value="false"/>
          <Option type="QString" name="buttons" value="AllButtons"/>
          <Option type="bool" name="show_first_feature" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
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
    <field name="accessuri" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="inspireid_localid" reuseLastValue="0"/>
    <field name="inspireid_namespace" reuseLastValue="0"/>
    <field name="inspireid_versionid" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="soilderivedobject_isbasedonobservedsoilprofile_2">
      <config type="Map">
        <Option type="bool" name="force-suppress-popup" value="false"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="soilderivedobject_isbasedonsoilbody_2">
      <config type="Map">
        <Option type="bool" name="force-suppress-popup" value="false"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="soilderivedobject_isbasedonsoilderivedobject">
      <config type="Map">
        <Option type="bool" name="force-suppress-popup" value="false"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="soilderivedobject_isbasedonsoilderivedobject_2">
      <config type="Map">
        <Option type="bool" name="force-suppress-popup" value="false"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>COALESCE( "inspireid_localid", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>2</layerGeometryType>
</qgis>
