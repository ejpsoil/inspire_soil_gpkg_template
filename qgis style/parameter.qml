<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="observation_parameter" providerKey="ogr" referencedLayer="observation_d5ffb748_b58c_4d49_bc5b_7d71f48f37d8" layerName="observation" name="observation_parameter" dataSource="./INSPIRE_Selection_4.gpkg|layername=observation" referencingLayer="parameter_4b92e4c8_b5e6_467a_8dad_0eba0668969f" layerId="observation_d5ffb748_b58c_4d49_bc5b_7d71f48f37d8" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idobservation"/>
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
    <field configurationFlags="None" name="value">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idobservation">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=observation" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="observation_d5ffb748_b58c_4d49_bc5b_7d71f48f37d8" name="ReferencedLayerId" type="QString"/>
            <Option value="observation" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="observation_parameter" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="Name" field="name"/>
    <alias index="2" name="Value" field="value"/>
    <alias index="3" name="Observation" field="idobservation"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="name"/>
    <policy policy="DefaultValue" field="value"/>
    <policy policy="DefaultValue" field="idobservation"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="name"/>
    <default applyOnUpdate="0" expression="" field="value"/>
    <default applyOnUpdate="0" expression="" field="idobservation"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="name"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="value"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="idobservation"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="value"/>
    <constraint exp="" desc="" field="idobservation"/>
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
    <attributeEditorField showLabel="1" index="1" name="name" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" name="value" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="3" name="idobservation" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="idobservation"/>
    <field editable="1" name="name"/>
    <field editable="1" name="value"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idobservation"/>
    <field labelOnTop="0" name="name"/>
    <field labelOnTop="0" name="value"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idobservation"/>
    <field reuseLastValue="0" name="name"/>
    <field reuseLastValue="0" name="value"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"name"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
