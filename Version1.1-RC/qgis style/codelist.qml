<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0" version="3.32.3-Lima">
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
    <field configurationFlags="None" name="label">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="definition">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="collection">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="foi">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="phenomenon">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="foi_phenomenon">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name=""/>
    <alias field="label" index="1" name=""/>
    <alias field="definition" index="2" name=""/>
    <alias field="collection" index="3" name=""/>
    <alias field="foi" index="4" name=""/>
    <alias field="phenomenon" index="5" name=""/>
    <alias field="foi_phenomenon" index="6" name=""/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="label" policy="Duplicate"/>
    <policy field="definition" policy="Duplicate"/>
    <policy field="collection" policy="Duplicate"/>
    <policy field="foi" policy="Duplicate"/>
    <policy field="phenomenon" policy="Duplicate"/>
    <policy field="foi_phenomenon" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="label" applyOnUpdate="0" expression=""/>
    <default field="definition" applyOnUpdate="0" expression=""/>
    <default field="collection" applyOnUpdate="0" expression=""/>
    <default field="foi" applyOnUpdate="0" expression=""/>
    <default field="phenomenon" applyOnUpdate="0" expression=""/>
    <default field="foi_phenomenon" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="label" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="definition" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="collection" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="foi" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="phenomenon" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="foi_phenomenon" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="label" exp="" desc=""/>
    <constraint field="definition" exp="" desc=""/>
    <constraint field="collection" exp="" desc=""/>
    <constraint field="foi" exp="" desc=""/>
    <constraint field="phenomenon" exp="" desc=""/>
    <constraint field="foi_phenomenon" exp="" desc=""/>
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
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field editable="1" name="collection"/>
    <field editable="1" name="definition"/>
    <field editable="1" name="foi"/>
    <field editable="1" name="foi_phenomenon"/>
    <field editable="1" name="id"/>
    <field editable="1" name="label"/>
    <field editable="1" name="phenomenon"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="collection"/>
    <field labelOnTop="0" name="definition"/>
    <field labelOnTop="0" name="foi"/>
    <field labelOnTop="0" name="foi_phenomenon"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="label"/>
    <field labelOnTop="0" name="phenomenon"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="collection"/>
    <field reuseLastValue="0" name="definition"/>
    <field reuseLastValue="0" name="foi"/>
    <field reuseLastValue="0" name="foi_phenomenon"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="label"/>
    <field reuseLastValue="0" name="phenomenon"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression> regexp_substr("id" , '[^/]*$')</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
