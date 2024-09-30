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
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="individualname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="organizationname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="positionname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="address">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="contactinstructions">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="electronicmailaddress">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="hoursofservice">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="telephonefacsimile">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="telephonevoice">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="website">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="role">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="&quot;label&quot;" name="Description"/>
            <Option type="QString" value="&quot;collection&quot; IN('ResponsiblePartyRole') " name="FilterExpression"/>
            <Option type="QString" value="id" name="Key"/>
            <Option type="QString" value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer"/>
            <Option type="QString" value="codelist" name="LayerName"/>
            <Option type="QString" value="ogr" name="LayerProviderName"/>
            <Option type="QString" value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource"/>
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
    <alias field="id" index="0" name=""/>
    <alias field="guidkey" index="1" name=""/>
    <alias field="individualname" index="2" name="Individual"/>
    <alias field="organizationname" index="3" name="Organization"/>
    <alias field="positionname" index="4" name="Position"/>
    <alias field="address" index="5" name="Address"/>
    <alias field="contactinstructions" index="6" name="Cintact Instruction"/>
    <alias field="electronicmailaddress" index="7" name=""/>
    <alias field="hoursofservice" index="8" name="Hour of service"/>
    <alias field="telephonefacsimile" index="9" name="Fax"/>
    <alias field="telephonevoice" index="10" name="Telephone"/>
    <alias field="website" index="11" name="Website"/>
    <alias field="role" index="12" name="Role"/>
  </aliases>
  <splitPolicies>
    <policy field="id" policy="Duplicate"/>
    <policy field="guidkey" policy="Duplicate"/>
    <policy field="individualname" policy="DefaultValue"/>
    <policy field="organizationname" policy="DefaultValue"/>
    <policy field="positionname" policy="DefaultValue"/>
    <policy field="address" policy="DefaultValue"/>
    <policy field="contactinstructions" policy="DefaultValue"/>
    <policy field="electronicmailaddress" policy="DefaultValue"/>
    <policy field="hoursofservice" policy="DefaultValue"/>
    <policy field="telephonefacsimile" policy="DefaultValue"/>
    <policy field="telephonevoice" policy="DefaultValue"/>
    <policy field="website" policy="DefaultValue"/>
    <policy field="role" policy="DefaultValue"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="guidkey" expression=""/>
    <default applyOnUpdate="0" field="individualname" expression=""/>
    <default applyOnUpdate="0" field="organizationname" expression=""/>
    <default applyOnUpdate="0" field="positionname" expression=""/>
    <default applyOnUpdate="0" field="address" expression=""/>
    <default applyOnUpdate="0" field="contactinstructions" expression=""/>
    <default applyOnUpdate="0" field="electronicmailaddress" expression=""/>
    <default applyOnUpdate="0" field="hoursofservice" expression=""/>
    <default applyOnUpdate="0" field="telephonefacsimile" expression=""/>
    <default applyOnUpdate="0" field="telephonevoice" expression=""/>
    <default applyOnUpdate="0" field="website" expression=""/>
    <default applyOnUpdate="0" field="role" expression=""/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" field="id" notnull_strength="1" exp_strength="0" constraints="3"/>
    <constraint unique_strength="1" field="guidkey" notnull_strength="0" exp_strength="0" constraints="2"/>
    <constraint unique_strength="0" field="individualname" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="organizationname" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="positionname" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="address" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="contactinstructions" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="electronicmailaddress" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="hoursofservice" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="telephonefacsimile" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="telephonevoice" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="website" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="role" notnull_strength="0" exp_strength="0" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="guidkey" exp="" desc=""/>
    <constraint field="individualname" exp="" desc=""/>
    <constraint field="organizationname" exp="" desc=""/>
    <constraint field="positionname" exp="" desc=""/>
    <constraint field="address" exp="" desc=""/>
    <constraint field="contactinstructions" exp="" desc=""/>
    <constraint field="electronicmailaddress" exp="" desc=""/>
    <constraint field="hoursofservice" exp="" desc=""/>
    <constraint field="telephonefacsimile" exp="" desc=""/>
    <constraint field="telephonevoice" exp="" desc=""/>
    <constraint field="website" exp="" desc=""/>
    <constraint field="role" exp="" desc=""/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
    </labelStyle>
    <attributeEditorField index="0" name="id" showLabel="1" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="1" name="guidkey" showLabel="1" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" name="Name" showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" groupBox="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
      <attributeEditorField index="2" name="individualname" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="3" name="organizationname" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="4" name="positionname" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField index="12" name="role" showLabel="1" verticalStretch="0" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer type="GroupBox" columnCount="1" collapsed="0" visibilityExpressionEnabled="0" name="Info" showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" groupBox="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
      <attributeEditorField index="5" name="address" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="6" name="contactinstructions" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="7" name="electronicmailaddress" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="8" name="hoursofservice" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="9" name="telephonefacsimile" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="10" name="telephonevoice" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField index="11" name="website" showLabel="1" verticalStretch="0" horizontalStretch="0">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer type="GroupBox" columnCount="2" collapsed="1" visibilityExpressionEnabled="0" name="Process" showLabel="1" collapsedExpressionEnabled="0" verticalStretch="0" groupBox="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
      <attributeEditorRelation forceSuppressFormPopup="0" name="relatedparty_process_4" showLabel="0" verticalStretch="0" relationWidgetTypeId="relation_editor" relation="relatedparty_process_4" nmRelationId="" horizontalStretch="0" label="Process">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
      <attributeEditorRelation forceSuppressFormPopup="0" name="relatedparty_process_3" showLabel="0" verticalStretch="0" relationWidgetTypeId="relation_editor" relation="relatedparty_process_3" nmRelationId="" horizontalStretch="0" label="">
        <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
          <labelFont style="" bold="0" underline="0" strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="address" editable="1"/>
    <field name="contactinstructions" editable="1"/>
    <field name="electronicmailaddress" editable="1"/>
    <field name="guidkey" editable="1"/>
    <field name="hoursofservice" editable="1"/>
    <field name="id" editable="1"/>
    <field name="individualname" editable="1"/>
    <field name="organizationname" editable="1"/>
    <field name="positionname" editable="1"/>
    <field name="role" editable="1"/>
    <field name="telephonefacsimile" editable="1"/>
    <field name="telephonevoice" editable="1"/>
    <field name="website" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="address" labelOnTop="0"/>
    <field name="contactinstructions" labelOnTop="0"/>
    <field name="electronicmailaddress" labelOnTop="0"/>
    <field name="guidkey" labelOnTop="0"/>
    <field name="hoursofservice" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="individualname" labelOnTop="0"/>
    <field name="organizationname" labelOnTop="0"/>
    <field name="positionname" labelOnTop="0"/>
    <field name="role" labelOnTop="0"/>
    <field name="telephonefacsimile" labelOnTop="0"/>
    <field name="telephonevoice" labelOnTop="0"/>
    <field name="website" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="address" reuseLastValue="0"/>
    <field name="contactinstructions" reuseLastValue="0"/>
    <field name="electronicmailaddress" reuseLastValue="0"/>
    <field name="guidkey" reuseLastValue="0"/>
    <field name="hoursofservice" reuseLastValue="0"/>
    <field name="id" reuseLastValue="0"/>
    <field name="individualname" reuseLastValue="0"/>
    <field name="organizationname" reuseLastValue="0"/>
    <field name="positionname" reuseLastValue="1"/>
    <field name="role" reuseLastValue="0"/>
    <field name="telephonefacsimile" reuseLastValue="0"/>
    <field name="telephonevoice" reuseLastValue="0"/>
    <field name="website" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="relatedparty_process_3">
      <config type="Map">
        <Option type="bool" value="false" name="force-suppress-popup"/>
        <Option type="QString" value="" name="nm-rel"/>
      </config>
    </widget>
    <widget name="relatedparty_process_4">
      <config type="Map">
        <Option type="bool" value="false" name="force-suppress-popup"/>
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>"individualname"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
