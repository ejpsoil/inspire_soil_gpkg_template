<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation id="profileelement_faohorizonnotationtype" providerKey="ogr" referencedLayer="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" layerName="profileelement" name="profileelement_faohorizonnotationtype" dataSource="./INSPIRE_Selection_4.gpkg|layername=profileelement" referencingLayer="faohorizonnotationtype_7354cb4c_6a01_4e2f_9316_e2b8e011fb3b" layerId="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" strength="Association">
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
    <field configurationFlags="None" name="faohorizondiscontinuity">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faohorizonmaster">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOHorizonMasterValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faohorizonsubordinate">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOHorizonSubordinateValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faohorizonverical">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faoprime">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOPrimeValue') &#xa;&#xa;" name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isoriginalclassification">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option value="" name="CheckedState" type="QString"/>
            <Option value="0" name="TextDisplayMethod" type="int"/>
            <Option value="" name="UncheckedState" type="QString"/>
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
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=profileelement" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="profileelement_e0037153_3a70_46eb_9cb8_8b365ffbe8f7" name="ReferencedLayerId" type="QString"/>
            <Option value="profileelement" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="profileelement_faohorizonnotationtype" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="FAO Horizon Discontinuity" field="faohorizondiscontinuity"/>
    <alias index="2" name="FAO Horizon Masterity" field="faohorizonmaster"/>
    <alias index="3" name="FAO Horizon Subordinate" field="faohorizonsubordinate"/>
    <alias index="4" name="FAO Horizon Vertical" field="faohorizonverical"/>
    <alias index="5" name="FAO Prime" field="faoprime"/>
    <alias index="6" name="It is an Original classification" field="isoriginalclassification"/>
    <alias index="7" name="Profile Element" field="idprofileelement"/>
  </aliases>
  <splitPolicies>
    <policy policy="DefaultValue" field="id"/>
    <policy policy="DefaultValue" field="faohorizondiscontinuity"/>
    <policy policy="DefaultValue" field="faohorizonmaster"/>
    <policy policy="DefaultValue" field="faohorizonsubordinate"/>
    <policy policy="DefaultValue" field="faohorizonverical"/>
    <policy policy="DefaultValue" field="faoprime"/>
    <policy policy="DefaultValue" field="isoriginalclassification"/>
    <policy policy="DefaultValue" field="idprofileelement"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="faohorizondiscontinuity"/>
    <default applyOnUpdate="0" expression="" field="faohorizonmaster"/>
    <default applyOnUpdate="0" expression="" field="faohorizonsubordinate"/>
    <default applyOnUpdate="0" expression="" field="faohorizonverical"/>
    <default applyOnUpdate="0" expression="" field="faoprime"/>
    <default applyOnUpdate="0" expression="" field="isoriginalclassification"/>
    <default applyOnUpdate="0" expression="" field="idprofileelement"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="faohorizondiscontinuity"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="faohorizonmaster"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="faohorizonsubordinate"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="faohorizonverical"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="faoprime"/>
    <constraint exp_strength="0" notnull_strength="1" unique_strength="0" constraints="1" field="isoriginalclassification"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="idprofileelement"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="faohorizondiscontinuity"/>
    <constraint exp="" desc="" field="faohorizonmaster"/>
    <constraint exp="" desc="" field="faohorizonsubordinate"/>
    <constraint exp="" desc="" field="faohorizonverical"/>
    <constraint exp="" desc="" field="faoprime"/>
    <constraint exp="" desc="" field="isoriginalclassification"/>
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
    <attributeEditorField showLabel="1" index="0" name="id" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="1" name="faohorizondiscontinuity" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" name="faohorizonmaster" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="3" name="faohorizonsubordinate" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="4" name="faohorizonverical" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="5" name="faoprime" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="6" name="isoriginalclassification" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="7" name="idprofileelement" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="faohorizondiscontinuity"/>
    <field editable="1" name="faohorizonmaster"/>
    <field editable="1" name="faohorizonsubordinate"/>
    <field editable="1" name="faohorizonverical"/>
    <field editable="1" name="faoprime"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="idprofileelement"/>
    <field editable="1" name="isoriginalclassification"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="faohorizondiscontinuity"/>
    <field labelOnTop="0" name="faohorizonmaster"/>
    <field labelOnTop="0" name="faohorizonsubordinate"/>
    <field labelOnTop="0" name="faohorizonverical"/>
    <field labelOnTop="0" name="faoprime"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="idprofileelement"/>
    <field labelOnTop="0" name="isoriginalclassification"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="faohorizondiscontinuity"/>
    <field reuseLastValue="0" name="faohorizonmaster"/>
    <field reuseLastValue="0" name="faohorizonsubordinate"/>
    <field reuseLastValue="0" name="faohorizonverical"/>
    <field reuseLastValue="0" name="faoprime"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idprofileelement"/>
    <field reuseLastValue="0" name="isoriginalclassification"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "id", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
