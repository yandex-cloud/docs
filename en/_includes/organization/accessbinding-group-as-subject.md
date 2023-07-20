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

      * `<service_name>`: Name of the service whose resource requires assigning a role, such as `resource-manager`, to be accessed.
      * `<resource>`: Resource category, e.g., `cloud`.
      * `<resource_name>`: Resource name. You can specify the resource name or ID.
      * `<resource_ID>`: Resource ID.
      * `<role_ID>`: Role ID, such as `{{ roles-cloud-owner }}`.
      * `<group_id>`: ID of the group the role is assigned to.

      For example, here is how you can assign the `resource-manager.viewer` role for the `mycloud` [cloud](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
        --role resource-manager.viewer \
        --subject group:aje6o61dvog2h6g9a33s
      ```

- API

   Use the `updateAccessBindings` REST API method for the respective resource.

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

   To learn how to assign a role for the respective resource, see:
   * [{#T}](../../iam/operations/sa/set-access-bindings.md)
   * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
   * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)

- Terraform

   If you do not have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Add the resource parameters to the configuration file and specify the required role and group:

      ```
      resource "yandex_resourcemanager_cloud_iam_member" "admin" {
        cloud_id    = "<cloud_ID>"
        role        = "<role_ID>"
        member      = "group:<group_ID>"
      }
      ```

      Where:

      * `cloud_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md). You can also assign a role in an individual folder. To do this, specify `folder_id`instead of `cloud_id` and the required folder ID in the resource parameters.
      * `role`: [Role](../../iam/concepts/access-control/roles.md) being assigned. This parameter is required.
      * `member`: Group the role is assigned to. Specified in `group:<group_ ID>` format. This parameter is required.

      For more information about the `yandex_resourcemanager_cloud_iam_member` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_member).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Once you are done, all the resources you need will be created in the specified folder. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder-name>|<folder-id>
      ```

{% endlist %}
