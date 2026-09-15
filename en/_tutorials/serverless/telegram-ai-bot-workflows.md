# How to create a Telegram bot with AI agent support using {{ sw-full-name }}


With serverless technologies, you can create a Telegram bot with [text generation model]({{ link-docs-ai }}ai-studio/concepts/generation/models) support based on [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/index).

In this tutorial, you will create a bot which provides movie recommendations based on user preferences. You will do this by creating an AI agent, arranging for data storage in [{{ objstorage-full-name }}]({{ link-docs }}/storage/) and [{{ lockbox-full-name }}]({{ link-docs }}/lockbox/), setting up bot logic in [{{ sw-full-name }}]({{ link-docs }}/serverless-integrations/), and a webhook to start using a link.

To create a bot:

1. [Get your cloud ready](#before-you-begin).
1. [Create a Telegram bot](#create-bot).
1. [Create a secret](#create-secret).
1. [Create a bucket](#create-bucket).
1. [Create a service account](#create-sa).
1. [Create an AI agent](#create-ai-agent).
1. [Set up a workflow](#config-workflow).
1. [Set up a webhook for your bot](#config-webhook).
1. [Test your bot](#check-result).
1. [Customize the agent](#what-is-next).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


## Required paid resources {#paid-resources}

The cost of Telegram bot support includes:

* Fee for text generation (see [{{ ai-studio-full-name }} pricing]({{ link-docs-ai }}ai-studio/pricing)).
* Fee for storing the secret and requests to the secret (see [{{ lockbox-full-name }} pricing]({{ link-docs }}/lockbox/pricing)).
* Fee for storage space occupied by data, number of data operations, and outgoing traffic (see [{{ objstorage-full-name }} pricing]({{ link-docs }}/storage/pricing)).
* Fee for retrieval and storage of logs (see [{{ cloud-logging-full-name }} pricing]({{ link-docs }}/logging/pricing)).


## Create a Telegram bot {#create-bot}

Create a bot in Telegram and get a token.

1. To register a new bot, start [BotFather](https://t.me/BotFather) and run this command:

    ```text
    /newbot
    ```

1. Name your bot, e.g., `Serverless AI Telegram Bot`. This is the name users will see when chatting with the bot.
1. Specify a username for your bot, e.g., `ServerlessAITelegramBot`. You can use it to find the bot in Telegram. The username must end with `...Bot` or `..._bot`.

    As a result, you will get a token. Save it, as you will need it later.


## Create a secret {#create-secret}

Create a [secret]({{ link-docs }}/lockbox/concepts/secret) to store the Telegram API access token.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder) where you are going to create your infrastructure.
  1. [Navigate]({{ link-console-main }}/link/lockbox) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret.
  1. Select the `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}` secret type.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** field, enter `token`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** field, specify the token you got when [creating](#create-bot) the bot.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a secret:

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
      * `--payload`: Secret contents as a YAML or JSON array:

          * `key`: Secret key.
          * `text_value`: Secret value. Specify the token you got when [creating the bot](#create-bot).

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

  To create a secret, use the [Create]({{ link-docs }}/lockbox/api-ref/Secret/create) REST API method for the [Secret]({{ link-docs }}/lockbox/api-ref/Secret/index) resource or the [SecretService/Create]({{ link-docs }}/lockbox/api-ref/grpc/Secret/create) gRPC API call.

{% endlist %}


## Create a bucket {#create-bucket}

Create a [bucket]({{ link-docs }}/storage/concepts/bucket) to store your chat history with the bot.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. [Navigate]({{ link-console-main }}/link/storage) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. In the top panel, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Specify a bucket name that meets [these naming conventions]({{ link-docs }}/storage/concepts/bucket#naming).
  1. Specify the maximum bucket size: `5 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. See the description of the CLI command for creating a bucket:

      ```bash
      yc storage bucket create --help
      ```

  1. Create a bucket in the default [folder]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder):

      ```bash
      yc storage bucket create \
        --name <bucket_name> \
        --default-storage-class standard \
        --max-size 5368709120
      ```

      Where:

      * `--name`: Bucket name that meets the [naming conventions]({{ link-docs }}/storage/concepts/bucket#naming).
      * `--default-storage-class`: [Storage class]({{ link-docs }}/storage/concepts/storage-class).
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

  To create a bucket, [assign]({{ link-docs }}/iam/operations/sa/assign-role-for-sa) the `storage.editor` [role]({{ link-docs }}/storage/security/index#storage-editor) to the service account used by the AWS CLI.

  In the terminal, run this command:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name>
  ```

  Where:

  * `--endpoint-url`: {{ objstorage-name }} endpoint.
  * `--bucket`: Bucket name that meets the [naming conventions]({{ link-docs }}/storage/concepts/bucket#naming).

- API {#api}

  To create a bucket, use the [Create]({{ link-docs }}/storage/api-ref/Bucket/create) REST API method for the [Bucket]({{ link-docs }}/storage/api-ref/Bucket/index) resource, the [BucketService/Create]({{ link-docs }}/storage/api-ref/grpc/Bucket/create) gRPC API call, or the [create]({{ link-docs }}/storage/s3/api-ref/bucket/create) S3 API method.

{% endlist %}


## Create a service account {#create-sa}

Create a [service account]({{ link-docs }}/iam/concepts/users/service-accounts) named `sa-workflows`, which you will use to execute the workflow steps.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. [Navigate]({{ link-console-main }}/link/iam) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name the service account: `sa-workflows`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign these [roles]({{ link-docs }}/iam/roles-reference):

      * `storage.uploader`
      * `storage.viewer`
      * `{{ roles-lockbox-payloadviewer }}`
      * `{{ roles-yagpt-user }}`
      * `ai.assistants.editor`

  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. If you do not have [jq](https://stedolan.github.io/jq/download/) yet, install it.

  1. See the description of the CLI command for creating a service account:

      ```bash
      yc iam service-account create --help
      ```

  1. Create a service account:

      ```bash
      yc iam service-account create --name sa-workflows
      ```

      Where `--name` is the service account name.

      Result:

      ```text
      id: ajersnus6rb2********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T12:18:41.869376672Z"
      name: sa-workflows
      ```

  1. Save the service account ID and the folder ID to these variables:

      ```bash
      WF_SA=$(yc iam service-account get --name sa-workflows --format json | jq -r .id)
      FOLDER_ID=$(yc config get folder-id)
      ```

  1. See the description of the CLI command for assigning a [role]({{ link-docs }}/iam/roles-reference) for the folder:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Assign the following roles for the folder to the service account:

      ```bash
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

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role ai.assistants.editor \
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
            role_id: {{ roles-yagpt-user }}
            subject:
              id: ajersnus6rb2********
              type: serviceAccount
      ```

- API {#api}

  Create a service account named `sa-workflows` with the following roles:

  * `storage.uploader`
  * `storage.viewer`
  * `{{ roles-lockbox-payloadviewer }}`
  * `{{ roles-yagpt-user }}`
  * `ai.assistants.editor`

  To create a service account, use the [Create]({{ link-docs }}/iam/api-ref/ServiceAccount/create) REST API method for the [ServiceAccount]({{ link-docs }}/iam/api-ref/ServiceAccount/index) resource or the [ServiceAccountService/Create]({{ link-docs }}/iam/api-ref/grpc/ServiceAccount/create) gRPC API call.

  To assign a role to a service account, use the [updateAccessBindings]({{ link-docs }}/iam/api-ref/ServiceAccount/updateAccessBindings) REST API method for the [ServiceAccount]({{ link-docs }}/iam/api-ref/ServiceAccount/index) resource or the [ServiceAccountService/UpdateAccessBindings]({{ link-docs }}/iam/api-ref/grpc/ServiceAccount/updateAccessBindings) gRPC API call.

{% endlist %}


## Create an AI agent {#create-ai-agent}

Create a [text agent]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents) in {{ ai-studio-name }} to process user requests.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [{{ ai-studio-name }} interface]({{ link-console-ai }}).
  1. Click **Create AI agent** → **Create agent**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the agent, e.g., `Cinephile agent`.
  1. In the **Instruction** field, enter an instruction for the agent:

      ```
      You are a movie selection consultant
      
      You goal is to help the user find a movie to watch based on their preferences.
      On first request, ask them to name some of their favorite movies (one per line).
      Use this information to make recommendations and ask clarifying questions.
      
      History of previous conversations: not_var{{ backstory }}
      ```

      {% note info %}

      The `not_var{{ backstory }}` variable is used to provide conversation history to the agent. It allows the agent to be aware of the user’s previous messages when generating a response.

      {% endnote %}

  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Copy the ID of the agent you created by clicking **ID** ![image](../../_assets/console-icons/copy.svg) at the top left. Save it. You will need this ID to set up a workflow.

{% endlist %}


## Set up a workflow {#config-workflow}

Set up a workflow to read and store chat history, call the AI agent, and send responses to Telegram.

{% include [workflow-constructor-tip](../../_includes/serverless-integrations/workflow-constructor-tip.md) %}

![telegram-ai-bot-workflows-workflow](../../_assets/tutorials/telegram-ai-bot-workflows-workflow.png)


### Prepare a YaWL specification {#prepare-spec-wf}

Save the workflow [YaWL specification]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/index) to a YAML file, e.g., `yawl-spec.yaml`.

```yaml
yawl: '0.1'
start: do_work
steps:
  do_work:
    parallel:
      branches:

        # Step that sends a typing action to make the chat feel more responsive
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

        # Main logic
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
                      - STEP_INVALID_ARGUMENT # There is no file or it is not JSON -> initialize.
                    errorListMode: INCLUDE
                    output: '\({history: []})'
                    next: call_ai

            call_ai:
              aiStudioAgent:
                promptTemplateId: <agent_ID>
                message: \(.input.message.text)
                variables:
                  backstory: >-
                    History of previous conversations (JSON array of objects)
                    {role,message}): "\(.history)"
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
* `<agent_ID>`: ID of the agent [you created earlier](#create-ai-agent).


### Create a workflow {#create-workflow}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. [Navigate]({{ link-console-main }}/link/serverless-integrations) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Select the `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}` method.
  1. In the code editor, paste the text of the previously prepared YaWL workflow specification.
  1. Expand **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**:

      1. Enter a name for the workflow. The naming requirements are as follows:

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
      * `--name`: Workflow name. The naming requirements are as follows:

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
      execution_url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/dfq0eod50iol********/start
      ```

- API {#api}

  To create a workflow, use the [Create]({{ link-docs-ai }}ai-studio/workflows/api-ref/Workflow/create) REST API method for the [Workflows]({{ link-docs-ai }}ai-studio/workflows/api-ref/Workflow/index) resource or the [Workflow/Create]({{ link-docs-ai }}ai-studio/workflows/api-ref/grpc/Workflow/create) gRPC API call.

{% endlist %}


### Make the workflow public {#make-public}

Make the workflow public so it can be executed via a link without authentication.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your [workflow]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow).
  1. [Navigate]({{ link-console-main }}/link/serverless-integrations) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Select the workflow.
  1. Enable **{{ ui-key.yacloud.serverless-workflows.label_public-access }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. View the description of the CLI command for updating a [workflow]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow):

      ```bash
      yc serverless workflow update --help
      ```

  1. Make the workflow public:

      ```bash
      yc serverless workflow update \
        --name <workflow_name> \
        --set-is-public
      ```

      Result:

      ```text
      id: dfqjl5hh5p90********
      ...
      is_public: true
      execution_url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/dfq0eod50iol********/start
      ```

- API {#api}

  To make a [workflow]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow) public, use the [Update]({{ link-docs-ai }}ai-studio/workflows/api-ref/Workflow/update) REST API method for the [Workflows]({{ link-docs-ai }}ai-studio/workflows/api-ref/Workflow/index) resource or the [workflow/Update]({{ link-docs-ai }}ai-studio/workflows/api-ref/grpc/Workflow/update) gRPC API call with `isPublic: true`.

{% endlist %}

{% note info %}

Any user can execute a public workflow without an IAM token. This is necessary for setting up a Telegram webhook to send workflow execution requests via a link.

{% endnote %}


## Set up a webhook for your bot {#config-webhook}

Set up a webhook for your bot for it to send workflow execution requests via a link.


### Get a workflow execution link {#get-execution-url}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your workflow.
  1. [Navigate]({{ link-console-main }}/link/serverless-integrations) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Select a workflow. The execution link will appear in the **{{ ui-key.yacloud.serverless-workflows.label_execution-url }}** field.

- {{ yandex-cloud }} CLI {#cli}

  To get an execution link, run this command:

  ```bash
  yc serverless workflow get <workflow_name>
  ```

  Result:

  ```text
  id: dfqjl5hh5p90********
  ...
  is_public: true
  execution_url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/dfq0eod50iol********/start
  ```

  Save the value of the `execution_url` field.

- API {#api}

  To get a workflow execution link, use the [get]({{ link-docs-ai }}ai-studio/workflows/api-ref/Workflow/get) REST API method for the [Workflow]({{ link-docs-ai }}ai-studio/workflows/api-ref/Workflow/index) resource or the [WorkflowsService/Get]({{ link-docs-ai }}ai-studio/workflows/api-ref/grpc/Workflow/get) gRPC API call. The execution link will appear in the `execution_url` field.

{% endlist %}


### Set up a webhook {#setup-webhook}

If you do not have [cURL](https://curl.haxx.se) yet, install it.

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

Set up a webhook for your bot:

{% list tabs group=instructions %}

- Bash {#bash}

  Run this command:

  ```bash
  curl -s "https://api.telegram.org/bot<bot_token>/setWebhook" \
    -d "url=<execution_url>"
  ```

  Where:

  * `<bot_token>`: Token you got when [creating the bot](#create-bot).
  * `<execution_url>`: Workflow execution link you got in the [previous step](#get-execution-url).

  Here is an example:

  ```bash
  curl -s "https://api.telegram.org/bot1357246809:AAFhSteLniAw71g8jx6K5kTErO3********/setWebhook" \
    -d "url=https://serverless-workflows.{{ api-host }}/workflows/v1/execution/fd2g4pu20roc********/start"
  ```

  Result:

  ```text
  {"ok":true,"result":true,"description":"Webhook was set"}
  ```

{% endlist %}


## Test your bot {#check-result}

1. Find the Telegram bot you created [earlier](#create-bot) by its username.
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
    Which of these movies would you like to watch? Or do you have some other favorite movies you want me to consider?
    ```


#### What's next {#what-is-next}

Try editing the agent's instruction in {{ ai-studio-name }} to suit your task. For example, edit the agent's instruction to make it select music artists:

```
You are a music artist selection consultant

You goal is to help the user find music to listen to based on their preferences.
On first request, ask them to name some of their favorite bands, artists,
composers, and genres (one per line).
Use this information to make recommendations, ask clarifying questions.

History of previous conversations: not_var{{ backstory }}
```

Also, you can:
* Add text or files as sources of information for the agent. For more information, see [Text-based agents in {{ ai-studio-name }}]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents).
* Configure conversation context management. To learn more, see [Conversation context management]({{ link-docs-ai }}ai-studio/operations/agents/manage-context).
* Use the agent's other tools, such as file search or web search.


## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid [paying](#paid-resources) for them:

1. [Delete]({{ link-docs-ai }}ai-studio/operations/workflows/workflow/delete) the workflow.
1. [Delete]({{ link-docs }}/storage/operations/buckets/delete) the bucket.
1. [Delete]({{ link-docs }}/lockbox/operations/secret-delete) the secret.
1. Delete the AI agent in {{ ai-studio-name }}.
1. If the workflow logging feature was left on, [delete]({{ link-docs }}/logging/operations/delete-group) the log group.