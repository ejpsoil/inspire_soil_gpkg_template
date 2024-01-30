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
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
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
    <field configurationFlags="None" name="properties">
      <editWidget type="Binary">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="Mane" field="name"/>
    <alias index="3" name="Description" field="description"/>
    <alias index="4" name="Properties File" field="properties"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="name"/>
    <policy policy="DefaultValue" field="description"/>
    <policy policy="DefaultValue" field="properties"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="name"/>
    <default applyOnUpdate="0" expression="" field="description"/>
    <default applyOnUpdate="0" expression="" field="properties"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="name"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="description"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="properties"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="description"/>
    <constraint exp="" desc="" field="properties"/>
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
    <attributeEditorField showLabel="1" index="2" name="name" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="3" name="description" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Properties File" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="1" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" index="4" name="properties" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorRelation showLabel="1" relation="thing_datastreamcollection" label="Datastream Collection" name="thing_datastreamcollection" forceSuppressFormPopup="0" nmRelationId="" horizontalStretch="0" verticalStretch="0" relationWidgetTypeId="relation_editor">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <editor_configuration type="Map">
        <Option value="false" name="allow_add_child_feature_with_no_geometry" type="bool"/>
        <Option value="AllButtons" name="buttons" type="QString"/>
        <Option value="true" name="show_first_feature" type="bool"/>
      </editor_configuration>
    </attributeEditorRelation>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="description"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="name"/>
    <field editable="1" name="properties"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="name"/>
    <field labelOnTop="0" name="properties"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="description"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="name"/>
    <field reuseLastValue="0" name="properties"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="thing_datastreamcollection">
      <config type="Map">
        <Option value="false" name="force-suppress-popup" type="bool"/>
        <Option value="" name="nm-rel" type="QString"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>"name"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
