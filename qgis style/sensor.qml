<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.32.3-Lima">
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
  </fieldConfiguration>
  <aliases>
    <alias name="" field="id" index="0"/>
    <alias name="" field="guidkey" index="1"/>
    <alias name="Name" field="name" index="2"/>
    <alias name="Description" field="description" index="3"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="name"/>
    <policy policy="DefaultValue" field="description"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="name" expression=""/>
    <default applyOnUpdate="0" field="description" expression=""/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="1" field="id" constraints="3"/>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="0" field="guidkey" constraints="2"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="name" constraints="1"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="description" constraints="1"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="description"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
    </labelStyle>
    <attributeEditorField name="id" horizontalStretch="0" verticalStretch="0" showLabel="1" index="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="name" horizontalStretch="0" verticalStretch="0" showLabel="1" index="2">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="description" horizontalStretch="0" verticalStretch="0" showLabel="1" index="3">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer groupBox="1" visibilityExpressionEnabled="0" collapsed="0" visibilityExpression="" name="RELATIONS" horizontalStretch="0" type="GroupBox" verticalStretch="0" collapsedExpression="" showLabel="1" columnCount="1" collapsedExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
      <attributeEditorContainer groupBox="1" visibilityExpressionEnabled="0" collapsed="1" visibilityExpression="" name="Datastream" horizontalStretch="0" type="GroupBox" verticalStretch="0" collapsedExpression="" showLabel="1" columnCount="1" collapsedExpressionEnabled="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
        <attributeEditorRelation nmRelationId="" label="Datastream" relation="sensor_datastream_2" relationWidgetTypeId="relation_editor" name="sensor_datastream_2" horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" showLabel="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option value="false" name="allow_add_child_feature_with_no_geometry" type="bool"/>
            <Option value="AllButtons" name="buttons" type="QString"/>
            <Option value="true" name="show_first_feature" type="bool"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="description"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="name"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="name"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="description"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="name"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="sensor_datastream_2">
      <config type="Map">
        <Option value="false" name="force-suppress-popup" type="bool"/>
        <Option value="" name="nm-rel" type="QString"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>"name"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
