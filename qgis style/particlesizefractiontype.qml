<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="profileelement_particlesizefractiontype" providerKey="ogr" referencedLayer="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" layerName="profileelement" name="profileelement_particlesizefractiontype" dataSource="./INSPIRE_Selection_4.gpkg|layername=profileelement" referencingLayer="particlesizefractiontype_207bae84_461b_4dd9_931b_e550f2b8e398" layerId="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="idprofileelement"/>
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
    <field configurationFlags="None" name="pariclesize_min">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="pariclesize_max">
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
    <alias index="2" name="Min" field="pariclesize_min"/>
    <alias index="3" name="Max" field="pariclesize_max"/>
    <alias index="4" name="" field="idprofileelement"/>
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
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="fractioncontent"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="pariclesize_min"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="pariclesize_max"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="idprofileelement"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="fractioncontent"/>
    <constraint exp="" desc="" field="pariclesize_min"/>
    <constraint exp="" desc="" field="pariclesize_max"/>
    <constraint exp="" desc="" field="idprofileelement"/>
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
      <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="4" name="idprofileelement" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="1" name="fractioncontent" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Particle Size" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="0" index="2" name="pariclesize_min" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="0" index="3" name="pariclesize_max" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
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
  <previewExpression>if ( "pariclesize_min" = 0,'Clay',&#xd;
If("pariclesize_min" = 0.002,'Lime','Sand')&#xd;
) || ' '|| "fractioncontent" ||'%'</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
