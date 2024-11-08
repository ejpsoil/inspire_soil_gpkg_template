<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" version="3.32.3-Lima" readOnly="0">
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
    <alias field="id" name="" index="0"/>
    <alias field="label" name="" index="1"/>
    <alias field="definition" name="" index="2"/>
    <alias field="collection" name="" index="3"/>
    <alias field="foi" name="" index="4"/>
    <alias field="phenomenon" name="" index="5"/>
    <alias field="foi_phenomenon" name="" index="6"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="Duplicate" field="label"/>
    <policy policy="Duplicate" field="definition"/>
    <policy policy="Duplicate" field="collection"/>
    <policy policy="Duplicate" field="foi"/>
    <policy policy="Duplicate" field="phenomenon"/>
    <policy policy="Duplicate" field="foi_phenomenon"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="label" applyOnUpdate="0"/>
    <default expression="" field="definition" applyOnUpdate="0"/>
    <default expression="" field="collection" applyOnUpdate="0"/>
    <default expression="" field="foi" applyOnUpdate="0"/>
    <default expression="" field="phenomenon" applyOnUpdate="0"/>
    <default expression="" field="foi_phenomenon" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="0" exp_strength="0" field="id" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="label" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="definition" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="collection" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="foi" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="phenomenon" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="foi_phenomenon" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="label" desc="" exp=""/>
    <constraint field="definition" desc="" exp=""/>
    <constraint field="collection" desc="" exp=""/>
    <constraint field="foi" desc="" exp=""/>
    <constraint field="phenomenon" desc="" exp=""/>
    <constraint field="foi_phenomenon" desc="" exp=""/>
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
    <field name="collection" reuseLastValue="0"/>
    <field name="definition" reuseLastValue="0"/>
    <field name="foi" reuseLastValue="0"/>
    <field name="foi_phenomenon" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="label" reuseLastValue="0"/>
    <field name="phenomenon" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>COALESCE( "label", '&lt;NULL>' )</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
