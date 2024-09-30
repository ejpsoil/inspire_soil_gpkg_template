<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers/>
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
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="uomname" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="uomsymbol" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="measuretype" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="namestandardunit" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="scaletostandardunit" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="offsettostandardunit" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="formula" configurationFlags="None">
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
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="guidkey" applyOnUpdate="0" expression=""/>
    <default field="uomname" applyOnUpdate="0" expression=""/>
    <default field="uomsymbol" applyOnUpdate="0" expression=""/>
    <default field="measuretype" applyOnUpdate="0" expression=""/>
    <default field="namestandardunit" applyOnUpdate="0" expression=""/>
    <default field="scaletostandardunit" applyOnUpdate="0" expression=""/>
    <default field="offsettostandardunit" applyOnUpdate="0" expression=""/>
    <default field="formula" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="1" exp_strength="0" constraints="3" notnull_strength="1"/>
    <constraint field="guidkey" unique_strength="1" exp_strength="0" constraints="2" notnull_strength="0"/>
    <constraint field="uomname" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="uomsymbol" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="measuretype" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="namestandardunit" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="scaletostandardunit" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="offsettostandardunit" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="formula" unique_strength="1" exp_strength="0" constraints="2" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="id" desc=""/>
    <constraint exp="" field="guidkey" desc=""/>
    <constraint exp="" field="uomname" desc=""/>
    <constraint exp="" field="uomsymbol" desc=""/>
    <constraint exp="" field="measuretype" desc=""/>
    <constraint exp="" field="namestandardunit" desc=""/>
    <constraint exp="" field="scaletostandardunit" desc=""/>
    <constraint exp="" field="offsettostandardunit" desc=""/>
    <constraint exp="" field="formula" desc=""/>
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
      <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
    </labelStyle>
    <attributeEditorField verticalStretch="0" name="id" showLabel="1" horizontalStretch="0" index="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" name="uomname" showLabel="1" horizontalStretch="0" index="2">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" name="uomsymbol" showLabel="1" horizontalStretch="0" index="3">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer verticalStretch="0" type="GroupBox" visibilityExpression="" collapsedExpression="" columnCount="1" name="Standard Unit" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" horizontalStretch="0" collapsedExpressionEnabled="0" collapsed="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField verticalStretch="0" name="namestandardunit" showLabel="1" horizontalStretch="0" index="5">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" name="scaletostandardunit" showLabel="1" horizontalStretch="0" index="6">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" name="offsettostandardunit" showLabel="1" horizontalStretch="0" index="7">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField verticalStretch="0" name="measuretype" showLabel="1" horizontalStretch="0" index="4">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" name="formula" showLabel="1" horizontalStretch="0" index="8">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer verticalStretch="0" type="GroupBox" visibilityExpression="" collapsedExpression="" columnCount="1" name="Observable Properties" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" horizontalStretch="0" collapsedExpressionEnabled="0" collapsed="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorRelation forceSuppressFormPopup="0" verticalStretch="0" nmRelationId="" relation="unitofmeasure_observableproperty" label="" relationWidgetTypeId="relation_editor" name="unitofmeasure_observableproperty" showLabel="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont underline="0" bold="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
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
    <field name="formula" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="measuretype" editable="1"/>
    <field name="namestandardunit" editable="1"/>
    <field name="offsettostandardunit" editable="1"/>
    <field name="scaletostandardunit" editable="1"/>
    <field name="uomname" editable="1"/>
    <field name="uomsymbol" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="formula" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="measuretype" labelOnTop="0"/>
    <field name="namestandardunit" labelOnTop="0"/>
    <field name="offsettostandardunit" labelOnTop="0"/>
    <field name="scaletostandardunit" labelOnTop="0"/>
    <field name="uomname" labelOnTop="0"/>
    <field name="uomsymbol" labelOnTop="0"/>
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
