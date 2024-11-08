<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
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
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uomname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uomsymbol">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="measuretype">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="namestandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="scaletostandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="offsettostandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="formula">
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
    <alias field="uomname" name="Name" index="2"/>
    <alias field="uomsymbol" name="Symbol" index="3"/>
    <alias field="measuretype" name="Measure Type" index="4"/>
    <alias field="namestandardunit" name="Name" index="5"/>
    <alias field="scaletostandardunit" name="Scale" index="6"/>
    <alias field="offsettostandardunit" name="Offset" index="7"/>
    <alias field="formula" name="Formula" index="8"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="uomname"/>
    <policy policy="DefaultValue" field="uomsymbol"/>
    <policy policy="DefaultValue" field="measuretype"/>
    <policy policy="DefaultValue" field="namestandardunit"/>
    <policy policy="DefaultValue" field="scaletostandardunit"/>
    <policy policy="DefaultValue" field="offsettostandardunit"/>
    <policy policy="DefaultValue" field="formula"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="guidkey" applyOnUpdate="0"/>
    <default expression="" field="uomname" applyOnUpdate="0"/>
    <default expression="" field="uomsymbol" applyOnUpdate="0"/>
    <default expression="" field="measuretype" applyOnUpdate="0"/>
    <default expression="" field="namestandardunit" applyOnUpdate="0"/>
    <default expression="" field="scaletostandardunit" applyOnUpdate="0"/>
    <default expression="" field="offsettostandardunit" applyOnUpdate="0"/>
    <default expression="" field="formula" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="guidkey" unique_strength="1" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="uomname" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="uomsymbol" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="measuretype" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="namestandardunit" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="scaletostandardunit" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="offsettostandardunit" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="2" exp_strength="0" field="formula" unique_strength="1" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="guidkey" desc="" exp=""/>
    <constraint field="uomname" desc="" exp=""/>
    <constraint field="uomsymbol" desc="" exp=""/>
    <constraint field="measuretype" desc="" exp=""/>
    <constraint field="namestandardunit" desc="" exp=""/>
    <constraint field="scaletostandardunit" desc="" exp=""/>
    <constraint field="offsettostandardunit" desc="" exp=""/>
    <constraint field="formula" desc="" exp=""/>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="uomname" index="2">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="uomsymbol" index="3">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Standard Unit" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="namestandardunit" index="5">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="scaletostandardunit" index="6">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="offsettostandardunit" index="7">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="measuretype" index="4">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="formula" index="8">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Observable Properties" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="unitofmeasure_observableproperty" verticalStretch="0" nmRelationId="" name="unitofmeasure_observableproperty" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="formula"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="measuretype"/>
    <field editable="1" name="namestandardunit"/>
    <field editable="1" name="offsettostandardunit"/>
    <field editable="1" name="scaletostandardunit"/>
    <field editable="1" name="uomname"/>
    <field editable="1" name="uomsymbol"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="formula"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="measuretype"/>
    <field labelOnTop="0" name="namestandardunit"/>
    <field labelOnTop="0" name="offsettostandardunit"/>
    <field labelOnTop="0" name="scaletostandardunit"/>
    <field labelOnTop="0" name="uomname"/>
    <field labelOnTop="0" name="uomsymbol"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="formula" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="measuretype" reuseLastValue="0"/>
    <field name="namestandardunit" reuseLastValue="0"/>
    <field name="offsettostandardunit" reuseLastValue="0"/>
    <field name="scaletostandardunit" reuseLastValue="0"/>
    <field name="uomname" reuseLastValue="0"/>
    <field name="uomsymbol" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "uomname", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
