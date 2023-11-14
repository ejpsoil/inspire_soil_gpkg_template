<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Fields|Forms">
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
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizondiscontinuity" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonmaster" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonMaster') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonsubordinate" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="&quot;label&quot;" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('https://crea.gov.it/infosuoli/vocabularies/FAOHorizonSubordinate') " type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonverical" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="faoprime" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="true" type="bool"/>
            <Option name="Description" value="" type="QString"/>
            <Option name="FilterExpression" value="&quot;collection&quot; IN('https://crea.gov.it/infosuoli/vocabularies/FAOPrime') &#xa;&#xa;" type="QString"/>
            <Option name="Key" value="id" type="QString"/>
            <Option name="Layer" value="codelist_2fcb5223_45ef_46bd_9dd1_ecb1b00167a8" type="QString"/>
            <Option name="LayerName" value="codelist" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=codelist" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="false" type="bool"/>
            <Option name="Value" value="label" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="isoriginalclassification" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" value="" type="QString"/>
            <Option name="TextDisplayMethod" value="0" type="int"/>
            <Option name="UncheckedState" value="" type="QString"/>
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
            <Option name="ReferencedLayerDataSource" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector_02/Vector.gpkg|layername=profileelement" type="QString"/>
            <Option name="ReferencedLayerId" value="profileelement_eaacb1ed_57eb_4069_bd23_eddf9d26c64a" type="QString"/>
            <Option name="ReferencedLayerName" value="profileelement" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="profileelement_faohorizonnotationtype" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="" field="faohorizondiscontinuity"/>
    <alias index="3" name="" field="faohorizonmaster"/>
    <alias index="4" name="" field="faohorizonsubordinate"/>
    <alias index="5" name="" field="faohorizonverical"/>
    <alias index="6" name="" field="faoprime"/>
    <alias index="7" name="" field="isoriginalclassification"/>
    <alias index="8" name="" field="idprofileelement"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="faohorizondiscontinuity"/>
    <policy policy="DefaultValue" field="faohorizonmaster"/>
    <policy policy="DefaultValue" field="faohorizonsubordinate"/>
    <policy policy="Duplicate" field="faohorizonverical"/>
    <policy policy="DefaultValue" field="faoprime"/>
    <policy policy="DefaultValue" field="isoriginalclassification"/>
    <policy policy="DefaultValue" field="idprofileelement"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="faohorizondiscontinuity" expression=""/>
    <default applyOnUpdate="0" field="faohorizonmaster" expression=""/>
    <default applyOnUpdate="0" field="faohorizonsubordinate" expression=""/>
    <default applyOnUpdate="0" field="faohorizonverical" expression=""/>
    <default applyOnUpdate="0" field="faoprime" expression=""/>
    <default applyOnUpdate="0" field="isoriginalclassification" expression=""/>
    <default applyOnUpdate="0" field="idprofileelement" expression=""/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" exp_strength="0" field="id" constraints="3" unique_strength="1"/>
    <constraint notnull_strength="0" exp_strength="0" field="guidkey" constraints="2" unique_strength="1"/>
    <constraint notnull_strength="0" exp_strength="0" field="faohorizondiscontinuity" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" exp_strength="0" field="faohorizonmaster" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" exp_strength="0" field="faohorizonsubordinate" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" exp_strength="0" field="faohorizonverical" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" exp_strength="0" field="faoprime" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" exp_strength="0" field="isoriginalclassification" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" exp_strength="0" field="idprofileelement" constraints="2" unique_strength="1"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
    </labelStyle>
    <attributeEditorField verticalStretch="0" index="0" name="id" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" index="2" name="faohorizondiscontinuity" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" index="3" name="faohorizonmaster" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" index="4" name="faohorizonsubordinate" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" index="5" name="faohorizonverical" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" index="6" name="faoprime" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" index="7" name="isoriginalclassification" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField verticalStretch="0" index="8" name="idprofileelement" showLabel="1" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont style="" bold="0" strikethrough="0" underline="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field name="faohorizondiscontinuity" editable="1"/>
    <field name="faohorizonmaster" editable="1"/>
    <field name="faohorizonsubordinate" editable="1"/>
    <field name="faohorizonverical" editable="1"/>
    <field name="faoprime" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="idprofileelement" editable="1"/>
    <field name="isoriginalclassification" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="faohorizondiscontinuity" labelOnTop="0"/>
    <field name="faohorizonmaster" labelOnTop="0"/>
    <field name="faohorizonsubordinate" labelOnTop="0"/>
    <field name="faohorizonverical" labelOnTop="0"/>
    <field name="faoprime" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="idprofileelement" labelOnTop="0"/>
    <field name="isoriginalclassification" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="faohorizondiscontinuity" reuseLastValue="0"/>
    <field name="faohorizonmaster" reuseLastValue="0"/>
    <field name="faohorizonsubordinate" reuseLastValue="0"/>
    <field name="faohorizonverical" reuseLastValue="0"/>
    <field name="faoprime" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="idprofileelement" reuseLastValue="0"/>
    <field name="isoriginalclassification" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "id", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
