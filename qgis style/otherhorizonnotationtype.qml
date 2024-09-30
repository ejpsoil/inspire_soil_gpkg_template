<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="profileelement_e3c097e6_b9be_4926_8bd6_13f11448b000" id="profileelement_otherhorizonnotationtype" referencingLayer="otherhorizonnotationtype_9d3923ad_c916_40e0_b96b_7fd6d7c588ef" layerId="profileelement_e3c097e6_b9be_4926_8bd6_13f11448b000" providerKey="ogr" dataSource="./INSPIRE_SO_DEMO_V01.gpkg|layername=profileelement" layerName="profileelement" name="profileelement_otherhorizonnotationtype" strength="Association">
      <fieldRef referencedField="guidkey" referencingField="otherhorizonnotation"/>
    </relation>
  </referencedLayers>
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
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="horizonnotation">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('OtherHorizonNotationTypeValue')" type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="diagnostichorizon">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; = current_value('horizonnotation')" type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isoriginalclassification">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option value="" type="QString" name="CheckedState"/>
            <Option value="0" type="int" name="TextDisplayMethod"/>
            <Option value="" type="QString" name="UncheckedState"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="otherhorizonnotation">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowAddFeatures"/>
            <Option value="false" type="bool" name="AllowNULL"/>
            <Option value="true" type="bool" name="FetchLimitActive"/>
            <Option value="100" type="int" name="FetchLimitNumber"/>
            <Option value="false" type="bool" name="MapIdentification"/>
            <Option value="false" type="bool" name="ReadOnly"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=profileelement" type="QString" name="ReferencedLayerDataSource"/>
            <Option value="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" type="QString" name="ReferencedLayerId"/>
            <Option value="profileelement" type="QString" name="ReferencedLayerName"/>
            <Option value="ogr" type="QString" name="ReferencedLayerProviderKey"/>
            <Option value="profileelement_otherhorizonnotationtype" type="QString" name="Relation"/>
            <Option value="false" type="bool" name="ShowForm"/>
            <Option value="true" type="bool" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="horizonnotation" index="2" name="Horizon Notation"/>
    <alias field="diagnostichorizon" index="3" name="Diagnostic Horizon"/>
    <alias field="isoriginalclassification" index="4" name="Is original Classificatzion"/>
    <alias field="otherhorizonnotation" index="5" name="Profile Element"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="Duplicate"/>
    <policy field="horizonnotation" policy="DefaultValue"/>
    <policy field="diagnostichorizon" policy="DefaultValue"/>
    <policy field="isoriginalclassification" policy="DefaultValue"/>
    <policy field="otherhorizonnotation" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="guidkey" applyOnUpdate="0" expression=""/>
    <default field="horizonnotation" applyOnUpdate="0" expression=""/>
    <default field="diagnostichorizon" applyOnUpdate="0" expression=""/>
    <default field="isoriginalclassification" applyOnUpdate="0" expression=""/>
    <default field="otherhorizonnotation" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="1" notnull_strength="1" exp_strength="0" constraints="3"/>
    <constraint field="guidkey" unique_strength="1" notnull_strength="0" exp_strength="0" constraints="2"/>
    <constraint field="horizonnotation" unique_strength="0" notnull_strength="1" exp_strength="0" constraints="1"/>
    <constraint field="diagnostichorizon" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="isoriginalclassification" unique_strength="0" notnull_strength="1" exp_strength="0" constraints="1"/>
    <constraint field="otherhorizonnotation" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="horizonnotation" exp="" desc=""/>
    <constraint field="diagnostichorizon" exp="" desc=""/>
    <constraint field="isoriginalclassification" exp="" desc=""/>
    <constraint field="otherhorizonnotation" exp="" desc=""/>
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
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="0" name="id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" collapsedExpression="" collapsed="0" horizontalStretch="0" groupBox="1" visibilityExpression="" collapsedExpressionEnabled="0" type="GroupBox" visibilityExpressionEnabled="0" name="Notation" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="2" name="horizonnotation" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="0" index="3" name="diagnostichorizon" showLabel="1" verticalStretch="0">
        <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" index="4" name="isoriginalclassification" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="5" name="otherhorizonnotation" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" bold="0" italic="0" style=""/>
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
    <field labelOnTop="0" name="diagnostichorizon"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="horizonnotation"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="isoriginalclassification"/>
    <field labelOnTop="0" name="otherhorizonnotation"/>
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
  <previewExpression> "horizonnotation" || ' - '|| regexp_substr( "diagnostichorizon" , '[^/]*$')</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
