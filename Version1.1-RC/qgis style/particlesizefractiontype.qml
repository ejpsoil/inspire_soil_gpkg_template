<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="profileelement_df6b698e_5913_4023_acf5_5c39652d49b4" providerKey="ogr" layerId="profileelement_df6b698e_5913_4023_acf5_5c39652d49b4" dataSource="./INSPIRE_SO.gpkg|layername=profileelement" name="profileelement_particlesizefractiontype" layerName="profileelement" referencingLayer="particlesizefractiontype_7fcdd654_2356_47de_9edc_a784f940e368" id="profileelement_particlesizefractiontype" strength="Association">
      <fieldRef referencingField="idprofileelement" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="fractioncontent">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="particlesize_lower">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="particlesize_upper">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idprofileelement">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="true" name="FetchLimitActive" type="bool"/>
            <Option value="100" name="FetchLimitNumber" type="int"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_07 Dati OK/Vector.gpkg|layername=profileelement" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="profileelement_8af1614f_54a2_483f_83ff_f52e8f55a005" name="ReferencedLayerId" type="QString"/>
            <Option value="profileelement" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="profileelement_particlesizefractiontype" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="Fraction content %" field="fractioncontent"/>
    <alias index="2" name="Lower limit" field="particlesize_lower"/>
    <alias index="3" name="Upper limit" field="particlesize_upper"/>
    <alias index="4" name="" field="idprofileelement"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="fractioncontent"/>
    <policy policy="DefaultValue" field="particlesize_lower"/>
    <policy policy="DefaultValue" field="particlesize_upper"/>
    <policy policy="DefaultValue" field="idprofileelement"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="fractioncontent" applyOnUpdate="0" expression=""/>
    <default field="particlesize_lower" applyOnUpdate="0" expression=""/>
    <default field="particlesize_upper" applyOnUpdate="0" expression=""/>
    <default field="idprofileelement" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="3" notnull_strength="1" exp_strength="0" unique_strength="1"/>
    <constraint field="fractioncontent" constraints="1" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint field="particlesize_lower" constraints="1" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint field="particlesize_upper" constraints="1" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint field="idprofileelement" constraints="1" notnull_strength="1" exp_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="fractioncontent" exp=""/>
    <constraint desc="" field="particlesize_lower" exp=""/>
    <constraint desc="" field="particlesize_upper" exp=""/>
    <constraint desc="" field="idprofileelement" exp=""/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont strikethrough="0" bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="4" name="idprofileelement" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont strikethrough="0" bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="1" name="fractioncontent" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont strikethrough="0" bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpression="" visibilityExpression="" showLabel="1" name="Particle Size in micrometers (µm)" verticalStretch="0" collapsedExpressionEnabled="0" horizontalStretch="0" columnCount="1" groupBox="1" type="GroupBox" collapsed="0" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont strikethrough="0" bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="2" name="particlesize_lower" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont strikethrough="0" bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="3" name="particlesize_upper" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont strikethrough="0" bold="0" italic="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="fractioncontent" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="idprofileelement" editable="1"/>
    <field name="pariclesize_max" editable="1"/>
    <field name="pariclesize_min" editable="1"/>
    <field name="particlesize_lower" editable="1"/>
    <field name="particlesize_max" editable="1"/>
    <field name="particlesize_min" editable="1"/>
    <field name="particlesize_upper" editable="1"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="fractioncontent"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idprofileelement"/>
    <field labelOnTop="0" name="pariclesize_max"/>
    <field labelOnTop="0" name="pariclesize_min"/>
    <field labelOnTop="0" name="particlesize_lower"/>
    <field labelOnTop="0" name="particlesize_max"/>
    <field labelOnTop="0" name="particlesize_min"/>
    <field labelOnTop="0" name="particlesize_upper"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="fractioncontent"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idprofileelement"/>
    <field reuseLastValue="0" name="pariclesize_max"/>
    <field reuseLastValue="0" name="pariclesize_min"/>
    <field reuseLastValue="0" name="particlesize_lower"/>
    <field reuseLastValue="0" name="particlesize_max"/>
    <field reuseLastValue="0" name="particlesize_min"/>
    <field reuseLastValue="0" name="particlesize_upper"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"fractioncontent" ||'% ' ||'('|| "particlesize_lower" ||'-'|| "particlesize_upper" ||')'</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
