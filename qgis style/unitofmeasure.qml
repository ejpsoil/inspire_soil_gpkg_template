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
    <field configurationFlags="None" name="uomname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uomsymbol">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="measuretype">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="namestandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="scaletostandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="offsettostandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="formula">
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
    <alias index="2" name="Name" field="uomname"/>
    <alias index="3" name="Symbol" field="uomsymbol"/>
    <alias index="4" name="Measure Type" field="measuretype"/>
    <alias index="5" name="Name" field="namestandardunit"/>
    <alias index="6" name="Scale" field="scaletostandardunit"/>
    <alias index="7" name="Offset" field="offsettostandardunit"/>
    <alias index="8" name="Formula" field="formula"/>
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
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="uomname"/>
    <default applyOnUpdate="0" expression="" field="uomsymbol"/>
    <default applyOnUpdate="0" expression="" field="measuretype"/>
    <default applyOnUpdate="0" expression="" field="namestandardunit"/>
    <default applyOnUpdate="0" expression="" field="scaletostandardunit"/>
    <default applyOnUpdate="0" expression="" field="offsettostandardunit"/>
    <default applyOnUpdate="0" expression="" field="formula"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="uomname"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="uomsymbol"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="measuretype"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="namestandardunit"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="scaletostandardunit"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="offsettostandardunit"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="formula"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="uomname"/>
    <constraint exp="" desc="" field="uomsymbol"/>
    <constraint exp="" desc="" field="measuretype"/>
    <constraint exp="" desc="" field="namestandardunit"/>
    <constraint exp="" desc="" field="scaletostandardunit"/>
    <constraint exp="" desc="" field="offsettostandardunit"/>
    <constraint exp="" desc="" field="formula"/>
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
    <attributeEditorField showLabel="1" index="2" name="uomname" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="3" name="uomsymbol" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Standard Unit" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="5" name="namestandardunit" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="6" name="scaletostandardunit" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="7" name="offsettostandardunit" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="4" name="measuretype" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="8" name="formula" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Observable Properties" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="0" type="Tab" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="unitofmeasure_observableproperty" label="" name="unitofmeasure_observableproperty" forceSuppressFormPopup="0" nmRelationId="" horizontalStretch="0" verticalStretch="0" relationWidgetTypeId="relation_editor">
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
    <field reuseLastValue="0" name="formula"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="measuretype"/>
    <field reuseLastValue="0" name="namestandardunit"/>
    <field reuseLastValue="0" name="offsettostandardunit"/>
    <field reuseLastValue="0" name="scaletostandardunit"/>
    <field reuseLastValue="0" name="uomname"/>
    <field reuseLastValue="0" name="uomsymbol"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "uomname", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
