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
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="organizationname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="positionname">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="address">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="contactinstructions">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="electronicmailaddress">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="hoursofservice">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="telephonefacsimile">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="telephonevoice">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="website">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="role">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="&quot;label&quot;" name="Description" type="QString"/>
            <Option value="&quot;collection&quot; IN('ResponsiblePartyRole') " name="FilterExpression" type="QString"/>
            <Option value="id" name="Key" type="QString"/>
            <Option value="codelist_dca3491b_79c9_4c76_afe9_83b8d8e331a2" name="Layer" type="QString"/>
            <Option value="codelist" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/andrea.lachi/Documents/Geopackage Soil/GPKG_Soil_Selection 04/INSPIRE_Selection_4.gpkg|layername=codelist" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="label" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="id"/>
    <alias index="1" name="" field="guidkey"/>
    <alias index="2" name="Individual" field="individualname"/>
    <alias index="3" name="Organization" field="organizationname"/>
    <alias index="4" name="Position" field="positionname"/>
    <alias index="5" name="Address" field="address"/>
    <alias index="6" name="Cintact Instruction" field="contactinstructions"/>
    <alias index="7" name="" field="electronicmailaddress"/>
    <alias index="8" name="Hour of service" field="hoursofservice"/>
    <alias index="9" name="Fax" field="telephonefacsimile"/>
    <alias index="10" name="Telephone" field="telephonevoice"/>
    <alias index="11" name="Website" field="website"/>
    <alias index="12" name="Role" field="role"/>
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
    <constraint exp_strength="0" notnull_strength="1" unique_strength="1" constraints="3" field="id"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="1" constraints="2" field="guidkey"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="individualname"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="organizationname"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="positionname"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="address"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="contactinstructions"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="electronicmailaddress"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="hoursofservice"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="telephonefacsimile"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="telephonevoice"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="website"/>
    <constraint exp_strength="0" notnull_strength="0" unique_strength="0" constraints="0" field="role"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="guidkey"/>
    <constraint exp="" desc="" field="individualname"/>
    <constraint exp="" desc="" field="organizationname"/>
    <constraint exp="" desc="" field="positionname"/>
    <constraint exp="" desc="" field="address"/>
    <constraint exp="" desc="" field="contactinstructions"/>
    <constraint exp="" desc="" field="electronicmailaddress"/>
    <constraint exp="" desc="" field="hoursofservice"/>
    <constraint exp="" desc="" field="telephonefacsimile"/>
    <constraint exp="" desc="" field="telephonevoice"/>
    <constraint exp="" desc="" field="website"/>
    <constraint exp="" desc="" field="role"/>
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
      <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" index="0" name="id" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" index="1" name="guidkey" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Name" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="2" name="individualname" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="3" name="organizationname" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="4" name="positionname" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField showLabel="1" index="12" name="role" horizontalStretch="0" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer columnCount="1" showLabel="1" collapsedExpressionEnabled="0" collapsedExpression="" name="Info" visibilityExpressionEnabled="0" horizontalStretch="0" verticalStretch="0" groupBox="1" type="GroupBox" collapsed="0" visibilityExpression="">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" index="5" name="address" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="6" name="contactinstructions" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="7" name="electronicmailaddress" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="8" name="hoursofservice" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="9" name="telephonefacsimile" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="10" name="telephonevoice" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" index="11" name="website" horizontalStretch="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorRelation showLabel="1" relation="relatedparty_process_3" label="Process" name="relatedparty_process_3" forceSuppressFormPopup="0" nmRelationId="" horizontalStretch="0" verticalStretch="0" relationWidgetTypeId="relation_editor">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" strikethrough="0" italic="0" underline="0"/>
      </labelStyle>
      <editor_configuration type="Map">
        <Option value="false" name="allow_add_child_feature_with_no_geometry" type="bool"/>
        <Option value="AllButtons" name="buttons" type="QString"/>
        <Option value="true" name="show_first_feature" type="bool"/>
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
        <Option value="false" name="force-suppress-popup" type="bool"/>
        <Option value="" name="nm-rel" type="QString"/>
      </config>
    </widget>
  </widgets>
  <previewExpression>"individualname"</previewExpression>
  <layerGeometryType>4</layerGeometryType>
</qgis>
