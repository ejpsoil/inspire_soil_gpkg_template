<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Fields|Forms" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
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
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_localid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_namespace">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="inspireid_versionid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="soilinvestigationpurpose">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="false"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/SoilInvestigationPurposeValue') "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_6dff4a6f_20e9_4a3d_912e_3af2836047d1"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="validfrom">
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
    <field configurationFlags="None" name="validto">
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
    <field configurationFlags="None" name="beginlifespanversion">
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
    <field configurationFlags="None" name="endlifespanversion">
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
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="inspireid_localid" index="2" name="Local id"/>
    <alias field="inspireid_namespace" index="3" name="Namespace"/>
    <alias field="inspireid_versionid" index="4" name="Version id"/>
    <alias field="soilinvestigationpurpose" index="5" name="Soil Investigation Purpose"/>
    <alias field="validfrom" index="6" name="Valid From"/>
    <alias field="validto" index="7" name="Valid To"/>
    <alias field="beginlifespanversion" index="8" name="Begin Lifespan version"/>
    <alias field="endlifespanversion" index="9" name="End Lifespan version"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="Duplicate"/>
    <policy field="inspireid_localid" policy="Duplicate"/>
    <policy field="inspireid_namespace" policy="Duplicate"/>
    <policy field="inspireid_versionid" policy="Duplicate"/>
    <policy field="soilinvestigationpurpose" policy="Duplicate"/>
    <policy field="validfrom" policy="Duplicate"/>
    <policy field="validto" policy="Duplicate"/>
    <policy field="beginlifespanversion" policy="Duplicate"/>
    <policy field="endlifespanversion" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="guidkey" expression="" applyOnUpdate="0"/>
    <default field="inspireid_localid" expression="" applyOnUpdate="0"/>
    <default field="inspireid_namespace" expression="" applyOnUpdate="0"/>
    <default field="inspireid_versionid" expression="" applyOnUpdate="0"/>
    <default field="soilinvestigationpurpose" expression="" applyOnUpdate="0"/>
    <default field="validfrom" expression="" applyOnUpdate="0"/>
    <default field="validto" expression="" applyOnUpdate="0"/>
    <default field="beginlifespanversion" expression="" applyOnUpdate="0"/>
    <default field="endlifespanversion" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="guidkey" constraints="2" unique_strength="1" exp_strength="0" notnull_strength="0"/>
    <constraint field="inspireid_localid" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="inspireid_namespace" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="inspireid_versionid" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="soilinvestigationpurpose" constraints="1" unique_strength="0" exp_strength="0" notnull_strength="1"/>
    <constraint field="validfrom" constraints="1" unique_strength="0" exp_strength="0" notnull_strength="1"/>
    <constraint field="validto" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="beginlifespanversion" constraints="1" unique_strength="0" exp_strength="0" notnull_strength="1"/>
    <constraint field="endlifespanversion" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="inspireid_localid" exp="" desc=""/>
    <constraint field="inspireid_namespace" exp="" desc=""/>
    <constraint field="inspireid_versionid" exp="" desc=""/>
    <constraint field="soilinvestigationpurpose" exp="" desc=""/>
    <constraint field="validfrom" exp="" desc=""/>
    <constraint field="validto" exp="" desc=""/>
    <constraint field="beginlifespanversion" exp="" desc=""/>
    <constraint field="endlifespanversion" exp="" desc=""/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="0" name="id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" collapsed="0" name="INSPIRE ID" showLabel="1" groupBox="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="2" name="inspireid_localid" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="3" name="inspireid_namespace" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="4" name="inspireid_versionid" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" index="5" name="soilinvestigationpurpose" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpressionEnabled="0" visibilityExpression="" columnCount="2" collapsedExpression="" horizontalStretch="0" collapsed="0" name="Dates" showLabel="1" groupBox="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="8" name="beginlifespanversion" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="9" name="endlifespanversion" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="6" name="validfrom" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="7" name="validto" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsedExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsedExpression="" horizontalStretch="0" collapsed="0" name="Soil Plot" showLabel="1" groupBox="0" type="Tab" visibilityExpressionEnabled="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorRelation forceSuppressFormPopup="0" nmRelationId="" relationWidgetTypeId="relation_editor" horizontalStretch="0" name="soilsite_soilplot" showLabel="0" relation="soilsite_soilplot" verticalStretch="0" label="">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
          <Option name="buttons" type="QString" value="AllButtons"/>
          <Option name="show_first_feature" type="bool" value="true"/>
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
    <field name="soilinvestigationpurpose" editable="1"/>
    <field name="validfrom" editable="1"/>
    <field name="validto" editable="1"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="beginlifespanversion"/>
    <field labelOnTop="0" name="endlifespanversion"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="inspireid_localid"/>
    <field labelOnTop="0" name="inspireid_namespace"/>
    <field labelOnTop="0" name="inspireid_versionid"/>
    <field labelOnTop="0" name="soilinvestigationpurpose"/>
    <field labelOnTop="0" name="validfrom"/>
    <field labelOnTop="0" name="validto"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="beginlifespanversion" reuseLastValue="0"/>
    <field name="endlifespanversion" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="inspireid_localid" reuseLastValue="0"/>
    <field name="inspireid_namespace" reuseLastValue="0"/>
    <field name="inspireid_versionid" reuseLastValue="0"/>
    <field name="soilinvestigationpurpose" reuseLastValue="0"/>
    <field name="validfrom" reuseLastValue="0"/>
    <field name="validto" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'id '|| COALESCE( "id", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>2</layerGeometryType>
</qgis>
