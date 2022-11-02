{% list tabs %}

- Management console

   1. Select the desired cloud or folder.

   1. Click the **Access bindings** tab.

   1. Click **Assign roles**.

   1. In the **Configure access bindings** window, click **Select user**.

   1. Go to the **Groups** tab and select the desired group or perform a search by group name.

   1. Click **Add role**.

   1. Select a role in the cloud or folder.

   1. Click **Save**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   1. Choose a role from the list in [Roles](../../iam/concepts/access-control/roles.md).

   1. Assign the role using the command:

      ```bash
      yc <service_name> <resource> add-access-binding <resource_name>|<resource_ID> \
        --role <role_ID> \
        --subject group:<group_ID>
      ```

      Where:

      * `<service_name>`: The name of the service whose resource requires assigning a role, such as `resource-manager`, to be accessed.
      * `<resource>`: The resource category, for example, `cloud`.
      * `<resource_name>`: The name of the resource. You can specify the resource name or ID.
      * `<resource_ID>`: The ID of the resource.
      * `<role_ID>`: The ID of the role, such as `{{ roles-cloud-owner }}`.
      * `<group_id>`: The ID of the group that the role is assigned to.

      For example, assign the `resource-manager.viewer` role for the `mycloud` [cloud](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
        --role resource-manager.viewer \
        --subject group:aje6o61dvog2h6g9a33s
      ```

- API

   Use the `updateAccessBindings` method for the corresponding resource.

   1. Choose a role from the list in [Roles](../../iam/concepts/access-control/roles.md).

   1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `group` type and group ID in the `subject` property:

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

   For detailed instructions on how to assign a role for the corresponding resource, see:
   * [{#T}](../../iam/operations/sa/set-access-bindings.md)
   * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
   * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../_tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Add the resource parameters to the configuration file, specify the required role and a list of groups:

      ```
      resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
        cloud_id    = "<cloud_ID>"
        role        = "<role_ID"
        members     = ["group:<group_ID>"]
      }
      ```

      Where:

      * `cloud_id`: Cloud ID. You can also assign a role in an individual folder. To do this, specify `folder_id`instead of `cloud_id` and the required folder ID in the resource parameters.
      * `role`: The [role](../../iam/concepts/access-control/roles.md) assigned. Required parameter.
      * `members`: The list of groups that the role is assigned to. Specified in `group:<group_ ID>` format. Required parameter.

      For more information about the parameters of the `yandex_resourcemanager_cloud_iam_binding` resource, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_iam_binding).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Afterwards, all the necessary resources are created in the specified folder. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder-name>|<folder-id>
      ```

{% endlist %}