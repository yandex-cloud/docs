{% include [set-access-to-all](./set-access-to-all.md) %}

For instance, allow any authenticated user to view information about the cloud `my-cloud`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), [select](../../resource-manager/operations/cloud/switch-cloud.md) a cloud.
   1. Click the **Access bindings** tab.
   1. Click **Assign bindings**.
   1. In the **Configure access bindings** window, click **Select user**.
   1. Select the **Groups** section.
   1. Select the **All authenticated users** group.
   1. Click **Add role**.
   1. Select the `resource-manager.viewer` role.
   1. Click **Save**.

- CLI

   Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the subject type, specify `system`:

   ```bash
   yc resource-manager cloud add-access-binding my-cloud \
     --role viewer \
     --subject system:allAuthenticatedUsers
   ```

- API

   Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the `subject` property, specify the `system` type:

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
       "accessBindingDeltas": [{
           "action": "ADD",
           "accessBinding": {
               "roleId": "viewer",
               "subject": {
                   "id": "allAuthenticatedUsers",
                   "type": "system"
       }}}]}' \
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
   ```

- {{ TF }}

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
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      After that access rights are granted for the cloud.

{% endlist %}