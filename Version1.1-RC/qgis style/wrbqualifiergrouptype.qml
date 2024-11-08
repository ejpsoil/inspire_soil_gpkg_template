<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" readOnly="0" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <referencedLayers/>
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
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbversion">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('wrbversion')" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_c31ed647_1b11_42f4_8db6_c48e13994a56" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_06_New/Sicily_TESTFORM/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="qualifierplace">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('WRBQualifierPlaceValue')" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_c31ed647_1b11_42f4_8db6_c48e13994a56" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_06_New/Sicily_TESTFORM/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbqualifier">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="" name="Description"/>
            <Option type="QString" value="CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBQualifierValue') &#xa;  WHEN current_value('wrbversion')= 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBQualifierValue2014')  &#xa;  WHEN current_value('wrbversion')= 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBQualifierValue2022')  &#xa;  ELSE 0&#xa;END" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_c31ed647_1b11_42f4_8db6_c48e13994a56" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_06_New/Sicily_TESTFORM/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_1">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="" name="Description"/>
            <Option type="QString" value="CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBSpecifierValue') &#xa;  WHEN current_value('wrbversion')= 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBSpecifierValue2014')  &#xa;  WHEN current_value('wrbversion')= 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBSpecifierValue2022')  &#xa;  ELSE 0&#xa;END" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_c31ed647_1b11_42f4_8db6_c48e13994a56" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_06_New/Sicily_TESTFORM/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="wrbspecifier_2">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="" name="Description"/>
            <Option type="QString" value="CASE &#xa;  WHEN current_value('wrbversion')= 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue'  THEN &quot;collection&quot; IN('WRBSpecifierValue') &#xa;  WHEN current_value('wrbversion')= 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html' THEN &quot;collection&quot; IN('WRBSpecifierValue2014')  &#xa;  WHEN current_value('wrbversion')= 'https://obrl-soil.github.io/wrbsoil2022/'  THEN &quot;collection&quot; IN('WRBSpecifierValue2022')  &#xa;  ELSE 0&#xa;END" name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_c31ed647_1b11_42f4_8db6_c48e13994a56" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage_Sicily_Import/GPKG/Sicily_06_New/Sicily_TESTFORM/INSPIRE_SO.gpkg|layername=codelist" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="label" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="WRB Version" field="wrbversion"/>
    <alias index="3" name="Qualifier Place" field="qualifierplace"/>
    <alias index="4" name="WRB Qualifier" field="wrbqualifier"/>
    <alias index="5" name="WRB Specifier 1" field="wrbspecifier_1"/>
    <alias index="6" name="WRB Specifier 2" field="wrbspecifier_2"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
    <policy policy="DefaultValue" field="wrbversion"/>
    <policy policy="DefaultValue" field="qualifierplace"/>
    <policy policy="DefaultValue" field="wrbqualifier"/>
    <policy policy="DefaultValue" field="wrbspecifier_1"/>
    <policy policy="DefaultValue" field="wrbspecifier_2"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="wrbversion"/>
    <default applyOnUpdate="0" expression="" field="qualifierplace"/>
    <default applyOnUpdate="0" expression="" field="wrbqualifier"/>
    <default applyOnUpdate="0" expression="" field="wrbspecifier_1"/>
    <default applyOnUpdate="0" expression="" field="wrbspecifier_2"/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" exp_strength="0" field="id" unique_strength="1"/>
    <constraint constraints="2" notnull_strength="0" exp_strength="0" field="guidkey" unique_strength="1"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="wrbversion" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="qualifierplace" unique_strength="0"/>
    <constraint constraints="1" notnull_strength="1" exp_strength="0" field="wrbqualifier" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="wrbspecifier_1" unique_strength="0"/>
    <constraint constraints="0" notnull_strength="0" exp_strength="0" field="wrbspecifier_2" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="guidkey"/>
    <constraint desc="" exp="" field="wrbversion"/>
    <constraint desc="" exp="" field="qualifierplace"/>
    <constraint desc="" exp="" field="wrbqualifier"/>
    <constraint desc="" exp="" field="wrbspecifier_1"/>
    <constraint desc="" exp="" field="wrbspecifier_2"/>
  </constraintExpressions>
  <expressionfields/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGIS forms can have a Python function that is called when the form is
opened.

Use this function to add extra logic to your forms.

Enter the name of the function in the "Python Init function"
field.
An example follows:
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
      <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="0" horizontalStretch="0" name="id" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="2" horizontalStretch="0" name="wrbversion" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="3" horizontalStretch="0" name="qualifierplace" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="4" horizontalStretch="0" name="wrbqualifier" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" groupBox="1" collapsedExpressionEnabled="0" collapsed="0" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" name="Specifier" verticalStretch="0" columnCount="1" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="5" horizontalStretch="0" name="wrbspecifier_1" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="6" horizontalStretch="0" name="wrbspecifier_2" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont italic="0" style="" bold="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="id"/>
    <field editable="1" name="qualifierplace"/>
    <field editable="1" name="wrbqualifier"/>
    <field editable="1" name="wrbspecifier_1"/>
    <field editable="1" name="wrbspecifier_2"/>
    <field editable="1" name="wrbversion"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="qualifierplace"/>
    <field labelOnTop="0" name="wrbqualifier"/>
    <field labelOnTop="0" name="wrbspecifier_1"/>
    <field labelOnTop="0" name="wrbspecifier_2"/>
    <field labelOnTop="0" name="wrbversion"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="qualifierplace"/>
    <field reuseLastValue="0" name="wrbqualifier"/>
    <field reuseLastValue="0" name="wrbspecifier_1"/>
    <field reuseLastValue="0" name="wrbspecifier_2"/>
    <field reuseLastValue="0" name="wrbversion"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( if( "wrbversion" = 'https://inspire.ec.europa.eu/codelist/WRBReferenceSoilGroupValue','2006',if( "wrbversion" = 'http://stats-class.fao.uniroma2.it/WRB/v2014/rsg.html','2014','2022')))&#xd;
|| ' '||&#xd;
COALESCE(if( "qualifierplace" = 'http://inspire.ec.europa.eu/codelist/WRBQualifierPlaceValue/prefix','P','S'))&#xd;
|| ' '||&#xd;
COALESCE(if ("wrbspecifier_1",regexp_substr(regexp_substr("wrbspecifier_1", '[^/]+$'), '[^#]+$'),''))&#xd;
|| ' '||&#xd;
COALESCE(if ("wrbspecifier_2",regexp_substr(regexp_substr("wrbspecifier_2", '[^/]+$'), '[^#]+$'),''))&#xd;
|| ' '||&#xd;
COALESCE(if ("wrbqualifier",regexp_substr(regexp_substr("wrbqualifier", '[^/]+$'), '[^#]+$'),''))&#xd;
&#xd;
</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
