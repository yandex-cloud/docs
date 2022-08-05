{% include [set-access-to-all](set-access-to-all.md) %}

For example, allow any authenticated user to view information about a folder and its resources:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. Go to **Access rights**.
   1. Click **Assign roles**.
   1. In the folder's **Configure access rights** window, click **Select subject**.
   1. Select the **Groups** section.
   1. Select the **All authenticated users** group.
   1. Click **Add role**.
   1. Select a role in the folder.
   1. Click **Save**.

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

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note alert %}

   Don't create the resource together with the `yandex_resourcemanager_folder_iam_policy` resource. They will conflict with each other.

   {% endnote %}

   To assign a role for a folder created using {{ TF }}:

   1. Describe the parameters of the folder role in a configuration file:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to grant permissions for. Required parameter.
      * `role`: The role assigned. Required parameter.

         {% note info %}

         For each role, only one `yandex_resourcemanager_folder_iam_binding` resource can be used.

         {% endnote %}

      * `members`: List of users to assign the role to. To add all users, create an entry in the format `system:<allUsers|allAuthenticatedUsers>`, where `<allUsers|allAuthenticatedUsers>` is one of [system groups](../../iam/concepts/access-control/system-group.md). Required parameter.

      {% cut "Example of assigning roles for the folder using {{ TF }}" %}

      ```hcl
      ...
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder ID>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "viewer" {
        folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"

        role = "viewer"

      members = [
        "system:allUsers",
      ]
      }
      ...
      ```

      {% endcut %}

      For more information about the parameters of the `yandex_resourcemanager_folder_iam_binding` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_folder_iam_binding).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder name>|<folder ID>
      ```

{% endlist %}
