---
title: Managing API keys in {{ iam-full-name }}
description: In this tutorial, you will learn how to create and delete API keys in {{ iam-full-name }} using the management console, CLI, and API.
---

# Managing API keys

An [API key](../../concepts/authorization/api-key.md) is a secret key used for simplified [service account](../../concepts/users/service-accounts.md) authentication in the [{{ yandex-cloud }} API](../../../api-design-guide/index.yaml).

If you do not have a service account yet, [create one](../sa/create.md) and [assign roles to it](../sa/assign-role-for-sa.md).

## Creating an API key {#create-api-key}

To create a service account API key:

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
        id: ajeefjedtpbi********
        service_account_id: ajeg2b2et02f********
        created_at: "2025-03-03T16:29:04.709971428Z"
        scope: yc.postbox.send
        scopes:
          - yc.postbox.send
        expires_at: "2025-04-09T08:41:27Z"
      secret: AQVNznzc3uVybtct16KkWUFCdQEneK2-********
      ```

      Save the key value you got in a secure location. You will not be able to get it again.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<service_account_ID>"
        description        = "<key_description>"
        scope              = "<scope>"
        expires_at         = "<date_and_time>"
        pgp_key            = "<PGP_key>"
        output_to_lockbox  {
          secret_id             = "<Lockbox_secret_ID>"
          entry_for_secret_key = "<secret_key>"
        }
      }
      ```

      Where:

      * `service_account_id`: Service account [ID](../sa/get-id.md). This is a required parameter.
      * `description`: Key description. This is an optional parameter.
      * `scope`: Key [scope](../../concepts/authorization/api-key.md#scoped-api-keys). This is an optional parameter.
      * `expires_at`: Key expiration date and time in `YYYY-MM-DDThh:mm:ssZ` format. This is an optional parameter.
      * `pgp_key`: Additional PGP key for encrypting a private key. Specify the public part of the key in Base64 encoding or in `keybase:keybaseusername` format. This is an optional parameter.
      * `output_to_lockbox`: Description of the {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md) to save the API key value to, in order to avoid its possible leak through the `terraform.tfstate` file. This is an optional parameter. Nested parameters:
          * `secret_id`: ID of the {{ lockbox-full-name }} secret to save the API key value to. The secret must be [custom](../../../lockbox/concepts/secret.md#secret-type).
          * `entry_for_secret_key`: Secret key to assign to the API key value being saved.

      To learn more about the resources you can create with {{ TF }}, see the [{{ TF }} documentation]({{ tf-provider-resources-link }}/iam_service_account_api_key).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can see their detailed description using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc iam api-key list --service-account-id <service_account_ID>
      ```

- API {#api}

  Use the [create](../../api-ref/ApiKey/create.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

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

To learn how to transmit a key in a request, read the [guides for the respective services](../../concepts/authorization/api-key.md#supported-services) supporting this authentication method.

### Viewing available scopes for an API key {#available-scopes}

{% list tabs group=instructions %}

- CLI {#cli}

  To view available [scopes](../../concepts/authorization/api-key.md#scoped-api-keys) of an API key, run this command:

  ```bash
  yc iam api-key list-scopes
  ```

  Result:


  ```text
  - yc.ai.foundationModels.execute
  - yc.ai.imageGeneration.execute
  - yc.ai.languageModels.execute
  - yc.ai.speechkitStt.execute
  - yc.ai.speechkitTts.execute
  - yc.ai.translate.execute
  - yc.ai.vision.execute
  - yc.monitoring.manage
  - yc.monitoring.read
  - yc.postbox.send
  - yc.search-api.execute
  - yc.serverless.containers.invoke
  - yc.serverless.functions.invoke
  - yc.ydb.tables.manage
  - yc.ydb.topics.manage
  ```

- API {#api}

  To view the available [scopes](../../concepts/authorization/api-key.md#scoped-api-keys) of an API key, use the [ListScopes](../../api-ref/ApiKey/listScopes.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource or the [ApiKeyService/ListScopes](../../api-ref/grpc/ApiKey/listScopes.md) gRPC API call.

{% endlist %}

### Examples {#examples}

#### Adding a description when creating an API key {#add-description}

To add an API key description when creating the key:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam api-key create \
    --service-account-name <service_account_name> \
    --description "this API-key is for my-robot"
  ```

  Where:

  * `--service-account-name`: Service account [name](../sa/get-id.md). This is a required parameter.
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

  Send your request:

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

## Deleting an API key {#delete-api-key}

To delete a service account API key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the required service account.
  1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_api_keys }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the API key to delete, and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete-api-key }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Get a list of API keys for a specific service account by entering the service account name:

        ```bash
        yc iam api-key list \
          --service-account-name <service_account_name>
        ```

        Result:

        ```text
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | ajenhvftf77r******** | 2022-03-13 21:15:40 |
        | ajeq610sgh05******** | 2022-03-13 21:14:43 |
        +----------------------+---------------------+
        ```

        The folder specified in the CLI profile is used by default to search for the service account. You can specify a different folder through the `--folder-name` or `--folder-id` parameter.

    1. Delete the API key by specifying its ID:

        ```bash
        yc iam api-key delete <API_key_ID>
        ```

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Open the {{ TF }} configuration file and delete the section with the API key description.

        Example API key description in the {{ TF }} configuration:

        ```hcl
        resource "yandex_iam_service_account_api_key" "sa-api-key" {
            service_account_id = "<service_account_ID>"
            description        = "<key_description>"
            pgp_key            = "<PGP_key>"
        }
        ```

        For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iam_service_account_api_key).

    1. Make sure the configuration files are correct.

        1. In the command line, go to the directory where you created the configuration file.
        1. Run a check using this command:

            ```bash
            terraform plan
            ```

        If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

    1. Deploy the cloud resources.

        1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

        1. Confirm creating and deleting the resources by typing `yes` in the terminal and clicking **Enter**.

        This will create or delete all resources you need in the specified folder. You can check the new resources and their settings or make sure the resources were deleted using the [management console]({{ link-console-main }}) and this CLI command:

        ```bash
        yc iam api-key list --service-account-id <service_account_ID>
        ```

- API {#api}

  Use the [delete](../../api-ref/ApiKey/delete.md) REST API method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

    ```bash
    export APIKEY_ID=<API_key_ID>
    export IAM_TOKEN=<IAM_token>
    curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        https://iam.{{ api-host }}/iam/v1/apiKeys/$APIKEY_ID
    ```

   You can also delete the API key using the [ApiKeyService/Delete](../../api-ref/grpc/ApiKey/delete.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/authorization/api-key.md)
* [{{ yandex-cloud }} services that support API keys](../../concepts/authorization/api-key.md#supported-services)