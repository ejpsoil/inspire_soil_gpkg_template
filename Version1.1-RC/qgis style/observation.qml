<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation strength="Association" referencingLayer="observation_f74eff24_f45f_4ad1_9e08_2cd4df4f6233" referencedLayer="datastream_06f0115e_dcb8_469b_bb08_0b0156e72e97" layerName="datastream" layerId="datastream_06f0115e_dcb8_469b_bb08_0b0156e72e97" providerKey="ogr" id="datastream_observation" name="datastream_observation" dataSource="./INSPIRE_SO.gpkg|layername=datastream">
      <fieldRef referencingField="iddatastream" referencedField="guidkey"/>
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
    <field configurationFlags="None" name="phenomenontime">
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
    <field configurationFlags="None" name="resulttime">
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
    <field configurationFlags="None" name="validtime">
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
    <field configurationFlags="None" name="resultquality">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="result_value">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="result_uri">
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
    <field configurationFlags="None" name="iddatastream">
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
    <field configurationFlags="None" name="typeofdata">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="domain">
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
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="Phenomenon Time" field="phenomenontime"/>
    <alias index="3" name="Result Time" field="resulttime"/>
    <alias index="4" name="Valid Time" field="validtime"/>
    <alias index="5" name="Result Quality" field="resultquality"/>
    <alias index="6" name="" field="result_value"/>
    <alias index="7" name="" field="result_uri"/>
    <alias index="8" name="Datastream" field="iddatastream"/>
    <alias index="9" name="" field="typeofdata"/>
    <alias index="10" name="" field="domain"/>
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
    <policy policy="DefaultValue" field="domain"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="phenomenontime"/>
    <default applyOnUpdate="0" expression="" field="resulttime"/>
    <default applyOnUpdate="0" expression="" field="validtime"/>
    <default applyOnUpdate="0" expression="" field="resultquality"/>
    <default applyOnUpdate="1" expression="if ( &quot;typeofdata&quot;  = 'result_uri',Null, &quot;result_value&quot; )" field="result_value"/>
    <default applyOnUpdate="0" expression="" field="result_uri"/>
    <default applyOnUpdate="0" expression="" field="iddatastream"/>
    <default applyOnUpdate="0" expression="" field="typeofdata"/>
    <default applyOnUpdate="0" expression="" field="domain"/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" exp_strength="0" field="id" unique_strength="1"/>
    <constraint constraints="2" notnull_strength="0" exp_strength="0" field="guidkey" unique_strength="1"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="phenomenontime" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="resulttime" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="validtime" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="resultquality" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="result_value" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="result_uri" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="iddatastream" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="typeofdata" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="domain" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="guidkey"/>
    <constraint desc="" exp="" field="phenomenontime"/>
    <constraint desc="" exp="" field="resulttime"/>
    <constraint desc="" exp="" field="validtime"/>
    <constraint desc="" exp="" field="resultquality"/>
    <constraint desc="" exp="" field="result_value"/>
    <constraint desc="" exp="" field="result_uri"/>
    <constraint desc="" exp="" field="iddatastream"/>
    <constraint desc="" exp="" field="typeofdata"/>
    <constraint desc="" exp="" field="domain"/>
  </constraintExpressions>
  <expressionfields>
    <field type="10" comment="" length="0" typeName="string" expression="attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;)&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'domain_typeofvalue'&#xd;&#xa;&#x9;)" name="typeofdata" subType="0" precision="0"/>
    <field type="10" comment="" length="0" typeName="string" expression="'Domain Value: '||&#xd;&#xa;IF(&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_min'&#xd;&#xa;)) IS NOT NULL,&#xd;&#xa;--True&#xd;&#xa;'Min '||&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_min'&#xd;&#xa;))&#xd;&#xa;&#xd;&#xa;|| ' and Max ' ||&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'observableproperty',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;(&#xd;&#xa;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;) &#xd;&#xa;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;))&#x9;&#x9;&#xd;&#xa;) &#xd;&#xa;,'domain_max'&#xd;&#xa;))&#xd;&#xa;--FALSE&#xd;&#xa;, '')&#xd;&#xa;&#xd;&#xa;&#xd;&#xa;||&#xd;&#xa;&#xd;&#xa;IF(&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'unitofmeasure',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#xd;&#xa;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;))&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'iduom'&#xd;&#xa;&#x9;&#x9;))&#xd;&#xa;) &#xd;&#xa;,'uomsymbol'&#xd;&#xa;)) &#xd;&#xa;&#xd;&#xa;is NOT NULL ,&#xd;&#xa;&#xd;&#xa;--TRUE&#xd;&#xa;' - ' ||&#xd;&#xa;&#xd;&#xa;COALESCE(attribute(get_feature&#xd;&#xa;(&#xd;&#xa;&#x9;'unitofmeasure',&#xd;&#xa;&#x9;'guidkey',&#xd;&#xa;&#x9;&#xd;&#xa;&#xd;&#xa;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;'observableproperty',&#xd;&#xa;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;&#x9;COALESCE(attribute(get_feature&#xd;&#xa;&#x9;&#x9;&#x9;(&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'datastream',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;'guidkey',&#xd;&#xa;&#x9;&#x9;&#x9;&#x9;&quot;iddatastream&quot;&#xd;&#xa;&#x9;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;&#x9;,'idobservedproperty'&#xd;&#xa;&#x9;&#x9;&#x9;))&#x9;&#x9;&#xd;&#xa;&#x9;&#x9;) &#xd;&#xa;&#x9;&#x9;,'iduom'&#xd;&#xa;&#x9;&#x9;))&#xd;&#xa;) &#xd;&#xa;,'uomsymbol'&#xd;&#xa;)) ,&#xd;&#xa;--FALSE&#xd;&#xa;' ')" name="domain" subType="0" precision="0"/>
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
      <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="2" horizontalStretch="0" name="phenomenontime" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="3" horizontalStretch="0" name="resulttime" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="4" horizontalStretch="0" name="validtime" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;typeofdata&quot;  = 'result_value'&#xa;" horizontalStretch="0" name="Numeric_Value" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" index="10" horizontalStretch="0" name="domain" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="0" index="6" horizontalStretch="0" name="result_value" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;typeofdata&quot;  = 'result_uri'" horizontalStretch="0" name="Coded_Value" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="7" horizontalStretch="0" name="result_uri" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="0" index="8" horizontalStretch="0" name="iddatastream" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="5" horizontalStretch="0" name="resultquality" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="1=0" horizontalStretch="0" name="Hidden" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="9" horizontalStretch="0" name="typeofdata" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
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
