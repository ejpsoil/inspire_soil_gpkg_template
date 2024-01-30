<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="unitofmeasure_observableproperty" providerKey="ogr" referencedLayer="unitofmeasure_4a09664c_ea4b_45c2_8f39_23241bbc8077" layerName="unitofmeasure" name="unitofmeasure_observableproperty" dataSource="./INSPIRE_Selection_4.gpkg|layername=unitofmeasure" referencingLayer="observableproperty_f892a84a_e3f5_40d1_82d1_d5a70fbafff0" layerId="unitofmeasure_4a09664c_ea4b_45c2_8f39_23241bbc8077" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="iduom"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
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
    <field configurationFlags="None" name="definition">
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
    <field configurationFlags="None" name="foi">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FOIType') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="phenomenontype">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('PhenomenonType') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="basephenomenon">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value=" &quot;foi_phenomenon&quot; = current_value('foi')+current_value('phenomenontype') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_min">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_max">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_typeofvalue">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option name="map" type="List">
              <Option type="Map">
                <Option value="result_value" name="Numeric Value" type="QString"/>
              </Option>
              <Option type="Map">
                <Option value="result_uri" name="Coded Value" type="QString"/>
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
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN ('PropertyCoded')" name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iduom">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=unitofmeasure" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="unitofmeasure_4a09664c_ea4b_45c2_8f39_23241bbc8077" name="ReferencedLayerId" type="QString"/>
            <Option value="unitofmeasure" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="unitofmeasure_observableproperty" name="Relation" type="QString"/>
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
    <alias index="3" name="Definition" field="definition"/>
    <alias index="4" name="Descriprion" field="description"/>
    <alias index="5" name="Feture Of Interest" field="foi"/>
    <alias index="6" name="Phenomenon Type" field="phenomenontype"/>
    <alias index="7" name="Base Phenomenon" field="basephenomenon"/>
    <alias index="8" name="Min Value" field="domain_min"/>
    <alias index="9" name="Max Value" field="domain_max"/>
    <alias index="10" name="Type of Value" field="domain_typeofvalue"/>
    <alias index="11" name="" field="domain_code"/>
    <alias index="12" name="Unit Of Measure" field="iduom"/>
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
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="name"/>
    <default applyOnUpdate="0" expression="" field="definition"/>
    <default applyOnUpdate="0" expression="" field="description"/>
    <default applyOnUpdate="0" expression="" field="foi"/>
    <default applyOnUpdate="0" expression="" field="phenomenontype"/>
    <default applyOnUpdate="0" expression="" field="basephenomenon"/>
    <default applyOnUpdate="0" expression="" field="domain_min"/>
    <default applyOnUpdate="0" expression="" field="domain_max"/>
    <default applyOnUpdate="0" expression="" field="domain_typeofvalue"/>
    <default applyOnUpdate="0" expression="" field="domain_code"/>
    <default applyOnUpdate="0" expression="" field="iduom"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="name"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="definition"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="description"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="foi"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="phenomenontype"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="basephenomenon"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="domain_min"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="domain_max"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="domain_typeofvalue"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="domain_code"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="iduom"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="definition"/>
    <constraint exp="" desc="" field="description"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
    </labelStyle>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Property" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="2" name="name" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="3" name="definition" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="4" name="description" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="5" name="foi" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="6" name="phenomenontype" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="7" name="basephenomenon" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="12" name="iduom" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Type Of Domain Value" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" index="10" name="domain_typeofvalue" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer columnCount="1" showLabel="0" collapsedExpressionEnabled="0" collapsedExpression="" name="Value Domain" visibilityExpressionEnabled="1" horizontalStretch="0" verticalStretch="0" groupBox="0" type="Row" collapsed="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_value'">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" index="8" name="domain_min" horizontalStretch="0" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" index="9" name="domain_max" horizontalStretch="0" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
      <attributeEditorContainer columnCount="1" showLabel="0" collapsedExpressionEnabled="0" collapsedExpression="" name="Coced Value" visibilityExpressionEnabled="1" horizontalStretch="0" verticalStretch="0" groupBox="0" type="Row" collapsed="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_uri'">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" index="11" name="domain_code" horizontalStretch="0" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
  <previewExpression>COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
