<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
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
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_localid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_namespace" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="inspireid_versionid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="localidentifier" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="beginlifespanversion" configurationFlags="None">
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
    <field name="endlifespanversion" configurationFlags="None">
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
    <field name="validfrom" configurationFlags="None">
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
    <field name="validto" configurationFlags="None">
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
    <field name="isderived" configurationFlags="None">
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
    <field name="wrbreferencesoilgroup" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_23addab1_184e_4eae_be1c_bccf93d49a65" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="isoriginalclassification" configurationFlags="None">
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
    <field name="location" configurationFlags="None">
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
    <alias name="" field="id" index="0"/>
    <alias name="" field="guidkey" index="1"/>
    <alias name="Local id" field="inspireid_localid" index="2"/>
    <alias name="Namespace" field="inspireid_namespace" index="3"/>
    <alias name="Veersion id" field="inspireid_versionid" index="4"/>
    <alias name="Local identifier" field="localidentifier" index="5"/>
    <alias name="Begin Lifespan version" field="beginlifespanversion" index="6"/>
    <alias name="End Lifespan version" field="endlifespanversion" index="7"/>
    <alias name="Valid From" field="validfrom" index="8"/>
    <alias name="Valid To" field="validto" index="9"/>
    <alias name="Is Derived" field="isderived" index="10"/>
    <alias name="World Reference Base" field="wrbreferencesoilgroup" index="11"/>
    <alias name="It is an Original classification" field="isoriginalclassification" index="12"/>
    <alias name="" field="location" index="13"/>
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
    <policy field="wrbreferencesoilgroup" policy="DefaultValue"/>
    <policy field="isoriginalclassification" policy="DefaultValue"/>
    <policy field="location" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="inspireid_localid" expression=""/>
    <default applyOnUpdate="0" field="inspireid_namespace" expression=""/>
    <default applyOnUpdate="0" field="inspireid_versionid" expression=""/>
    <default applyOnUpdate="0" field="localidentifier" expression=""/>
    <default applyOnUpdate="0" field="beginlifespanversion" expression=""/>
    <default applyOnUpdate="0" field="endlifespanversion" expression=""/>
    <default applyOnUpdate="0" field="validfrom" expression=""/>
    <default applyOnUpdate="0" field="validto" expression=""/>
    <default applyOnUpdate="0" field="isderived" expression=""/>
    <default applyOnUpdate="0" field="wrbreferencesoilgroup" expression=""/>
    <default applyOnUpdate="0" field="isoriginalclassification" expression=""/>
    <default applyOnUpdate="0" field="location" expression=""/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" constraints="3" unique_strength="1" field="id"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="2" unique_strength="1" field="guidkey"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="inspireid_localid"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="inspireid_namespace"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="inspireid_versionid"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="localidentifier"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0" field="beginlifespanversion"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="endlifespanversion"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0" field="validfrom"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="validto"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0" field="isderived"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="wrbreferencesoilgroup"/>
    <constraint notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0" field="isoriginalclassification"/>
    <constraint notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0" field="location"/>
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
    <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
      <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" name="id" showLabel="1" verticalStretch="0" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" name="isderived" showLabel="1" verticalStretch="0" index="10">
      <labelStyle overrideLabelFont="1" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="1" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="1" type="GroupBox" name="INSPIRE ID" visibilityExpression="" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" name="inspireid_localid" showLabel="1" verticalStretch="0" index="2">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" name="inspireid_namespace" showLabel="1" verticalStretch="0" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" name="inspireid_versionid" showLabel="1" verticalStretch="0" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" name="localidentifier" showLabel="1" verticalStretch="0" index="5">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="1" type="GroupBox" name="Dates" visibilityExpression="" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" name="beginlifespanversion" showLabel="1" verticalStretch="0" index="6">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" name="endlifespanversion" showLabel="1" verticalStretch="0" index="7">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" name="validfrom" showLabel="1" verticalStretch="0" index="8">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" name="validto" showLabel="1" verticalStretch="0" index="9">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" name="wrbreferencesoilgroup" showLabel="1" verticalStretch="0" index="11">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" name="isoriginalclassification" showLabel="1" verticalStretch="0" index="12">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="1" type="GroupBox" name="Soil Plot" visibilityExpression=" &quot;isderived&quot; =False" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" name="location" showLabel="0" verticalStretch="0" index="13">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="0" type="Tab" name="Profile Element" visibilityExpression="" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_profileelement" showLabel="0" label="" relation="soilprofile_profileelement" verticalStretch="0" nmRelationId="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="0" type="Tab" name="WRB Qualifier" visibilityExpression="" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_wrbqualifiergrouptype" showLabel="0" label="" relation="soilprofile_wrbqualifiergrouptype" verticalStretch="0" nmRelationId="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="0" type="Tab" name="Other Soil Name" visibilityExpression="" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_othersoilnametype" showLabel="0" label="" relation="soilprofile_othersoilnametype" verticalStretch="0" nmRelationId="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="0" type="Tab" name="Soil Derived Object" visibilityExpression="" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_isbasedonobservedsoilprofile" showLabel="0" label="" relation="soilprofile_isbasedonobservedsoilprofile" verticalStretch="0" nmRelationId="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="0" type="Tab" name="Derived Presence in Soil Body" visibilityExpression=" &quot;isderived&quot; =True" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_derivedprofilepresenceinsoilbody" showLabel="0" label="" relation="soilprofile_derivedprofilepresenceinsoilbody" verticalStretch="0" nmRelationId="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="0" type="Tab" name="Is Derived From" visibilityExpression=" &quot;isderived&quot; =True" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_isderivedfrom_2" showLabel="0" label="" relation="soilprofile_isderivedfrom_2" verticalStretch="0" nmRelationId="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpression="" horizontalStretch="0" groupBox="0" type="Tab" name="Derived Soil Profile" visibilityExpression=" &quot;isderived&quot; =False" showLabel="1" collapsedExpressionEnabled="0" collapsed="0" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
      </labelStyle>
      <attributeEditorRelation horizontalStretch="0" forceSuppressFormPopup="0" name="soilprofile_isderivedfrom" showLabel="0" label="" relation="soilprofile_isderivedfrom" verticalStretch="0" nmRelationId="" relationWidgetTypeId="relation_editor">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
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
