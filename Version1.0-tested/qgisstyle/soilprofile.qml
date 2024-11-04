<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="soilplot_411146e5_ca8f_4659_a430_a75db29eb32e" layerId="soilplot_411146e5_ca8f_4659_a430_a75db29eb32e" referencingLayer="soilprofile_8ce3bd32_cf10_4c90_8870_2b9420461acf" providerKey="ogr" layerName="soilplot" strength="Association" name="soilplot_soilprofile" dataSource="./INSPIRE_SO_DEMO_QGIS_V01.gpkg|layername=soilplot" id="soilplot_soilprofile">
      <fieldRef referencedField="guidkey" referencingField="location"/>
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
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="localidentifier">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="beginlifespanversion">
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
    <field configurationFlags="None" name="endlifespanversion">
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
    <field configurationFlags="None" name="validfrom">
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
    <field configurationFlags="None" name="validto">
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
    <field configurationFlags="None" name="isderived">
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
    <field configurationFlags="None" name="wrbreferencesoilgroup">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="true" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('WRBReferenceSoilGroupValue') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_054f6089_cc9f_4561_976d_2dc9d8c1a7b6" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPK_Soil_03/GPK_Soil_03.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
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
    <field configurationFlags="None" name="location">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilplot" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="soilplot_b1bf44ed_bd29_4858_b4c8_5694622c97fa" type="QString" name="ReferencedLayerId"/>
            <Option value="soilplot" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="soilplot_soilprofile" type="QString" name="Relation"/>
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
    <alias field="inspireid_localid" name="Local id" index="2"/>
    <alias field="inspireid_namespace" name="Namespace" index="3"/>
    <alias field="inspireid_versionid" name="Veersion id" index="4"/>
    <alias field="localidentifier" name="Local identifier" index="5"/>
    <alias field="beginlifespanversion" name="Begin Lifespan version" index="6"/>
    <alias field="endlifespanversion" name="End Lifespan version" index="7"/>
    <alias field="validfrom" name="Valid From" index="8"/>
    <alias field="validto" name="Valid To" index="9"/>
    <alias field="isderived" name="Is Derived" index="10"/>
    <alias field="wrbreferencesoilgroup" name="World Reference Base" index="11"/>
    <alias field="isoriginalclassification" name="It is an Original classification" index="12"/>
    <alias field="location" name="" index="13"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="inspireid_localid"/>
    <policy policy="DefaultValue" field="inspireid_namespace"/>
    <policy policy="DefaultValue" field="inspireid_versionid"/>
    <policy policy="DefaultValue" field="localidentifier"/>
    <policy policy="DefaultValue" field="beginlifespanversion"/>
    <policy policy="DefaultValue" field="endlifespanversion"/>
    <policy policy="DefaultValue" field="validfrom"/>
    <policy policy="DefaultValue" field="validto"/>
    <policy policy="DefaultValue" field="isderived"/>
    <policy policy="DefaultValue" field="wrbreferencesoilgroup"/>
    <policy policy="DefaultValue" field="isoriginalclassification"/>
    <policy policy="DefaultValue" field="location"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="guidkey" applyOnUpdate="0"/>
    <default expression="" field="inspireid_localid" applyOnUpdate="0"/>
    <default expression="" field="inspireid_namespace" applyOnUpdate="0"/>
    <default expression="" field="inspireid_versionid" applyOnUpdate="0"/>
    <default expression="" field="localidentifier" applyOnUpdate="0"/>
    <default expression="" field="beginlifespanversion" applyOnUpdate="0"/>
    <default expression="" field="endlifespanversion" applyOnUpdate="0"/>
    <default expression="" field="validfrom" applyOnUpdate="0"/>
    <default expression="" field="validto" applyOnUpdate="0"/>
    <default expression="" field="isderived" applyOnUpdate="0"/>
    <default expression="" field="wrbreferencesoilgroup" applyOnUpdate="0"/>
    <default expression="" field="isoriginalclassification" applyOnUpdate="0"/>
    <default expression="" field="location" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="guidkey" unique_strength="1" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="inspireid_localid" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="inspireid_namespace" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="inspireid_versionid" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="localidentifier" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="beginlifespanversion" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="endlifespanversion" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="validfrom" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="0" exp_strength="0" field="validto" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="1" exp_strength="0" field="isderived" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="wrbreferencesoilgroup" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="1" exp_strength="0" field="isoriginalclassification" unique_strength="0" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="location" unique_strength="1" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="guidkey" desc="" exp=""/>
    <constraint field="inspireid_localid" desc="" exp=""/>
    <constraint field="inspireid_namespace" desc="" exp=""/>
    <constraint field="inspireid_versionid" desc="" exp=""/>
    <constraint field="localidentifier" desc="" exp=""/>
    <constraint field="beginlifespanversion" desc="" exp=""/>
    <constraint field="endlifespanversion" desc="" exp=""/>
    <constraint field="validfrom" desc="" exp=""/>
    <constraint field="validto" desc="" exp=""/>
    <constraint field="isderived" desc="" exp=""/>
    <constraint field="wrbreferencesoilgroup" desc="" exp=""/>
    <constraint field="isoriginalclassification" desc="" exp=""/>
    <constraint field="location" desc="" exp=""/>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="isderived" index="10">
      <labelStyle overrideLabelFont="1" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" italic="0" bold="1" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="INSPIRE ID" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="inspireid_localid" index="2">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="inspireid_namespace" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="inspireid_versionid" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="localidentifier" index="5">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Dates" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="beginlifespanversion" index="6">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="endlifespanversion" index="7">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="validfrom" index="8">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="validto" index="9">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="wrbreferencesoilgroup" index="11">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="isoriginalclassification" index="12">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;isderived&quot; =False" name="Soil Plot" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" horizontalStretch="0" verticalStretch="0" name="location" index="13">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Profile Element" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_profileelement" verticalStretch="0" nmRelationId="" name="soilprofile_profileelement" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Datastream" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_datastream_8" verticalStretch="0" nmRelationId="" name="soilprofile_datastream_8" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="WRB Qualifier" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_wrbqualifiergroup_profile_2" verticalStretch="0" nmRelationId="" name="soilprofile_wrbqualifiergroup_profile_2" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Other Soil Name" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_othersoilnametype" verticalStretch="0" nmRelationId="" name="soilprofile_othersoilnametype" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Soil Derived Object" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_isbasedonobservedsoilprofile" verticalStretch="0" nmRelationId="" name="soilprofile_isbasedonobservedsoilprofile" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;isderived&quot; =True" name="Derived Presence in Soil Body" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_derivedprofilepresenceinsoilbody" verticalStretch="0" nmRelationId="" name="soilprofile_derivedprofilepresenceinsoilbody" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;isderived&quot; =True" name="Is Derived From" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_isderivedfrom_2" verticalStretch="0" nmRelationId="" name="soilprofile_isderivedfrom_2" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="Tab" visibilityExpressionEnabled="1" verticalStretch="0" visibilityExpression=" &quot;isderived&quot; =False" name="Derived Soil Profile" columnCount="1" groupBox="0" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" horizontalStretch="0" relation="soilprofile_isderivedfrom" verticalStretch="0" nmRelationId="" name="soilprofile_isderivedfrom" label="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
          <Option value="AllButtons" type="QString" name="buttons"/>
          <Option value="true" type="bool" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="beginlifespanversion"/>
    <field editable="1" name="endlifespanversion"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="inspireid_localid"/>
    <field editable="1" name="inspireid_namespace"/>
    <field editable="1" name="inspireid_versionid"/>
    <field editable="1" name="isderived"/>
    <field editable="1" name="isoriginalclassification"/>
    <field editable="1" name="localidentifier"/>
    <field editable="1" name="location"/>
    <field editable="1" name="validfrom"/>
    <field editable="1" name="validto"/>
    <field editable="1" name="wrbreferencesoilgroup"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="beginlifespanversion"/>
    <field labelOnTop="0" name="endlifespanversion"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="inspireid_localid"/>
    <field labelOnTop="0" name="inspireid_namespace"/>
    <field labelOnTop="0" name="inspireid_versionid"/>
    <field labelOnTop="0" name="isderived"/>
    <field labelOnTop="0" name="isoriginalclassification"/>
    <field labelOnTop="0" name="localidentifier"/>
    <field labelOnTop="0" name="location"/>
    <field labelOnTop="0" name="validfrom"/>
    <field labelOnTop="0" name="validto"/>
    <field labelOnTop="0" name="wrbreferencesoilgroup"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="beginlifespanversion" reuseLastValue="0"/>
    <field name="endlifespanversion" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="inspireid_localid" reuseLastValue="0"/>
    <field name="inspireid_namespace" reuseLastValue="0"/>
    <field name="inspireid_versionid" reuseLastValue="0"/>
    <field name="isderived" reuseLastValue="0"/>
    <field name="isoriginalclassification" reuseLastValue="0"/>
    <field name="localidentifier" reuseLastValue="0"/>
    <field name="location" reuseLastValue="0"/>
    <field name="validfrom" reuseLastValue="0"/>
    <field name="validto" reuseLastValue="0"/>
    <field name="wrbreferencesoilgroup" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'id '|| COALESCE( "id", '&lt;NULL>' )|| ' - ' || COALESCE( "localidentifier", '&lt;NULL>') </previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
