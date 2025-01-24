<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation dataSource="./INSPIRE_SO.gpkg|layername=soilplot" providerKey="ogr" referencingLayer="soilprofile_165f1928_0446_4d98_8774_06e1489496c6" referencedLayer="soilplot_46c9e318_9d6f_40d7_bad2_907a92c85b7e" id="soilplot_soilprofile" name="soilplot_soilprofile" layerId="soilplot_46c9e318_9d6f_40d7_bad2_907a92c85b7e" strength="Association" layerName="soilplot">
      <fieldRef referencedField="guidkey" referencingField="location"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="guidkey" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_localid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_namespace" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_versionid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="localidentifier" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="beginlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" type="bool" value="false"/>
            <Option name="calendar_popup" type="bool" value="true"/>
            <Option name="display_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format_overwrite" type="bool" value="false"/>
            <Option name="field_iso_format" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="endlifespanversion" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" type="bool" value="true"/>
            <Option name="calendar_popup" type="bool" value="true"/>
            <Option name="display_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format_overwrite" type="bool" value="false"/>
            <Option name="field_iso_format" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="validfrom" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" type="bool" value="false"/>
            <Option name="calendar_popup" type="bool" value="true"/>
            <Option name="display_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format_overwrite" type="bool" value="false"/>
            <Option name="field_iso_format" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="validto" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" type="bool" value="true"/>
            <Option name="calendar_popup" type="bool" value="true"/>
            <Option name="display_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format" type="QString" value="yyyy-MM-dd HH:mm:ss"/>
            <Option name="field_format_overwrite" type="bool" value="false"/>
            <Option name="field_iso_format" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="isderived" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" type="QString" value=""/>
            <Option name="TextDisplayMethod" type="int" value="0"/>
            <Option name="UncheckedState" type="QString" value=""/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="wrbversion" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="true"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('wrbversion') "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_7257b262_7388_468b_a269_2546711c92b6"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/_INSPIRE_NOV24/INSPIRE_SO.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="true"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="wrbreferencesoilgroup" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="true"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue') &#xa;  WHEN current_value('wrbversion') = 'https://agroportal.lirmm.fr/ontologies/WRB_2014-2015' THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue2014')  &#xa;  WHEN current_value('wrbversion') = 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue2022')  &#xa;  ELSE 0&#xa;END&#xa;&#xa;&#xa;--&quot;collection&quot; = current_value('wrbversion')&#xa;"/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_14cfe8e5_df71_4203_bf31_a0387b425363"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Git_EJPSOIL/inspire_soil_gpkg_template/Version1.1-RC/geopackage/INSPIRE_SO_with_data_and_QGIS_project/INSPIRE_SO.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="isoriginalclassification" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" type="QString" value=""/>
            <Option name="TextDisplayMethod" type="int" value="0"/>
            <Option name="UncheckedState" type="QString" value=""/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="location" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"/>
            <Option name="AllowNULL" type="bool" value="false"/>
            <Option name="FetchLimitActive" type="bool" value="true"/>
            <Option name="FetchLimitNumber" type="int" value="100"/>
            <Option name="MapIdentification" type="bool" value="false"/>
            <Option name="ReadOnly" type="bool" value="false"/>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilplot"/>
            <Option name="ReferencedLayerId" type="QString" value="soilplot_b1bf44ed_bd29_4858_b4c8_5694622c97fa"/>
            <Option name="ReferencedLayerName" type="QString" value="soilplot"/>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"/>
            <Option name="Relation" type="QString" value="soilplot_soilprofile"/>
            <Option name="ShowForm" type="bool" value="false"/>
            <Option name="ShowOpenFormButton" type="bool" value="true"/>
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
    <alias field="inspireid_versionid" name="Version id" index="4"/>
    <alias field="localidentifier" name="Local identifier" index="5"/>
    <alias field="beginlifespanversion" name="Begin Lifespan version" index="6"/>
    <alias field="endlifespanversion" name="End Lifespan version" index="7"/>
    <alias field="validfrom" name="Valid From" index="8"/>
    <alias field="validto" name="Valid To" index="9"/>
    <alias field="isderived" name="Is Derived" index="10"/>
    <alias field="wrbversion" name="World Reference Base Version" index="11"/>
    <alias field="wrbreferencesoilgroup" name="Reference Soil Group" index="12"/>
    <alias field="isoriginalclassification" name="It is an Original classification" index="13"/>
    <alias field="location" name="" index="14"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="inspireid_localid" policy="DefaultValue"/>
    <policy field="inspireid_namespace" policy="DefaultValue"/>
    <policy field="inspireid_versionid" policy="DefaultValue"/>
    <policy field="localidentifier" policy="DefaultValue"/>
    <policy field="beginlifespanversion" policy="DefaultValue"/>
    <policy field="endlifespanversion" policy="DefaultValue"/>
    <policy field="validfrom" policy="DefaultValue"/>
    <policy field="validto" policy="DefaultValue"/>
    <policy field="isderived" policy="DefaultValue"/>
    <policy field="wrbversion" policy="DefaultValue"/>
    <policy field="wrbreferencesoilgroup" policy="DefaultValue"/>
    <policy field="isoriginalclassification" policy="DefaultValue"/>
    <policy field="location" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="guidkey" expression="" applyOnUpdate="0"/>
    <default field="inspireid_localid" expression="" applyOnUpdate="0"/>
    <default field="inspireid_namespace" expression="" applyOnUpdate="0"/>
    <default field="inspireid_versionid" expression="" applyOnUpdate="0"/>
    <default field="localidentifier" expression="" applyOnUpdate="0"/>
    <default field="beginlifespanversion" expression="now()||'Z'" applyOnUpdate="0"/>
    <default field="endlifespanversion" expression="" applyOnUpdate="0"/>
    <default field="validfrom" expression="now()||'Z'" applyOnUpdate="0"/>
    <default field="validto" expression="" applyOnUpdate="0"/>
    <default field="isderived" expression="" applyOnUpdate="0"/>
    <default field="wrbversion" expression="" applyOnUpdate="0"/>
    <default field="wrbreferencesoilgroup" expression="" applyOnUpdate="0"/>
    <default field="isoriginalclassification" expression="" applyOnUpdate="0"/>
    <default field="location" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="1" exp_strength="0" constraints="3" notnull_strength="1"/>
    <constraint field="guidkey" unique_strength="1" exp_strength="0" constraints="2" notnull_strength="0"/>
    <constraint field="inspireid_localid" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="inspireid_namespace" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="inspireid_versionid" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="localidentifier" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="beginlifespanversion" unique_strength="0" exp_strength="0" constraints="1" notnull_strength="1"/>
    <constraint field="endlifespanversion" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="validfrom" unique_strength="0" exp_strength="0" constraints="1" notnull_strength="1"/>
    <constraint field="validto" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="isderived" unique_strength="0" exp_strength="0" constraints="1" notnull_strength="1"/>
    <constraint field="wrbversion" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="wrbreferencesoilgroup" unique_strength="0" exp_strength="0" constraints="0" notnull_strength="0"/>
    <constraint field="isoriginalclassification" unique_strength="0" exp_strength="0" constraints="1" notnull_strength="1"/>
    <constraint field="location" unique_strength="1" exp_strength="0" constraints="2" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="inspireid_localid" exp="" desc=""/>
    <constraint field="inspireid_namespace" exp="" desc=""/>
    <constraint field="inspireid_versionid" exp="" desc=""/>
    <constraint field="localidentifier" exp="" desc=""/>
    <constraint field="beginlifespanversion" exp="" desc=""/>
    <constraint field="endlifespanversion" exp="" desc=""/>
    <constraint field="validfrom" exp="" desc=""/>
    <constraint field="validto" exp="" desc=""/>
    <constraint field="isderived" exp="" desc=""/>
    <constraint field="wrbversion" exp="" desc=""/>
    <constraint field="wrbreferencesoilgroup" exp="" desc=""/>
    <constraint field="isoriginalclassification" exp="" desc=""/>
    <constraint field="location" exp="" desc=""/>
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
    <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
    </labelStyle>
    <attributeEditorField verticalStretch="0" horizontalStretch="0" name="id" index="0" showLabel="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" horizontalStretch="0" name="isderived" index="10" showLabel="1">
      <labelStyle overrideLabelFont="1" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" bold="1" italic="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" horizontalStretch="0" name="INSPIRE ID" visibilityExpression="" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="inspireid_localid" index="2" showLabel="1">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="inspireid_namespace" index="3" showLabel="1">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="inspireid_versionid" index="4" showLabel="1">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField verticalStretch="0" horizontalStretch="0" name="localidentifier" index="5" showLabel="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" horizontalStretch="0" name="Dates" visibilityExpression="" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="beginlifespanversion" index="6" showLabel="1">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="endlifespanversion" index="7" showLabel="1">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="validfrom" index="8" showLabel="1">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="validto" index="9" showLabel="1">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField verticalStretch="0" horizontalStretch="0" name="wrbversion" index="11" showLabel="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" horizontalStretch="0" name="wrbreferencesoilgroup" index="12" showLabel="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" horizontalStretch="0" name="isoriginalclassification" index="13" showLabel="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="1" horizontalStretch="0" name="Soil Plot" visibilityExpression=" &quot;isderived&quot; =False" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField verticalStretch="0" horizontalStretch="0" name="location" index="14" showLabel="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="0" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" horizontalStretch="0" name="WRB Qualifier" visibilityExpression="" showLabel="1" type="Tab" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_wrbqualifiergroup_profile_2" relation="soilprofile_wrbqualifiergroup_profile_2" showLabel="1" nmRelationId="" label="">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
          <Option name="buttons" type="QString" value="AllButtons"/>
          <Option name="show_first_feature" type="bool" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="0" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" horizontalStretch="0" name="Other Soil Name" visibilityExpression="" showLabel="1" type="Tab" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_othersoilnametype" relation="soilprofile_othersoilnametype" showLabel="0" nmRelationId="" label="">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
          <Option name="buttons" type="QString" value="AllButtons"/>
          <Option name="show_first_feature" type="bool" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="0" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="1" horizontalStretch="0" name="Is Derived From" visibilityExpression=" &quot;isderived&quot; =True" showLabel="1" type="Tab" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_isderivedfrom_2" relation="soilprofile_isderivedfrom_2" showLabel="0" nmRelationId="" label="">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
          <Option name="buttons" type="QString" value="AllButtons"/>
          <Option name="show_first_feature" type="bool" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="0" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="1" horizontalStretch="0" name="Derived Soil Profile" visibilityExpression=" &quot;isderived&quot; =False" showLabel="1" type="Tab" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_isderivedfrom" relation="soilprofile_isderivedfrom" showLabel="0" nmRelationId="" label="">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
          <Option name="buttons" type="QString" value="AllButtons"/>
          <Option name="show_first_feature" type="bool" value="true"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" horizontalStretch="0" name="RELATIONS" visibilityExpression="" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="1" visibilityExpressionEnabled="0" horizontalStretch="0" name="Profile Element" visibilityExpression="" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_profileelement" relation="soilprofile_profileelement" showLabel="0" nmRelationId="" label="">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
            <Option name="buttons" type="QString" value="AllButtons"/>
            <Option name="show_first_feature" type="bool" value="true"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="1" visibilityExpressionEnabled="0" horizontalStretch="0" name="Datastream" visibilityExpression="" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_datastream_8" relation="soilprofile_datastream_8" showLabel="0" nmRelationId="" label="">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
            <Option name="buttons" type="QString" value="AllButtons"/>
            <Option name="show_first_feature" type="bool" value="true"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="1" visibilityExpressionEnabled="1" horizontalStretch="0" name="Derived Presence in Soil Body" visibilityExpression=" &quot;isderived&quot; =True" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_derivedprofilepresenceinsoilbody" relation="soilprofile_derivedprofilepresenceinsoilbody" showLabel="0" nmRelationId="" label="">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
            <Option name="buttons" type="QString" value="AllButtons"/>
            <Option name="show_first_feature" type="bool" value="true"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer groupBox="1" verticalStretch="0" columnCount="1" collapsed="1" visibilityExpressionEnabled="1" horizontalStretch="0" name="Soil Derived Object" visibilityExpression=" &quot;isderived&quot; =False" showLabel="1" type="GroupBox" collapsedExpression="" collapsedExpressionEnabled="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
        </labelStyle>
        <attributeEditorRelation verticalStretch="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_isbasedonobservedsoilprofile" relation="soilprofile_isbasedonobservedsoilprofile" showLabel="0" nmRelationId="" label="">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" italic="0" style="" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
            <Option name="buttons" type="QString" value="AllButtons"/>
            <Option name="show_first_feature" type="bool" value="true"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="beginlifespanversion" editable="1"/>
    <field name="endlifespanversion" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="inspireid_localid" editable="1"/>
    <field name="inspireid_namespace" editable="1"/>
    <field name="inspireid_versionid" editable="1"/>
    <field name="isderived" editable="1"/>
    <field name="isoriginalclassification" editable="1"/>
    <field name="localidentifier" editable="1"/>
    <field name="location" editable="1"/>
    <field name="validfrom" editable="1"/>
    <field name="validto" editable="1"/>
    <field name="wrbreferencesoilgroup" editable="1"/>
    <field name="wrbversion" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="beginlifespanversion" labelOnTop="0"/>
    <field name="endlifespanversion" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="inspireid_localid" labelOnTop="0"/>
    <field name="inspireid_namespace" labelOnTop="0"/>
    <field name="inspireid_versionid" labelOnTop="0"/>
    <field name="isderived" labelOnTop="0"/>
    <field name="isoriginalclassification" labelOnTop="0"/>
    <field name="localidentifier" labelOnTop="0"/>
    <field name="location" labelOnTop="0"/>
    <field name="validfrom" labelOnTop="0"/>
    <field name="validto" labelOnTop="0"/>
    <field name="wrbreferencesoilgroup" labelOnTop="0"/>
    <field name="wrbversion" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="beginlifespanversion"/>
    <field reuseLastValue="0" name="endlifespanversion"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="inspireid_localid"/>
    <field reuseLastValue="0" name="inspireid_namespace"/>
    <field reuseLastValue="0" name="inspireid_versionid"/>
    <field reuseLastValue="0" name="isderived"/>
    <field reuseLastValue="0" name="isoriginalclassification"/>
    <field reuseLastValue="0" name="localidentifier"/>
    <field reuseLastValue="0" name="location"/>
    <field reuseLastValue="0" name="validfrom"/>
    <field reuseLastValue="0" name="validto"/>
    <field reuseLastValue="0" name="wrbreferencesoilgroup"/>
    <field reuseLastValue="0" name="wrbversion"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "localidentifier", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
