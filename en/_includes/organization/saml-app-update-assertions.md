{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
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

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for adding an attribute:

     ```bash
     yc organization-manager idp application saml attribute create --help
     ```

  1. To add a user attribute, run this command:

     ```bash
     yc organization-manager idp application saml attribute create \
       --application-id <app_ID> \
       --name <attribute_name> \
       --value <attribute_value>
     ```

     Where:

     * `--application-id`: SAML application ID.
     * `--name`: Attribute name unique to your application.
     * `--value`: Attribute value. The possible values are:

       {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

  1. To add a user group attribute, run this command:

     ```bash
     yc organization-manager idp application saml attribute create \
       --application-id <app_ID> \
       --name <group_attribute_name> \
       --value <group_attribute_value>
     ```

     Where:

     * `--name`: User group attribute name. The attribute name must be unique within your application.
     * `--value`: Group attribute value. The possible values are:

       {% include [saml-app-group-assertion](./saml-app-group-assertion.md) %}

  1. To update the attribute, run this command:

     ```bash
     yc organization-manager idp application saml attribute update \
       --id <attribute_ID> \
       --name <new_attribute_name> \
       --value <new_attribute_value>
     ```

  1. To delete the attribute, run this command:

     ```bash
     yc organization-manager idp application saml attribute delete <attribute_ID>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the following SAML application attributes in the configuration file:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<organization_ID>"
       name            = "<application_name>"

       attribute_mapping = {
         name_id  = {
           format = "EMAIL"
         }

         attributes = [{
           name  = "email"
           value = "SubjectClaims.email"
         }, {
           name  = "firstName"
           value = "SubjectClaims.given_name"
         }, {
           name  = "lastName"
           value = "SubjectClaims.family_name"
         }]
       }

       group_claims_settings = {
         group_attribute_name    = "<group_attribute_name>"
         group_distribution_type = "ALL_GROUPS"
       }
     }
     ```

     Where:

     * `organization_id`: [ID of the organization](../../organization/operations/organization-get-id.md) you want to create your SAML application in. This is a required parameter.
     * `name`: SAML application name. This is a required parameter.
     * `attributes`: List of attributes {{ org-name }} will be delivering to the service provider. Each attribute contains:
       * `name`: Attribute name unique to your application.
       * `value`: Attribute value. The possible values are:

         {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

     * `group_claims_settings`: User group attribute parameters:
       * `group_attribute_name`: User group attribute name. The attribute name must be unique within your application.
       * `group_distribution_type`: Group attribute value. The possible values are: 
         * `ASSIGNED_GROUPS`: In a SAML response, this field will include only those groups that are explicitly specified on the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab of your SAML app.
         * `ALL_GROUPS`: In a SAML response, this field will include all [groups](../../organization/concepts/groups.md) the user belongs to.

             The maximum number of groups this field can include is 1,000. If the user belongs to more groups than this, only the first thousand will go to the service provider. 

     For more information about `yandex_organizationmanager_idp_application_saml_application` properties, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the changes to the resources and their settings in [{{ org-full-name }}]({{ link-org-cloud-center }}).

- API {#api}

  Use the [Application.Update](../../organization/idp/application/saml/api-ref/Application/update.md) REST API method for the [Application](../../organization/idp/application/saml/api-ref/Application/index.md) resource or the [ApplicationService/Update](../../organization/idp/application/saml/api-ref/grpc/Application/update.md) gRPC API call.

{% endlist %}

Make sure the attributes you added are also added to the SAML app's integration settings and can be processed correctly on the service provider's side.