<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencingLayer="observableproperty_3411d313_79d3_41e7_8c93_64f5346f06a5" layerName="unitofmeasure" strength="Association" name="unitofmeasure_observableproperty" referencedLayer="unitofmeasure_5f72ea2d_ac78_4ee6_94c9_4526b5d663c0" dataSource="./INSPIRE_SO_07.gpkg|layername=unitofmeasure" layerId="unitofmeasure_5f72ea2d_ac78_4ee6_94c9_4526b5d663c0" providerKey="ogr" id="unitofmeasure_observableproperty">
      <fieldRef referencedField="guidkey" referencingField="iduom"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="guidkey" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="name" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="foi" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('FOIType') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="phenomenontype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('PhenomenonType') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="basephenomenon" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value=" &quot;foi_phenomenon&quot; = current_value('foi')+current_value('phenomenontype') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="domain_min" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="domain_max" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="domain_typeofvalue" configurationFlags="None">
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
    <field name="domain_code" configurationFlags="None">
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
    <field name="iduom" configurationFlags="None">
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
    <alias field="foi" name="Feture Of Interest" index="3"/>
    <alias field="phenomenontype" name="Phenomenon Type" index="4"/>
    <alias field="basephenomenon" name="Base Phenomenon" index="5"/>
    <alias field="domain_min" name="Min Value" index="6"/>
    <alias field="domain_max" name="Max Value" index="7"/>
    <alias field="domain_typeofvalue" name="Type of Value" index="8"/>
    <alias field="domain_code" name="" index="9"/>
    <alias field="iduom" name="Unit Of Measure" index="10"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="name" policy="DefaultValue"/>
    <policy field="foi" policy="DefaultValue"/>
    <policy field="phenomenontype" policy="DefaultValue"/>
    <policy field="basephenomenon" policy="DefaultValue"/>
    <policy field="domain_min" policy="DefaultValue"/>
    <policy field="domain_max" policy="DefaultValue"/>
    <policy field="domain_typeofvalue" policy="DefaultValue"/>
    <policy field="domain_code" policy="DefaultValue"/>
    <policy field="iduom" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="id"/>
    <default expression="" applyOnUpdate="0" field="guidkey"/>
    <default expression="" applyOnUpdate="0" field="name"/>
    <default expression="" applyOnUpdate="0" field="foi"/>
    <default expression="" applyOnUpdate="0" field="phenomenontype"/>
    <default expression="" applyOnUpdate="0" field="basephenomenon"/>
    <default expression="" applyOnUpdate="0" field="domain_min"/>
    <default expression="" applyOnUpdate="0" field="domain_max"/>
    <default expression="" applyOnUpdate="0" field="domain_typeofvalue"/>
    <default expression="" applyOnUpdate="0" field="domain_code"/>
    <default expression="" applyOnUpdate="0" field="iduom"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="1" field="id" constraints="3"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="1" field="guidkey" constraints="2"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="name" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="foi" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="phenomenontype" constraints="0"/>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="0" field="basephenomenon" constraints="1"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="domain_min" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="domain_max" constraints="0"/>
    <constraint notnull_strength="1" exp_strength="0" unique_strength="0" field="domain_typeofvalue" constraints="1"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="domain_code" constraints="0"/>
    <constraint notnull_strength="0" exp_strength="0" unique_strength="0" field="iduom" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="foi"/>
    <constraint exp="" desc="" field="phenomenontype"/>
    <constraint exp="" desc="" field="basephenomenon"/>
    <constraint exp="" desc="" field="domain_min"/>
    <constraint exp="" desc="" field="domain_max"/>
    <constraint exp="" desc="" field="domain_typeofvalue"/>
    <constraint exp="" desc="" field="domain_code"/>
    <constraint exp="" desc="" field="iduom"/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Property">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="name" index="2">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="definition" index="-1">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="description" index="-1">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Phenomenon">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="foi" index="3">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="phenomenontype" index="4">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="basephenomenon" index="5">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="iduom" index="10">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="GroupBox" showLabel="1" columnCount="1" groupBox="1" visibilityExpression="" name="Type Of Domain Value">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="0" name="domain_typeofvalue" index="8">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="1" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Row" showLabel="0" columnCount="1" groupBox="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_value'" name="Value Domain">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="domain_min" index="6">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="domain_max" index="7">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
      <attributeEditorContainer horizontalStretch="0" collapsed="0" visibilityExpressionEnabled="1" collapsedExpressionEnabled="0" verticalStretch="0" collapsedExpression="" type="Row" showLabel="0" columnCount="1" groupBox="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_uri'" name="Coced Value">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
        <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="domain_code" index="9">
          <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
            <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" strikethrough="0" underline="0" style=""/>
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
    <field name="basephenomenon" labelOnTop="0"/>
    <field name="definition" labelOnTop="0"/>
    <field name="description" labelOnTop="0"/>
    <field name="domain_code" labelOnTop="0"/>
    <field name="domain_max" labelOnTop="0"/>
    <field name="domain_min" labelOnTop="0"/>
    <field name="domain_typeofvalue" labelOnTop="0"/>
    <field name="foi" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="iduom" labelOnTop="0"/>
    <field name="name" labelOnTop="0"/>
    <field name="phenomenontype" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="basephenomenon"/>
    <field reuseLastValue="0" name="definition"/>
    <field reuseLastValue="0" name="description"/>
    <field reuseLastValue="0" name="domain_code"/>
    <field reuseLastValue="0" name="domain_max"/>
    <field reuseLastValue="0" name="domain_min"/>
    <field reuseLastValue="0" name="domain_typeofvalue"/>
    <field reuseLastValue="0" name="foi"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="iduom"/>
    <field reuseLastValue="0" name="name"/>
    <field reuseLastValue="0" name="phenomenontype"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "foi", '&lt;NULL>' )&#xd;
 || ' - ' || &#xd;
 COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
