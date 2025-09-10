# How to create a Telegram bot with AI agent support using {{ sw-full-name }}


With serverless technologies, you can create a Telegram bot with [text generation model](../../foundation-models/concepts/generation/models.md) support based on [{{ foundation-models-full-name }}](../../foundation-models/).

In this tutorial, you will create a bot which provides movie recommendations based on user preferences. To do this, you will implement data storage in [{{ objstorage-full-name }}](../../storage/) and [{{ lockbox-full-name }}](../../lockbox/), configure bot logic in [{{ sw-full-name }}](../../serverless-integrations/) and set up a webhook using [{{ api-gw-full-name }}](../../api-gateway/).

To create a bot:

1. [Get your cloud ready](#before-you-begin).
1. [Register your Telegram bot](#create-bot).
1. [Create a secret](#create-secret).
1. [Create a bucket](#create-bucket).
1. [Create service accounts](#create-sa).
1. [Set up a workflow](#config-workflow).
1. [Set up an API gateway](#config-api-gateway).
1. [Set up a webhook for your bot](#config-webhook).
1. [Test your bot](#check-result).
1. [Customize the agent](#customize).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


## Required paid resources {#paid-resources}

The cost of Telegram bot support includes:

* Text generation fee (see [{{ foundation-models-full-name }} pricing](../../foundation-models/pricing.md)).
* Fee for storing the secret and requests to the secret (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for the amount of stored data, number of data operations, and outbound traffic (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for the number of requests to the API gateway and outbound traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for collecting and storing logs (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).


## Register your Telegram bot {#create-bot}

Register your bot in Telegram and get a token.

1. To register the new bot, start [BotFather](https://t.me/BotFather) and run this command:

    ```text
    /newbot
    ```

1. Specify the bot’s name, e.g., `Serverless AI Telegram Bot`. This is the name users will see when chatting with the bot.
1. Specify the username of your bot, e.g., `ServerlessAITelegramBot`. You can use it to find the bot in Telegram. The username must end with `...Bot` or `..._bot`.

    As a result, you will get a token. Save it, as you will need it later.


## Create a secret {#create-secret}

Create a [secret](../../lockbox/concepts/secret.md) to store the token for access to the Telegram API.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret.
  1. Select the `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}` secret type.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `token`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, specify the bot’s token you got when [creating](#create-bot) it.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI create secret command:

      ```bash
      yc lockbox secret create --help
      ```

  1. Create a secret:

      ```bash
      yc lockbox secret create \
        --name tg-bot-token \
        --payload '[{"key":"token","text_value":"<bot_token>"}]'
      ```

      Where:

      * `--name`: Secret name.
      * `--payload`: Secret contents as a YAML or JSON array.

          * `key`: Secret key.
          * `text_value`: Secret value. Specify the token you received when [creating the bot](#create-bot).

      Result:

      ```text
      id: e6qf05v4ftms********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T12:26:02.961Z"
      name: tg-bot-token
      status: ACTIVE
      current_version:
        id: e6q768pl3vrf********
        secret_id: e6qf05v4ftms********
        created_at: "2025-08-20T12:26:02.961Z"
        status: ACTIVE
        payload_entry_keys:
          - token
      ```

- API {#api}

  To create a secret, use the [Create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

{% endlist %}


## Create a bucket {#create-bucket}

Create a [bucket](../../storage/concepts/bucket.md) to store your chat history with the bot.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. In the top panel, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Enter a name for the bucket as per the [naming requirements](../../storage/concepts/bucket.md#naming).
  1. Specify the maximum bucket size: `5 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. View the description of the CLI command to create a bucket:

      ```bash
      yc storage bucket create --help
      ```

  1. Create a bucket in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc storage bucket create \
        --name <bucket_name> \
        --default-storage-class standard \
        --max-size 5368709120
      ```

      Where:

      * `--name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
      * `--default-storage-class`: [Storage class](../../storage/concepts/storage-class.md).
      * `--max-size`: Maximum bucket size, in bytes.

      Result:

      ```text
      name: bot-history-storage
      folder_id: b1g681qpemb4********
      anonymous_access_flags: {}
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "5368709120"
      created_at: "2025-08-20T12:23:21.361186Z"
      resource_id: e3erbgk1qmih********
      ```

- AWS CLI {#aws-cli}

  {% include [aws-cli-install](../../_includes/aws-cli-install.md) %}

  To create a bucket, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../../storage/security/index.md#storage-editor) to the service account used by the AWS CLI.

  In the terminal, run this command:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name>
  ```

  Where:

  * `--endpoint-url`: {{ objstorage-name }} endpoint.
  * `--bucket`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).

- API {#api}

  To create a bucket, use the [Create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}


## Create service accounts {#create-sa}

Create two [service accounts](../../iam/concepts/users/service-accounts.md):

* `sa-apigw`: This one will be used for executing the {{ sw-name }} [workflow](../../serverless-integrations/concepts/workflows/workflow.md).
* `sa-workflows`: This one will be used for executing the workflow steps.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Specify the service account name: `sa-apigw`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `serverless.workflows.executor` [role](../../iam/roles-reference.md).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

  Similarly, create a service account named `sa-workflows` and assign the following roles to it:

  * `storage.uploader`
  * `storage.viewer`
  * `{{ roles-lockbox-payloadviewer }}`
  * `{{ roles-yagpt-user }}`

- {{ yandex-cloud }} CLI {#cli}

  1. View a description of the CLI command to create a service account:

      ```bash
      yc iam service-account create --help
      ```

  1. Create service accounts:

      ```bash
      yc iam service-account create --name sa-apigw
      yc iam service-account create --name sa-workflows
      ```

      Where `--name` is the service account name.

      Result:

      ```text
      id: ajeu2s3k358j********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T12:18:37.599632350Z"
      name: sa-apigw

      id: ajersnus6rb2********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T12:18:41.869376672Z"
      name: sa-workflows
      ```

  1. Save the service account IDs and the folder ID to these variables:

      ```bash
      APIGW_SA=$(yc iam service-account get --name sa-apigw --format json | jq -r .id)
      WF_SA=$(yc iam service-account get --name sa-workflows --format json | jq -r .id)
      FOLDER_ID=$(yc config get folder-id)
      ```

  1. View the description of the CLI command for assigning a [role](../../iam/roles-reference.md) for the folder:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Assign roles for the folder to the service accounts:

      ```bash
      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role serverless.workflows.executor \
        --subject serviceAccount:$APIGW_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role storage.uploader \
        --subject serviceAccount:$WF_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role storage.viewer \
        --subject serviceAccount:$WF_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:$WF_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role {{ roles-yagpt-user }} \
        --subject serviceAccount:$WF_SA
      ```

      Where:

      * `--id`: Folder ID.
      * `--role`: Role.
      * `--subject`: Service account ID.

      Result:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: serverless.workflows.executor
            subject:
              id: ajeu2s3k358j********
              type: serviceAccount
      ...
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: {{ roles-yagpt-user }}
            subject:
              id: ajersnus6rb2********
              type: serviceAccount
      ```

- API {#api}

  Create service accounts:

  * `sa-apigw` with the `serverless.workflows.executor` role.
  * `sa-workflows` with the following roles:

      * `storage.uploader`
      * `storage.viewer`
      * `{{ roles-lockbox-payloadviewer }}`
      * `{{ roles-yagpt-user }}`

  To create a service account, use the [Create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign a role to a service account, use the [updateAccessBindings](../../iam/api-ref/ServiceAccount/updateAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/UpdateAccessBindings](../../iam/api-ref/grpc/ServiceAccount/updateAccessBindings.md) gRPC API call.

{% endlist %}


## Set up a workflow {#config-workflow}

Set up a workflow to enable the bot to read and save the chat history, call the AI agent, and send responses to Telegram.


### Prepare a YaWL specification {#prepare-spec-wf}

Save the workflow [YaWL specification](../../serverless-integrations/concepts/workflows/yawl/index.md) to a YAML file, e.g., `yawl-spec.yaml`.

```yaml
yawl: '0.1'
start: do_work
steps:
  do_work:
    parallel:
      branches:

        # Branch which outputs _typing_ to reanimate the chat faster
        send_typing_action:
          start: send_typing_action
          steps:
            send_typing_action:
              httpCall:
                url: >-
                  https://api.telegram.org/bot\(lockboxPayload("<secret_ID>"; "token"))/sendChatAction
                method: POST
                headers:
                  Content-Type: application/json
                body: |
                  \({
                    chat_id: .input.message.chat.id,
                    action: "typing"
                  })

        # Basic logic
        handle_update:
          start: get_history
          steps:
            get_history:
              objectStorage:
                bucket: <bucket_name>
                object: history/\(.input.message.chat.id).json
                get:
                  contentType: JSON
                output: '\({history: .Content})'
                next: call_ai
                catch:
                  - errorList:
                      - STEP_INVALID_ARGUMENT # There is no file or it is not JSON -> initialize
                    errorListMode: INCLUDE
                    output: '\({history: []})'
                    next: call_ai

            call_ai:
              aiAgent:
                agentConfig:
                  role: You are a movie selection consultant
                  goal: >-
                    Help the user find a movie to watch based on their tastes.
                    When they send their first request, ask them to name some of their favorite movies
                    (one per line). Then use this information to make recommendations
                    and ask clarifying questions.
                  backstory: >-
                    History of previous conversations (JSON array of {role,message} objects):
                    "\(.history)"
                  model:
                    name: yandexgpt
                tasks:
                  - description: \(.input.message.text)
                    result: Response in Markdown to send to Telegram.
                output: '\({reply: .Result})'
                next: send_reply

            send_reply:
              telegramBot:
                token: \(lockboxPayload("<secret_ID>"; "token"))
                sendMessage:
                  chatId: \(.input.message.chat.id)
                  text: \(.reply)
                  replyTo: \(.input.message.message_id)
                  parseMode: MARKDOWN
                next: save_history

            save_history:
              objectStorage:
                bucket: <bucket_name>
                object: history/\(.input.message.chat.id).json
                put:
                  contentType: JSON
                  content: >-
                    \(
                      .history +
                      [
                        {role:"user", message:.input.message.text},
                        {role:"assistant", message:.reply}
                      ]
                    )
```

Where:

* `<bucket_name>`: Name of the bucket you [created earlier](#create-bucket).
* `<secret_ID>`: ID of the secret you [created earlier](#create-secret).

This example uses the {{ gpt-pro }} (`name: yandexgpt`) text model. You can use [another model](../../foundation-models/concepts/generation/models.md#generation) available in synchronous mode in {{ foundation-models-name }}.


### Create a workflow {#create-workflow}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Choose the `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}` method.
  1. In the code editor, paste the text of the previously prepared YaWL workflow specification.
  1. Expand **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**:

      1. Enter a name for the workflow. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}

      1. Select the `sa-workflows` service account.
      1. Under **{{ ui-key.yacloud.logging.label_title }}**, disable **{{ ui-key.yacloud.logging.field_logging }}** if you do not want to pay for storing logs.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. See the description of the CLI command for creating a workflow:

      ```bash
      yc serverless workflow create --help
      ```

  1. Create a workflow:

      ```bash
      yc serverless workflow create \
        --yaml-spec <specification_file> \
        --name <workflow_name> \
        --service-account-id $WF_SA
      ```

      Where:

      * `--yaml-spec`: Path to the file with the workflow YaWL specification prepared earlier, e.g., `./yawl-spec.yaml`.
      * `--name`: Workflow name. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}

      * `--service-account-id`: `sa-workflows` service account ID.

      Result:

      ```text
      id: dfqjl5hh5p90********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: "yawl: ..."
      created_at: "2025-03-11T09:27:51.691990Z"
      name: my-workflow
      status: ACTIVE
      log_options: {}
      service_account_id: aje4tpd9coa********
      ```

- API {#api}

  To create a workflow, use the [Create](../../serverless-integrations/workflows/api-ref/Workflow/create.md) REST API method for the [Workflows](../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [Workflow/Create](../../serverless-integrations/workflows/api-ref/grpc/Workflow/create.md) gRPC API call.

{% endlist %}


## Set up an API gateway {#config-api-gateway}

Set up an [API gateway](../../api-gateway/concepts/index.md) as a Telegram webhook.


### Prepare an API specification {#prepare-spec-api}

Save the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) API specification to a YAML file, e.g., `api-spec.yaml`:

```yaml
openapi: 3.0.0
info:
  title: Telegram Webhook → Workflows
  version: 1.0.0
paths:
  /handle:
    post:
      x-yc-apigateway-integration:
        type: http
        method: POST
        service_account_id: <service_account_ID>  # sa-apigw service account
        url: https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/start
      requestBody:
        description: Telegram update passthrough to Workflows
        content:
          application/json:
            schema:
              x-yc-schema-mapping:
                type: static
                template:
                  workflowId: <workflow_ID>  # your workflow
                  input:
                    inputJson: ${.|tojson}  # entire Telegram update as input
```

Where:

* `<service_account_ID>`: `sa-apigw` service account ID.
* `<workflow_ID>`: ID of the workflow created in the [previous step](#create-workflow).


### Create an API gateway {#create-api-gw}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter the name of the API gateway. Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**, paste the text of the OpenAPI specification you prepared earlier.
  1. Under **{{ ui-key.yacloud.logging.label_title }}**, disable **{{ ui-key.yacloud.logging.field_logging }}** if you do not want to pay for storing logs.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Wait until the API gateway is created and select it.
  1. Save the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** value, you will need it at the next step.

- {{ yandex-cloud }} CLI {#cli}

  1. View the description of the CLI command for creating an API gateway:

      ```bash
      {{ yc-serverless }} api-gateway create --help
      ```

  1. Create an API gateway:

      ```bash
      {{ yc-serverless }} api-gateway create \
        --name <API_gateway_name> \
        --spec=<specification_file_path>
      ```

      Where:

      * `--name`: API gateway name. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}

      * `--spec`: Path to the specification file you created earlier.

      Result:

      ```text
      id: d5d63uh1h26g********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:23:19.682Z"
      name: ai-bot-gw
      status: ACTIVE
      domain: d5d63uh1h26g********.********.apigw.yandexcloud.net
      connectivity: {}
      log_options:
        folder_id: b1g681qpemb4********
      execution_timeout: 300s
      ```

  1. Save the `domain` value, you will need it at the next step.

- API {#api}

  To create an API gateway, use the [Create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md) gRPC API call.

{% endlist %}


## Set up a webhook for your bot {#config-webhook}

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  curl -s "https://api.telegram.org/bot<bot_token>/setWebhook" \
    -d "url=<service_domain>/handle"
  ```

  Where:

  * `<bot_token>`: Token you got when [creating the bot](#create-bot).
  * `<service_domain>`: Service domain of the API gateway you got when [creating](#create-api-gw) it.

  Here is an example:

  ```bash
  curl -s "https://api.telegram.org/bot1357246809:AAFhSteLniAw71g8jx6K5kTErO3********/setWebhook" \
    -d "url=https://d5d0jdhgrro2********.********.apigw.yandexcloud.net/handle"
  ```

  Result:

  ```text
  {"ok":true,"result":true,"description":"Webhook was set"}
  ```

{% endlist %}


## Test your bot {#check-result}

1. Find the bot in Telegram by its username, which you created [earlier](#create-bot).
1. Click **START** to start a chat.
1. Send the bot a list of movie titles, one per line.

    Here is an example:

    ```text
    Movie 1
    Movie 2
    Movie 3
    ```

    Bot's response:

    ```text
    Hi there! Thank you for letting me know your preferences. Here are the movies I would recommend based on your tastes:
    ...
    Which of these films you would like to watch? Or do you have some other favourite movies you want me to consider?
    ```


#### What's next {#what-is-next}

Try customizing the YaWL workflow specification. For example, provide a different request to the text model:

```yaml
...
call_ai:
  aiAgent:
    agentConfig:
      role: You are a consultant which recommends music artists
      goal: >-
        Help the user find music to listen to based on their tastes.
        When they send their first request, ask them to name some of their favorite
        bands, artists, composers, and genres (one per line).
        Then use this information to make recommendations and ask clarifying questions.
```

You can also add text or files as sources of information. Learn more in the [AI Agent integration step description](../../serverless-integrations/concepts/workflows/yawl/integration/aiagent.md).


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete](../../api-gateway/operations/api-gw-delete.md) the API gateway.
* [Delete](../../serverless-integrations/operations/workflows/workflow/delete.md) the workflow.
* [Delete](../../storage/operations/buckets/delete.md) the bucket.
* [Delete](../../lockbox/operations/secret-delete.md) the secret.
* If logging was enabled for the workflow or API gateway, [delete](../../logging/operations/delete-group.md) the log group.