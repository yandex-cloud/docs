{% include [set-access-to-all](set-access-to-all.md) %}

For example, allow any authenticated user to view folder information:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. Click the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the **{{ ui-key.yacloud_components.acl.label.title }}** window, click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_org.form.acl.edit.action.subject.select }}**.
   1. Go to the **{{ ui-key.yacloud_org.common.resource-acl.label_groups }}** section.
   1. Select the `All authenticated users` group.
   1. Click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}**.
   1. Select the `resource-manager.viewer` role.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   Assign the `viewer` for the `my-folder` folder. Set the subject type to `system` and its ID to `allAuthenticatedUsers`:

   ```bash
   yc resource-manager folder add-access-binding my-folder \
     --role viewer \
     --subject system:allAuthenticatedUsers
   ```

- API

   1. Create a request body, for example, in a `body.json` file. In `roleId`, assign the `viewer` role. In the `subject` property, specify the `system` type and the `allAuthenticatedUsers` ID:

      **body.json:**
      ```json
      {
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "allAuthenticatedUsers",
                  "type": "system"
                  }
              }
          }]
      }
      ```

   1. {% include [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md) %}

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note alert %}

   Don't create the resource together with the `yandex_resourcemanager_folder_iam_policy` resource. They will conflict with each other.

   {% endnote %}

   To assign a role to a folder created using {{ TF }}:

   1. Describe the parameters of the folder role in a configuration file:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to grant permissions for. This is a required parameter.
      * `role`: Role being assigned. This is a required parameter.

         {% note info %}

         For each role, you can only use one `yandex_resourcemanager_folder_iam_member` resource.

         {% endnote %}

      * `member`: User to assign the role to. To add all users, create an entry in the format `system:<allUsers|allAuthenticatedUsers>`, where `<allUsers|allAuthenticatedUsers>` is one of [system groups](../../iam/concepts/access-control/system-group.md). This is a required parameter.

      Example of the configuration file structure:

      ```hcl
      ...
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "viewer" {
        folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"
        role      = "viewer"
        member    = "system:allUsers"
      }
      ...
      ```

      For more information about the `yandex_resourcemanager_folder_iam_member` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

   1. Check the configuration using this command:
      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder name>|<folder ID>
      ```

{% endlist %}
