<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <renderer-v2 symbollevels="0" referencescale="-1" type="singleSymbol" enableorderby="0" forceraster="0">
    <symbols>
      <symbol is_animated="0" force_rhr="0" type="fill" frame_rate="10" alpha="1" name="0" clip_to_extent="1">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </data_defined_properties>
        <layer locked="0" id="{12b7e589-6bec-497b-a46c-48647e55fb41}" enabled="1" class="SimpleFill" pass="0">
          <Option type="Map">
            <Option value="3x:0,0,0,0,0,0" type="QString" name="border_width_map_unit_scale"/>
            <Option value="180,224,149,255" type="QString" name="color"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="0,0,255,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="1" type="QString" name="outline_width"/>
            <Option value="Pixel" type="QString" name="outline_width_unit"/>
            <Option value="no" type="QString" name="style"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <referencedLayers/>
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
    <field configurationFlags="None" name="soilinvestigationpurpose">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('SoilInvestigationPurposeValue') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
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
    <constraint field="id" notnull_strength="1" exp_strength="0" constraints="3" unique_strength="1"/>
    <constraint field="guidkey" notnull_strength="0" exp_strength="0" constraints="2" unique_strength="1"/>
    <constraint field="inspireid_localid" notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="inspireid_namespace" notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="inspireid_versionid" notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="soilinvestigationpurpose" notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0"/>
    <constraint field="validfrom" notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0"/>
    <constraint field="validto" notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="beginlifespanversion" notnull_strength="1" exp_strength="0" constraints="1" unique_strength="0"/>
    <constraint field="endlifespanversion" notnull_strength="0" exp_strength="0" constraints="0" unique_strength="0"/>
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
    <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
      <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="0" name="id">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" visibilityExpressionEnabled="0" horizontalStretch="0" visibilityExpression="" collapsed="0" showLabel="1" verticalStretch="0" groupBox="1" type="GroupBox" collapsedExpressionEnabled="0" collapsedExpression="" name="INSPIRE ID">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="2" name="inspireid_localid">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="3" name="inspireid_namespace">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="4" name="inspireid_versionid">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="5" name="soilinvestigationpurpose">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="2" visibilityExpressionEnabled="0" horizontalStretch="0" visibilityExpression="" collapsed="0" showLabel="1" verticalStretch="0" groupBox="1" type="GroupBox" collapsedExpressionEnabled="0" collapsedExpression="" name="Dates">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="8" name="beginlifespanversion">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="9" name="endlifespanversion">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="6" name="validfrom">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" showLabel="1" verticalStretch="0" index="7" name="validto">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer columnCount="1" visibilityExpressionEnabled="0" horizontalStretch="0" visibilityExpression="" collapsed="0" showLabel="1" verticalStretch="0" groupBox="1" type="GroupBox" collapsedExpressionEnabled="0" collapsedExpression="" name="RELATIONS">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
      </labelStyle>
      <attributeEditorContainer columnCount="1" visibilityExpressionEnabled="0" horizontalStretch="0" visibilityExpression="" collapsed="1" showLabel="1" verticalStretch="0" groupBox="1" type="GroupBox" collapsedExpressionEnabled="0" collapsedExpression="" name="Soil Plot">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" strikethrough="0" style="" bold="1"/>
        </labelStyle>
        <attributeEditorRelation label="" horizontalStretch="0" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" showLabel="0" verticalStretch="0" name="soilsite_soilplot" relation="soilsite_soilplot" nmRelationId="">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
            <Option value="AllButtons" type="QString" name="buttons"/>
            <Option value="true" type="bool" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer columnCount="1" visibilityExpressionEnabled="0" horizontalStretch="0" visibilityExpression="" collapsed="1" showLabel="1" verticalStretch="0" groupBox="1" type="GroupBox" collapsedExpressionEnabled="0" collapsedExpression="" name="Datastream">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" strikethrough="0" style="" bold="1"/>
        </labelStyle>
        <attributeEditorRelation label="Datastream" horizontalStretch="0" forceSuppressFormPopup="0" relationWidgetTypeId="relation_editor" showLabel="0" verticalStretch="0" name="soilsite_datastream_9" relation="soilsite_datastream_9" nmRelationId="">
          <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
            <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
            <Option value="AllButtons" type="QString" name="buttons"/>
            <Option value="true" type="bool" name="show_first_feature"/>
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
    <field reuseLastValue="0" name="beginlifespanversion"/>
    <field reuseLastValue="0" name="endlifespanversion"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="inspireid_localid"/>
    <field reuseLastValue="0" name="inspireid_namespace"/>
    <field reuseLastValue="0" name="inspireid_versionid"/>
    <field reuseLastValue="0" name="soilinvestigationpurpose"/>
    <field reuseLastValue="0" name="validfrom"/>
    <field reuseLastValue="0" name="validto"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="soilsite_datastream_9">
      <config type="Map">
        <Option value="false" type="bool" name="force-suppress-popup"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>COALESCE( "inspireid_localid", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>2</layerGeometryType>
</qgis>
