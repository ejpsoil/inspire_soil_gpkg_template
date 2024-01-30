<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.32.3-Lima" styleCategories="LayerConfiguration|Symbology|Fields|Forms|Relations" readOnly="0">
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
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="label"/>
    <alias index="2" name="" field="definition"/>
    <alias index="3" name="" field="collection"/>
    <alias index="4" name="" field="foi"/>
    <alias index="5" name="" field="phenomenon"/>
    <alias index="6" name="" field="foi_phenomenon"/>
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
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="label"/>
    <default applyOnUpdate="0" expression="" field="definition"/>
    <default applyOnUpdate="0" expression="" field="collection"/>
    <default applyOnUpdate="0" expression="" field="foi"/>
    <default applyOnUpdate="0" expression="" field="phenomenon"/>
    <default applyOnUpdate="0" expression="" field="foi_phenomenon"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="label"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="definition"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="collection"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="foi"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="phenomenon"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="foi_phenomenon"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="label"/>
    <constraint exp="" desc="" field="definition"/>
    <constraint exp="" desc="" field="collection"/>
    <constraint exp="" desc="" field="foi"/>
    <constraint exp="" desc="" field="phenomenon"/>
    <constraint exp="" desc="" field="foi_phenomenon"/>
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
  <previewExpression>"phenomenon"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
