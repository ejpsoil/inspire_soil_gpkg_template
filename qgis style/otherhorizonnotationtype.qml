<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="profileelement_0057e95f_935c_4f95_a2a2_2bf7a03462fa" strength="Association" name="profileelement_otherhorizonnotationtype" providerKey="ogr" dataSource="./Vector.gpkg|layername=profileelement" referencingLayer="otherhorizonnotationtype_30b68e74_405b_4578_821d_90d692b1651b" layerId="profileelement_0057e95f_935c_4f95_a2a2_2bf7a03462fa" layerName="profileelement" id="profileelement_otherhorizonnotationtype">
      <fieldRef referencedField="guidkey" referencingField="otherhorizonnotation"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="horizonnotation" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowMulti" value="false"/>
            <Option type="bool" name="AllowNull" value="false"/>
            <Option type="QString" name="Description" value="&quot;label&quot;"/>
            <Option type="QString" name="FilterExpression" value="&quot;collection&quot; IN('OtherHorizonNotationTypeValue')"/>
            <Option type="QString" name="Key" value="id"/>
            <Option type="QString" name="Layer" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748"/>
            <Option type="QString" name="LayerName" value="codelist"/>
            <Option type="QString" name="LayerProviderName" value="ogr"/>
            <Option type="QString" name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist"/>
            <Option type="int" name="NofColumns" value="1"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="UseCompleter" value="false"/>
            <Option type="QString" name="Value" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="diagnostichorizon" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowMulti" value="false"/>
            <Option type="bool" name="AllowNull" value="false"/>
            <Option type="QString" name="Description" value="&quot;label&quot;"/>
            <Option type="QString" name="FilterExpression" value="&quot;foi&quot; = current_value('horizonnotation')"/>
            <Option type="QString" name="Key" value="id"/>
            <Option type="QString" name="Layer" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748"/>
            <Option type="QString" name="LayerName" value="codelist"/>
            <Option type="QString" name="LayerProviderName" value="ogr"/>
            <Option type="QString" name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist"/>
            <Option type="int" name="NofColumns" value="1"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="UseCompleter" value="false"/>
            <Option type="QString" name="Value" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="isoriginalclassification" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option type="QString" name="CheckedState" value=""/>
            <Option type="int" name="TextDisplayMethod" value="0"/>
            <Option type="QString" name="UncheckedState" value=""/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="otherhorizonnotation" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowAddFeatures" value="false"/>
            <Option type="bool" name="AllowNULL" value="false"/>
            <Option type="bool" name="FetchLimitActive" value="true"/>
            <Option type="int" name="FetchLimitNumber" value="100"/>
            <Option type="bool" name="MapIdentification" value="false"/>
            <Option type="bool" name="ReadOnly" value="false"/>
            <Option type="QString" name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=profileelement"/>
            <Option type="QString" name="ReferencedLayerId" value="profileelement_0057e95f_935c_4f95_a2a2_2bf7a03462fa"/>
            <Option type="QString" name="ReferencedLayerName" value="profileelement"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="profileelement_otherhorizonnotationtype"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="id" index="0"/>
    <alias name="Horizon Notation" field="horizonnotation" index="1"/>
    <alias name="Diagnostic Horizon" field="diagnostichorizon" index="2"/>
    <alias name="Is original Classificatzion" field="isoriginalclassification" index="3"/>
    <alias name="Profile Element" field="otherhorizonnotation" index="4"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="horizonnotation"/>
    <policy policy="DefaultValue" field="diagnostichorizon"/>
    <policy policy="DefaultValue" field="isoriginalclassification"/>
    <policy policy="DefaultValue" field="otherhorizonnotation"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="horizonnotation"/>
    <default applyOnUpdate="0" expression="" field="diagnostichorizon"/>
    <default applyOnUpdate="0" expression="" field="isoriginalclassification"/>
    <default applyOnUpdate="0" expression="" field="otherhorizonnotation"/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" constraints="3" exp_strength="0" field="id" notnull_strength="1"/>
    <constraint unique_strength="0" constraints="0" exp_strength="0" field="horizonnotation" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" exp_strength="0" field="diagnostichorizon" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" exp_strength="0" field="isoriginalclassification" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" exp_strength="0" field="otherhorizonnotation" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="horizonnotation"/>
    <constraint desc="" exp="" field="diagnostichorizon"/>
    <constraint desc="" exp="" field="isoriginalclassification"/>
    <constraint desc="" exp="" field="otherhorizonnotation"/>
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
      <labelFont italic="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0"/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" showLabel="1" name="id" verticalStretch="0" index="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont italic="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpressionEnabled="0" horizontalStretch="0" columnCount="1" groupBox="1" type="GroupBox" showLabel="1" name="Notation" collapsedExpression="" verticalStretch="0" collapsed="0" visibilityExpression="" visibilityExpressionEnabled="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont italic="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" showLabel="1" name="horizonnotation" verticalStretch="0" index="1">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont italic="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" showLabel="1" name="diagnostichorizon" verticalStretch="0" index="2">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont italic="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" showLabel="1" name="isoriginalclassification" verticalStretch="0" index="3">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont italic="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" showLabel="1" name="otherhorizonnotation" verticalStretch="0" index="4">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont italic="0" style="" bold="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="diagnostichorizon"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="horizonnotation"/>
    <field editable="1" name="id"/>
    <field editable="1" name="isoriginalclassification"/>
    <field editable="1" name="otherhorizonnotation"/>
  </editable>
  <labelOnTop>
    <field name="diagnostichorizon" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="horizonnotation" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="isoriginalclassification" labelOnTop="0"/>
    <field name="otherhorizonnotation" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="diagnostichorizon"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="horizonnotation"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="isoriginalclassification"/>
    <field reuseLastValue="0" name="otherhorizonnotation"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "id", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
