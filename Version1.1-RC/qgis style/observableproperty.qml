<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation strength="Association" dataSource="./INSPIRE_SO.gpkg|layername=unitofmeasure" referencedLayer="unitofmeasure_02d878f2_36b3_4f5c_8712_6434479e0f46" referencingLayer="observableproperty_8f63be5a_c2e8_4713_bca6_7b4895cde2c1" id="unitofmeasure_observableproperty" layerId="unitofmeasure_02d878f2_36b3_4f5c_8712_6434479e0f46" layerName="unitofmeasure" providerKey="ogr" name="unitofmeasure_observableproperty">
      <fieldRef referencedField="guidkey" referencingField="iduom"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="guidkey">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="foi">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('FOIType') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_7257b262_7388_468b_a269_2546711c92b6" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/_INSPIRE_NOV24/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="phenomenontype">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('PhenomenonType') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="basephenomenon">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value=" &quot;foi_phenomenon&quot; = current_value('foi')+current_value('phenomenontype') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Corso Qgis/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_min">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain_max">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
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
                <Option type="QString" value="result_value" name="Numeric Value"/>
              </Option>
              <Option type="Map">
                <Option type="QString" value="result_uri" name="Coded Value"/>
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
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN ('PropertyCoded')" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="iduom">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/_INSPIRE_NOV24/INSPIRE_SO.gpkg|layername=unitofmeasure" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="unitofmeasure_02d878f2_36b3_4f5c_8712_6434479e0f46" name="ReferencedLayerId"/>
            <Option type="QString" value="unitofmeasure" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="unitofmeasure_observableproperty" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="id" name=""/>
    <alias index="1" field="guidkey" name=""/>
    <alias index="2" field="name" name="Name"/>
    <alias index="3" field="foi" name="Feature Of Interest"/>
    <alias index="4" field="phenomenontype" name="Phenomenon Type"/>
    <alias index="5" field="basephenomenon" name="Base Phenomenon"/>
    <alias index="6" field="domain_min" name="Min Value"/>
    <alias index="7" field="domain_max" name="Max Value"/>
    <alias index="8" field="domain_typeofvalue" name="Type of Value"/>
    <alias index="9" field="domain_code" name=""/>
    <alias index="10" field="iduom" name="Unit Of Measure"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="name"/>
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
    <constraint constraints="3" unique_strength="1" notnull_strength="1" exp_strength="0" field="id"/>
    <constraint constraints="2" unique_strength="1" notnull_strength="0" exp_strength="0" field="guidkey"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="name"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="foi"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="phenomenontype"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="basephenomenon"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="domain_min"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="domain_max"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="domain_typeofvalue"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="domain_code"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="iduom"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="guidkey"/>
    <constraint desc="" exp="" field="name"/>
    <constraint desc="" exp="" field="foi"/>
    <constraint desc="" exp="" field="phenomenontype"/>
    <constraint desc="" exp="" field="basephenomenon"/>
    <constraint desc="" exp="" field="domain_min"/>
    <constraint desc="" exp="" field="domain_max"/>
    <constraint desc="" exp="" field="domain_typeofvalue"/>
    <constraint desc="" exp="" field="domain_code"/>
    <constraint desc="" exp="" field="iduom"/>
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
      <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
    </labelStyle>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Property">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="2" verticalStretch="0" name="name">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="-1" verticalStretch="0" name="definition">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="-1" verticalStretch="0" name="description">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Phenomenon">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="3" verticalStretch="0" name="foi">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="4" verticalStretch="0" name="phenomenontype">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="5" verticalStretch="0" name="basephenomenon">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="10" verticalStretch="0" name="iduom">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Type Of Domain Value">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" horizontalStretch="0" index="8" verticalStretch="0" name="domain_typeofvalue">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer collapsed="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_value'" groupBox="0" showLabel="0" collapsedExpression="" horizontalStretch="0" columnCount="1" type="Row" visibilityExpressionEnabled="1" verticalStretch="0" collapsedExpressionEnabled="0" name="Value Domain">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" horizontalStretch="0" index="6" verticalStretch="0" name="domain_min">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" horizontalStretch="0" index="7" verticalStretch="0" name="domain_max">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
      <attributeEditorContainer collapsed="0" visibilityExpression=" &quot;domain_typeofvalue&quot; = 'result_uri'" groupBox="0" showLabel="0" collapsedExpression="" horizontalStretch="0" columnCount="1" type="Row" visibilityExpressionEnabled="1" verticalStretch="0" collapsedExpressionEnabled="0" name="Coced Value">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" horizontalStretch="0" index="9" verticalStretch="0" name="domain_code">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
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
  <previewExpression>COALESCE( "foi", '&lt;NULL>' )&#xd;&#xd;
 || ' - ' || &#xd;&#xd;
 COALESCE( "name", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
