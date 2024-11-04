<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" layerId="datastream_a41706c1_e0bc_4442_8390_9430e68880e1" referencingLayer="observation_569281fb_a991_44f0_a1e0_3a119d969c09" providerKey="ogr" layerName="datastream" strength="Association" name="datastream_observation" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=datastream" id="datastream_observation">
      <fieldRef referencedField="guidkey" referencingField="iddatastream"/>
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
    <field configurationFlags="None" name="phenomenontime">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="allow_null"/>
            <Option value="true" type="bool" name="calendar_popup"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="display_format"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="field_format"/>
            <Option value="false" type="bool" name="field_format_overwrite"/>
            <Option value="false" type="bool" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="resulttime">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="true" type="bool" name="allow_null"/>
            <Option value="true" type="bool" name="calendar_popup"/>
            <Option value="dd/MM/yyyy HH:mm:ss" type="QString" name="display_format"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="field_format"/>
            <Option value="false" type="bool" name="field_format_overwrite"/>
            <Option value="false" type="bool" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="validtime">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="true" type="bool" name="allow_null"/>
            <Option value="true" type="bool" name="calendar_popup"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="display_format"/>
            <Option value="yyyy-MM-dd HH:mm:ss" type="QString" name="field_format"/>
            <Option value="false" type="bool" name="field_format_overwrite"/>
            <Option value="false" type="bool" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="resultquality">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="result_value">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="result_uri">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot;  IN (attribute(get_feature&#xa;(&#xa;&#x9;'observableproperty',&#xa;&#x9;'guidkey',&#xa;&#x9;&#xa;&#x9;attribute(get_feature&#xa;&#x9;(&#xa;&#x9;&#x9;'datastream',&#xa;&#x9;&#x9;'guidkey',&#xa;&#x9;&#x9; current_value('iddatastream')&#xa;&#x9;) &#xa;&#x9;,'idobservedproperty'&#xa;&#x9;)&#x9;&#xa;) &#xa;,'domain_code'))" type="QString" name="FilterExpression"/>
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
    <field configurationFlags="None" name="iddatastream">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=datastream" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="datastream_41c8894d_6c71_4607_a42c_ca410c56a19d" type="QString" name="ReferencedLayerId"/>
            <Option value="datastream" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="datastream_observation" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="typeofdata">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="guidkey" name="" index="1"/>
    <alias field="phenomenontime" name="Phenomenon Time" index="2"/>
    <alias field="resulttime" name="Result Time" index="3"/>
    <alias field="validtime" name="Valid Time" index="4"/>
    <alias field="resultquality" name="Result Quality" index="5"/>
    <alias field="result_value" name="" index="6"/>
    <alias field="result_uri" name="" index="7"/>
    <alias field="iddatastream" name="Datastream" index="8"/>
    <alias field="typeofdata" name="" index="9"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="phenomenontime"/>
    <policy policy="DefaultValue" field="resulttime"/>
    <policy policy="DefaultValue" field="validtime"/>
    <policy policy="DefaultValue" field="resultquality"/>
    <policy policy="DefaultValue" field="result_value"/>
    <policy policy="DefaultValue" field="result_uri"/>
    <policy policy="DefaultValue" field="iddatastream"/>
    <policy policy="DefaultValue" field="typeofdata"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="guidkey" applyOnUpdate="0"/>
    <default expression="" field="phenomenontime" applyOnUpdate="0"/>
    <default expression="" field="resulttime" applyOnUpdate="0"/>
    <default expression="" field="validtime" applyOnUpdate="0"/>
    <default expression="" field="resultquality" applyOnUpdate="0"/>
    <default expression="" field="result_value" applyOnUpdate="0"/>
    <default expression="" field="result_uri" applyOnUpdate="0"/>
    <default expression="" field="iddatastream" applyOnUpdate="0"/>
    <default expression="" field="typeofdata" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="guidkey" unique_strength="1" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="phenomenontime" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="resulttime" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="validtime" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="resultquality" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="result_value" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="result_uri" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="iddatastream" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="typeofdata" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="guidkey" desc="" exp=""/>
    <constraint field="phenomenontime" desc="" exp=""/>
    <constraint field="resulttime" desc="" exp=""/>
    <constraint field="validtime" desc="" exp=""/>
    <constraint field="resultquality" desc="" exp=""/>
    <constraint field="result_value" desc="" exp=""/>
    <constraint field="result_uri" desc="" exp=""/>
    <constraint field="iddatastream" desc="" exp=""/>
    <constraint field="typeofdata" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields>
    <field type="10" typeName="string" expression="attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;)&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'domain_typeofvalue'&#xd;&#xa;&#x9;)" comment="" length="0" name="typeofdata" precision="0" subType="0"/>
  </expressionfields>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="phenomenontime" index="2">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="resulttime" index="3">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="validtime" index="4">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;typeofdata&quot;  = 'result_value'&#xa;&#xa;" name="Numeric Value" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="result_value" index="6">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;typeofdata&quot;  = 'result_uri'" name="Coded Value" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" horizontalStretch="0" verticalStretch="0" name="result_uri" index="7">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="iddatastream" index="8">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="resultquality" index="5">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression="1=0" name="Hidden" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="typeofdata" index="9">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="iddatastream"/>
    <field editable="1" name="phenomenontime"/>
    <field editable="1" name="result_uri"/>
    <field editable="1" name="result_value"/>
    <field editable="1" name="resultquality"/>
    <field editable="1" name="resulttime"/>
    <field editable="0" name="typeofdata"/>
    <field editable="1" name="validtime"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="iddatastream"/>
    <field labelOnTop="0" name="phenomenontime"/>
    <field labelOnTop="0" name="result_uri"/>
    <field labelOnTop="1" name="result_value"/>
    <field labelOnTop="0" name="resultquality"/>
    <field labelOnTop="0" name="resulttime"/>
    <field labelOnTop="0" name="typeofdata"/>
    <field labelOnTop="0" name="validtime"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="iddatastream" reuseLastValue="0"/>
    <field name="phenomenontime" reuseLastValue="0"/>
    <field name="result_uri" reuseLastValue="0"/>
    <field name="result_value" reuseLastValue="0"/>
    <field name="resultquality" reuseLastValue="0"/>
    <field name="resulttime" reuseLastValue="0"/>
    <field name="typeofdata" reuseLastValue="0"/>
    <field name="validtime" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties>
    <field name="result_value">
      <Option type="Map">
        <Option value="" type="QString" name="name"/>
        <Option type="Map" name="properties">
          <Option type="Map" name="dataDefinedAlias">
            <Option value="true" type="bool" name="active"/>
            <Option value="'Domain Value: '&#xd;&#xa;&#xd;&#xa;||&#xd;&#xa;&#xd;&#xa;&#xd;&#xa;IF(&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_min'&#xd;&#xa;)) IS NOT NULL,&#xd;&#xa;--True&#xd;&#xa;'Min '||&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_min'&#xd;&#xa;))&#xd;&#xa;&#xd;&#xa;|| ' - Max ' ||&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_max'&#xd;&#xa;))&#xd;&#xa;--FALSE&#xd;&#xa;, '')&#xd;&#xa;&#xd;&#xa;&#xd;&#xa;||&#xd;&#xa;&#xd;&#xa;IF(&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'unitofmeasure',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#xd;&#xa;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;))&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'iduom'&#xd;&#xa;&#x9;&#x9;))&#xd;&#xa;) &#xd;&#xa;,'uomsymbol'&#xd;&#xa;)) &#xd;&#xa;&#xd;&#xa;is NOT NULL ,&#xd;&#xa;&#xd;&#xa;--TRUE&#xd;&#xa;' - ' ||&#xd;&#xa;&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'unitofmeasure',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#xd;&#xa;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;))&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'iduom'&#xd;&#xa;&#x9;&#x9;))&#xd;&#xa;) &#xd;&#xa;,'uomsymbol'&#xd;&#xa;)) ,&#xd;&#xa;--FALSE&#xd;&#xa;' ')" type="QString" name="expression"/>
            <Option value="3" type="int" name="type"/>
          </Option>
        </Option>
        <Option value="collection" type="QString" name="type"/>
      </Option>
    </field>
  </dataDefinedFieldProperties>
  <widgets/>
  <previewExpression>regexp_replace(  &#xd;
&#xd;
attribute(get_feature&#xd;
(&#xd;
	'observableproperty',&#xd;
	'guidkey',&#xd;
	&#xd;
	COALESCE(attribute(get_feature&#xd;
	(&#xd;
		'datastream',&#xd;
		'guidkey',&#xd;
		"iddatastream"&#xd;
	) &#xd;
	,'idobservedproperty'&#xd;
	))		&#xd;
) &#xd;
,'basephenomenon'),&#xd;
&#xd;
'.*/', '')</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
