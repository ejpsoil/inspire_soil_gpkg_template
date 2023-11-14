<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Fields|Forms" readOnly="0">
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
    <field name="soilplottype" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="false"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/SoilPlotTypeValue') "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_23addab1_184e_4eae_be1c_bccf93d49a65"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
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
    <field name="locatedon" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"/>
            <Option name="AllowNULL" type="bool" value="false"/>
            <Option name="FetchLimitActive" type="bool" value="true"/>
            <Option name="FetchLimitNumber" type="int" value="100"/>
            <Option name="MapIdentification" type="bool" value="false"/>
            <Option name="ReadOnly" type="bool" value="false"/>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=soilsite"/>
            <Option name="ReferencedLayerId" type="QString" value="soilsite_b1a194b7_e66a_4744_80af_5bfa81c8ef3c"/>
            <Option name="ReferencedLayerName" type="QString" value="soilsite"/>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"/>
            <Option name="Relation" type="QString" value="soilsite_soilplot"/>
            <Option name="ShowForm" type="bool" value="false"/>
            <Option name="ShowOpenFormButton" type="bool" value="true"/>
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
    <alias name="Varsion id" field="inspireid_versionid" index="4"/>
    <alias name="Type" field="soilplottype" index="5"/>
    <alias name="Begin Lifespan Version" field="beginlifespanversion" index="6"/>
    <alias name="End Lifespan Version" field="endlifespanversion" index="7"/>
    <alias name="Soil Site" field="locatedon" index="8"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="inspireid_localid"/>
    <policy policy="DefaultValue" field="inspireid_namespace"/>
    <policy policy="DefaultValue" field="inspireid_versionid"/>
    <policy policy="DefaultValue" field="soilplottype"/>
    <policy policy="DefaultValue" field="beginlifespanversion"/>
    <policy policy="DefaultValue" field="endlifespanversion"/>
    <policy policy="DefaultValue" field="locatedon"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="inspireid_localid" expression=""/>
    <default applyOnUpdate="0" field="inspireid_namespace" expression=""/>
    <default applyOnUpdate="0" field="inspireid_versionid" expression=""/>
    <default applyOnUpdate="0" field="soilplottype" expression=""/>
    <default applyOnUpdate="0" field="beginlifespanversion" expression=""/>
    <default applyOnUpdate="0" field="endlifespanversion" expression=""/>
    <default applyOnUpdate="0" field="locatedon" expression=""/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" exp_strength="0" field="id" notnull_strength="1"/>
    <constraint constraints="2" unique_strength="1" exp_strength="0" field="guidkey" notnull_strength="0"/>
    <constraint constraints="0" unique_strength="0" exp_strength="0" field="inspireid_localid" notnull_strength="0"/>
    <constraint constraints="0" unique_strength="0" exp_strength="0" field="inspireid_namespace" notnull_strength="0"/>
    <constraint constraints="0" unique_strength="0" exp_strength="0" field="inspireid_versionid" notnull_strength="0"/>
    <constraint constraints="1" unique_strength="0" exp_strength="0" field="soilplottype" notnull_strength="1"/>
    <constraint constraints="1" unique_strength="0" exp_strength="0" field="beginlifespanversion" notnull_strength="1"/>
    <constraint constraints="0" unique_strength="0" exp_strength="0" field="endlifespanversion" notnull_strength="0"/>
    <constraint constraints="0" unique_strength="0" exp_strength="0" field="locatedon" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="guidkey" exp=""/>
    <constraint desc="" field="inspireid_localid" exp=""/>
    <constraint desc="" field="inspireid_namespace" exp=""/>
    <constraint desc="" field="inspireid_versionid" exp=""/>
    <constraint desc="" field="soilplottype" exp=""/>
    <constraint desc="" field="beginlifespanversion" exp=""/>
    <constraint desc="" field="endlifespanversion" exp=""/>
    <constraint desc="" field="locatedon" exp=""/>
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
      <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
    </labelStyle>
    <attributeEditorField name="id" horizontalStretch="0" showLabel="1" verticalStretch="0" index="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer name="INSPIRE ID" type="GroupBox" horizontalStretch="0" visibilityExpressionEnabled="0" showLabel="1" groupBox="1" collapsedExpression="" verticalStretch="0" collapsedExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsed="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
      </labelStyle>
      <attributeEditorField name="inspireid_localid" horizontalStretch="0" showLabel="1" verticalStretch="0" index="2">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_namespace" horizontalStretch="0" showLabel="1" verticalStretch="0" index="3">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="inspireid_versionid" horizontalStretch="0" showLabel="1" verticalStretch="0" index="4">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField name="soilplottype" horizontalStretch="0" showLabel="1" verticalStretch="0" index="5">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="locatedon" horizontalStretch="0" showLabel="1" verticalStretch="0" index="8">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer name="Dates" type="GroupBox" horizontalStretch="0" visibilityExpressionEnabled="0" showLabel="1" groupBox="1" collapsedExpression="" verticalStretch="0" collapsedExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsed="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
      </labelStyle>
      <attributeEditorField name="beginlifespanversion" horizontalStretch="0" showLabel="1" verticalStretch="0" index="6">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="endlifespanversion" horizontalStretch="0" showLabel="1" verticalStretch="0" index="7">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer name="SOIL PROFILE" type="GroupBox" horizontalStretch="0" visibilityExpressionEnabled="0" showLabel="1" groupBox="1" collapsedExpression="" verticalStretch="0" collapsedExpressionEnabled="0" visibilityExpression="" columnCount="1" collapsed="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="1">
        <labelFont description="MS Shell Dlg 2,8,-1,5,75,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="1" style=""/>
      </labelStyle>
      <attributeEditorRelation name="soilplot_soilprofile" forceSuppressFormPopup="0" label="" relationWidgetTypeId="relation_editor" horizontalStretch="0" showLabel="0" relation="soilplot_soilprofile" nmRelationId="" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0" bold="0" style=""/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option name="allow_add_child_feature_with_no_geometry" type="bool" value="false"/>
          <Option name="buttons" type="QString" value="Link|Unlink|SaveChildEdits|AddChildFeature|DeleteChildFeature|ZoomToChildFeature"/>
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
    <field name="locatedon" editable="1"/>
    <field name="soilplottype" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="beginlifespanversion" labelOnTop="0"/>
    <field name="endlifespanversion" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="inspireid_localid" labelOnTop="0"/>
    <field name="inspireid_namespace" labelOnTop="0"/>
    <field name="inspireid_versionid" labelOnTop="0"/>
    <field name="locatedon" labelOnTop="0"/>
    <field name="soilplottype" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="beginlifespanversion" reuseLastValue="0"/>
    <field name="endlifespanversion" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="inspireid_localid" reuseLastValue="0"/>
    <field name="inspireid_namespace" reuseLastValue="0"/>
    <field name="inspireid_versionid" reuseLastValue="0"/>
    <field name="locatedon" reuseLastValue="0"/>
    <field name="soilplottype" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'id '|| COALESCE( "id", '&lt;NULL>' ) || ' - '|| COALESCE( "inspireid_localid", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>0</layerGeometryType>
</qgis>
