{% include [include](../sa-assign-role-note.md) %}

In the management console, you can only grant a service account roles to folders in the same cloud as the service account's folder and to the cloud itself. To assign it a role for another resource, use the CLI or API.

{% list tabs %}

- Management console

   You assign roles to a service account the same way as to a user account.

   To assign a service account a role for the folder:

   {% include [grant-role-console-sa](../grant-role-console-sa.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To assign the service account a role for a resource, run:

   ```bash
   yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
     --role <role-id> \
     --subject serviceAccount:<service-account-id>
   ```

   Where:

   * `<service-name>`: The name of the service whose resource a role is assigned for (for example, `resource-manager`).
   * `<resource>`: The resource category, for example, `cloud`.
   * `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
   * `<resource-id>`: The resource ID.
   * `<role-id>`: The role ID, for example, `{{ roles-cloud-owner }}`.
   * `<service-account-id>`: The identifier of the service account assigned the role.

   For example, to assign a service account the `viewer` role for the `my-folder` [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

   {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- API

   {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md). Required parameter.
      * `role`: The role assigned. Required parameter.
      * `members`: List of users or service account the role is being assigned to. Specified in the following format: `userAccount:<user ID>` or `serviceAccount:<service account ID>`. Required parameter.

      ```
      resource "yandex_resourcemanager_folder_iam_binding" "admin-account-iam" {
        folder_id   = "<folder ID>"
        role        = "<role>"
        members     = [
          "serviceAccount:<Service account ID>",
        ]
      }
      ```

      For more information about the parameters of the `yandex_resourcemanager_folder_iam_binding` resource, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_iam_binding).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Afterwards, all the necessary resources are created in the specified folder. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc resource-manager folder list-access-bindings <folder name>|<folder ID>
      ```

{% endlist %}
