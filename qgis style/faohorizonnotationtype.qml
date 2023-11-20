<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation referencedLayer="profileelement_0057e95f_935c_4f95_a2a2_2bf7a03462fa" strength="Association" dataSource="./Vector.gpkg|layername=profileelement" referencingLayer="faohorizonnotationtype_8c21b470_ae59_4bb0_ade7_7f2569196f79" id="profileelement_faohorizonnotationtype" layerId="profileelement_0057e95f_935c_4f95_a2a2_2bf7a03462fa" providerKey="ogr" name="profileelement_faohorizonnotationtype" layerName="profileelement">
      <fieldRef referencingField="idprofileelement" referencedField="guidkey"/>
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
    <field configurationFlags="None" name="faohorizondiscontinuity">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faohorizonmaster">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('FAOHorizonMaster') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faohorizonsubordinate">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('FAOHorizonSubordinate') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faohorizonverical">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="faoprime">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('FAOPrime') &#xa;&#xa;" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_44009776_a9a6_4371_91e7_8f3009ac5748" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isoriginalclassification">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option type="QString" value="" name="CheckedState"/>
            <Option type="int" value="0" name="TextDisplayMethod"/>
            <Option type="QString" value="" name="UncheckedState"/>
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
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_08 newcodelist/Vector.gpkg|layername=profileelement" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="profileelement_0057e95f_935c_4f95_a2a2_2bf7a03462fa" name="ReferencedLayerId"/>
            <Option type="QString" value="profileelement" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="profileelement_faohorizonnotationtype" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="id" name=""/>
    <alias index="1" field="faohorizondiscontinuity" name=""/>
    <alias index="2" field="faohorizonmaster" name=""/>
    <alias index="3" field="faohorizonsubordinate" name=""/>
    <alias index="4" field="faohorizonverical" name=""/>
    <alias index="5" field="faoprime" name=""/>
    <alias index="6" field="isoriginalclassification" name=""/>
    <alias index="7" field="idprofileelement" name=""/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="faohorizondiscontinuity" policy="DefaultValue"/>
    <policy field="faohorizonmaster" policy="DefaultValue"/>
    <policy field="faohorizonsubordinate" policy="DefaultValue"/>
    <policy field="faohorizonverical" policy="DefaultValue"/>
    <policy field="faoprime" policy="DefaultValue"/>
    <policy field="isoriginalclassification" policy="DefaultValue"/>
    <policy field="idprofileelement" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="faohorizondiscontinuity" expression="" applyOnUpdate="0"/>
    <default field="faohorizonmaster" expression="" applyOnUpdate="0"/>
    <default field="faohorizonsubordinate" expression="" applyOnUpdate="0"/>
    <default field="faohorizonverical" expression="" applyOnUpdate="0"/>
    <default field="faoprime" expression="" applyOnUpdate="0"/>
    <default field="isoriginalclassification" expression="" applyOnUpdate="0"/>
    <default field="idprofileelement" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" field="id" notnull_strength="1" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="faohorizondiscontinuity" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="faohorizonmaster" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="faohorizonsubordinate" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="faohorizonverical" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="faoprime" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" field="isoriginalclassification" notnull_strength="0" exp_strength="0"/>
    <constraint constraints="2" unique_strength="1" field="idprofileelement" notnull_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="faohorizondiscontinuity" exp="" desc=""/>
    <constraint field="faohorizonmaster" exp="" desc=""/>
    <constraint field="faohorizonsubordinate" exp="" desc=""/>
    <constraint field="faohorizonverical" exp="" desc=""/>
    <constraint field="faoprime" exp="" desc=""/>
    <constraint field="isoriginalclassification" exp="" desc=""/>
    <constraint field="idprofileelement" exp="" desc=""/>
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
    <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
      <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
    </labelStyle>
    <attributeEditorField index="0" showLabel="1" verticalStretch="0" name="id" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="1" showLabel="1" verticalStretch="0" name="faohorizondiscontinuity" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="2" showLabel="1" verticalStretch="0" name="faohorizonmaster" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="3" showLabel="1" verticalStretch="0" name="faohorizonsubordinate" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="4" showLabel="1" verticalStretch="0" name="faohorizonverical" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="5" showLabel="1" verticalStretch="0" name="faoprime" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="6" showLabel="1" verticalStretch="0" name="isoriginalclassification" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="7" showLabel="1" verticalStretch="0" name="idprofileelement" horizontalStretch="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont bold="0" italic="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0" strikethrough="0"/>
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
