<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation strength="Association" referencingLayer="soilprofile_b6d09b5f_42f3_40ac_b072_29d46030c2f0" referencedLayer="soilplot_383f2201_ad95_4184_b8f0_d003966182c7" layerName="soilplot" layerId="soilplot_383f2201_ad95_4184_b8f0_d003966182c7" providerKey="ogr" id="soilplot_soilprofile" name="soilplot_soilprofile" dataSource="./INSPIRE_SO.gpkg|layername=soilplot">
      <fieldRef referencingField="location" referencedField="guidkey"/>
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
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="localidentifier">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="beginlifespanversion">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="endlifespanversion">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="validfrom">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="validto">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd HH:mm:ss" name="field_format"/>
            <Option type="bool" value="false" name="field_format_overwrite"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isderived">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option type="QString" value="" name="CheckedState"/>
            <Option type="int" value="0" name="TextDisplayMethod"/>
            <Option type="QString" value="" name="UncheckedState"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbversion">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('wrbversion') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_612657c0_5777_49fb_96f7_0ded0115c241" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/GPKG/INSP_03_TEST_WRB.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="true" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbreferencesoilgroup">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue') &#xa;  WHEN current_value('wrbversion') = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue2014')  &#xa;  WHEN current_value('wrbversion') = 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue2022')  &#xa;  ELSE 0&#xa;END&#xa;&#xa;&#xa;--&quot;collection&quot; = current_value('wrbversion')&#xa;" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_c31ed647_1b11_42f4_8db6_c48e13994a56" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_06_New/Sicily_TESTFORM/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isoriginalclassification">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option type="QString" value="" name="CheckedState"/>
            <Option type="int" value="0" name="TextDisplayMethod"/>
            <Option type="QString" value="" name="UncheckedState"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="location">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilplot" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="soilplot_b1bf44ed_bd29_4858_b4c8_5694622c97fa" name="ReferencedLayerId"/>
            <Option type="QString" value="soilplot" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="soilplot_soilprofile" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="Local id" field="inspireid_localid"/>
    <alias index="3" name="Namespace" field="inspireid_namespace"/>
    <alias index="4" name="Version id" field="inspireid_versionid"/>
    <alias index="5" name="Local identifier" field="localidentifier"/>
    <alias index="6" name="Begin Lifespan version" field="beginlifespanversion"/>
    <alias index="7" name="End Lifespan version" field="endlifespanversion"/>
    <alias index="8" name="Valid From" field="validfrom"/>
    <alias index="9" name="Valid To" field="validto"/>
    <alias index="10" name="Is Derived" field="isderived"/>
    <alias index="11" name="World Reference Base Version" field="wrbversion"/>
    <alias index="12" name="World Reference Base" field="wrbreferencesoilgroup"/>
    <alias index="13" name="It is an Original classification" field="isoriginalclassification"/>
    <alias index="14" name="" field="location"/>
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
    <policy policy="DefaultValue" field="wrbversion"/>
    <policy policy="DefaultValue" field="wrbreferencesoilgroup"/>
    <policy policy="DefaultValue" field="isoriginalclassification"/>
    <policy policy="DefaultValue" field="location"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="inspireid_localid"/>
    <default applyOnUpdate="0" expression="" field="inspireid_namespace"/>
    <default applyOnUpdate="0" expression="" field="inspireid_versionid"/>
    <default applyOnUpdate="0" expression="" field="localidentifier"/>
    <default applyOnUpdate="0" expression="now()||'Z'" field="beginlifespanversion"/>
    <default applyOnUpdate="0" expression="" field="endlifespanversion"/>
    <default applyOnUpdate="0" expression="now()||'Z'" field="validfrom"/>
    <default applyOnUpdate="0" expression="" field="validto"/>
    <default applyOnUpdate="0" expression="" field="isderived"/>
    <default applyOnUpdate="0" expression="" field="wrbversion"/>
    <default applyOnUpdate="0" expression="" field="wrbreferencesoilgroup"/>
    <default applyOnUpdate="0" expression="" field="isoriginalclassification"/>
    <default applyOnUpdate="0" expression="" field="location"/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" exp_strength="0" field="id" unique_strength="1"/>
    <constraint constraints="2" notnull_strength="0" exp_strength="0" field="guidkey" unique_strength="1"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_localid" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_namespace" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="inspireid_versionid" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="localidentifier" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="beginlifespanversion" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="endlifespanversion" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="validfrom" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="validto" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="isderived" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="wrbversion" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="wrbreferencesoilgroup" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="isoriginalclassification" unique_strength="0"/>
    <constraint constraints="2" notnull_strength="0" exp_strength="0" field="location" unique_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="guidkey"/>
    <constraint desc="" exp="" field="inspireid_localid"/>
    <constraint desc="" exp="" field="inspireid_namespace"/>
    <constraint desc="" exp="" field="inspireid_versionid"/>
    <constraint desc="" exp="" field="localidentifier"/>
    <constraint desc="" exp="" field="beginlifespanversion"/>
    <constraint desc="" exp="" field="endlifespanversion"/>
    <constraint desc="" exp="" field="validfrom"/>
    <constraint desc="" exp="" field="validto"/>
    <constraint desc="" exp="" field="isderived"/>
    <constraint desc="" exp="" field="wrbversion"/>
    <constraint desc="" exp="" field="wrbreferencesoilgroup"/>
    <constraint desc="" exp="" field="isoriginalclassification"/>
    <constraint desc="" exp="" field="location"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="0" horizontalStretch="0" name="id" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="10" horizontalStretch="0" name="isderived" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="1" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="1" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="INSPIRE ID" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="2" horizontalStretch="0" name="inspireid_localid" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="3" horizontalStretch="0" name="inspireid_namespace" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="4" horizontalStretch="0" name="inspireid_versionid" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="5" horizontalStretch="0" name="localidentifier" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Dates" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="6" horizontalStretch="0" name="beginlifespanversion" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="7" horizontalStretch="0" name="endlifespanversion" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="8" horizontalStretch="0" name="validfrom" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="9" horizontalStretch="0" name="validto" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="11" horizontalStretch="0" name="wrbversion" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="12" horizontalStretch="0" name="wrbreferencesoilgroup" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="13" horizontalStretch="0" name="isoriginalclassification" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;isderived&quot; =False" horizontalStretch="0" name="Soil Plot" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" index="14" horizontalStretch="0" name="location" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" groupBox="0" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="WRB Qualifier" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="1" relation="soilprofile_wrbqualifiergroup_profile_2" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_wrbqualifiergroup_profile_2" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" groupBox="0" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Other Soil Name" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="soilprofile_othersoilnametype" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_othersoilnametype" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" groupBox="0" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;isderived&quot; =True" horizontalStretch="0" name="Is Derived From" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="soilprofile_isderivedfrom_2" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_isderivedfrom_2" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" groupBox="0" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;isderived&quot; =False" horizontalStretch="0" name="Derived Soil Profile" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" relation="soilprofile_isderivedfrom" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_isderivedfrom" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="RELATIONS" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="1" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Profile Element" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" relation="soilprofile_profileelement" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_profileelement" nmRelationId="" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="1" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Datastream" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" relation="soilprofile_datastream_8" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_datastream_8" nmRelationId="" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="1" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;isderived&quot; =True" horizontalStretch="0" name="Derived Presence in Soil Body" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" relation="soilprofile_derivedprofilepresenceinsoilbody" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_derivedprofilepresenceinsoilbody" nmRelationId="" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="1" showLabel="1" collapsedExpression="" visibilityExpression=" &quot;isderived&quot; =False" horizontalStretch="0" name="Soil Derived Object" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" relation="soilprofile_isbasedonobservedsoilprofile" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" label="" horizontalStretch="0" name="soilprofile_isbasedonobservedsoilprofile" nmRelationId="" verticalStretch="0">
          <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
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
    <field editable="1" name="wrbversion"/>
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
    <field labelOnTop="0" name="wrbversion"/>
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
