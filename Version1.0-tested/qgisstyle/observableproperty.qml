<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="unitofmeasure_ca12ed79_c5be_49bf_aaed_d5478fac61fb" layerId="unitofmeasure_ca12ed79_c5be_49bf_aaed_d5478fac61fb" referencingLayer="observableproperty_54541782_41af_4d65_9367_01527efa7b4d" providerKey="ogr" layerName="unitofmeasure" strength="Association" name="unitofmeasure_observableproperty" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=unitofmeasure" id="unitofmeasure_observableproperty">
      <fieldRef referencedField="guidkey" referencingField="iduom"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="guidkey">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="definition">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="description">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="foi">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('FOIType') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="phenomenontype">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('PhenomenonType') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="basephenomenon">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value=" &quot;foi_phenomenon&quot; = current_value('foi')+current_value('phenomenontype') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_min">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_max">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_typeofvalue">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map">
                <Option value="result_value" type="QString" name="Numeric Value"/>
              </Option>
              <Option type="Map">
                <Option value="result_uri" type="QString" name="Coded Value"/>
              </Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_code">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="true" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN ('PropertyCoded')" type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iduom">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=unitofmeasure" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="unitofmeasure_4a09664c_ea4b_45c2_8f39_23241bbc8077" type="QString" name="ReferencedLayerId"/>
            <Option value="unitofmeasure" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="unitofmeasure_observableproperty" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="guidkey" name="" index="1"/>
    <alias field="name" name="Name" index="2"/>
    <alias field="definition" name="Definition" index="3"/>
    <alias field="description" name="Descriprion" index="4"/>
    <alias field="foi" name="Feture Of Interest" index="5"/>
    <alias field="phenomenontype" name="Phenomenon Type" index="6"/>
    <alias field="basephenomenon" name="Base Phenomenon" index="7"/>
    <alias field="domain_min" name="Min Value" index="8"/>
    <alias field="domain_max" name="Max Value" index="9"/>
    <alias field="domain_typeofvalue" name="Type of Value" index="10"/>
    <alias field="domain_code" name="" index="11"/>
    <alias field="iduom" name="Unit Of Measure" index="12"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="name"/>
    <policy policy="DefaultValue" field="definition"/>
    <policy policy="DefaultValue" field="description"/>
    <policy policy="DefaultValue" field="foi"/>
    <policy policy="DefaultValue" field="phenomenontype"/>
    <policy policy="DefaultValue" field="basephenomenon"/>
    <policy policy="DefaultValue" field="domain_min"/>
    <policy policy="DefaultValue" field="domain_max"/>
    <policy policy="DefaultValue" field="domain_typeofvalue"/>
    <policy policy="DefaultValue" field="domain_code"/>
    <policy policy="DefaultValue" field="iduom"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="guidkey" applyOnUpdate="0"/>
    <default expression="" field="name" applyOnUpdate="0"/>
    <default expression="" field="definition" applyOnUpdate="0"/>
    <default expression="" field="description" applyOnUpdate="0"/>
    <default expression="" field="foi" applyOnUpdate="0"/>
    <default expression="" field="phenomenontype" applyOnUpdate="0"/>
    <default expression="" field="basephenomenon" applyOnUpdate="0"/>
    <default expression="" field="domain_min" applyOnUpdate="0"/>
    <default expression="" field="domain_max" applyOnUpdate="0"/>
    <default expression="" field="domain_typeofvalue" applyOnUpdate="0"/>
    <default expression="" field="domain_code" applyOnUpdate="0"/>
    <default expression="" field="iduom" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="guidkey" unique_strength="1" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="name" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="definition" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="description" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="foi" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="phenomenontype" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="basephenomenon" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="domain_min" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="domain_max" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="domain_typeofvalue" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="domain_code" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="iduom" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="guidkey" desc="" exp=""/>
    <constraint field="name" desc="" exp=""/>
    <constraint field="definition" desc="" exp=""/>
    <constraint field="description" desc="" exp=""/>
    <constraint field="foi" desc="" exp=""/>
    <constraint field="phenomenontype" desc="" exp=""/>
    <constraint field="basephenomenon" desc="" exp=""/>
    <constraint field="domain_min" desc="" exp=""/>
    <constraint field="domain_max" desc="" exp=""/>
    <constraint field="domain_typeofvalue" desc="" exp=""/>
    <constraint field="domain_code" desc="" exp=""/>
    <constraint field="iduom" desc="" exp=""/>
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
    <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
    </labelStyle>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Property" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="name" index="2">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="definition" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="description" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="foi" index="5">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="phenomenontype" index="6">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="basephenomenon" index="7">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="iduom" index="12">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Type Of Domain Value" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" horizontalStretch="0" verticalStretch="0" name="domain_typeofvalue" index="10">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer showLabel="0" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Row" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_value'" name="Value Domain" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="domain_min" index="8">
          <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="domain_max" index="9">
          <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
      <attributeEditorContainer showLabel="0" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Row" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_uri'" name="Coced Value" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="domain_code" index="11">
          <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="basephenomenon"/>
    <field editable="1" name="definition"/>
    <field editable="1" name="description"/>
    <field editable="1" name="domain_code"/>
    <field editable="1" name="domain_max"/>
    <field editable="1" name="domain_min"/>
    <field editable="1" name="domain_typeofvalue"/>
    <field editable="1" name="foi"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="iduom"/>
    <field editable="1" name="name"/>
    <field editable="1" name="phenomenontype"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="basephenomenon"/>
    <field labelOnTop="0" name="definition"/>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="domain_code"/>
    <field labelOnTop="0" name="domain_max"/>
    <field labelOnTop="0" name="domain_min"/>
    <field labelOnTop="0" name="domain_typeofvalue"/>
    <field labelOnTop="0" name="foi"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="iduom"/>
    <field labelOnTop="0" name="name"/>
    <field labelOnTop="0" name="phenomenontype"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="basephenomenon" reuseLastValue="0"/>
    <field name="definition" reuseLastValue="0"/>
    <field name="description" reuseLastValue="0"/>
    <field name="domain_code" reuseLastValue="0"/>
    <field name="domain_max" reuseLastValue="0"/>
    <field name="domain_min" reuseLastValue="0"/>
    <field name="domain_typeofvalue" reuseLastValue="0"/>
    <field name="foi" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="iduom" reuseLastValue="0"/>
    <field name="name" reuseLastValue="0"/>
    <field name="phenomenontype" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
