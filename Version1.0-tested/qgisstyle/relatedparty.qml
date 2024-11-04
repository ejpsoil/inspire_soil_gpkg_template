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
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="organizationname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="positionname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="address">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="contactinstructions">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="electronicmailaddress">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="hoursofservice">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="telephonefacsimile">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="telephonevoice">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="website">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="IsMultiline"/>
            <Option value="false" type="bool" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="role">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" type="bool" name="AllowMulti"/>
            <Option value="false" type="bool" name="AllowNull"/>
            <Option value="&quot;label&quot;" type="QString" name="Description"/>
            <Option value="&quot;collection&quot; IN('ResponsiblePartyRole') " type="QString" name="FilterExpression"/>
            <Option value="id" type="QString" name="Key"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" type="QString" name="Layer"/>
            <Option value="codelist" type="QString" name="LayerName"/>
            <Option value="ogr" type="QString" name="LayerProviderName"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" type="QString" name="LayerSource"/>
            <Option value="1" type="int" name="NofColumns"/>
            <Option value="false" type="bool" name="OrderByValue"/>
            <Option value="false" type="bool" name="UseCompleter"/>
            <Option value="label" type="QString" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="guidkey" name="" index="1"/>
    <alias field="individualname" name="Individual" index="2"/>
    <alias field="organizationname" name="Organization" index="3"/>
    <alias field="positionname" name="Position" index="4"/>
    <alias field="address" name="Address" index="5"/>
    <alias field="contactinstructions" name="Cintact Instruction" index="6"/>
    <alias field="electronicmailaddress" name="" index="7"/>
    <alias field="hoursofservice" name="Hour of service" index="8"/>
    <alias field="telephonefacsimile" name="Fax" index="9"/>
    <alias field="telephonevoice" name="Telephone" index="10"/>
    <alias field="website" name="Website" index="11"/>
    <alias field="role" name="Role" index="12"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="Duplicate" field="guidkey"/>
    <policy policy="DefaultValue" field="individualname"/>
    <policy policy="DefaultValue" field="organizationname"/>
    <policy policy="DefaultValue" field="positionname"/>
    <policy policy="DefaultValue" field="address"/>
    <policy policy="DefaultValue" field="contactinstructions"/>
    <policy policy="DefaultValue" field="electronicmailaddress"/>
    <policy policy="DefaultValue" field="hoursofservice"/>
    <policy policy="DefaultValue" field="telephonefacsimile"/>
    <policy policy="DefaultValue" field="telephonevoice"/>
    <policy policy="DefaultValue" field="website"/>
    <policy policy="DefaultValue" field="role"/>
  </splitPolicies>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="guidkey" applyOnUpdate="0"/>
    <default expression="" field="individualname" applyOnUpdate="0"/>
    <default expression="" field="organizationname" applyOnUpdate="0"/>
    <default expression="" field="positionname" applyOnUpdate="0"/>
    <default expression="" field="address" applyOnUpdate="0"/>
    <default expression="" field="contactinstructions" applyOnUpdate="0"/>
    <default expression="" field="electronicmailaddress" applyOnUpdate="0"/>
    <default expression="" field="hoursofservice" applyOnUpdate="0"/>
    <default expression="" field="telephonefacsimile" applyOnUpdate="0"/>
    <default expression="" field="telephonevoice" applyOnUpdate="0"/>
    <default expression="" field="website" applyOnUpdate="0"/>
    <default expression="" field="role" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="id" unique_strength="1" notnull_strength="1"/>
    <constraint constraints="2" exp_strength="0" field="guidkey" unique_strength="1" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="individualname" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="organizationname" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="positionname" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="address" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="contactinstructions" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="electronicmailaddress" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="hoursofservice" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="telephonefacsimile" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="telephonevoice" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="website" unique_strength="0" notnull_strength="0"/>
    <constraint constraints="0" exp_strength="0" field="role" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="guidkey" desc="" exp=""/>
    <constraint field="individualname" desc="" exp=""/>
    <constraint field="organizationname" desc="" exp=""/>
    <constraint field="positionname" desc="" exp=""/>
    <constraint field="address" desc="" exp=""/>
    <constraint field="contactinstructions" desc="" exp=""/>
    <constraint field="electronicmailaddress" desc="" exp=""/>
    <constraint field="hoursofservice" desc="" exp=""/>
    <constraint field="telephonefacsimile" desc="" exp=""/>
    <constraint field="telephonevoice" desc="" exp=""/>
    <constraint field="website" desc="" exp=""/>
    <constraint field="role" desc="" exp=""/>
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
    <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
      <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="id" index="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="guidkey" index="1">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Name" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="individualname" index="2">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="organizationname" index="3">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="positionname" index="4">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="role" index="12">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer showLabel="1" collapsedExpression="" horizontalStretch="0" collapsed="0" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" visibilityExpression="" name="Info" columnCount="1" groupBox="1" collapsedExpressionEnabled="0">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="address" index="5">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="contactinstructions" index="6">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="electronicmailaddress" index="7">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="hoursofservice" index="8">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="telephonefacsimile" index="9">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="telephonevoice" index="10">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" verticalStretch="0" name="website" index="11">
        <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
          <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorRelation showLabel="1" forceSuppressFormPopup="0" horizontalStretch="0" relation="relatedparty_process_3" verticalStretch="0" nmRelationId="" name="relatedparty_process_3" label="Process" relationWidgetTypeId="relation_editor">
      <labelStyle overrideLabelFont="0" labelColor="0,0,0,255" overrideLabelColor="0">
        <labelFont strikethrough="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" bold="0" style="" underline="0"/>
      </labelStyle>
      <editor_configuration type="Map">
        <Option value="false" type="bool" name="allow_add_child_feature_with_no_geometry"/>
        <Option value="AllButtons" type="QString" name="buttons"/>
        <Option value="true" type="bool" name="show_first_feature"/>
      </editor_configuration>
    </attributeEditorRelation>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="address"/>
    <field editable="1" name="contactinstructions"/>
    <field editable="1" name="electronicmailaddress"/>
    <field editable="1" name="guidkey"/>
    <field editable="1" name="hoursofservice"/>
    <field editable="1" name="id"/>
    <field editable="1" name="individualname"/>
    <field editable="1" name="organizationname"/>
    <field editable="1" name="positionname"/>
    <field editable="1" name="role"/>
    <field editable="1" name="telephonefacsimile"/>
    <field editable="1" name="telephonevoice"/>
    <field editable="1" name="website"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="address"/>
    <field labelOnTop="0" name="contactinstructions"/>
    <field labelOnTop="0" name="electronicmailaddress"/>
    <field labelOnTop="0" name="guidkey"/>
    <field labelOnTop="0" name="hoursofservice"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="individualname"/>
    <field labelOnTop="0" name="organizationname"/>
    <field labelOnTop="0" name="positionname"/>
    <field labelOnTop="0" name="role"/>
    <field labelOnTop="0" name="telephonefacsimile"/>
    <field labelOnTop="0" name="telephonevoice"/>
    <field labelOnTop="0" name="website"/>
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
        <Option value="false" type="bool" name="force-suppress-popup"/>
        <Option value="" type="QString" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>"individualname"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
