<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation layerId="thing_55e436ac_7501_479e_aa13_13e43b168723" referencingLayer="datastreamcollection_66a8e55e_91f7_44dc_b064_d371aca3302d" referencedLayer="thing_55e436ac_7501_479e_aa13_13e43b168723" name="thing_datastreamcollection" providerKey="ogr" layerName="thing" id="thing_datastreamcollection" strength="Association" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=thing">
      <fieldRef referencingField="idthing" referencedField="guidkey"/>
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
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/_ConsegnaV01/INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=thing" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="thing_55e436ac_7501_479e_aa13_13e43b168723" name="ReferencedLayerId" type="QString"/>
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
    <alias name="" field="id" index="0"/>
    <alias name="" field="guidkey" index="1"/>
    <alias name="Name" field="name" index="2"/>
    <alias name="Description" field="description" index="3"/>
    <alias name="Observed Area" field="observedarea" index="4"/>
    <alias name="Begin" field="beginphenomenontime" index="5"/>
    <alias name="End" field="endphenomenontime" index="6"/>
    <alias name="Begin" field="beginresulttime" index="7"/>
    <alias name="End" field="endresulttime" index="8"/>
    <alias name="Properties" field="properties" index="9"/>
    <alias name="Thing" field="idthing" index="10"/>
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
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="name" expression=""/>
    <default applyOnUpdate="0" field="description" expression=""/>
    <default applyOnUpdate="0" field="observedarea" expression=""/>
    <default applyOnUpdate="0" field="beginphenomenontime" expression=""/>
    <default applyOnUpdate="0" field="endphenomenontime" expression=""/>
    <default applyOnUpdate="0" field="beginresulttime" expression=""/>
    <default applyOnUpdate="0" field="endresulttime" expression=""/>
    <default applyOnUpdate="0" field="properties" expression=""/>
    <default applyOnUpdate="0" field="idthing" expression=""/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="1" field="id" constraints="3"/>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="0" field="guidkey" constraints="2"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="name" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="description" constraints="1"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="observedarea" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="beginphenomenontime" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="endphenomenontime" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="beginresulttime" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="endresulttime" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="properties" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="idthing" constraints="1"/>
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
    <attributeEditorField name="idthing" horizontalStretch="0" verticalStretch="0" showLabel="1" index="10">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer groupBox="1" visibilityExpressionEnabled="0" collapsed="0" visibilityExpression="" name="Phenomenon Time" horizontalStretch="0" type="GroupBox" verticalStretch="0" collapsedExpression="" showLabel="1" columnCount="1" collapsedExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
      <attributeEditorField name="beginphenomenontime" horizontalStretch="0" verticalStretch="0" showLabel="1" index="5">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="endphenomenontime" horizontalStretch="0" verticalStretch="0" showLabel="1" index="6">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="1" visibilityExpressionEnabled="0" collapsed="0" visibilityExpression="" name="Result TIme" horizontalStretch="0" type="GroupBox" verticalStretch="0" collapsedExpression="" showLabel="1" columnCount="1" collapsedExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
      <attributeEditorField name="beginresulttime" horizontalStretch="0" verticalStretch="0" showLabel="1" index="7">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="endresulttime" horizontalStretch="0" verticalStretch="0" showLabel="1" index="8">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="1" visibilityExpressionEnabled="0" collapsed="1" visibilityExpression="" name="Files" horizontalStretch="0" type="GroupBox" verticalStretch="0" collapsedExpression="" showLabel="1" columnCount="2" collapsedExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
      <attributeEditorField name="observedarea" horizontalStretch="0" verticalStretch="0" showLabel="1" index="4">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="properties" horizontalStretch="0" verticalStretch="0" showLabel="1" index="9">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="1" visibilityExpressionEnabled="0" collapsed="0" visibilityExpression="" name="RELATIONS" horizontalStretch="0" type="GroupBox" verticalStretch="0" collapsedExpression="" showLabel="1" columnCount="1" collapsedExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
      </labelStyle>
      <attributeEditorContainer groupBox="1" visibilityExpressionEnabled="0" collapsed="1" visibilityExpression="" name="Datastream Collection" horizontalStretch="0" type="GroupBox" verticalStretch="0" collapsedExpression="" showLabel="1" columnCount="1" collapsedExpressionEnabled="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" underline="0" style="" italic="0"/>
        </labelStyle>
        <attributeEditorRelation nmRelationId="" label="Datastream" relation="datastreamcollection_datastream_5" relationWidgetTypeId="relation_editor" name="datastreamcollection_datastream_5" horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" showLabel="0">
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
