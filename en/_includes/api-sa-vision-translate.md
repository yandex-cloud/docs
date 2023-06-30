# Setting up access with API keys

To securely work with {{ vision-full-name }} and {{ translate-full-name }} services, we recommend using authorization on behalf of a [service account](../iam/concepts/users/service-accounts.md) with an [API key](../iam/concepts/authorization/api-key.md).

To set up authorization on behalf of a service account:

1. [Prepare your cloud](#prepare-cloud).
1. [Create a service account](#create-account).
1. [Assign roles to the service account](#assign-roles).
1. [Create an API key](#run-client).


## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account {#create-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
   1. In the **Service accounts** tab, click **Create service account**.
   1. Enter a name for the service account, such as `sa-api`.

      The name format requirements are as follows:

      {% include [name-format](./name-format.md) %}

   1. Click **Create**.

- CLI

   {% include [name-format](./cli-install.md) %}

   {% include [default-catalogue](./default-catalogue.md) %}

   Run the command to create a service account:

   ```bash
   yc iam service-account create --name sa-api
   ```

   Where `name` is the name of the service account in the format:

   {% include [name-format](./name-format.md) %}

   Result:
   ```yaml
   id: ajehr0to1g8b********
   folder_id: b1gv87ssvu49********
   created_at: "2023-03-04T09:03:11.665153755Z"
   name: sa-api
   ```

- API

   Create a service account using the [create](../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../iam/api-ref/ServiceAccount/index.md) resource:

   ```bash
   curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM token>" \
      -d '{
            "folderId": "<folder_ID>",
            "name": "sa-api",
            "description": "service account for api"
      }' \
      https://iam.{{ api-host }}/iam/v1/serviceAccounts
   ```
   Where:
   * `<IAM token>`: Valid IAM token required for authorization.
   * `folderId`: ID of the folder that hosts the services.
   * `name`: Service account name in the following format:

      {% include [name-format](./name-format.md) %}

   You can also create a service account using the [ServiceAccountService/Create](../iam/api-ref/grpc/service_account_service.md#Create) gRPC call.

{% endlist %}

## Assign roles to the service account {#assign-roles}

{% list tabs %}

- Management console

   1. On the [start page]({{ link-console-main }}) of the management console, select the folder.
   1. Go to **Access rights**.
   1. Find the `sa-api` service account in the list and click ![image](../_assets/options.svg).
   1. Click **Edit roles**.
   1. Click **Add role** in the dialog box that opens and select the `ai.translate.user` role for {{ translate-full-name }} or the `ai.vision.user` role for {{ vision-full-name }}.
   1. Click **Save**.

- CLI

   Run this command:
   ```
   yc resource-manager folder add-access-binding <folder_ID> \
      --role <role_ID> \
      --subject serviceAccount:<service_account_ID>
   ```

   Where:
   <role_ID>: `ai.translate.user` for {{ translate-full-name }} or `ai.vision.user` for {{ vision-full-name }}.

- API

   Assign the required role to the service account using the [setAccessBindings](../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../iam/api-ref/ServiceAccount/index.md) resource:

   ```bash
   curl -X POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer <IAM token>" \
     -d '{
            "accessBindingDeltas": [{
               "action": "ADD",
               "accessBinding": {
                  "roleId": "<role_ID>",
                  "subject": {
                        "id": "<service_account_ID>",
                        "type": "serviceAccount"
                        }
                  }
               }
            ]
      }' \
     https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<folder_ID>:updateAccessBindings
   ```

   Where:
   * `<IAM token>`: Valid IAM token required for authorization.
   * `<service_account_ID>`: ID of the `sa-api` service account.
   * `<role_ID>`: `ai.translate.user` for {{ translate-full-name }} or `ai.vision.user` for {{ vision-full-name }}.

   You can also assign service account roles using the [ServiceAccountService/SetAccessBindings](../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC call.

{% endlist %}

## Create an API key {#run-client}

{% list tabs %}

- Management console

   {% include [create-console](./iam/create-api-key-console.md) %}

- CLI

   {% include [default-catalogue](./default-catalogue.md) %}

   1. See the description of the create API key command:

      ```bash
      yc iam api-key create --help
      ```

   1. Select a service account, such as `sa-api`.

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | sa-api           |                               |
      +----------------------+------------------+-------------------------------+
      ```

   1. Create an API key for the `sa-api` service account and write the response to a file:

      ```bash
      yc iam api-key create --service-account-name sa-api > api-key.yaml
      ```

      The response's `secret` property will contain the API key:

      ```
      api_key:
        id: ajeke74kbp5bfq7m6ka2
        service_account_id: ajepg0mjt06********
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHsssT5ICtm
      ```

      To learn how to provide the key to a request, read the guides for the [services](../iam/concepts/authorization/api-key.md#supported-services) that support this authorization method.

- API

   Create an API key using the [create](../iam/api-ref/ApiKey/create.md) REST API method for the [ApiKey](../iam/api-ref/ApiKey/index.md) resource:

   ```bash
   curl -X POST \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer <IAM token>" \
      -d "{ \"serviceAccountId\": \"<service_account_ID>\" }" \
      https://iam.{{ api-host }}/iam/v1/apiKeys
   ```

   Where:
   * `<IAM token>`: Valid IAM token required for authorization.
   * `<service_account_ID>`: ID of the `sa-api` service account.

   You can also create an API key using the [ApiKeyService/Create](../iam/api-ref/grpc/api_key_service.md#Create) gRPC API call.

{% endlist %}

Now you can send requests to {{ vision-full-name }} and {{ translate-full-name }} services on behalf of your service account.

Enter the API key when accessing {{ yandex-cloud }} resources via the API. Pass the API key in the `Authorization` header in the following format:

```
Authorization: Api-Key <API key>
```
