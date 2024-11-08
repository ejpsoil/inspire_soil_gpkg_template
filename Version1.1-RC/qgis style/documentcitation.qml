<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
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
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="shortname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="date">
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
    <field configurationFlags="None" name="link">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="specificreference">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="name" index="2" name="Name"/>
    <alias field="shortname" index="3" name="Short Name"/>
    <alias field="date" index="4" name="Date"/>
    <alias field="link" index="5" name="Uri"/>
    <alias field="specificreference" index="6" name="Specific Reference"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="name" policy="DefaultValue"/>
    <policy field="shortname" policy="DefaultValue"/>
    <policy field="date" policy="DefaultValue"/>
    <policy field="link" policy="DefaultValue"/>
    <policy field="specificreference" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="name" expression=""/>
    <default applyOnUpdate="0" field="shortname" expression=""/>
    <default applyOnUpdate="0" field="date" expression=""/>
    <default applyOnUpdate="0" field="link" expression=""/>
    <default applyOnUpdate="0" field="specificreference" expression=""/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" field="id" notnull_strength="1" exp_strength="0" constraints="3"/>
    <constraint unique_strength="1" field="guidkey" notnull_strength="0" exp_strength="0" constraints="2"/>
    <constraint unique_strength="0" field="name" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="shortname" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="date" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="link" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="specificreference" notnull_strength="0" exp_strength="0" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="name" exp="" desc=""/>
    <constraint field="shortname" exp="" desc=""/>
    <constraint field="date" exp="" desc=""/>
    <constraint field="link" exp="" desc=""/>
    <constraint field="specificreference" exp="" desc=""/>
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
      <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
    </labelStyle>
    <attributeEditorField index="0" name="id" showLabel="1" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" name="Name" showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" groupBox="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
      <attributeEditorField index="2" name="name" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="3" name="shortname" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField index="4" name="date" showLabel="1" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="5" name="link" showLabel="1" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="6" name="specificreference" showLabel="1" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" columnCount="2" collapsed="1" visibilityExpressionEnabled="0" name="Process" showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" groupBox="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
      <attributeEditorRelation forceSuppressFormPopup="0" name="documentcitation_process_2" showLabel="0" verticalStretch="0" relationWidgetTypeId="relation_editor" relation="documentcitation_process_2" nmRelationId="" horizontalStretch="0" label="Process">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
      <attributeEditorRelation forceSuppressFormPopup="0" name="documentcitation_process" showLabel="0" verticalStretch="0" relationWidgetTypeId="relation_editor" relation="documentcitation_process" nmRelationId="" horizontalStretch="0" label="">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
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
    <field name="date" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="link" editable="1"/>
    <field name="name" editable="1"/>
    <field name="shortname" editable="1"/>
    <field name="specificreference" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="date" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="link" labelOnTop="0"/>
    <field name="name" labelOnTop="0"/>
    <field name="shortname" labelOnTop="0"/>
    <field name="specificreference" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="date" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="link" reuseLastValue="0"/>
    <field name="name" reuseLastValue="0"/>
    <field name="shortname" reuseLastValue="0"/>
    <field name="specificreference" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="documentcitation_process">
      <config type="Map">
        <Option type="bool" value="false" name="force-suppress-popup"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="documentcitation_process_2">
      <config type="Map">
        <Option type="bool" value="false" name="force-suppress-popup"/>
        <Option type="QString" value="" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>COALESCE( "shortname", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
