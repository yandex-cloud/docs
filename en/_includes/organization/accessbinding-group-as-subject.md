{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

   1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).
   1. At the top right, click **{{ ui-key.yacloud_org.entity.user.action.acl }}**.
   1. Go to the **{{ ui-key.yacloud_org.pages.groups }}** tab and select the [group](../../organization/concepts/groups.md) you need or search by group name.
   1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** and select the [role](../../iam/concepts/access-control/roles.md) in the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). You can assign multiple roles.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   1. Select a [role](../../iam/concepts/access-control/roles.md) from the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).
   1. Assign the role using the command:

      ```bash
      yc <service_name> <resource> add-access-binding <resource_name_or_ID> \
        --role <role_ID> \
        --subject group:<group_ID>
      ```

      Where:

      * `<service_name>`: Name of the service whose resource requires a role for access, e.g., `resource-manager`.
      * `<resource>`: Resource category, e.g., `cloud`.
      * `<resource_name_or_ID>`: Name or ID of the resource. You can specify the resource name or ID.
      * `--role`: Role ID, e.g., `{{ roles-cloud-owner }}`.
      * `--subject group`: ID of the [group](../../organization/concepts/groups.md) to which the role is assigned.

      For example, here is how you can assign the `resource-manager.viewer` role for the `mycloud` [cloud](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
        --role resource-manager.viewer \
        --subject group:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Add the resource parameters to the configuration file and specify the required [role](../../iam/concepts/access-control/roles.md) and [group](../../organization/concepts/groups.md):

      ```hcl
      resource "yandex_resourcemanager_cloud_iam_member" "admin" {
        cloud_id    = "<cloud_ID>"
        role        = "<role_ID>"
        member      = "group:<group_ID>"
      }
      ```

      Where:

      * `cloud_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md). You can also assign a role within an individual [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). To do this, specify `folder_id` instead of `cloud_id` and the required folder ID in the resource parameters.
      * `role`: Role being assigned. This is a required parameter.
      * `member`: Group the role is assigned to. It should be specified in `group:<group_ ID>` format. This is a required parameter.

      For more information about the `yandex_resourcemanager_cloud_iam_member` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_member).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      terraform plan
      ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this CLI command:

      ```bash
      yc resource-manager folder list-access-bindings <folder_name_or_ID>
      ```

- API {#api}

   Use the `updateAccessBindings` REST API method for the respective resource.

   1. Select a [role](../../iam/concepts/access-control/roles.md) from the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).
   1. Create the request body, for example, in the `body.json` file. Set the `action` property to `ADD` and specify the `group` type and group ID in the `subject` property:

      **body.json:**

      ```json
      {
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "<group_ID>",
                      "type": "group"
                      }
                  }
              }
          ]
      }
      ```

   1. {% include [grant-role-folder-via-curl-step](../iam/grant-role-folder-via-curl-step.md) %}

   To learn how to assign a role for the respective resource, see:
   * [{#T}](../../iam/operations/sa/set-access-bindings.md)
   * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
   * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)

{% endlist %}