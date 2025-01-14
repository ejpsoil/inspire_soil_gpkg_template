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
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
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
    <alias name="" field="id" index="0"/>
    <alias name="" field="guidkey" index="1"/>
    <alias name="Individual" field="individualname" index="2"/>
    <alias name="Organization" field="organizationname" index="3"/>
    <alias name="Position" field="positionname" index="4"/>
    <alias name="Address" field="address" index="5"/>
    <alias name="Contact Instruction" field="contactinstructions" index="6"/>
    <alias name="E-mail address" field="electronicmailaddress" index="7"/>
    <alias name="Hour of service" field="hoursofservice" index="8"/>
    <alias name="Fax" field="telephonefacsimile" index="9"/>
    <alias name="Telephone" field="telephonevoice" index="10"/>
    <alias name="Website" field="website" index="11"/>
    <alias name="Role" field="role" index="12"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="DefaultValue" field="guidkey"/>
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
    <constraint constraints="3" notnull_strength="1" unique_strength="1" field="id" exp_strength="0"/>
    <constraint constraints="2" notnull_strength="0" unique_strength="1" field="guidkey" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="individualname" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="organizationname" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="positionname" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="address" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="contactinstructions" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="electronicmailaddress" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="hoursofservice" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="telephonefacsimile" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="telephonevoice" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="website" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="role" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="guidkey" exp=""/>
    <constraint desc="" field="individualname" exp=""/>
    <constraint desc="" field="organizationname" exp=""/>
    <constraint desc="" field="positionname" exp=""/>
    <constraint desc="" field="address" exp=""/>
    <constraint desc="" field="contactinstructions" exp=""/>
    <constraint desc="" field="electronicmailaddress" exp=""/>
    <constraint desc="" field="hoursofservice" exp=""/>
    <constraint desc="" field="telephonefacsimile" exp=""/>
    <constraint desc="" field="telephonevoice" exp=""/>
    <constraint desc="" field="website" exp=""/>
    <constraint desc="" field="role" exp=""/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
    </labelStyle>
    <attributeEditorField name="id" showLabel="1" horizontalStretch="0" index="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" collapsedExpressionEnabled="0" columnCount="1" type="GroupBox" name="Name" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" groupBox="1" visibilityExpressionEnabled="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
      <attributeEditorField name="individualname" showLabel="1" horizontalStretch="0" index="2" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="organizationname" showLabel="1" horizontalStretch="0" index="3" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="positionname" showLabel="1" horizontalStretch="0" index="4" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField name="role" showLabel="1" horizontalStretch="0" index="12" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" collapsedExpressionEnabled="0" columnCount="1" type="GroupBox" name="Info" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" groupBox="1" visibilityExpressionEnabled="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
      <attributeEditorField name="address" showLabel="1" horizontalStretch="0" index="5" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="contactinstructions" showLabel="1" horizontalStretch="0" index="6" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="electronicmailaddress" showLabel="1" horizontalStretch="0" index="7" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="hoursofservice" showLabel="1" horizontalStretch="0" index="8" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="telephonefacsimile" showLabel="1" horizontalStretch="0" index="9" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="telephonevoice" showLabel="1" horizontalStretch="0" index="10" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField name="website" showLabel="1" horizontalStretch="0" index="11" verticalStretch="0">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="1" collapsedExpressionEnabled="0" columnCount="2" type="GroupBox" name="Process" showLabel="1" collapsedExpression="" visibilityExpression="" horizontalStretch="0" groupBox="1" visibilityExpressionEnabled="0" verticalStretch="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
      </labelStyle>
      <attributeEditorRelation label="Process" name="relatedparty_process_4" showLabel="0" nmRelationId="" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" relation="relatedparty_process_4">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
      <attributeEditorRelation label="" name="relatedparty_process_3" showLabel="0" nmRelationId="" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" verticalStretch="0" relation="relatedparty_process_3">
        <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
          <labelFont italic="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" style="" bold="0" underline="0"/>
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
