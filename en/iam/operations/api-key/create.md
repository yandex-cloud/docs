# Creating an API key

This guide will tell you how to create an [API key](../../concepts/authorization/api-key.md) for a [service account](../../concepts/users/service-accounts.md). The _API key_ is a secret key used for simplified authorization in the {{ yandex-cloud }} API.

If you do not have a service account yet, [create one](../sa/create.md) and [assign roles to it](../sa/assign-role-for-sa.md).

## Creating an API key {#create-api-key}

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

  1. Get a list of service accounts in the default folder:

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

  1. Create an API key for the required service account and save the response to the `api_key.yaml` file:

      ```bash
      yc iam api-key create \
        --service-account-name <service_account_name> \
        --scope <scope> \
        --expires-at <date_and_time> \
        > api_key.yaml
      ```

      Where:
      
      * `--service-account-name`: Service account name. This is a required parameter.
      * `--scope`: Key [scope](../../concepts/authorization/api-key.md#scoped-api-keys). This is an optional parameter.
      * `--expires-at`: Key expiration date and time. This is an optional parameter.
      * `api_key.yaml`: File to save the response to.
      
      As a result, you will get the `api_key.yaml` file with the API key value in the `secret` field:

      ```yaml
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
        scope              = "<scope>"
        expires_at         = "<date_and_time>"
        pgp_key            = "<PGP_key>"
      }
      ```

      Where:

      * `service_account_id`: Service account [ID](../sa/get-id.md). This is a required parameter.
      * `description`: Key description. This is an optional parameter.
      * `scope`: Key [scope](../../concepts/authorization/api-key.md#scoped-api-keys). This is an optional parameter.
      * `expires_at`: Key expiration date and time in `YYYY-MM-DDThh:mm:ssZ` format. This is an optional parameter.
      * `pgp_key`: Additional PGP key for encrypting a private key. Specify the public part of the key in Base64 encoding or in `keybase:keybaseusername` format. This is an optional parameter.

      For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_api_key).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc iam key list --service-account-id <service_account_ID>
      ```

- API {#api}

  Create an API key using the [create](../../api-ref/ApiKey/create.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

  ```bash
  export SERVICEACCOUNT_ID=<service_account_ID>
  export IAM_TOKEN=<token>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --data "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"scope\": \"<scope>\",
        \"expiresAt\": \"<date_and_time>\"
    }" \
    https://iam.{{ api-host }}/iam/v1/apiKeys
  ```

  Where:

  * `SERVICEACCOUNT_ID`: Service account [ID](../sa/get-id.md). This is a required parameter.
  * `IAM_TOKEN`: [IAM token](../../concepts/authorization/iam-token.md). This is a required parameter.
  * `scope`: Key [scope](../../concepts/authorization/api-key.md#scoped-api-keys). This is an optional parameter.
  * `expiresAt`: Expiration date and time for the key with restricted access. This is an optional parameter.

  You can also create an API key using the [ApiKeyService/Create](../../api-ref/grpc/ApiKey/create.md) gRPC API call.

{% endlist %}

### Viewing available scopes {#available-scopes}

{% list tabs group=instructions %}

- CLI {#cli}

  To view available scopes of an API key, run this command:

  ```bash
  yc iam api-key list-scopes
  ```

  Result:

  
  ```text
  - yc.postbox.send
  - yc.ydb.tables.manage
  - yc.ydb.topics.manage
  ```



- API {#api}

  View available scopes of an API key using the [ListScopes](../../api-ref/ApiKey/listScopes.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource.

  You can also view available scopes of an API key using the [ApiKeyService/ListScopes](../../api-ref/grpc/ApiKey/listScopes.md) gRPC API call.

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

  * `--service-account-name`: Service account name. This is a required parameter.
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
  * `description`: Key description. This is an optional parameter.

- API {#api}

  ```bash
  export SERVICEACCOUNT_ID=<service_account_ID>
  export IAM_TOKEN=<IAM_token>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --data "{
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
