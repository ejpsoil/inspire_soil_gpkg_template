<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation strength="Association" dataSource="./INSPIRE_SO.gpkg|layername=profileelement" referencedLayer="profileelement_b3ab52bf_7e70_44aa_8dc8_597c154a28b8" referencingLayer="particlesizefractiontype_c32c054c_73a6_48c5_8407_9776c43fb7bb" id="profileelement_particlesizefractiontype" layerId="profileelement_b3ab52bf_7e70_44aa_8dc8_597c154a28b8" layerName="profileelement" providerKey="ogr" name="profileelement_particlesizefractiontype">
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
    <alias index="0" field="id" name=""/>
    <alias index="1" field="fractioncontent" name="Fraction content %"/>
    <alias index="2" field="pariclesize_min" name="Min"/>
    <alias index="3" field="pariclesize_max" name="Max"/>
    <alias index="4" field="idprofileelement" name=""/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="fractioncontent"/>
    <policy policy="DefaultValue" field="pariclesize_min"/>
    <policy policy="DefaultValue" field="pariclesize_max"/>
    <policy policy="DefaultValue" field="idprofileelement"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="fractioncontent"/>
    <default applyOnUpdate="0" expression="" field="pariclesize_min"/>
    <default applyOnUpdate="0" expression="" field="pariclesize_max"/>
    <default applyOnUpdate="0" expression="" field="idprofileelement"/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" notnull_strength="1" exp_strength="0" field="id"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="fractioncontent"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="pariclesize_min"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="pariclesize_max"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" exp_strength="0" field="idprofileelement"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="fractioncontent"/>
    <constraint desc="" exp="" field="pariclesize_min"/>
    <constraint desc="" exp="" field="pariclesize_max"/>
    <constraint desc="" exp="" field="idprofileelement"/>
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
    <attributeEditorField showLabel="1" horizontalStretch="0" index="4" verticalStretch="0" name="idprofileelement">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="1" verticalStretch="0" name="fractioncontent">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Particle Size expressed in micrometers (µm)">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="2" verticalStretch="0" name="pariclesize_min">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="3" verticalStretch="0" name="pariclesize_max">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
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
  <previewExpression>if ( "pariclesize_min" = 0,'Clay',&#xd;&#xd;
If("pariclesize_min" = 2,'Lime','Sand')&#xd;&#xd;
) || ' '|| "fractioncontent" ||'%'</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
