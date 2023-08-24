# Creating API keys

This guide will tell you how to create an [API key](../../concepts/authorization/api-key.md) for a [service account](../../concepts/users/service-accounts.md). The _API key_ is a secret key used for simplified authorization in the {{ yandex-cloud }} API.

If you do not have a service account yet, [create one](../sa/create.md) and [assign roles to it](../sa/assign-role-for-sa.md).

To create an API key:

{% list tabs %}

- Management console

  {% include [create-console](../../../_includes/iam/create-api-key-console.md) %}

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the create API key command:

      ```bash
      yc iam api-key create --help
      ```

   1. Select a service account (for example, `my-robot`):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

   1. Create an API key for the `my-robot` service account and write the response to a file:

      ```bash
      yc iam api-key create --service-account-name my-robot > api-key.yaml
      ```

      The response's `secret` property will contain the API key:

      ```
      api_key:
        id: ajeke74kbp5b********
        service_account_id: ajepg0mjt06s********
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHs********
      ```

      To learn how to provide the key to a request, read the guides for the [services](../../concepts/authorization/api-key.md#supported-services) that support this authorization method.

- API

   1. [Find out the service account ID](../sa/get-id.md).
   1. Create an API key using the [create](../../api-ref/ApiKey/create.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

      ```bash
      export SERVICEACCOUNT_ID=<service_account_ID>
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $IAM_TOKEN" \
        -d "{ \"serviceAccountId\": \"$SERVICEACCOUNT_ID\" }" \
        https://iam.{{ api-host }}/iam/v1/apiKeys
      ```
      You can also create an API key using the [ApiKeyService/Create](../../api-ref/grpc/api_key_service.md#Create) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Add parameters of resource to the configuration file:

      * `service_account_id` = service account [ID](../sa/get-id.md). Required parameter.
      * `-description`: Key description. Optional parameter.
      * `pgp_key`: Additional PGP key for encrypting a private key. Optional parameter. Specify the public part of the key in Base64 encoding or in the `keybase:keybaseusername` format.

      Example of the configuration file structure:

      ```
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<service_account_ID>"
        description        = "<key_description>"
        pgp_key            = "<pgp_key>"
      }
      ```

      For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_api_key).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following CLI command:

      ```
      yc iam key list --service-account-id <service account ID>
      ```

{% endlist %}

## Examples {#examples}

### Add a description when creating {#add-description}

To make it easier to find an API key without knowing its ID, add a description when creating it:

{% list tabs %}

- CLI

   ```bash
   yc iam api-key create --service-account-name my-robot \
     --description "this API-key is for my-robot"
   ```

- API

   ```bash
   export SERVICEACCOUNT_ID=<service_account_ID>
   export IAM_TOKEN=CggaATEVAgA...
   curl -X POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $IAM_TOKEN" \
     -d "{
         \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
         \"description\": \"this API-key is for my-robot\"
     }" \
     https://iam.{{ api-host }}/iam/v1/apiKeys
   ```

- {{ TF }}

   1. Add parameters of resource to the configuration file:

      * `service_account_id`: Service account ID. Required parameter.
      * `-description`: Key description. Optional parameter.

      {% cut "Example of adding a description when creating a service account API key using {{ TF }}" %}

      ```
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<service_account_ID>"
        description        = "this API-key is for my-robot"
      }
      ```

      {% endcut %}

      For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_api_key).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

{% endlist %}

#### What's next {#what-is-next}

* [Find out what services support API keys](../../concepts/authorization/api-key.md#supported-services).
