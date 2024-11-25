<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation strength="Association" dataSource="./INSPIRE_SO.gpkg|layername=soilplot" referencedLayer="soilplot_8190d140_634f_4bd7_84c1_07e62651b4b7" referencingLayer="soilprofile_fb4e4060_125a_40a1_ab64_0b0e16ec081d" id="soilplot_soilprofile" layerId="soilplot_8190d140_634f_4bd7_84c1_07e62651b4b7" layerName="soilplot" providerKey="ogr" name="soilplot_soilprofile">
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
            <Option type="QString" value="codelist_7257b262_7388_468b_a269_2546711c92b6" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/_INSPIRE_NOV24/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
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
    <alias index="0" field="id" name=""/>
    <alias index="1" field="guidkey" name=""/>
    <alias index="2" field="inspireid_localid" name="Local id"/>
    <alias index="3" field="inspireid_namespace" name="Namespace"/>
    <alias index="4" field="inspireid_versionid" name="Version id"/>
    <alias index="5" field="localidentifier" name="Local identifier"/>
    <alias index="6" field="beginlifespanversion" name="Begin Lifespan version"/>
    <alias index="7" field="endlifespanversion" name="End Lifespan version"/>
    <alias index="8" field="validfrom" name="Valid From"/>
    <alias index="9" field="validto" name="Valid To"/>
    <alias index="10" field="isderived" name="Is Derived"/>
    <alias index="11" field="wrbversion" name="World Reference Base Version"/>
    <alias index="12" field="wrbreferencesoilgroup" name="Reference Soil Group"/>
    <alias index="13" field="isoriginalclassification" name="It is an Original classification"/>
    <alias index="14" field="location" name=""/>
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
    <constraint constraints="3" unique_strength="1" notnull_strength="1" exp_strength="0" field="id"/>
    <constraint constraints="2" unique_strength="1" notnull_strength="0" exp_strength="0" field="guidkey"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="inspireid_localid"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="inspireid_namespace"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="inspireid_versionid"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="localidentifier"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="beginlifespanversion"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="endlifespanversion"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="validfrom"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="validto"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="isderived"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="wrbversion"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="wrbreferencesoilgroup"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="isoriginalclassification"/>
    <constraint constraints="2" unique_strength="1" notnull_strength="0" exp_strength="0" field="location"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="0" verticalStretch="0" name="id">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="10" verticalStretch="0" name="isderived">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="1">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" bold="1"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="INSPIRE ID">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="2" verticalStretch="0" name="inspireid_localid">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="3" verticalStretch="0" name="inspireid_namespace">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="4" verticalStretch="0" name="inspireid_versionid">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="5" verticalStretch="0" name="localidentifier">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Dates">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="6" verticalStretch="0" name="beginlifespanversion">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="7" verticalStretch="0" name="endlifespanversion">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="8" verticalStretch="0" name="validfrom">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="9" verticalStretch="0" name="validto">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="11" verticalStretch="0" name="wrbversion">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="12" verticalStretch="0" name="wrbreferencesoilgroup">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="13" verticalStretch="0" name="isoriginalclassification">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" visibilityExpression=" &quot;isderived&quot; =False" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="1" verticalStretch="0" collapsedExpressionEnabled="0" name="Soil Plot">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" horizontalStretch="0" index="14" verticalStretch="0" name="location">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="0" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="WRB Qualifier">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation nmRelationId="" showLabel="1" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_wrbqualifiergroup_profile_2" verticalStretch="0" name="soilprofile_wrbqualifiergroup_profile_2" label="">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="0" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Other Soil Name">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_othersoilnametype" verticalStretch="0" name="soilprofile_othersoilnametype" label="">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" visibilityExpression=" &quot;isderived&quot; =True" groupBox="0" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="Tab" visibilityExpressionEnabled="1" verticalStretch="0" collapsedExpressionEnabled="0" name="Is Derived From">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_isderivedfrom_2" verticalStretch="0" name="soilprofile_isderivedfrom_2" label="">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" visibilityExpression=" &quot;isderived&quot; =False" groupBox="0" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="Tab" visibilityExpressionEnabled="1" verticalStretch="0" collapsedExpressionEnabled="0" name="Derived Soil Profile">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_isderivedfrom" verticalStretch="0" name="soilprofile_isderivedfrom" label="">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="RELATIONS">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorContainer collapsed="1" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Profile Element">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_profileelement" verticalStretch="0" name="soilprofile_profileelement" label="">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer collapsed="1" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Datastream">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_datastream_8" verticalStretch="0" name="soilprofile_datastream_8" label="">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer collapsed="1" visibilityExpression=" &quot;isderived&quot; =True" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="1" verticalStretch="0" collapsedExpressionEnabled="0" name="Derived Presence in Soil Body">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_derivedprofilepresenceinsoilbody" verticalStretch="0" name="soilprofile_derivedprofilepresenceinsoilbody" label="">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer collapsed="1" visibilityExpression=" &quot;isderived&quot; =False" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="1" verticalStretch="0" collapsedExpressionEnabled="0" name="Soil Derived Object">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="soilprofile_isbasedonobservedsoilprofile" verticalStretch="0" name="soilprofile_isbasedonobservedsoilprofile" label="">
          <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
            <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
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
