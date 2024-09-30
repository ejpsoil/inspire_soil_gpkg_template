<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="datastream_observation" referencedLayer="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" layerName="datastream" referencingLayer="observation_32d9f945_59fe_43ae_9cf6_bbd6c55fc2af" dataSource="./INSPIRE_SO_12.gpkg|layername=datastream" providerKey="ogr" name="datastream_observation" layerId="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" strength="Composition">
      <fieldRef referencingField="iddatastream" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="guidkey" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="phenomenontime" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="d MMM yyyy HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="resulttime" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="d MMM yyyy HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="validtime" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="d MMM yyyy HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="resultquality" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="result_value" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="result_uri" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="" name="Description"/>
            <Option type="QString" value="&quot;collection&quot;  IN (attribute(get_feature&#xa;(&#xa;&#x9;'observableproperty',&#xa;&#x9;'guidkey',&#xa;&#x9;&#xa;&#x9;attribute(get_feature&#xa;&#x9;(&#xa;&#x9;&#x9;'datastream',&#xa;&#x9;&#x9;'guidkey',&#xa;&#x9;&#x9; current_value('iddatastream')&#xa;&#x9;) &#xa;&#x9;,'idobservedproperty'&#xa;&#x9;)&#x9;&#xa;) &#xa;,'domain_code'))" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_3d50a9dd_4d09_4b58_ba39_e41d239fc7fc" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_05 - O&amp;M/INSPIRE_SO_12.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="iddatastream" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_05 - O&amp;M/INSPIRE_SO_12.gpkg|layername=datastream" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="datastream_2ac05955_6e7e_44b2_a564_b096ca480269" name="ReferencedLayerId"/>
            <Option type="QString" value="datastream" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="datastream_observation" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="typeofdata" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="domain" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="phenomenontime" index="2" name="Phenomenon Time"/>
    <alias field="resulttime" index="3" name="Result Time"/>
    <alias field="validtime" index="4" name="Valid Time"/>
    <alias field="resultquality" index="5" name="Result Quality"/>
    <alias field="result_value" index="6" name=""/>
    <alias field="result_uri" index="7" name=""/>
    <alias field="iddatastream" index="8" name="Datastream"/>
    <alias field="typeofdata" index="9" name=""/>
    <alias field="domain" index="10" name=""/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="phenomenontime" policy="DefaultValue"/>
    <policy field="resulttime" policy="DefaultValue"/>
    <policy field="validtime" policy="DefaultValue"/>
    <policy field="resultquality" policy="DefaultValue"/>
    <policy field="result_value" policy="DefaultValue"/>
    <policy field="result_uri" policy="DefaultValue"/>
    <policy field="iddatastream" policy="DefaultValue"/>
    <policy field="typeofdata" policy="DefaultValue"/>
    <policy field="domain" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="guidkey" applyOnUpdate="0" expression=""/>
    <default field="phenomenontime" applyOnUpdate="0" expression=""/>
    <default field="resulttime" applyOnUpdate="0" expression=""/>
    <default field="validtime" applyOnUpdate="0" expression=""/>
    <default field="resultquality" applyOnUpdate="0" expression=""/>
    <default field="result_value" applyOnUpdate="1" expression="if ( &quot;typeofdata&quot;  = 'result_uri',Null, &quot;result_value&quot; )"/>
    <default field="result_uri" applyOnUpdate="0" expression=""/>
    <default field="iddatastream" applyOnUpdate="0" expression=""/>
    <default field="typeofdata" applyOnUpdate="0" expression=""/>
    <default field="domain" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" notnull_strength="1" constraints="3" exp_strength="0" unique_strength="1"/>
    <constraint field="guidkey" notnull_strength="0" constraints="2" exp_strength="0" unique_strength="1"/>
    <constraint field="phenomenontime" notnull_strength="1" constraints="1" exp_strength="0" unique_strength="0"/>
    <constraint field="resulttime" notnull_strength="1" constraints="1" exp_strength="0" unique_strength="0"/>
    <constraint field="validtime" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="resultquality" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="result_value" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="result_uri" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="iddatastream" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="typeofdata" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
    <constraint field="domain" notnull_strength="0" constraints="0" exp_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="phenomenontime" exp="" desc=""/>
    <constraint field="resulttime" exp="" desc=""/>
    <constraint field="validtime" exp="" desc=""/>
    <constraint field="resultquality" exp="" desc=""/>
    <constraint field="result_value" exp="" desc=""/>
    <constraint field="result_uri" exp="" desc=""/>
    <constraint field="iddatastream" exp="" desc=""/>
    <constraint field="typeofdata" exp="" desc=""/>
    <constraint field="domain" exp="" desc=""/>
  </constraintExpressions>
  <expressionfields>
    <field type="10" subType="0" precision="0" comment="" typeName="string" expression="attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;)&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'domain_typeofvalue'&#xd;&#xa;&#x9;)" length="0" name="typeofdata"/>
    <field type="10" subType="0" precision="0" comment="" typeName="string" expression="'Domain Value: '||&#xd;&#xa;IF(&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_min'&#xd;&#xa;)) IS NOT NULL,&#xd;&#xa;--True&#xd;&#xa;'Min '||&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_min'&#xd;&#xa;))&#xd;&#xa;&#xd;&#xa;|| ' and Max ' ||&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_max'&#xd;&#xa;))&#xd;&#xa;--FALSE&#xd;&#xa;, '')&#xd;&#xa;&#xd;&#xa;&#xd;&#xa;||&#xd;&#xa;&#xd;&#xa;IF(&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'unitofmeasure',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#xd;&#xa;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;))&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'iduom'&#xd;&#xa;&#x9;&#x9;))&#xd;&#xa;) &#xd;&#xa;,'uomsymbol'&#xd;&#xa;)) &#xd;&#xa;&#xd;&#xa;is NOT NULL ,&#xd;&#xa;&#xd;&#xa;--TRUE&#xd;&#xa;' - ' ||&#xd;&#xa;&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'unitofmeasure',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#xd;&#xa;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;))&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'iduom'&#xd;&#xa;&#x9;&#x9;))&#xd;&#xa;) &#xd;&#xa;,'uomsymbol'&#xd;&#xa;)) ,&#xd;&#xa;--FALSE&#xd;&#xa;' ')" length="0" name="domain"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="2" showLabel="1" name="phenomenontime">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="3" showLabel="1" name="resulttime">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="4" showLabel="1" name="validtime">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" type="GroupBox" collapsedExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" collapsedExpression="" showLabel="1" columnCount="1" name="Numeric_Value" visibilityExpressionEnabled="1" visibilityExpression=" &quot;typeofdata&quot;  = 'result_value'&#xa;">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="10" showLabel="0" name="domain">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="6" showLabel="0" name="result_value">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" type="GroupBox" collapsedExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" collapsedExpression="" showLabel="1" columnCount="1" name="Coded_Value" visibilityExpressionEnabled="1" visibilityExpression=" &quot;typeofdata&quot;  = 'result_uri'">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="7" showLabel="1" name="result_uri">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="8" showLabel="0" name="iddatastream">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" index="5" showLabel="1" name="resultquality">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" type="GroupBox" collapsedExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" collapsedExpression="" showLabel="1" columnCount="1" name="Hidden" visibilityExpressionEnabled="1" visibilityExpression="1=0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" verticalStretch="0" index="9" showLabel="1" name="typeofdata">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" italic="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="0" name="domain"/>
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
    <field labelOnTop="0" name="domain"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="iddatastream"/>
    <field labelOnTop="0" name="phenomenontime"/>
    <field labelOnTop="0" name="result_uri"/>
    <field labelOnTop="0" name="result_value"/>
    <field labelOnTop="0" name="resultquality"/>
    <field labelOnTop="0" name="resulttime"/>
    <field labelOnTop="0" name="typeofdata"/>
    <field labelOnTop="0" name="validtime"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="domain"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="iddatastream"/>
    <field reuseLastValue="0" name="phenomenontime"/>
    <field reuseLastValue="0" name="result_uri"/>
    <field reuseLastValue="0" name="result_value"/>
    <field reuseLastValue="0" name="resultquality"/>
    <field reuseLastValue="0" name="resulttime"/>
    <field reuseLastValue="0" name="typeofdata"/>
    <field reuseLastValue="0" name="validtime"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"phenomenontime"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
