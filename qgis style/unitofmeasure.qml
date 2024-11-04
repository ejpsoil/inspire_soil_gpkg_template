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
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uomname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uomsymbol">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="measuretype">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="namestandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="scaletostandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="offsettostandardunit">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="formula">
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
    <alias name="" field="id" index="0"/>
    <alias name="" field="guidkey" index="1"/>
    <alias name="Name" field="uomname" index="2"/>
    <alias name="Symbol" field="uomsymbol" index="3"/>
    <alias name="Measure Type" field="measuretype" index="4"/>
    <alias name="Name" field="namestandardunit" index="5"/>
    <alias name="Scale" field="scaletostandardunit" index="6"/>
    <alias name="Offset" field="offsettostandardunit" index="7"/>
    <alias name="Formula" field="formula" index="8"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="uomname" policy="DefaultValue"/>
    <policy field="uomsymbol" policy="DefaultValue"/>
    <policy field="measuretype" policy="DefaultValue"/>
    <policy field="namestandardunit" policy="DefaultValue"/>
    <policy field="scaletostandardunit" policy="DefaultValue"/>
    <policy field="offsettostandardunit" policy="DefaultValue"/>
    <policy field="formula" policy="DefaultValue"/>
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
    <constraint unique_strength="1" constraints="3" notnull_strength="1" exp_strength="0" field="id"/>
    <constraint unique_strength="1" constraints="2" notnull_strength="0" exp_strength="0" field="guidkey"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="uomname"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="uomsymbol"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="measuretype"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="namestandardunit"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="scaletostandardunit"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="offsettostandardunit"/>
    <constraint unique_strength="1" constraints="2" notnull_strength="0" exp_strength="0" field="formula"/>
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
      <labelFont bold="0" italic="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorField verticalStretch="0" name="id" showLabel="1" horizontalStretch="0" index="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" name="uomname" showLabel="1" horizontalStretch="0" index="2">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" name="uomsymbol" showLabel="1" horizontalStretch="0" index="3">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer verticalStretch="0" collapsed="0" visibilityExpression="" visibilityExpressionEnabled="0" type="GroupBox" collapsedExpression="" name="Standard Unit" columnCount="1" showLabel="1" horizontalStretch="0" collapsedExpressionEnabled="0" groupBox="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField verticalStretch="0" name="namestandardunit" showLabel="1" horizontalStretch="0" index="5">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" name="scaletostandardunit" showLabel="1" horizontalStretch="0" index="6">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" name="offsettostandardunit" showLabel="1" horizontalStretch="0" index="7">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField verticalStretch="0" name="measuretype" showLabel="1" horizontalStretch="0" index="4">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" name="formula" showLabel="1" horizontalStretch="0" index="8">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer verticalStretch="0" collapsed="0" visibilityExpression="" visibilityExpressionEnabled="0" type="GroupBox" collapsedExpression="" name="RELATIONS" columnCount="1" showLabel="1" horizontalStretch="0" collapsedExpressionEnabled="0" groupBox="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorContainer verticalStretch="0" collapsed="1" visibilityExpression="" visibilityExpressionEnabled="0" type="GroupBox" collapsedExpression="" name="Observable Property" columnCount="1" showLabel="1" horizontalStretch="0" collapsedExpressionEnabled="0" groupBox="1">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" nmRelationId="" name="unitofmeasure_observableproperty" showLabel="0" horizontalStretch="0" relation="unitofmeasure_observableproperty" label="Observable Property" forceSuppressFormPopup="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" italic="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" name="allow_add_child_feature_with_no_geometry" value="false"/>
            <Option type="QString" name="buttons" value="AllButtons"/>
            <Option type="bool" name="show_first_feature" value="true"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
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
