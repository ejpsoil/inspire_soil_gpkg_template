<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers>
    <relation strength="Association" layerId="profileelement_eb6bed83_91c6_4b85_baa7_bbb9469e94e0" id="profileelement_faohorizonnotationtype" dataSource="./INSPIRE_SO_07.gpkg|layername=profileelement" layerName="profileelement" name="profileelement_faohorizonnotationtype" referencingLayer="faohorizonnotationtype_8a0968be_62d1_417e_a7ba_a0e3de8f8687" providerKey="ogr" referencedLayer="profileelement_eb6bed83_91c6_4b85_baa7_bbb9469e94e0">
      <fieldRef referencingField="idprofileelement" referencedField="guidkey"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizondiscontinuity" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonmaster_1" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOHorizonMasterValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_a4124c0e_f027_4721_825f_b8618baffa11" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonmaster_2" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOHorizonMasterValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_a4124c0e_f027_4721_825f_b8618baffa11" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonsubordinate_1" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOHorizonSubordinateValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_a4124c0e_f027_4721_825f_b8618baffa11" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonsubordinate_2" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOHorizonSubordinateValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_a4124c0e_f027_4721_825f_b8618baffa11" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonsubordinate_3" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="true" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOHorizonSubordinateValue') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_a4124c0e_f027_4721_825f_b8618baffa11" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faohorizonverical" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="faoprime" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('FAOPrimeValue') &#xa;&#xa;" name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_a4124c0e_f027_4721_825f_b8618baffa11" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_02/INSPIRE_SO_07.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="isoriginalclassification" configurationFlags="None">
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
    <field name="idprofileelement" configurationFlags="None">
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
    <alias field="id" name="" index="0"/>
    <alias field="faohorizondiscontinuity" name="FAO Horizon Discontinuity" index="1"/>
    <alias field="faohorizonmaster_1" name="FAO Horizon Master" index="2"/>
    <alias field="faohorizonmaster_2" name="" index="3"/>
    <alias field="faohorizonsubordinate_1" name="FAO Horizon Subordinate" index="4"/>
    <alias field="faohorizonsubordinate_2" name="Fao Hor Sub 2" index="5"/>
    <alias field="faohorizonsubordinate_3" name="Fao Hor Sub 3" index="6"/>
    <alias field="faohorizonverical" name="FAO Horizon Vertical" index="7"/>
    <alias field="faoprime" name="FAO Prime" index="8"/>
    <alias field="isoriginalclassification" name="It is an Original classification" index="9"/>
    <alias field="idprofileelement" name="Profile Element" index="10"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="DefaultValue"/>
    <policy field="faohorizondiscontinuity" policy="DefaultValue"/>
    <policy field="faohorizonmaster_1" policy="DefaultValue"/>
    <policy field="faohorizonmaster_2" policy="DefaultValue"/>
    <policy field="faohorizonsubordinate_1" policy="DefaultValue"/>
    <policy field="faohorizonsubordinate_2" policy="DefaultValue"/>
    <policy field="faohorizonsubordinate_3" policy="DefaultValue"/>
    <policy field="faohorizonverical" policy="DefaultValue"/>
    <policy field="faoprime" policy="DefaultValue"/>
    <policy field="isoriginalclassification" policy="DefaultValue"/>
    <policy field="idprofileelement" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="faohorizondiscontinuity" applyOnUpdate="0" expression=""/>
    <default field="faohorizonmaster_1" applyOnUpdate="0" expression=""/>
    <default field="faohorizonmaster_2" applyOnUpdate="0" expression=""/>
    <default field="faohorizonsubordinate_1" applyOnUpdate="0" expression=""/>
    <default field="faohorizonsubordinate_2" applyOnUpdate="0" expression=""/>
    <default field="faohorizonsubordinate_3" applyOnUpdate="0" expression=""/>
    <default field="faohorizonverical" applyOnUpdate="0" expression=""/>
    <default field="faoprime" applyOnUpdate="0" expression=""/>
    <default field="isoriginalclassification" applyOnUpdate="0" expression=""/>
    <default field="idprofileelement" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="3" notnull_strength="1" unique_strength="1" exp_strength="0"/>
    <constraint field="faohorizondiscontinuity" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="faohorizonmaster_1" constraints="1" notnull_strength="1" unique_strength="0" exp_strength="0"/>
    <constraint field="faohorizonmaster_2" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="faohorizonsubordinate_1" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="faohorizonsubordinate_2" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="faohorizonsubordinate_3" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="faohorizonverical" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="faoprime" constraints="1" notnull_strength="1" unique_strength="0" exp_strength="0"/>
    <constraint field="isoriginalclassification" constraints="1" notnull_strength="1" unique_strength="0" exp_strength="0"/>
    <constraint field="idprofileelement" constraints="2" notnull_strength="0" unique_strength="1" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="faohorizondiscontinuity" desc="" exp=""/>
    <constraint field="faohorizonmaster_1" desc="" exp=""/>
    <constraint field="faohorizonmaster_2" desc="" exp=""/>
    <constraint field="faohorizonsubordinate_1" desc="" exp=""/>
    <constraint field="faohorizonsubordinate_2" desc="" exp=""/>
    <constraint field="faohorizonsubordinate_3" desc="" exp=""/>
    <constraint field="faohorizonverical" desc="" exp=""/>
    <constraint field="faoprime" desc="" exp=""/>
    <constraint field="isoriginalclassification" desc="" exp=""/>
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
    <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
      <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="id" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="faohorizondiscontinuity" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer horizontalStretch="0" columnCount="1" verticalStretch="0" visibilityExpressionEnabled="0" showLabel="0" name="Master" collapsed="0" collapsedExpression="" type="Row" groupBox="0" collapsedExpressionEnabled="0" visibilityExpression="">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField horizontalStretch="1" verticalStretch="0" showLabel="1" name="faohorizonmaster_1" index="2">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="1" verticalStretch="0" showLabel="0" name="faohorizonmaster_2" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer horizontalStretch="0" columnCount="1" verticalStretch="0" visibilityExpressionEnabled="0" showLabel="0" name="Subordinate" collapsed="0" collapsedExpression="" type="Row" groupBox="0" collapsedExpressionEnabled="0" visibilityExpression="">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField horizontalStretch="1" verticalStretch="0" showLabel="1" name="faohorizonsubordinate_1" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="1" verticalStretch="0" showLabel="0" name="faohorizonsubordinate_2" index="5">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField horizontalStretch="1" verticalStretch="0" showLabel="0" name="faohorizonsubordinate_3" index="6">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="faoprime" index="8">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="isoriginalclassification" index="9">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" verticalStretch="0" showLabel="1" name="idprofileelement" index="10">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont style="" italic="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="faohorizondiscontinuity"/>
    <field editable="1" name="faohorizonmaster"/>
    <field editable="1" name="faohorizonmaster_1"/>
    <field editable="1" name="faohorizonmaster_2"/>
    <field editable="1" name="faohorizonsubordinate"/>
    <field editable="1" name="faohorizonsubordinate_1"/>
    <field editable="1" name="faohorizonsubordinate_2"/>
    <field editable="1" name="faohorizonsubordinate_3"/>
    <field editable="1" name="faohorizonverical"/>
    <field editable="1" name="faoprime"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="idprofileelement"/>
    <field editable="1" name="isoriginalclassification"/>
  </editable>
  <labelOnTop>
    <field name="faohorizondiscontinuity" labelOnTop="0"/>
    <field name="faohorizonmaster" labelOnTop="0"/>
    <field name="faohorizonmaster_1" labelOnTop="0"/>
    <field name="faohorizonmaster_2" labelOnTop="0"/>
    <field name="faohorizonsubordinate" labelOnTop="0"/>
    <field name="faohorizonsubordinate_1" labelOnTop="0"/>
    <field name="faohorizonsubordinate_2" labelOnTop="0"/>
    <field name="faohorizonsubordinate_3" labelOnTop="0"/>
    <field name="faohorizonverical" labelOnTop="0"/>
    <field name="faoprime" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="idprofileelement" labelOnTop="0"/>
    <field name="isoriginalclassification" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="faohorizondiscontinuity"/>
    <field reuseLastValue="0" name="faohorizonmaster"/>
    <field reuseLastValue="0" name="faohorizonmaster_1"/>
    <field reuseLastValue="0" name="faohorizonmaster_2"/>
    <field reuseLastValue="0" name="faohorizonsubordinate"/>
    <field reuseLastValue="0" name="faohorizonsubordinate_1"/>
    <field reuseLastValue="0" name="faohorizonsubordinate_2"/>
    <field reuseLastValue="0" name="faohorizonsubordinate_3"/>
    <field reuseLastValue="0" name="faohorizonverical"/>
    <field reuseLastValue="0" name="faoprime"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="idprofileelement"/>
    <field reuseLastValue="0" name="isoriginalclassification"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>if("faohorizonverical" is null,'',  "faohorizonverical" )&#xd;
||&#xd;
COALESCE(regexp_substr("faohorizonmaster_1" , '[^/]*$'),'') &#xd;
||  &#xd;
COALESCE(regexp_substr("faohorizonmaster_2" , '[^/]*$'),'') &#xd;
|| &#xd;
COALESCE(regexp_substr("faohorizonsubordinate_1" , '[^/]*$'),'')&#xd;
||&#xd;
COALESCE(regexp_substr("faohorizonsubordinate_2" , '[^/]*$'),'')&#xd;
||&#xd;
COALESCE(regexp_substr("faohorizonsubordinate_3" , '[^/]*$'),'')&#xd;
||&#xd;
if(  "faohorizondiscontinuity"  is null, '', ' Discontinuty : '||"faohorizondiscontinuity" )&#xd;
||&#xd;
if("faoprime" = 'http://inspire.ec.europa.eu/codelist/FAOPrimeValue/0' ,'', ' Prime : '||COALESCE(regexp_substr("faoprime" , '[^/]*$'),'') )&#xd;
&#xd;
&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
