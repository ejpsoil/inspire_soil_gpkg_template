<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation dataSource="./INSPIRE_SO.gpkg|layername=soilplot" referencedLayer="soilplot_3dc2f2d5_764d_455e_a0f7_8788a2761507" strength="Association" referencingLayer="soilprofile_1550177a_7855_4c65_a774_980f2ebacb11" layerName="soilplot" id="soilplot_soilprofile" layerId="soilplot_3dc2f2d5_764d_455e_a0f7_8788a2761507" name="soilplot_soilprofile" providerKey="ogr">
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
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="localidentifier">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="beginlifespanversion">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" value="false" type="bool"/>
            <Option name="calendar_popup" value="true" type="bool"/>
            <Option name="display_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format_overwrite" value="false" type="bool"/>
            <Option name="field_iso_format" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="endlifespanversion">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" value="true" type="bool"/>
            <Option name="calendar_popup" value="true" type="bool"/>
            <Option name="display_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format_overwrite" value="false" type="bool"/>
            <Option name="field_iso_format" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="validfrom">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" value="false" type="bool"/>
            <Option name="calendar_popup" value="true" type="bool"/>
            <Option name="display_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format_overwrite" value="false" type="bool"/>
            <Option name="field_iso_format" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="validto">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" value="true" type="bool"/>
            <Option name="calendar_popup" value="true" type="bool"/>
            <Option name="display_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format" value="yyyy-MM-dd HH:mm:ss" type="QString"/>
            <Option name="field_format_overwrite" value="false" type="bool"/>
            <Option name="field_iso_format" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isderived">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" value="" type="QString"/>
            <Option name="TextDisplayMethod" value="0" type="int"/>
            <Option name="UncheckedState" value="" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbversion">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('wrbversion') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_612657c0_5777_49fb_96f7_0ded0115c241" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/GPKG/INSP_03_TEST_WRB.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="true" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbreferencesoilgroup">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&#xa;CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue') &#xa;  WHEN current_value('wrbversion') = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue2014')  &#xa;  WHEN current_value('wrbversion') = 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBReferenceSoilGroupValue2022')  &#xa;  ELSE 0&#xa;END&#xa;&#xa;&#xa;--&quot;collection&quot; = current_value('wrbversion')&#xa;" type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_95efcf3a_4eef_4602_995d_4010a96ab058" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage_INSPIRE_Import/Tutorials/dati_github/INSPIRE_SO_DEMO_QGIS_V02.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isoriginalclassification">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" value="" type="QString"/>
            <Option name="TextDisplayMethod" value="0" type="int"/>
            <Option name="UncheckedState" value="" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="location">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilplot" type="QString"/>
            <Option name="ReferencedLayerId" value="soilplot_b1bf44ed_bd29_4858_b4c8_5694622c97fa" type="QString"/>
            <Option name="ReferencedLayerName" value="soilplot" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="soilplot_soilprofile" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
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
    <alias index="4" name="Veersion id" field="inspireid_versionid"/>
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
    <constraint notnull_strength="1" constraints="3" exp_strength="0" field="id" unique_strength="1"/>
    <constraint notnull_strength="0" constraints="2" exp_strength="0" field="guidkey" unique_strength="1"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="inspireid_localid" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="inspireid_namespace" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="inspireid_versionid" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="localidentifier" unique_strength="0"/>
    <constraint notnull_strength="1" constraints="1" exp_strength="0" field="beginlifespanversion" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="endlifespanversion" unique_strength="0"/>
    <constraint notnull_strength="1" constraints="1" exp_strength="0" field="validfrom" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="validto" unique_strength="0"/>
    <constraint notnull_strength="1" constraints="1" exp_strength="0" field="isderived" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="wrbversion" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="wrbreferencesoilgroup" unique_strength="0"/>
    <constraint notnull_strength="1" constraints="1" exp_strength="0" field="isoriginalclassification" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="2" exp_strength="0" field="location" unique_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="guidkey" exp=""/>
    <constraint desc="" field="inspireid_localid" exp=""/>
    <constraint desc="" field="inspireid_namespace" exp=""/>
    <constraint desc="" field="inspireid_versionid" exp=""/>
    <constraint desc="" field="localidentifier" exp=""/>
    <constraint desc="" field="beginlifespanversion" exp=""/>
    <constraint desc="" field="endlifespanversion" exp=""/>
    <constraint desc="" field="validfrom" exp=""/>
    <constraint desc="" field="validto" exp=""/>
    <constraint desc="" field="isderived" exp=""/>
    <constraint desc="" field="wrbversion" exp=""/>
    <constraint desc="" field="wrbreferencesoilgroup" exp=""/>
    <constraint desc="" field="isoriginalclassification" exp=""/>
    <constraint desc="" field="location" exp=""/>
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
      <labelFont italic="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="0" name="id">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="10" name="isderived">
      <labelStyle overrideLabelFont="1" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" style="" bold="1" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" name="INSPIRE ID" groupBox="1" collapsed="0" type="GroupBox">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="2" name="inspireid_localid">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="3" name="inspireid_namespace">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="4" name="inspireid_versionid">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="5" name="localidentifier">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Dates" groupBox="1" collapsed="0" type="GroupBox">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="6" name="beginlifespanversion">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="7" name="endlifespanversion">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="8" name="validfrom">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="9" name="validto">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="11" name="wrbversion">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="12" name="wrbreferencesoilgroup">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" verticalStretch="0" horizontalStretch="0" index="13" name="isoriginalclassification">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="1" visibilityExpression=" &quot;isderived&quot; =False" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Soil Plot" groupBox="1" collapsed="0" type="GroupBox">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" verticalStretch="0" horizontalStretch="0" index="14" name="location">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" name="WRB Qualifier" groupBox="0" collapsed="0" type="Tab">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_wrbqualifiergroup_profile_2" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_wrbqualifiergroup_profile_2">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
          <Option name="buttons" value="AllButtons" type="QString"/>
          <Option name="show_first_feature" value="true" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Other Soil Name" groupBox="0" collapsed="0" type="Tab">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_othersoilnametype" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_othersoilnametype">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
          <Option name="buttons" value="AllButtons" type="QString"/>
          <Option name="show_first_feature" value="true" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="1" visibilityExpression=" &quot;isderived&quot; =True" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Is Derived From" groupBox="0" collapsed="0" type="Tab">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_isderivedfrom_2" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_isderivedfrom_2">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
          <Option name="buttons" value="AllButtons" type="QString"/>
          <Option name="show_first_feature" value="true" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="1" visibilityExpression=" &quot;isderived&quot; =False" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Derived Soil Profile" groupBox="0" collapsed="0" type="Tab">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_isderivedfrom" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_isderivedfrom">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
          <Option name="buttons" value="AllButtons" type="QString"/>
          <Option name="show_first_feature" value="true" type="bool"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" name="RELATIONS" groupBox="1" collapsed="0" type="GroupBox">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Profile Element" groupBox="1" collapsed="1" type="GroupBox">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_profileelement" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_profileelement">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
            <Option name="buttons" value="AllButtons" type="QString"/>
            <Option name="show_first_feature" value="true" type="bool"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Datastream" groupBox="1" collapsed="1" type="GroupBox">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_datastream_8" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_datastream_8">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
            <Option name="buttons" value="AllButtons" type="QString"/>
            <Option name="show_first_feature" value="true" type="bool"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="1" visibilityExpression=" &quot;isderived&quot; =True" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Derived Presence in Soil Body" groupBox="1" collapsed="1" type="GroupBox">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_derivedprofilepresenceinsoilbody" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_derivedprofilepresenceinsoilbody">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
            <Option name="buttons" value="AllButtons" type="QString"/>
            <Option name="show_first_feature" value="true" type="bool"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" visibilityExpressionEnabled="1" visibilityExpression=" &quot;isderived&quot; =False" columnCount="1" collapsedExpression="" horizontalStretch="0" name="Soil Derived Object" groupBox="1" collapsed="1" type="GroupBox">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,9.6,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
        </labelStyle>
        <attributeEditorRelation showLabel="0" forceSuppressFormPopup="0" verticalStretch="0" label="" relation="soilprofile_isbasedonobservedsoilprofile" relationWidgetTypeId="relation_editor" nmRelationId="" horizontalStretch="0" name="soilprofile_isbasedonobservedsoilprofile">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style="" bold="0" underline="0" strikethrough="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option name="allow_add_child_feature_with_no_geometry" value="false" type="bool"/>
            <Option name="buttons" value="AllButtons" type="QString"/>
            <Option name="show_first_feature" value="true" type="bool"/>
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
