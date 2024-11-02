# Setting up access with API keys

To ensure security and facilitate your work with {{ vision-full-name }} and {{ translate-full-name }}, we recommend using authorization on behalf of a [service account](../iam/concepts/users/service-accounts.md) with an [API key](../iam/concepts/authorization/api-key.md).

To set up authorization on behalf of a service account:

1. [Prepare your cloud](#prepare-cloud).
1. [Create a service account](#create-account).
1. [Assign roles to the service account](#assign-roles).
1. [Create an API key](#run-client).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account {#create-account}
   
{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
   1. In the **Service accounts** tab, click **Create service account**.
   1. Enter a name for the service account, e.g., `sa-api`.

      The name format requirements are as follows:

      {% include [name-format](./name-format.md) %}

   1. Click **Create**.

- CLI {#cli}

   {% include [name-format](./cli-install.md) %}

   {% include [default-catalogue](./default-catalogue.md) %}

   Run the following command to create a service account:

   ```bash
   yc iam service-account create --name sa-api
   ```

   Where `--name` is the service account name in the following format:

   {% include [name-format](./name-format.md) %}

   Result:
   ```text
   id: ajehr0to1g8b********
   folder_id: b1gv87ssvu49********
   created_at: "2023-03-04T09:03:11.665153755Z"
   name: sa-api
   ```

- API {#api}

   Create a service account using the [create](../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../iam/api-ref/ServiceAccount/index.md) resource:

   ```bash
   curl \
     --request POST \
     --header 'Content-Type: application/json' \
     --header "Authorization: Bearer <IAM_token>" \
     --data '{
       "folderId": "<folder_ID>",
       "name": "<service_account_name>",
       "description": "service account for api"
     }' \
     https://iam.{{ api-host }}/iam/v1/serviceAccounts
   ```
   Where:
   * `<IAM_token>`: Valid authorization token.
   * `<folder_ID>`: ID of the folder hosting the services.
   * `<service_account_name>`: Service account name, e.g., `sa-api`. The name format requirements are as follows:

      {% include [name-format](./name-format.md) %}

   You can also create a service account using the [ServiceAccountService/Create](../iam/api-ref/grpc/ServiceAccount/create.md) gRPC call.

{% endlist %}

## Assign roles to the service account {#assign-roles}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the management console [home page]({{ link-console-main }}), select a folder.
   1. Click the **Access permissions** tab.
   1. Find the `sa-api` account in the list and click ![image](../_assets/console-icons/ellipsis.svg).
   1. Click **Edit roles**.
   1. Click **Add role** in the dialog box that opens and select the `ai.translate.user` role for {{ translate-full-name }} or `ai.vision.user` for {{ vision-full-name }}.
   1. Click **Save**.

- CLI {#cli}

   Run this command:
   ```
   yc resource-manager folder add-access-binding <folder_ID> \
      --role <role_ID> \
      --subject serviceAccount:<service_account_ID>
   ```

   Where `--role` is `ai.translate.user` for {{ translate-full-name }} or `ai.vision.user` for {{ vision-full-name }}.

- API {#api}

   Assign the required role to the service account using the [setAccessBindings](../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../iam/api-ref/ServiceAccount/index.md) resource:

   ```bash
   curl \
     --request POST \
     --header "Content-Type: application/json" \
     --header "Authorization: Bearer <IAM_token>" \
     --data '{
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

   * `<IAM_token>`: Valid authorization token.
   * `<role_ID>`: `ai.translate.user` for {{ translate-full-name }} or `ai.vision.user` for {{ vision-full-name }}.
   * `<service_account_ID>`: `sa-api` service account ID.

   You can also assign service account roles using the [ServiceAccountService/SetAccessBindings](../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC call.

{% endlist %}

## Create an API key {#run-client}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [create-console](./iam/create-api-key-console.md) %}

- CLI {#cli}

  {% include [default-catalogue](./default-catalogue.md) %}

  1. See the description of the create API key command:

      ```bash
      yc iam api-key create --help
      ```

  1. Select a service account, e.g., `sa-api`:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | sa-api           |                               |
      +----------------------+------------------+-------------------------------+
      ```

  1. Create an API key for the `sa-api` service account and save the response to the file:

      ```bash
      yc iam api-key create --service-account-name sa-api > api-key.yaml
      ```

      The `secret` property in the response will contain the API key:

      ```
      api_key:
        id: ajeke74kbp5b********
        service_account_id: ajepg0mjt06********
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHs********
      ```

      To learn how to transmit a key in a request, read the guides for the [services](../iam/concepts/authorization/api-key.md#supported-services) supporting this authorization method.

- API {#api}

   Create an API key using the [create](../iam/api-ref/ApiKey/create.md) REST API method for the [ApiKey](../iam/api-ref/ApiKey/index.md) resource:

   ```bash
   curl \
     --request POST \
     --header "Content-Type: application/json" \
     --header "Authorization: Bearer <IAM_token>" \
     --data "{ \"serviceAccountId\": \"<service_account_ID>\" }" \
     https://iam.{{ api-host }}/iam/v1/apiKeys
   ```

   Where:

   * `<IAM_token>`: Valid authorization token.
   * `<service_account_ID>`: `sa-api` service account ID.

   You can also create an API key using the [ApiKeyService/Create](../iam/api-ref/grpc/ApiKey/create.md) gRPC API call.

{% endlist %}

Now you can send requests to {{ vision-full-name }} and {{ translate-full-name }} services on behalf of your service account.

Enter the API key when accessing {{ yandex-cloud }} resources via the API. Provide the API key in the `Authorization` header in the following format:

```yaml
Authorization: Api-Key <API_key>
```