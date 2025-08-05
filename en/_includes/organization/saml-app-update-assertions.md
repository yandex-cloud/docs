{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
  1. To add a user group attribute, in the top-right corner of the page, click ![circles-3-plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** and do the following in the window that opens:

      1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, set a name for the user group attribute. The attribute name must be unique within your application.
      1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** field, select one of these values:

          {% include [saml-app-group-assertion](./saml-app-group-assertion.md) %}

      1. Click **{{ ui-key.yacloud.common.add }}**.
  1. To add more user group attributes, in the top-right corner of the page, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** and do the following in the window that opens:

      1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, set an attribute name unique within your app.
      1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** field, select one of these values:

          {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

      1. Click **{{ ui-key.yacloud.common.add }}**.
  1. To modify an existing attribute, click its row and do the following in the window that opens:
  
      1. Edit the attribute name and/or value.

          {% include [saml-app-nameid-assertion](./saml-app-nameid-assertion.md) %}
      
      1. Click **{{ ui-key.yacloud.common.update }}**.
  1. To delete an existing user or group attribute, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in its row and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, then confirm the deletion.

      {% note info %}

      You can delete any attributes except the required `NameID` attribute.

      {% endnote %}

{% endlist %}

Make sure the attributes you added are also added to the SAML app's integration settings and can be processed correctly on the service provider's side.