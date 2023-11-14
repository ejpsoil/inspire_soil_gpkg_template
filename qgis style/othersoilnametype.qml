<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Fields|Forms" readOnly="0" version="3.32.3-Lima">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
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
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="soilname">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"/>
            <Option name="AllowNull" type="bool" value="false"/>
            <Option name="Description" type="QString" value="&quot;label&quot;"/>
            <Option name="FilterExpression" type="QString" value="&quot;collection&quot; IN('http://inspire.ec.europa.eu/codelist/OtherSoilNameTypeValue') "/>
            <Option name="Key" type="QString" value="id"/>
            <Option name="Layer" type="QString" value="codelist_6dff4a6f_20e9_4a3d_912e_3af2836047d1"/>
            <Option name="LayerName" type="QString" value="codelist"/>
            <Option name="LayerProviderName" type="QString" value="ogr"/>
            <Option name="LayerSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=codelist"/>
            <Option name="NofColumns" type="int" value="1"/>
            <Option name="OrderByValue" type="bool" value="false"/>
            <Option name="UseCompleter" type="bool" value="false"/>
            <Option name="Value" type="QString" value="label"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="isoriginalclassification">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" type="QString" value=""/>
            <Option name="TextDisplayMethod" type="int" value="0"/>
            <Option name="UncheckedState" type="QString" value=""/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="othersoilname">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"/>
            <Option name="AllowNULL" type="bool" value="false"/>
            <Option name="FetchLimitActive" type="bool" value="true"/>
            <Option name="FetchLimitNumber" type="int" value="100"/>
            <Option name="MapIdentification" type="bool" value="false"/>
            <Option name="ReadOnly" type="bool" value="false"/>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/Vector/Vector.gpkg|layername=soilprofile"/>
            <Option name="ReferencedLayerId" type="QString" value="soilprofile_22025b68_6999_464c_bf4d_549fdc6f07f9"/>
            <Option name="ReferencedLayerName" type="QString" value="soilprofile"/>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"/>
            <Option name="Relation" type="QString" value="soilprofile_othersoilnametype"/>
            <Option name="ShowForm" type="bool" value="false"/>
            <Option name="ShowOpenFormButton" type="bool" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="soilname" index="2" name="Soil Name"/>
    <alias field="isoriginalclassification" index="3" name="It is an Original Classification"/>
    <alias field="othersoilname" index="4" name="Soil Profile"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="DefaultValue"/>
    <policy field="soilname" policy="DefaultValue"/>
    <policy field="isoriginalclassification" policy="DefaultValue"/>
    <policy field="othersoilname" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="guidkey" expression="" applyOnUpdate="0"/>
    <default field="soilname" expression="" applyOnUpdate="0"/>
    <default field="isoriginalclassification" expression="" applyOnUpdate="0"/>
    <default field="othersoilname" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="3" unique_strength="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="guidkey" constraints="2" unique_strength="1" exp_strength="0" notnull_strength="0"/>
    <constraint field="soilname" constraints="1" unique_strength="0" exp_strength="0" notnull_strength="1"/>
    <constraint field="isoriginalclassification" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="othersoilname" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="soilname" exp="" desc=""/>
    <constraint field="isoriginalclassification" exp="" desc=""/>
    <constraint field="othersoilname" exp="" desc=""/>
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
      <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="0" name="id" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="2" name="soilname" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="3" name="isoriginalclassification" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="4" name="othersoilname" showLabel="1" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont bold="0" underline="0" strikethrough="0" italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" style=""/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field name="guidkey" editable="1"/>
    <field name="id" editable="1"/>
    <field name="isoriginalclassification" editable="1"/>
    <field name="othersoilname" editable="1"/>
    <field name="soilname" editable="1"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="isoriginalclassification"/>
    <field labelOnTop="0" name="othersoilname"/>
    <field labelOnTop="0" name="soilname"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="isoriginalclassification" reuseLastValue="0"/>
    <field name="othersoilname" reuseLastValue="0"/>
    <field name="soilname" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>'id' || ' ' ||COALESCE( "id", '&lt;NULL>' ) || ' ' ||&#xd;
COALESCE(attribute(get_feature&#xd;
						(&#xd;
							'codelist',&#xd;
							'id',&#xd;
							"soilname"&#xd;
						),&#xd;
					'label'&#xd;
					),&#xd;
		'&lt;NULL>')&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
