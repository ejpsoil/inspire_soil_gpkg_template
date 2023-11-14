<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Fields|Forms">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
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
    <field name="inspireid_localid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_namespace" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_versionid" configurationFlags="None">
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
    <alias index="0" field="id" name=""/>
    <alias index="1" field="guidkey" name=""/>
    <alias index="2" field="inspireid_localid" name="Local id"/>
    <alias index="3" field="inspireid_namespace" name="Namespace"/>
    <alias index="4" field="inspireid_versionid" name="Version id"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="inspireid_localid" policy="DefaultValue"/>
    <policy field="inspireid_namespace" policy="DefaultValue"/>
    <policy field="inspireid_versionid" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="guidkey" expression="" applyOnUpdate="0"/>
    <default field="inspireid_localid" expression="" applyOnUpdate="0"/>
    <default field="inspireid_namespace" expression="" applyOnUpdate="0"/>
    <default field="inspireid_versionid" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" exp_strength="0" field="id" unique_strength="1"/>
    <constraint constraints="2" notnull_strength="0" exp_strength="0" field="guidkey" unique_strength="1"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_localid" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_namespace" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_versionid" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="guidkey" exp=""/>
    <constraint desc="" field="inspireid_localid" exp=""/>
    <constraint desc="" field="inspireid_namespace" exp=""/>
    <constraint desc="" field="inspireid_versionid" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
I moduli di QGIS possono avere una funzione Python che può essere chiamata quando un modulo viene aperto.

Usa questa funzione per aggiungere logica extra ai tuoi moduli.

Inserisci il nome della funzione nel campo "Funzione Python di avvio".

Segue un esempio:
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
      <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="0" showLabel="1" name="id" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="GroupBox" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="INSPIRE ID" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="2" showLabel="1" name="inspireid_localid" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="3" showLabel="1" name="inspireid_namespace" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="4" showLabel="1" name="inspireid_versionid" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="GroupBox" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Geometry" columnCount="3" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
      </labelStyle>
      <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="GroupBox" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Polygon" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="1">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
        <attributeEditorRelation horizontalStretch="0" nmRelationId="" forceSuppressFormPopup="0" label="" showLabel="0" relation="soilderivedobject_soilderivedobject_polygon" relationWidgetTypeId="relation_editor" name="soilderivedobject_soilderivedobject_polygon" verticalStretch="0">
          <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
            <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="GroupBox" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Line" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="1">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
        <attributeEditorRelation horizontalStretch="0" nmRelationId="" forceSuppressFormPopup="0" label="" showLabel="0" relation="soilderivedobject_soilderivedobject_line" relationWidgetTypeId="relation_editor" name="soilderivedobject_soilderivedobject_line" verticalStretch="0">
          <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
            <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="GroupBox" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Point" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="1">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
        <attributeEditorRelation horizontalStretch="0" nmRelationId="" forceSuppressFormPopup="0" label="" showLabel="0" relation="soilderivedobject_soilderivedobject_point" relationWidgetTypeId="relation_editor" name="soilderivedobject_soilderivedobject_point" verticalStretch="0">
          <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
            <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
    </attributeEditorContainer>
    <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="Tab" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Is Based on Soil Derived Object" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" nmRelationId="" forceSuppressFormPopup="0" label="" showLabel="0" relation="soilderivedobject_isbasedonsoilderivedobject" relationWidgetTypeId="relation_editor" name="soilderivedobject_isbasedonsoilderivedobject" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="Tab" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Soil Derived Object" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" nmRelationId="" forceSuppressFormPopup="0" label="" showLabel="0" relation="soilderivedobject_isbasedonsoilderivedobject_2" relationWidgetTypeId="relation_editor" name="soilderivedobject_isbasedonsoilderivedobject_2" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="Tab" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Is Based on Soil Body" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" nmRelationId="" forceSuppressFormPopup="0" label="" showLabel="0" relation="soilderivedobject_isbasedonsoilbody_2" relationWidgetTypeId="relation_editor" name="soilderivedobject_isbasedonsoilbody_2" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer visibilityExpression="" horizontalStretch="0" type="Tab" visibilityExpressionEnabled="0" showLabel="1" collapsed="0" name="Soil Body" columnCount="1" verticalStretch="0" collapsedExpressionEnabled="0" collapsedExpression="" groupBox="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" nmRelationId="" forceSuppressFormPopup="0" label="" showLabel="0" relation="soilderivedobject_isbasedonobservedsoilprofile_2" relationWidgetTypeId="relation_editor" name="soilderivedobject_isbasedonobservedsoilprofile_2" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" italic="0"/>
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
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="inspireid_localid"/>
    <field editable="1" name="inspireid_namespace"/>
    <field editable="1" name="inspireid_versionid"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="inspireid_localid"/>
    <field labelOnTop="0" name="inspireid_namespace"/>
    <field labelOnTop="0" name="inspireid_versionid"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="inspireid_localid"/>
    <field reuseLastValue="0" name="inspireid_namespace"/>
    <field reuseLastValue="0" name="inspireid_versionid"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'id '|| COALESCE( "id", '&lt;NULL>' )|| ' ' || COALESCE( "inspireid_localid", '&lt;NULL>') </previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
