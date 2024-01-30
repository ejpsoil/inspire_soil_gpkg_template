<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="otherhorizonnotationtype_otherhorizon_profileelement" providerKey="ogr" referencedLayer="otherhorizonnotationtype_d52d4ee1_52c4_4eb4_a1aa_f71bcb71bcfb" layerName="otherhorizonnotationtype" name="otherhorizonnotationtype_otherhorizon_profileelement" dataSource="./INSPIRE_Selection_4.gpkg|layername=otherhorizonnotationtype" referencingLayer="otherhorizon_profileelement_8d7be0a8_41d9_4af6_8cc6_3f8fa530d0f2" layerId="otherhorizonnotationtype_d52d4ee1_52c4_4eb4_a1aa_f71bcb71bcfb" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idotherhorizonnotationtype"/>
    </relation>
    <relation id="profileelement_otherhorizon_profileelement_2" providerKey="ogr" referencedLayer="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" layerName="profileelement" name="profileelement_otherhorizon_profileelement_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=profileelement" referencingLayer="otherhorizon_profileelement_8d7be0a8_41d9_4af6_8cc6_3f8fa530d0f2" layerId="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idprofileelement"/>
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
    <field configurationFlags="None" name="idprofileelement">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=profileelement" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" name="ReferencedLayerId" type="QString"/>
            <Option value="profileelement" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="profileelement_otherhorizon_profileelement_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idotherhorizonnotationtype">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=otherhorizonnotationtype" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="otherhorizonnotationtype_d52d4ee1_52c4_4eb4_a1aa_f71bcb71bcfb" name="ReferencedLayerId" type="QString"/>
            <Option value="otherhorizonnotationtype" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="otherhorizonnotationtype_otherhorizon_profileelement" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="Profile Element" field="idprofileelement"/>
    <alias index="2" name="Other Notation Type" field="idotherhorizonnotationtype"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="idprofileelement"/>
    <policy policy="DefaultValue" field="idotherhorizonnotationtype"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="idprofileelement"/>
    <default applyOnUpdate="0" expression="" field="idotherhorizonnotationtype"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idprofileelement"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idotherhorizonnotationtype"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="idprofileelement"/>
    <constraint exp="" desc="" field="idotherhorizonnotationtype"/>
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
    <attributeEditorField showLabel="1" index="1" name="idprofileelement" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" name="idotherhorizonnotationtype" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="idotherhorizonnotationtype"/>
    <field editable="1" name="idprofileelement"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idotherhorizonnotationtype"/>
    <field labelOnTop="0" name="idprofileelement"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idotherhorizonnotationtype"/>
    <field reuseLastValue="0" name="idprofileelement"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "idotherhorizonnotationtype", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
