<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="profileelement_particlesizefractiontype" referencingLayer="particlesizefractiontype_7fcdd654_2356_47de_9edc_a784f940e368" layerName="profileelement" strength="Association" referencedLayer="profileelement_df6b698e_5913_4023_acf5_5c39652d49b4" dataSource="./INSPIRE_SO.gpkg|layername=profileelement" providerKey="ogr" layerId="profileelement_df6b698e_5913_4023_acf5_5c39652d49b4" name="profileelement_particlesizefractiontype">
      <fieldRef referencedField="guidkey" referencingField="idprofileelement"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="fractioncontent">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="pariclesize_min">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="pariclesize_max">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="idprofileelement">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="true" name="FetchLimitActive"/>
            <Option type="int" value="100" name="FetchLimitNumber"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_07 Dati OK/Vector.gpkg|layername=profileelement" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="profileelement_8af1614f_54a2_483f_83ff_f52e8f55a005" name="ReferencedLayerId"/>
            <Option type="QString" value="profileelement" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="profileelement_particlesizefractiontype" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="fractioncontent" index="1" name="Fraction content %"/>
    <alias field="pariclesize_min" index="2" name="Min"/>
    <alias field="pariclesize_max" index="3" name="Max"/>
    <alias field="idprofileelement" index="4" name=""/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="fractioncontent" policy="DefaultValue"/>
    <policy field="pariclesize_min" policy="DefaultValue"/>
    <policy field="pariclesize_max" policy="DefaultValue"/>
    <policy field="idprofileelement" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="fractioncontent" expression="" applyOnUpdate="0"/>
    <default field="pariclesize_min" expression="" applyOnUpdate="0"/>
    <default field="pariclesize_max" expression="" applyOnUpdate="0"/>
    <default field="idprofileelement" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" field="id" exp_strength="0" constraints="3" unique_strength="1"/>
    <constraint notnull_strength="1" field="fractioncontent" exp_strength="0" constraints="1" unique_strength="0"/>
    <constraint notnull_strength="1" field="pariclesize_min" exp_strength="0" constraints="1" unique_strength="0"/>
    <constraint notnull_strength="1" field="pariclesize_max" exp_strength="0" constraints="1" unique_strength="0"/>
    <constraint notnull_strength="1" field="idprofileelement" exp_strength="0" constraints="1" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="fractioncontent" desc="" exp=""/>
    <constraint field="pariclesize_min" desc="" exp=""/>
    <constraint field="pariclesize_max" desc="" exp=""/>
    <constraint field="idprofileelement" desc="" exp=""/>
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
      <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0" underline="0" style=""/>
    </labelStyle>
    <attributeEditorField index="4" verticalStretch="0" showLabel="1" horizontalStretch="0" name="idprofileelement">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="1" verticalStretch="0" showLabel="1" horizontalStretch="0" name="fractioncontent">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer visibilityExpression="" columnCount="1" groupBox="1" verticalStretch="0" showLabel="1" collapsedExpression="" visibilityExpressionEnabled="0" horizontalStretch="0" collapsed="0" collapsedExpressionEnabled="0" name="Particle Size expressed in micrometers (µm)" type="GroupBox">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0" underline="0" style=""/>
      </labelStyle>
      <attributeEditorField index="2" verticalStretch="0" showLabel="1" horizontalStretch="0" name="pariclesize_min">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="3" verticalStretch="0" showLabel="1" horizontalStretch="0" name="pariclesize_max">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0" underline="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="fractioncontent"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="idprofileelement"/>
    <field editable="1" name="pariclesize_max"/>
    <field editable="1" name="pariclesize_min"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="fractioncontent"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idprofileelement"/>
    <field labelOnTop="0" name="pariclesize_max"/>
    <field labelOnTop="0" name="pariclesize_min"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="fractioncontent"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idprofileelement"/>
    <field reuseLastValue="0" name="pariclesize_max"/>
    <field reuseLastValue="0" name="pariclesize_min"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"fractioncontent" ||'% ' ||'('|| "pariclesize_min" ||'-'|| "pariclesize_max" ||')'</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
