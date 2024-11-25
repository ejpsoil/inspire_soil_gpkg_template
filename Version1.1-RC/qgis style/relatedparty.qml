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
    <alias index="0" field="id" name=""/>
    <alias index="1" field="guidkey" name=""/>
    <alias index="2" field="individualname" name="Individual"/>
    <alias index="3" field="organizationname" name="Organization"/>
    <alias index="4" field="positionname" name="Position"/>
    <alias index="5" field="address" name="Address"/>
    <alias index="6" field="contactinstructions" name="Cintact Instruction"/>
    <alias index="7" field="electronicmailaddress" name=""/>
    <alias index="8" field="hoursofservice" name="Hour of service"/>
    <alias index="9" field="telephonefacsimile" name="Fax"/>
    <alias index="10" field="telephonevoice" name="Telephone"/>
    <alias index="11" field="website" name="Website"/>
    <alias index="12" field="role" name="Role"/>
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
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="guidkey"/>
    <default applyOnUpdate="0" expression="" field="individualname"/>
    <default applyOnUpdate="0" expression="" field="organizationname"/>
    <default applyOnUpdate="0" expression="" field="positionname"/>
    <default applyOnUpdate="0" expression="" field="address"/>
    <default applyOnUpdate="0" expression="" field="contactinstructions"/>
    <default applyOnUpdate="0" expression="" field="electronicmailaddress"/>
    <default applyOnUpdate="0" expression="" field="hoursofservice"/>
    <default applyOnUpdate="0" expression="" field="telephonefacsimile"/>
    <default applyOnUpdate="0" expression="" field="telephonevoice"/>
    <default applyOnUpdate="0" expression="" field="website"/>
    <default applyOnUpdate="0" expression="" field="role"/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" notnull_strength="1" exp_strength="0" field="id"/>
    <constraint constraints="2" unique_strength="1" notnull_strength="0" exp_strength="0" field="guidkey"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="individualname"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="organizationname"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="positionname"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="address"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="contactinstructions"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="electronicmailaddress"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="hoursofservice"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="telephonefacsimile"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="telephonevoice"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="website"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="role"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="guidkey"/>
    <constraint desc="" exp="" field="individualname"/>
    <constraint desc="" exp="" field="organizationname"/>
    <constraint desc="" exp="" field="positionname"/>
    <constraint desc="" exp="" field="address"/>
    <constraint desc="" exp="" field="contactinstructions"/>
    <constraint desc="" exp="" field="electronicmailaddress"/>
    <constraint desc="" exp="" field="hoursofservice"/>
    <constraint desc="" exp="" field="telephonefacsimile"/>
    <constraint desc="" exp="" field="telephonevoice"/>
    <constraint desc="" exp="" field="website"/>
    <constraint desc="" exp="" field="role"/>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="0" verticalStretch="0" name="id">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Name">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="2" verticalStretch="0" name="individualname">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="3" verticalStretch="0" name="organizationname">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="4" verticalStretch="0" name="positionname">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" horizontalStretch="0" index="12" verticalStretch="0" name="role">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="1" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Info">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="5" verticalStretch="0" name="address">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="6" verticalStretch="0" name="contactinstructions">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="7" verticalStretch="0" name="electronicmailaddress">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="8" verticalStretch="0" name="hoursofservice">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="9" verticalStretch="0" name="telephonefacsimile">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="10" verticalStretch="0" name="telephonevoice">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" horizontalStretch="0" index="11" verticalStretch="0" name="website">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="1" visibilityExpression="" groupBox="1" showLabel="1" collapsedExpression="" horizontalStretch="0" columnCount="2" type="GroupBox" visibilityExpressionEnabled="0" verticalStretch="0" collapsedExpressionEnabled="0" name="Process">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
      </labelStyle>
      <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="relatedparty_process_4" verticalStretch="0" name="relatedparty_process_4" label="Process">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
        </labelStyle>
        <editor_configuration type="Map">
          <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
          <Option type="QString" value="AllButtons" name="buttons"/>
          <Option type="bool" value="true" name="show_first_feature"/>
        </editor_configuration>
      </attributeEditorRelation>
      <attributeEditorRelation nmRelationId="" showLabel="0" relationWidgetTypeId="relation_editor" horizontalStretch="0" forceSuppressFormPopup="0" relation="relatedparty_process_3" verticalStretch="0" name="relatedparty_process_3" label="">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont italic="0" strikethrough="0" underline="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" bold="0"/>
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
    <field reuseLastValue="0" name="address"/>
    <field reuseLastValue="0" name="contactinstructions"/>
    <field reuseLastValue="0" name="electronicmailaddress"/>
    <field reuseLastValue="0" name="guidkey"/>
    <field reuseLastValue="0" name="hoursofservice"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="individualname"/>
    <field reuseLastValue="0" name="organizationname"/>
    <field reuseLastValue="1" name="positionname"/>
    <field reuseLastValue="0" name="role"/>
    <field reuseLastValue="0" name="telephonefacsimile"/>
    <field reuseLastValue="0" name="telephonevoice"/>
    <field reuseLastValue="0" name="website"/>
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
