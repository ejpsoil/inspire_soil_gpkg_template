<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" layerId="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" referencingLayer="othersoilnametype_7faf9a1f_68a4_406e_8088_2b650db9079f" providerKey="ogr" layerName="soilprofile" strength="Association" name="soilprofile_othersoilnametype" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilprofile" id="soilprofile_othersoilnametype">
      <fieldRef referencedField="guidkey" referencingField="othersoilname"/>
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
    <field configurationFlags="None" name="othersoilname_type">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('OtherSoilNameTypeValue') " type="QString" name="FilterExpression"/>
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
    <field configurationFlags="None" name="othersoilname_class">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isoriginalclassification">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option value="" type="QString" name="CheckedState"/>
            <Option value="0" type="int" name="TextDisplayMethod"/>
            <Option value="" type="QString" name="UncheckedState"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="othersoilname">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=soilprofile" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilprofile_e19d0f33_d3eb_4c7f_86d4_7b842ac7e511" type="QString" name="ReferencedLayerId"/>
            <Option value="soilprofile" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilprofile_othersoilnametype" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="othersoilname_type" name="Type" index="1"/>
    <alias field="othersoilname_class" name="Class" index="2"/>
    <alias field="isoriginalclassification" name="It is an Original classification" index="3"/>
    <alias field="othersoilname" name="Other Soil Name" index="4"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="othersoilname_type"/>
    <policy policy="DefaultValue" field="othersoilname_class"/>
    <policy policy="DefaultValue" field="isoriginalclassification"/>
    <policy policy="DefaultValue" field="othersoilname"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="othersoilname_type" applyOnUpdate="0"/>
    <default expression="" field="othersoilname_class" applyOnUpdate="0"/>
    <default expression="" field="isoriginalclassification" applyOnUpdate="0"/>
    <default expression="" field="othersoilname" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="othersoilname_type" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="othersoilname_class" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="isoriginalclassification" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="othersoilname" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="othersoilname_type" desc="" exp=""/>
    <constraint field="othersoilname_class" desc="" exp=""/>
    <constraint field="isoriginalclassification" desc="" exp=""/>
    <constraint field="othersoilname" desc="" exp=""/>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="id" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="othersoilname_type" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="othersoilname_class" index="2">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="isoriginalclassification" index="3">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="othersoilname" index="4">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="id"/>
    <field editable="1" name="isoriginalclassification"/>
    <field editable="1" name="othersoilname"/>
    <field editable="1" name="othersoilname_class"/>
    <field editable="1" name="othersoilname_type"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="isoriginalclassification"/>
    <field labelOnTop="0" name="othersoilname"/>
    <field labelOnTop="0" name="othersoilname_class"/>
    <field labelOnTop="0" name="othersoilname_type"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="id" reuseLastValue="0"/>
    <field name="isoriginalclassification" reuseLastValue="0"/>
    <field name="othersoilname" reuseLastValue="0"/>
    <field name="othersoilname_class" reuseLastValue="0"/>
    <field name="othersoilname_type" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>regexp_substr(COALESCE( "othersoilname_type", '&lt;NULL>' ), '/([^/]+)$')&#xd;
|| ' - ' ||&#xd;
 "othersoilname_class" &#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
