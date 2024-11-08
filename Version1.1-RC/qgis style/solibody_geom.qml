<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <renderer-v2 symbollevels="0" referencescale="-1" type="singleSymbol" enableorderby="0" forceraster="0">
    <symbols>
      <symbol is_animated="0" force_rhr="0" type="fill" frame_rate="10" alpha="1" name="0" clip_to_extent="1">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </data_defined_properties>
        <layer locked="0" id="{cd60fe5a-d087-4cf6-9896-c24a11bff9a7}" enabled="1" class="SimpleFill" pass="0">
          <Option type="Map">
            <Option value="3x:0,0,0,0,0,0" type="QString" name="border_width_map_unit_scale"/>
            <Option value="255,170,0,255" type="QString" name="color"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="1" type="QString" name="outline_width"/>
            <Option value="Pixel" type="QString" name="outline_width_unit"/>
            <Option value="no" type="QString" name="style"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <referencedLayers>
    <relation referencingLayer="soilbody_geom_2b6b92d3_eab8_4c40_ba43_e455067579b6" referencedLayer="soilbody_5ad6dc34_beab_4c6b_b085_88d20ea779c8" id="soilbody_soilbody_geom" strength="Association" name="soilbody_soilbody_geom" providerKey="ogr" layerId="soilbody_5ad6dc34_beab_4c6b_b085_88d20ea779c8" layerName="soilbody" dataSource="./INSPIRE_SO.gpkg|layername=soilbody">
      <fieldRef referencingField="idsoilbody" referencedField="guidkey"/>
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
    <field configurationFlags="None" name="idsoilbody">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilbody" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilbody_9e604eb5_eab1_4147_aaa8_8d7a59ca703f" type="QString" name="ReferencedLayerId"/>
            <Option value="soilbody" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilbody_soilbody_geom" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="idsoilbody" index="1" name="id Soil Body"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="idsoilbody" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="idsoilbody" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" notnull_strength="1" exp_strength="0" constraints="3" unique_strength="1"/>
    <constraint field="idsoilbody" notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="idsoilbody" exp="" desc=""/>
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
  <editorlayout>generatedlayout</editorlayout>
  <attributeEditorForm>
    <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
      <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="0" name="id">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="1" name="idsoilbody">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field name="id" editable="1"/>
    <field name="idsoilbody" editable="1"/>
    <field name="idsoilbodylabel" editable="1"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idsoilbody"/>
    <field labelOnTop="0" name="idsoilbodylabel"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idsoilbody"/>
    <field reuseLastValue="0" name="idsoilbodylabel"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE(attribute(get_feature&#xd;&#xd;
	(&#xd;&#xd;
		'soilbody',&#xd;&#xd;
		'guidkey',&#xd;&#xd;
		"idsoilbody"&#xd;&#xd;
	) &#xd;&#xd;
	,'inspireid_localid'&#xd;&#xd;
	))	</previewExpression>
  <layerGeometryType>2</layerGeometryType>
</qgis>
