<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers/>
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
    <field configurationFlags="None" name="beginlifespanversion">
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
    <field configurationFlags="None" name="endlifespanversion">
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
    <field configurationFlags="None" name="soilbodylabel">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
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
    <alias index="5" name="Begin" field="beginlifespanversion"/>
    <alias index="6" name="End" field="endlifespanversion"/>
    <alias index="7" name="Label" field="soilbodylabel"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="inspireid_localid"/>
    <policy policy="DefaultValue" field="inspireid_namespace"/>
    <policy policy="DefaultValue" field="inspireid_versionid"/>
    <policy policy="DefaultValue" field="beginlifespanversion"/>
    <policy policy="DefaultValue" field="endlifespanversion"/>
    <policy policy="DefaultValue" field="soilbodylabel"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="inspireid_localid"/>
    <default applyOnUpdate="0" expression="" field="inspireid_namespace"/>
    <default applyOnUpdate="0" expression="" field="inspireid_versionid"/>
    <default applyOnUpdate="0" expression="" field="beginlifespanversion"/>
    <default applyOnUpdate="0" expression="" field="endlifespanversion"/>
    <default applyOnUpdate="0" expression="" field="soilbodylabel"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="inspireid_localid"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="inspireid_namespace"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="inspireid_versionid"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="beginlifespanversion"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="endlifespanversion"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="soilbodylabel"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="inspireid_localid"/>
    <constraint exp="" desc="" field="inspireid_namespace"/>
    <constraint exp="" desc="" field="inspireid_versionid"/>
    <constraint exp="" desc="" field="beginlifespanversion"/>
    <constraint exp="" desc="" field="endlifespanversion"/>
    <constraint exp="" desc="" field="soilbodylabel"/>
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
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Lifespan Version" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="5" name="beginlifespanversion" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="6" name="endlifespanversion" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="7" name="soilbodylabel" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Derived Profile presence in Soil Body" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="0" type="Tab" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="soilbody_derivedprofilepresenceinsoilbody_2" label="Derived Profile presence in Soil Body" name="soilbody_derivedprofilepresenceinsoilbody_2" forceSuppressFormPopup="0" nmRelationId="" horizontalStretch="0" verticalStretch="0" relationWidgetTypeId="relation_editor">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" name="allow_add_child_feature_with_no_geometry" type="bool"/>
          <Option value="AllButtons" name="buttons" type="QString"/>
          <Option value="true" name="show_first_feature" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Is Based on Soil Body" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="0" type="Tab" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="soilbody_isbasedonsoilbody" label="Is Based On Soil Body" name="soilbody_isbasedonsoilbody" forceSuppressFormPopup="0" nmRelationId="" horizontalStretch="0" verticalStretch="0" relationWidgetTypeId="relation_editor">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
    <field editable="1" name="beginlifespanversion"/>
    <field editable="1" name="endlifespanversion"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="inspireid_localid"/>
    <field editable="1" name="inspireid_namespace"/>
    <field editable="1" name="inspireid_versionid"/>
    <field editable="1" name="soilbodylabel"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="beginlifespanversion"/>
    <field labelOnTop="0" name="endlifespanversion"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="inspireid_localid"/>
    <field labelOnTop="0" name="inspireid_namespace"/>
    <field labelOnTop="0" name="inspireid_versionid"/>
    <field labelOnTop="0" name="soilbodylabel"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="beginlifespanversion"/>
    <field reuseLastValue="0" name="endlifespanversion"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="inspireid_localid"/>
    <field reuseLastValue="0" name="inspireid_namespace"/>
    <field reuseLastValue="0" name="inspireid_versionid"/>
    <field reuseLastValue="0" name="soilbodylabel"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="soilbody_derivedprofilepresenceinsoilbody_2">
      <config type="Map">
        <Option value="false" name="force-suppress-popup" type="bool"/>
        <Option name="nm-rel" type="invalid"/>
      </config>
    </widget>
    <widget name="soilbody_isbasedonsoilbody">
      <config type="Map">
        <Option value="false" name="force-suppress-popup" type="bool"/>
        <Option name="nm-rel" type="invalid"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>COALESCE( "inspireid_localid", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
