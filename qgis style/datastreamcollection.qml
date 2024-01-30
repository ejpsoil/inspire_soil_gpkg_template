<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="thing_datastreamcollection" providerKey="ogr" referencedLayer="thing_c905e9d6_56b4_44f1_aad5_15a329d33083" layerName="thing" name="thing_datastreamcollection" dataSource="./INSPIRE_Selection_4.gpkg|layername=thing" referencingLayer="datastreamcollection_05997361_72ea_40c3_ac61_ca85ad8ea1c8" layerId="thing_c905e9d6_56b4_44f1_aad5_15a329d33083" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idthing"/>
    </relation>
  </referencedLayers>
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
    <field configurationFlags="None" name="observedarea">
      <editWidget type="Binary">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="beginphenomenontime">
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
    <field configurationFlags="None" name="endphenomenontime">
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
    <field configurationFlags="None" name="beginresulttime">
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
    <field configurationFlags="None" name="endresulttime">
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
    <field configurationFlags="None" name="properties">
      <editWidget type="Binary">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idthing">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=thing" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="thing_c905e9d6_56b4_44f1_aad5_15a329d33083" name="ReferencedLayerId" type="QString"/>
            <Option value="thing" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="thing_datastreamcollection" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="Name" field="name"/>
    <alias index="3" name="Description" field="description"/>
    <alias index="4" name="Observed Area" field="observedarea"/>
    <alias index="5" name="Begin" field="beginphenomenontime"/>
    <alias index="6" name="End" field="endphenomenontime"/>
    <alias index="7" name="Begin" field="beginresulttime"/>
    <alias index="8" name="End" field="endresulttime"/>
    <alias index="9" name="Properties" field="properties"/>
    <alias index="10" name="Thing" field="idthing"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="name"/>
    <policy policy="DefaultValue" field="description"/>
    <policy policy="DefaultValue" field="observedarea"/>
    <policy policy="DefaultValue" field="beginphenomenontime"/>
    <policy policy="DefaultValue" field="endphenomenontime"/>
    <policy policy="DefaultValue" field="beginresulttime"/>
    <policy policy="DefaultValue" field="endresulttime"/>
    <policy policy="DefaultValue" field="properties"/>
    <policy policy="DefaultValue" field="idthing"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="name"/>
    <default applyOnUpdate="0" expression="" field="description"/>
    <default applyOnUpdate="0" expression="" field="observedarea"/>
    <default applyOnUpdate="0" expression="" field="beginphenomenontime"/>
    <default applyOnUpdate="0" expression="" field="endphenomenontime"/>
    <default applyOnUpdate="0" expression="" field="beginresulttime"/>
    <default applyOnUpdate="0" expression="" field="endresulttime"/>
    <default applyOnUpdate="0" expression="" field="properties"/>
    <default applyOnUpdate="0" expression="" field="idthing"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="name"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="description"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="observedarea"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="beginphenomenontime"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="endphenomenontime"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="beginresulttime"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="endresulttime"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="properties"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idthing"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="description"/>
    <constraint exp="" desc="" field="observedarea"/>
    <constraint exp="" desc="" field="beginphenomenontime"/>
    <constraint exp="" desc="" field="endphenomenontime"/>
    <constraint exp="" desc="" field="beginresulttime"/>
    <constraint exp="" desc="" field="endresulttime"/>
    <constraint exp="" desc="" field="properties"/>
    <constraint exp="" desc="" field="idthing"/>
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
    <attributeEditorField showLabel="1" index="10" name="idthing" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Phenomenon Time" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="5" name="beginphenomenontime" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="6" name="endphenomenontime" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Result TIme" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="7" name="beginresulttime" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="8" name="endresulttime" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer columnCount="2" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Files" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="1" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="4" name="observedarea" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="9" name="properties" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorRelation showLabel="1" relation="datastreamcollection_datastream_5" label="Datastream" name="datastreamcollection_datastream_5" forceSuppressFormPopup="0" nmRelationId="" horizontalStretch="0" verticalStretch="0" relationWidgetTypeId="relation_editor">
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
    <field editable="1" name="beginphenomenontime"/>
    <field editable="1" name="beginresulttime"/>
    <field editable="1" name="description"/>
    <field editable="1" name="endphenomenontime"/>
    <field editable="1" name="endresulttime"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="idthing"/>
    <field editable="1" name="name"/>
    <field editable="1" name="observedarea"/>
    <field editable="1" name="properties"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="beginphenomenontime"/>
    <field labelOnTop="0" name="beginresulttime"/>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="endphenomenontime"/>
    <field labelOnTop="0" name="endresulttime"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idthing"/>
    <field labelOnTop="0" name="name"/>
    <field labelOnTop="0" name="observedarea"/>
    <field labelOnTop="0" name="properties"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="beginphenomenontime"/>
    <field reuseLastValue="0" name="beginresulttime"/>
    <field reuseLastValue="0" name="description"/>
    <field reuseLastValue="0" name="endphenomenontime"/>
    <field reuseLastValue="0" name="endresulttime"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idthing"/>
    <field reuseLastValue="0" name="name"/>
    <field reuseLastValue="0" name="observedarea"/>
    <field reuseLastValue="0" name="properties"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="datastreamcollection_datastream_5">
      <config type="Map">
        <Option value="false" name="force-suppress-popup" type="bool"/>
        <Option value="" name="nm-rel" type="QString"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>"name"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
