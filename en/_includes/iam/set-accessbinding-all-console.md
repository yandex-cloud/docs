{% include [set-access-to-all](./set-access-to-all.md) %}

For instance, allow any authenticated user to view information about the `my-cloud` cloud:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), [select](../../resource-manager/operations/cloud/switch-cloud.md) a cloud.
   1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the **{{ ui-key.yacloud.component.acl.update-dialog.label_title }}** window, click **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}**.
   1. Go to the `{{ ui-key.yacloud.common.resource-acl.label_groups }}` section.
   1. Select the `All authenticated users` group.
   1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}**.
   1. Select the `resource-manager.viewer` role.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the subject type, specify `system`:

   ```bash
   yc resource-manager cloud add-access-binding my-cloud \
     --role viewer \
     --subject system:allAuthenticatedUsers
   ```

- {{ TF }} {#tf}

   1. Assign the `viewer` role to the `allAuthenticatedUsers` system group:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "viewer"
        member   = "system:allAuthenticatedUsers"
      }
      ```

   1. In the command line, go to the directory where you created the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      After that access rights are granted for the cloud.

- API {#api}

   Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the `subject` property, specify the `system` type:

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM_token>" \
       -d '{
       "accessBindingDeltas": [{
           "action": "ADD",
           "accessBinding": {
               "roleId": "viewer",
               "subject": {
                   "id": "allAuthenticatedUsers",
                   "type": "system"
       }}}]}' \
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
   ```

{% endlist %}