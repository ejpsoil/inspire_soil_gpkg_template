<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="datastreamcollection_datastream_5" providerKey="ogr" referencedLayer="datastreamcollection_05997361_72ea_40c3_ac61_ca85ad8ea1c8" layerName="datastreamcollection" name="datastreamcollection_datastream_5" dataSource="./INSPIRE_Selection_4.gpkg|layername=datastreamcollection" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="datastreamcollection_05997361_72ea_40c3_ac61_ca85ad8ea1c8" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="iddatastreamcollection"/>
    </relation>
    <relation id="observableproperty_datastream_3" providerKey="ogr" referencedLayer="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" layerName="observableproperty" name="observableproperty_datastream_3" dataSource="./INSPIRE_Selection_4.gpkg|layername=observableproperty" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idobservedproperty"/>
    </relation>
    <relation id="observableproperty_process_datastream" providerKey="ogr" referencedLayer="observableproperty_process_dbb706f2_690c_482d_8d97_d29ea9500844" layerName="observableproperty_process" name="observableproperty_process_datastream" dataSource="./INSPIRE_Selection_4.gpkg|layername=observableproperty_process" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="observableproperty_process_dbb706f2_690c_482d_8d97_d29ea9500844" strength="Association">
      <fieldRef referencedField="idprocess" referencingField="idprocess"/>
      <fieldRef referencedField="idobservedproperty" referencingField="idobservedproperty"/>
    </relation>
    <relation id="process_datastream_4" providerKey="ogr" referencedLayer="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" layerName="process" name="process_datastream_4" dataSource="./INSPIRE_Selection_4.gpkg|layername=process" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idprocess"/>
    </relation>
    <relation id="profileelement_datastream_6" providerKey="ogr" referencedLayer="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" layerName="profileelement" name="profileelement_datastream_6" dataSource="./INSPIRE_Selection_4.gpkg|layername=profileelement" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idprofileelement"/>
    </relation>
    <relation id="sensor_datastream_2" providerKey="ogr" referencedLayer="sensor_fb521675_7fbc_4e4a_ad7d_543510fee531" layerName="sensor" name="sensor_datastream_2" dataSource="./INSPIRE_Selection_4.gpkg|layername=sensor" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="sensor_fb521675_7fbc_4e4a_ad7d_543510fee531" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idsensor"/>
    </relation>
    <relation id="soilderivedobject_datastream_7" providerKey="ogr" referencedLayer="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" layerName="soilderivedobject" name="soilderivedobject_datastream_7" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilderivedobject" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idsoilderivedobject"/>
    </relation>
    <relation id="soilprofile_datastream_8" providerKey="ogr" referencedLayer="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" layerName="soilprofile" name="soilprofile_datastream_8" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilprofile" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idsoilprofile"/>
    </relation>
    <relation id="soilsite_datastream_9" providerKey="ogr" referencedLayer="soilsite_e1854895_b3fd_41ff_ac7e_3581994b0560" layerName="soilsite" name="soilsite_datastream_9" dataSource="./INSPIRE_Selection_4.gpkg|layername=soilsite" referencingLayer="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" layerId="soilsite_e1854895_b3fd_41ff_ac7e_3581994b0560" strength="Composition">
      <fieldRef referencedField="guidkey" referencingField="idsoilsite"/>
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
    <field configurationFlags="None" name="idsoilsite">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="true" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilsite" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilsite_e1854895_b3fd_41ff_ac7e_3581994b0560" name="ReferencedLayerId" type="QString"/>
            <Option value="soilsite" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilsite_datastream_9" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilprofile">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="true" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" name="ReferencedLayerId" type="QString"/>
            <Option value="soilprofile" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilprofile_datastream_8" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsoilderivedobject">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="true" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilderivedobject" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="soilderivedobject_a71785e5_025c_4b3e_815a_d38e26008c1c" name="ReferencedLayerId" type="QString"/>
            <Option value="soilderivedobject" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="soilderivedobject_datastream_7" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idprofileelement">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="true" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=profileelement" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" name="ReferencedLayerId" type="QString"/>
            <Option value="profileelement" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="profileelement_datastream_6" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iddatastreamcollection">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="true" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=datastreamcollection" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="datastreamcollection_05997361_72ea_40c3_ac61_ca85ad8ea1c8" name="ReferencedLayerId" type="QString"/>
            <Option value="datastreamcollection" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="datastreamcollection_datastream_5" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idprocess">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=process" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="process_f67eda7c_192e_4137_b95f_e414d5ab4a77" name="ReferencedLayerId" type="QString"/>
            <Option value="process" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="process_datastream_4" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idobservedproperty">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=observableproperty" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" name="ReferencedLayerId" type="QString"/>
            <Option value="observableproperty" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="observableproperty_datastream_3" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idsensor">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="true" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=sensor" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="sensor_fb521675_7fbc_4e4a_ad7d_543510fee531" name="ReferencedLayerId" type="QString"/>
            <Option value="sensor" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="sensor_datastream_2" name="Relation" type="QString"/>
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
    <alias index="2" name="Soil Site" field="idsoilsite"/>
    <alias index="3" name="Soil Profile" field="idsoilprofile"/>
    <alias index="4" name="Soil Derived Object" field="idsoilderivedobject"/>
    <alias index="5" name="Profile Element" field="idprofileelement"/>
    <alias index="6" name="Datastream Collection" field="iddatastreamcollection"/>
    <alias index="7" name="Process" field="idprocess"/>
    <alias index="8" name="Property" field="idobservedproperty"/>
    <alias index="9" name="Sensor" field="idsensor"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="idsoilsite"/>
    <policy policy="DefaultValue" field="idsoilprofile"/>
    <policy policy="DefaultValue" field="idsoilderivedobject"/>
    <policy policy="DefaultValue" field="idprofileelement"/>
    <policy policy="DefaultValue" field="iddatastreamcollection"/>
    <policy policy="DefaultValue" field="idprocess"/>
    <policy policy="DefaultValue" field="idobservedproperty"/>
    <policy policy="DefaultValue" field="idsensor"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="idsoilsite"/>
    <default applyOnUpdate="0" expression="" field="idsoilprofile"/>
    <default applyOnUpdate="0" expression="" field="idsoilderivedobject"/>
    <default applyOnUpdate="0" expression="" field="idprofileelement"/>
    <default applyOnUpdate="0" expression="" field="iddatastreamcollection"/>
    <default applyOnUpdate="0" expression="" field="idprocess"/>
    <default applyOnUpdate="0" expression="" field="idobservedproperty"/>
    <default applyOnUpdate="0" expression="" field="idsensor"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="idsoilsite"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="idsoilprofile"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="idsoilderivedobject"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="idprofileelement"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="iddatastreamcollection"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idprocess"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idobservedproperty"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="idsensor"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="idsoilsite"/>
    <constraint exp="" desc="" field="idsoilprofile"/>
    <constraint exp="" desc="" field="idsoilderivedobject"/>
    <constraint exp="" desc="" field="idprofileelement"/>
    <constraint exp="" desc="" field="iddatastreamcollection"/>
    <constraint exp="" desc="" field="idprocess"/>
    <constraint exp="" desc="" field="idobservedproperty"/>
    <constraint exp="" desc="" field="idsensor"/>
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
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Feature Of Interest" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="2" name="idsoilsite" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="3" name="idsoilprofile" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="5" name="idprofileelement" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="4" name="idsoilderivedobject" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="8" name="idobservedproperty" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont bold="1" style="" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="7" name="idprocess" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont bold="1" style="" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="6" name="iddatastreamcollection" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="9" name="idsensor" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorRelation showLabel="1" relation="datastream_observation" label="" name="datastream_observation" forceSuppressFormPopup="0" nmRelationId="" horizontalStretch="0" verticalStretch="0" relationWidgetTypeId="relation_editor">
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
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="iddatastreamcollection"/>
    <field editable="1" name="idobservedproperty"/>
    <field editable="1" name="idprocess"/>
    <field editable="1" name="idprofileelement"/>
    <field editable="1" name="idsensor"/>
    <field editable="1" name="idsoilderivedobject"/>
    <field editable="1" name="idsoilprofile"/>
    <field editable="1" name="idsoilsite"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="iddatastreamcollection"/>
    <field labelOnTop="0" name="idobservedproperty"/>
    <field labelOnTop="0" name="idprocess"/>
    <field labelOnTop="0" name="idprofileelement"/>
    <field labelOnTop="0" name="idsensor"/>
    <field labelOnTop="0" name="idsoilderivedobject"/>
    <field labelOnTop="0" name="idsoilprofile"/>
    <field labelOnTop="0" name="idsoilsite"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="iddatastreamcollection"/>
    <field reuseLastValue="0" name="idobservedproperty"/>
    <field reuseLastValue="0" name="idprocess"/>
    <field reuseLastValue="0" name="idprofileelement"/>
    <field reuseLastValue="0" name="idsensor"/>
    <field reuseLastValue="0" name="idsoilderivedobject"/>
    <field reuseLastValue="0" name="idsoilprofile"/>
    <field reuseLastValue="0" name="idsoilsite"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="datastream_observation">
      <config type="Map">
        <Option value="false" name="force-suppress-popup" type="bool"/>
        <Option value="" name="nm-rel" type="QString"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>IF( "datastreamcollection" is not null, &#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'datastreamcollection',&#xd;
		'guidkey',&#xd;
		"iddatastreamcollection"&#xd;
	) &#xd;
	,'name'&#xd;
	))	&#xd;
&#xd;
||' - ','')&#xd;
&#xd;
||&#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'observableproperty',&#xd;
		'guidkey',&#xd;
		"idobservedproperty"&#xd;
	) &#xd;
	,'name'&#xd;
	))		&#xd;
	&#xd;
|| ' - ' ||&#xd;
&#xd;
COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'process',&#xd;
		'guidkey',&#xd;
		"idprocess"&#xd;
	) &#xd;
	,'name'&#xd;
	))</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
