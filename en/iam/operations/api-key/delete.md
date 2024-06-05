---
title: "Deleting API keys"
description: "Follow this guide to delete an API key."
---

# Deleting API keys

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose a service account and click the row with its name.
   1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}** list, find an API key to be deleted.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the row of the key.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete-api-key }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Get a list of API key `IDs` for a specific service account. Specify the service account name in the `--service-account-name` parameter:

      ```bash
      yc iam api-key list --service-account-name <service_account_name>
      ```

      Result:

      ```bash
      +----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | ajenhvftf77r******** | 2022-03-13 21:15:40 |
      | ajeq610sgh05******** | 2022-03-13 21:14:43 |
      +----------------------+---------------------+
      ```

      The folder specified in the CLI profile is used by default to search for the service account. You can specify a different folder using the `--folder-name` or `--folder-id` flag.

   1. Delete the old API key. Instead of `<ID>`, specify the API key ID:

      ```bash
      yc iam api-key delete <ID>
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and delete the fragment with the API key description.

      Example API key description in the {{ TF }} configuration:

      ```
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<service_account_ID>"
        description        = "<key_description>"
        pgp_key            = "<PGP_key>"
      }
      ```

   1. Delete the record with information about the resource.

      For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_api_key).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) and this CLI command:

      ```
      yc iam key list --service-account-id <service_account_ID>
      ```

- API {#api}

   Delete the API key using the [delete](../../api-ref/ApiKey/delete.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

   ```bash
   export APIKEY_ID=ajeke74kbp5b********
   export IAM_TOKEN=CggaATEVAgA...
   curl -X DELETE -H "Authorization: Bearer $IAM_TOKEN" \
       https://iam.{{ api-host }}/iam/v1/apiKeys/$APIKEY_ID
   ```
   You can also delete the API key using the [ApiKeyService/Delete](../../api-ref/grpc/api_key_service.md#Delete) gRPC API call.

{% endlist %}
