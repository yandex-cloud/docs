# Setting up access to {{ foundation-models-full-name }} with API keys

{{ foundation-models-full-name }} is part of {{ yandex-cloud }} and uses its authentication and authorization mechanism. You can send requests to {{ foundation-models-name }} models under your user account by authenticating with an [IAM token](../../iam/concepts/authorization/iam-token.md). This is the most secure way to do a quick trial as the IAM token lifetime is limited to 12 hours. However, we recommend accessing the API as a [service account](../../iam/concepts/users/service-accounts.md) with an [API key](../../iam/concepts/authorization/api-key.md).

To set up authorization with an API key as a service account:

1. [Get your cloud ready](#prepare-cloud).
1. [Create a service account](#create-account).
1. [Assign roles to the service account](#assign-roles).
1. [Create an API key](#run-client).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account {#create-account}
   
{% list tabs group=instructions %}

- Management console {#console}

   {% include [create-sa-via-console-without-role](../../_includes/iam/create-sa-via-console-without-role.md) %}

- CLI {#cli}

   {% include [name-format](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Create a service account:

   ```bash
   yc iam service-account create --name sa-api
   ```

   Where `--name` is the service account name in the following format:

   {% include [name-format](../../_includes/name-format.md) %}

   Result:

   ```text
   id: ajehr0to1g8b********
   folder_id: b1gv87ssvu49********
   created_at: "2023-03-04T09:03:11.665153755Z"
   name: sa-api
   ```

- API {#api}

   Create a service account using the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource:

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
   * `<service_account_name>`: Service account name, e.g., `sa-api`. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   You can also create a service account using the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC call.

{% endlist %}

## Assign roles to the service account {#assign-roles}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the cloud or folder.
   1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
   1. Select the service account you created earlier.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles:
      * To use text generation models, add the `ai.languageModels.user` role.
      * To use image generation models, add the `{{ roles-yaart-user }}` role.
      * To create datasets and tune models, add the `ai.datasets.editor` and `ai.models.editor` roles.
      * To create an assistant, add the `ai.assistants.editor` role.
      
      You can assign multiple roles at the same time. [Learn more about {{ foundation-models-name }} roles](../security/index.md).

   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   Run this command:

   ```
   yc resource-manager folder add-access-binding <folder_ID> \
      --role <role_ID> \
      --subject serviceAccount:<service_account_ID>
   ```

   Where `--role` is the role for using {{ foundation-models-name }}:
      * `ai.languageModels.user`: To use text generation models.
      * `{{ roles-yaart-user }}`: To use image generation models.
      * `ai.datasets.editor` and `ai.models.editor`: To create datasets and tune models.
      * `ai.assistants.editor`: To create an assistant.
   
   [Learn more about {{ foundation-models-name }} roles](../security/index.md).
      

- API {#api}

   Assign the required role to the service account using the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource:

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
   * `<role_ID>`: Role for working with {{ foundation-models-name }}:
      * `ai.languageModels.user`: To use text generation models.
      * `{{ roles-yaart-user }}`: To use image generation models.
      * `ai.datasets.editor` and `ai.models.editor`: To create datasets and tune models.
      * `ai.assistants.editor`: To create an assistant.
   
      [Learn more about {{ foundation-models-name }} roles](../security/index.md).
   * `<service_account_ID>`: ID of the service account you created earlier.

   You can also assign service account roles using the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC call.

{% endlist %}

## Create an API key {#run-client}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
   1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
   1. Select the service account to create an API key for. [Create](../../iam/operations/sa/create.md) a new service account if you need to.
   1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
   1. Enter a description of the key so that you can easily find it in the management console.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** to specify how you are going to use the API key:
      
      * `yc.ai.languageModels.execute`: Enables using the API key to work with text generation models.
      * `yc.ai.imageGeneration.execute`: Enables using the API key to work with image generation models.
      * `yc.ai.foundationModels.execute`: Enables using the API key to work with all {{ foundation-models-name }} models.

   1. Optionally, specify **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Save the ID and secret key.

  {% note alert %}

  After you close this dialog, the key value will not be shown again.

  {% endnote %}

- CLI {#cli}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

  1. Create an API key for the selected service account and save the response to a file:

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

- API {#api}

   Create an API key using the [create](../../iam/api-ref/ApiKey/create.md) REST API method for the ApiKey resource:

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

   You can also create an API key using the [ApiKeyService/Create](../../iam/api-ref/grpc/ApiKey/create.md) gRPC API call.

{% endlist %}

Now you can send requests to {{ foundation-models-name }} models as a service account.
