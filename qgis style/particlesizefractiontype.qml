<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation layerName="profileelement" name="profileelement_particlesizefractiontype" dataSource="./Vector.gpkg|layername=profileelement" layerId="profileelement_8af1614f_54a2_483f_83ff_f52e8f55a005" id="profileelement_particlesizefractiontype" referencedLayer="profileelement_8af1614f_54a2_483f_83ff_f52e8f55a005" strength="Association" referencingLayer="particlesizefractiontype_64e90840_bfad_49d1_bc92_2b49dc2600ac" providerKey="ogr">
      <fieldRef referencingField="idprofileelement" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="fractioncontent" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="pariclesize_min" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="pariclesize_max" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="idprofileelement" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="FetchLimitActive" value="true" type="bool"/>
            <Option name="FetchLimitNumber" value="100" type="int"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_07 Dati OK/Vector.gpkg|layername=profileelement" type="QString"/>
            <Option name="ReferencedLayerId" value="profileelement_8af1614f_54a2_483f_83ff_f52e8f55a005" type="QString"/>
            <Option name="ReferencedLayerName" value="profileelement" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="profileelement_particlesizefractiontype" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
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
    <policy field="id" policy="DefaultValue"/>
    <policy field="fractioncontent" policy="DefaultValue"/>
    <policy field="pariclesize_min" policy="DefaultValue"/>
    <policy field="pariclesize_max" policy="DefaultValue"/>
    <policy field="idprofileelement" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="fractioncontent" expression=""/>
    <default applyOnUpdate="0" field="pariclesize_min" expression=""/>
    <default applyOnUpdate="0" field="pariclesize_max" expression=""/>
    <default applyOnUpdate="0" field="idprofileelement" expression=""/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" field="id" constraints="3"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="fractioncontent" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="pariclesize_min" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" field="pariclesize_max" constraints="0"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" field="idprofileelement" constraints="1"/>
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
    <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
      <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
    </labelStyle>
    <attributeEditorField name="idprofileelement" showLabel="1" index="4" horizontalStretch="0" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="fractioncontent" showLabel="1" index="1" horizontalStretch="0" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer name="Particle Size" showLabel="1" columnCount="1" visibilityExpressionEnabled="0" collapsed="0" collapsedExpressionEnabled="0" collapsedExpression="" visibilityExpression="" horizontalStretch="0" verticalStretch="0" type="GroupBox" groupBox="1">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
      <attributeEditorField name="pariclesize_min" showLabel="0" index="2" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="pariclesize_max" showLabel="0" index="3" horizontalStretch="0" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont bold="0" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
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
  </editable>
  <labelOnTop>
    <field name="fractioncontent" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="idprofileelement" labelOnTop="0"/>
    <field name="pariclesize_max" labelOnTop="0"/>
    <field name="pariclesize_min" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="fractioncontent" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="idprofileelement" reuseLastValue="0"/>
    <field name="pariclesize_max" reuseLastValue="0"/>
    <field name="pariclesize_min" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>if ( "pariclesize_min" = 0,'Clay',&#xd;
If("pariclesize_min" = 0.002,'Lime','Sand')&#xd;
) || ' '|| "fractioncontent" ||'%'</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
