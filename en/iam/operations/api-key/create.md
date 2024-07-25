# Creating API keys

This guide will tell you how to create an [API key](../../concepts/authorization/api-key.md) for a [service account](../../concepts/users/service-accounts.md). The _API key_ is a secret key used for simplified authorization in the {{ yandex-cloud }} API.

If you do not have a service account yet, [create one](../sa/create.md) and [assign roles to it](../sa/assign-role-for-sa.md).

To create an API key:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-console](../../../_includes/iam/create-api-key-console.md) %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the create API key command:

      ```bash
      yc iam api-key create --help
      ```

   1. Select a service account, e.g., `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

   1. Create an API key for the service account and save the response to the file:

      ```bash
      yc iam api-key create --service-account-name <service_account_name> > api_key.yaml
      ```

      Where:

      * `--service-account-name`: Name of the service account. This is a required parameter.
      * `api_key.yaml`: File to save the response to.

      As a result, you will get the `api_key.yaml` file with the API key value in the `secret` field:

      ```
      api_key:
        id: ajeke74kbp5b********
        service_account_id: ajepg0mjt06s********
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHs********
      ```

   To learn how to transmit a key in a request, read the guides for the [services](../../concepts/authorization/api-key.md#supported-services) supporting this authorization method.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<service_account_ID>"
        description        = "<key_description>"
        pgp_key            = "<pgp_key>"
      }
      ```

      Where:

      * `service_account_id`: Service account [ID](../sa/get-id.md). This is a required parameter.
      * `description`: Key description. This is an optional parameter.
      * `pgp_key`: Additional PGP key for encrypting a private key. Specify the public part of the key in Base64 encoding or in the `keybase:keybaseusername` format. This is an optional parameter.

      For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_api_key).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc iam key list --service-account-id <service_account_ID>
      ```

- API {#api}

  Create an API key using the [create](../../api-ref/ApiKey/create.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

  ```bash
  export SERVICEACCOUNT_ID=<service_account_ID>
  export IAM_TOKEN=<token>
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d "{ \"serviceAccountId\": \"$SERVICEACCOUNT_ID\" }" \
    https://iam.{{ api-host }}/iam/v1/apiKeys
  ```

  Where:

  * `SERVICEACCOUNT_ID`: Service account [ID](../sa/get-id.md). This is a required parameter.
  * `IAM_TOKEN`: [IAM token](../../concepts/authorization/iam-token.md). This is a required parameter.

  You can also create an API key using the [ApiKeyService/Create](../../api-ref/grpc/api_key_service.md#Create) gRPC API call.

{% endlist %}

## Examples {#examples}

### Adding a description when creating an API key {#add-description}

To add an API key description when creating the key:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
   yc iam api-key create --service-account-name my-robot \
     --description "this API-key is for my-robot"
   ```

   Where:

   * `--service-account-name`: Name of the service account. This is a required parameter.
   * `--description`: API key description. This is an optional parameter.

- {{ TF }} {#tf}

   ```hcl
   resource "yandex_iam_service_account_api_key" "sa-api-key" {
     service_account_id = "<service_account_ID>"
     description        = "this API-key is for my-robot"
   }
   ```

   Where:

   * `service_account_id`: Service account [ID](../sa/get-id.md). This is a required parameter.
   * `-description`: Key description. This is an optional parameter.

- API {#api}

   ```bash
   export SERVICEACCOUNT_ID=<service_account_ID>
   export IAM_TOKEN=<IAM_token>
   curl -X POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $IAM_TOKEN" \
     -d "{
         \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
         \"description\": \"this API-key is for my-robot\"
     }" \
     https://iam.{{ api-host }}/iam/v1/apiKeys
   ```

   Where:

   * `SERVICEACCOUNT_ID`: [Service account ID](../sa/get-id). This is a required parameter.
   * `IAM_TOKEN`: [IAM token](../../concepts/authorization/iam-token.md). This is a required parameter.

{% endlist %}

#### What's next {#what-is-next}

* [Find out what services support API keys](../../concepts/authorization/api-key.md#supported-services).
