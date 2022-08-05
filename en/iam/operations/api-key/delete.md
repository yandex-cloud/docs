# Deleting API keys

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. In the **Authorized keys** list, find an API key to be deleted.
   1. Click ![image](../../../_assets/options.svg) in the row of the key.
   1. Select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   1. Get a list of API key `IDs` for a specific service account. Specify the service account name in the `--service-account-name` parameter:

      ```bash
      yc iam api-key list --service-account-name <service account name>
      ```

      Result:

      ```bash
      +----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | ajenhvftf77r9cf84a17 | 2022-03-13 21:15:40 |
      | ajeq610sgh05p641pam4 | 2022-03-13 21:14:43 |
      +----------------------+---------------------+
      ```

      The folder specified in the CLI profile is used by default to search for the service account. You can specify a different folder using the `--folder-name` or `--folder-id` flag.

   1. Delete the old API key. Instead of `<ID>`, specify the API key ID:

      ```bash
      yc iam api-key delete <ID>
      ```

- API

   1. Delete the API key using the [delete](../../api-ref/ApiKey/delete.md) method for the [ApiKey](../../api-ref/ApiKey/index.md) resource.

      ```bash
      export APIKEY_ID=ajeke74kbp5bfq7m6ka2
      export IAM_TOKEN=CggaATEVAgA...
      curl -X DELETE -H "Authorization: Bearer $IAM_TOKEN" \
          https://iam.{{ api-host }}/iam/v1/apiKeys/$APIKEY_ID
      ```

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and delete the fragment with the API key description.

      Example API key description in the {{ TF }} configuration:

      ```
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
          service_account_id = "<service account ID>"
          description        = "<key description>"
          pgp_key            = "<PGP key>"
      }
      ```

   1. Delete the record with information about the resource.

      For more information about the resources that you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_api_key).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following CLI command:

      ```
      yc iam key list --service-account-id <service account ID>
      ```

{% endlist %}
