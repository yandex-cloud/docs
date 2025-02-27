# Creating triggers that invoke {{ sf-name }} functions to stop a VM and send Telegram notifications


In this tutorial, you will create a serverless infrastructure that will stop the virtual machines and send Telegram notifications when the VM resource use exceeds [budget](../../billing/concepts/budget.md) thresholds.

The [budget trigger](../../functions/concepts/trigger/budget-trigger.md) will invoke the {{ sf-name }} [function](../../functions/concepts/function.md) that will stop the {{ compute-name }} [virtual machines](../../compute/concepts/vm.md#project) and send a message to the {{ message-queue-full-name }} [queue](../../message-queue/concepts/queue.md). 

The [{{ message-queue-name }} trigger](../../functions/concepts/trigger/ymq-trigger.md) will deliver the queued messages to the second {{ sf-name }} function that will send Telegram notifications via a dedicated bot.

To deploy a project:
1. [Get your cloud ready](#before-you-begin).
1. [Create a budget](#create-budget).
1. [Create a {{ message-queue-name }} queue](#create-queue).
1. [Create a {{ sf-name }} function that the budget trigger will invoke](#create-budget-function).
1. [Create a budget trigger](#create-budget-trigger).
1. [Register your Telegram bot](#register-bot).
1. [Create a {{ sf-name }} function the {{ message-queue-name }} trigger will invoke](#create-queue-function).
1. [Create a trigger for {{ message-queue-name }}](#create-queue-trigger).
1. [Create {{ compute-name }} VM instances](#create-vms).
1. [Make sure the trigger stops the VMs and sends Telegram notifications](#test).

Create all specified {{ yandex-cloud }} resources in the same [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources includes:
* Fee for VM computing resources (see [{{ compute-name }} pricing](../../compute/pricing.md#prices-instance-resources)).
* Fee for VM [disks](../../compute/concepts/disk.md) (see [{{ compute-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for a dynamic [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for the number of function calls, computing resources allocated to a function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for the number of requests to queues and outgoing traffic (see [{{ message-queue-name }} pricing](../../message-queue/pricing.md)).
* Fee for logging operations and data storage in a [log group](../../logging/concepts/log-group.md) (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)) if you use [{{ cloud-logging-name }}](../../logging/).


### Download a project {#download}

Clone the repository containing the project:

```bash
git clone https://github.com/yandex-cloud-examples/yc-telegram-bot-with-trigger-for-budget
```


### Create a service account and static access key {#create-sa}

1. Create a service account:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your folder.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify the name: `service-account-for-budget`.
      1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_roles }}** field, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `editor` role.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create a service account named `service-account-for-budget`:

          ```bash
          yc iam service-account create \
            --name service-account-for-budget
          ```

          Result:

          ```text
          done (1s)
          id: ajed1o6dd581********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-02-23T18:32:38.365175925Z"
          name: service-account-for-budget
          ```

          Save the service account ID (`id`): you will need it in the next step.

          For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

      1. Assign the service account the `editor` role for your folder:

          ```bash
          yc resource-manager folder add-access-binding <folder_ID> \
            --role editor \
            --subject serviceAccount:<service_account_ID>
          ```

          Where:

          * `<folder_name>`: Name of your folder in {{ yandex-cloud }}.
          * `<service_account_ID>`: Service account [ID](../../iam/operations/sa/get-id.md) you saved in the previous step.

          Result:

          ```text
          done (2s)
          effective_deltas:
            - action: ADD
              access_binding:
                role_id: editor
                subject:
                  id: ajed1o6dd581********
                  type: serviceAccount
          ```

          For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

    - API {#api}

      To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

      To assign the service account a role for the folder, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

    {% endlist %}

1. Create a static access key:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your folder.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
      1. Select the `service-account-for-budget` service account from the list that opens.
      1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. If required, specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Save the ID and secret key.

          {% note alert %}

          After you close this dialog, the key value will not be shown again.

          {% endnote %}

    - CLI {#cli}

      Run this command:

      ```bash
      yc iam access-key create \
        --service-account-name service-account-for-budget
      ```

      Result:

      ```text
      access_key:
        id: aje75gg0rp8k********
        service_account_id: ajed1o6dd581********
        created_at: "2024-02-23T18:36:41.061060561Z"
        key_id: YCAJEK_r3Z_EvxRAR********
      secret: YCPQhHFMx6rnWXQC9ID425gk3V9YnUc********
      ```

      Save the ID (`key_id`) and secret key (`secret`). This is the only time you can copy this key as it will not be shown again.

      For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

    - API {#api}

      To create an access key, use the [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md) gRPC API call.

    {% endlist %}


### Create a cloud network and subnet {#create-network}

{% list tabs group=instructions %}

- Management console {#console} 

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `my-sample-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the left-hand panel, select ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. At the top right, click **{{ ui-key.yacloud.common.create }}**.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify `sample-subnet-{{ region-id }}-b`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** field, select the `{{ region-id }}-b` availability zone.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** field, select the `my-sample-network` cloud network.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field, specify `192.168.1.0/24`.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  1. Create a network named `my-sample-network`:

      ```bash
      yc vpc network create my-sample-network
      ```

      Result:

      ```text
      id: enp2gjcvrd59********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-02-23T18:39:17Z"
      name: my-sample-network
      default_security_group_id: enp9uobl2c33********
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create a subnet named `sample-subnet-{{ region-id }}-b` in the `{{ region-id }}-b` availability zone:

      ```bash
      yc vpc subnet create sample-subnet-{{ region-id }}-b \
        --zone {{ region-id }}-b \
        --network-name my-sample-network \
        --range 192.168.1.0/24
      ```

      Result:

      ```text
      id: e2l1ejkvq4jv********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-02-23T18:40:26Z"
      name: sample-subnet-ru-{{ region-id }}-b
      network_id: enp2gjcvrd59********
      zone_id: {{ region-id }}-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. To create a network, use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

  1. To create a subnet, use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}


## Create a budget {#create-budget}

{% include [create-budget-for-triggering](../_tutorials_includes/create-budget-for-triggering.md) %}


## Create a {{ message-queue-name }} {#create-queue}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select your folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Click **{{ ui-key.yacloud.ymq.queues.button_create }}**.
  1. Under **{{ ui-key.yacloud.ymq.queue.form.section_base }}**, specify:
      * **{{ ui-key.yacloud.common.name }}**: `budget-queue`  
      * **{{ ui-key.yacloud.ymq.queue.form.switch_fifo-queue }}**: `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}`

      Leave the other parameters unchanged.

  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Click the name of the your new queue: `budget-queue`. From the window that opens, copy the field values:
      * **{{ ui-key.yacloud.ymq.queue.overview.label_url }}**: Queue URL
      * **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**: Queue ID

      Save these values; you will need them in the next steps.

- AWS CLI {#cli}

  1. [Install and configure](../../message-queue/operations/configuring-aws-cli.md) the AWS CLI. When configuring, use the static access key you created in the previous step.

  1. Create a queue:

      ```bash
      aws sqs create-queue \
        --queue-name budget-queue \
        --endpoint https://message-queue.{{ api-host }}/
      ```

      Result:

      ```json
      {
          "QueueUrl": "https://message-queue.{{ api-host }}/b1glti4eser3********/dj600000001c********/budget-queue"
      }
      ```

      Save the `QueueUrl` value; you will need it in the next steps.

  1. Get the queue ID by specifying the previously saved URL in the `--queue-url` parameter:

      ```bash
      aws sqs get-queue-attributes \
        --queue-url <queue_URL> \
        --attribute-names QueueArn \
        --endpoint https://message-queue.{{ api-host }}/
      ```

      Result:

      ```json
      {
          "Attributes": {
              "QueueArn": "yrn:yc:ymq:{{ region-id }}:b1g9d2k0itu4********:budget-queue"
          }
      }
      ```

      Save the `QueueArn` queue ID; you will need it in the next steps.

{% endlist %}


## Create a {{ sf-name }} function the budget trigger will invoke {#create-budget-function}

1. Prepare a ZIP archive with the function code.

    Navigate to the `yc-telegram-bot-with-trigger-for-budget/steps/4-create-budget-trigger-handler` directory and add files to the `src_bgt.zip` archive:

    ```bash
    zip src_bgt.zip budget_trigger_handler.go go.mod
    ```

1. Create a function:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Create a function:
          1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
          1. Specify the function name: `budget-trigger-handler`.
          1. Click **{{ ui-key.yacloud.common.create }}**.

      1. Create a function version:
          1. Select `golang119` as the runtime environment, disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
          1. Specify the **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}** upload method and attach the `src_bgt.zip` archive you created in the previous step.
          1. Specify the entry point: `budget_trigger_handler.Handler`.
          1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `512 {{ ui-key.yacloud.common.units.label_megabyte }}`
              * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `service-account-for-budget`
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
                  * `FOLDER_ID` : ID of the folder where you want the VMs stopped.
                  * `TAG`: `target-for-stop`.
                  * `AWS_ACCESS_KEY_ID`: Static access key ID you saved in the previous step.
                  * `AWS_ACCESS_KEY_ID`: Secret key value of the static access key you saved in the previous step.
                  * `BUDGET_QUEUE_URL`: `budget-queue` URL you saved in the previous step.

          1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

    - CLI {#cli}

      1. Create a function named `budget-trigger-handler`:

          ```bash
          yc serverless function create \
            --name budget-trigger-handler
          ```

          Result:

          ```
          id: d4e4aigfdm0b********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-02-23T20:15:06.456Z"
          name: budget-trigger-handler
          http_invoke_url: https://{{ sf-url }}/d4e4aigfdm0b********
          status: ACTIVE
          ```

          For more information about the `yc serverless function create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/function/create.md).

      1. Create a version of the `budget-trigger-handler` function:

          ```bash
          yc serverless function version create \
            --function-name budget-trigger-handler \
            --memory=512m \
            --execution-timeout=5s \
            --runtime=golang119 \
            --entrypoint=budget_trigger_handler.Handler \
            --service-account-id=<service_account_ID> \
            --environment FOLDER_ID=<folder_ID> \
            --environment TAG=target-for-stop \
            --environment AWS_ACCESS_KEY_ID=<static_key_ID> \
            --environment AWS_SECRET_ACCESS_KEY=<private_key_value> \
            --environment BUDGET_QUEUE_URL=<queue_URL> \
            --source-path="./src_bgt.zip"
          ```

          Where:

          * `--service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the `service-account-for-budget` service account you saved in the previous step. This is the service account to invoke the function.
          * `--environment`: Environment variables:
              * `FOLDER_ID`: [ID](../../iam/operations/sa/get-id.md) of the folder where you want the VMs stopped.
              * `AWS_ACCESS_KEY_ID`: Static access key ID you saved in the previous step.
              * `AWS_ACCESS_KEY_ID`: Secret key value of the static access key you saved in the previous step.
              * `BUDGET_QUEUE_URL`: `budget-queue` URL you saved in the previous step.

          * `--source-path`: Path to the `src_bgt.zip` archive.

          Result:

          ```text
          done (2m32s)
          id: d4em5gaeev2b********
          function_id: d4e4aigfdm0b********
          created_at: "2024-02-23T20:31:18.458Z"
          runtime: golang119
          entrypoint: budget_trigger_handler.Handler
          resources:
            memory: "536870912"
          execution_timeout: 5s
          service_account_id: ajed1o6dd581********
          image_size: "23977984"
          status: ACTIVE
          tags:
            - $latest
          environment:
            AWS_ACCESS_KEY_ID: YCAJEK_r3Z_EvxRAR********
            AWS_SECRET_ACCESS_KEY: YCPQhHFMx6rnWXQC9ID425gk3V9YnUc0********
            BUDGET_QUEUE_URL: https://message-queue.{{ api-host }}/b1glti4eser3********/dj600000001c********/budget-queue
            FOLDER_ID: b1g9d2k0itu4********
            TAG: target-for-stop
          log_options:
            folder_id: b1g9d2k0itu4********
          ```

          For more information about the `yc serverless function version create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/function/version/create.md).

    - API {#api}

      To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call.

      To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

    {% endlist %}


## Create a budget trigger {#create-budget-trigger}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, specify the trigger name: `trigger-for-budget-from-yc`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_billing-budget }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_billing-budget }}**, select your billing account and the `vm-budget` budget you created earlier.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select the `budget-trigger-handler` function and specify the `service-account-for-budget` service account. This is the service account to invoke the function.

  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  To create a budget trigger that invokes the `budget-trigger-handler` function, run the following command:

  ```bash
  yc serverless trigger create billing-budget \
    --name trigger-for-budget-from-yc \
    --invoke-function-name budget-trigger-handler \
    --invoke-function-service-account-id <service_account_ID>  \
    --billing-account-id <billing_account_ID>  \
    --budget-id <budget_ID>
  ```

  Where:

  * `--invoke-function-service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the `service-account-for-budget` service account you saved in the previous step. This is the service account to invoke the function.
  * `--billing-account-id`: [Billing account](../../billing/concepts/billing-account.md) ID saved earlier when creating a budget.
  * `--budget-id`: Budget [ID](../../iam/operations/sa/get-id.md) you saved in the previous step.

  Result:

  ```text
  id: a1sjrukc64hs********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-02-23T21:20:03.308963151Z"
  name: trigger-for-budget-from-yc
  rule:
    billing_budget:
      billing_account_id: dn276oa9slgm********
      budget_id: dn2jr6qt0q9k********
      invoke_function:
        function_id: d4e4aigfdm0b********
        function_tag: $latest
        service_account_id: ajed1o6dd581********
  status: ACTIVE
  ```

  For more information about the `yc serverless trigger create billing-budget` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/trigger/create/billing-budget.md).

- API {#api}

  To create a trigger for budgets, use the [create](../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}


## Register your Telegram bot {#register-bot}

1. Register a bot in Telegram and get a token:

    1. To register a new bot, launch the [BotFather](https://t.me/BotFather) bot and send the following command:

        ```
        /newbot
        ```

        Result:

        ```text
        Alright, a new bot. How are we going to call it? Please choose a name for your bot.
        ```

    1. In the next message, specify the name of your bot, e.g., `YC VM budget informer`. This is the name users chatting with the bot will see.

        Result:

        ```text
        Good. Now let's choose a username for your bot. It must end in `bot`. Like this, for example: TetrisBot or tetris_bot.
        ```

    1. Specify the username of your bot, e.g., `YCVMBudgetInformerBot`. You can use it to find the bot in Telegram. The username must end with `...Bot` or `..._bot`. In response, you will receive an access token for the HTTP API.

        Result:

        ```text
        Done! Congratulations on your new bot. You will find it at t.me/YCVMBudgetInformerBot. You can now add a description, about section and profile picture for your bot, see /help for a list of commands. By the way, when you've finished creating your cool bot, ping our Bot Support if you want a better username for it. Just make sure the bot is fully operational before you do this.

        Use this token to access the HTTP API:
        715063****:AAGuj****-0VrIm7j9i****************
        Keep your token secure and store it safely, it can be used by anyone to control your bot.

        For a description of the Bot API, see this page: https://core.telegram.org/bots/api
        ```

1. Get `ChatID` of the user who will be receiving notifications from the bot:

    1. Save the API token you got in the previous step into the `TELEGRAM_BOT_API_TOKEN` environment variable:

        ```bash
        export TELEGRAM_BOT_API_TOKEN=<Telegram_API_token>
        ```

    1. Navigate to the `yc-telegram-bot-with-trigger-for-budget/steps/6-register-telegram-bot` directory and run the following command:

        ```bash
        go run .
        ```
        
        If required, pre-install the `Go` and `telegram_bot` packages.
        
        The command will launch a Telegram bot that will return the `ChatID` of the current user in response to any message.

    1. In Telegram, find your bot by its username, e.g., `YCVMBudgetInformerBot`, and send any message to it.

        Result:

        ```text
        59529*****
        ```
    
        Save the `ChatID` you have received in response. You will need it later.

    1. Return to the terminal and terminate the bot by pressing **Ctrl** + **C**.

## Create a {{ sf-name }} function the {{ message-queue-name }} budget trigger will invoke {#create-queue-function}

1. Prepare a ZIP archive with the function code.

    Navigate to the `yc-telegram-bot-with-trigger-for-budget/steps/7-create-budget-queue-handler` directory and add files to the `src_queue.zip` archive:

    ```bash
    zip src_queue.zip budget_queue_handler.go utils.go go.mod
    ```

1. Create a function:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Create a function:
          1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
          1. Specify the function name: `budget-queue-handler`.
          1. Click **{{ ui-key.yacloud.common.create }}**.

      1. Create a function version:
          1. Select `golang119` as the runtime environment, disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
          1. Specify the **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}** upload method and attach the `src_queue.zip` archive you created in the previous step.
          1. Specify the entry point: `budget_queue_handler.HandleBudgetQueueMessage`.
          1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `512 {{ ui-key.yacloud.common.units.label_megabyte }}`
              * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `service-account-for-budget`
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
                  * `TELEGRAM_BOT_API_TOKEN`: API token of the Telegram bot you saved in the previous step.
                  * `TELEGRAM_BOT_CHAT_ID`: `ChatID` of the Telegram user you saved in the previous step.

          1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

    - CLI {#cli}

      1. Create a function named `budget-queue-handler`:

          ```bash
          yc serverless function create \
            --name budget-queue-handler
          ```

          Result:

          ```
          id: d4e6r2g9trt5********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-02-24T07:36:04.092Z"
          name: budget-queue-handler
          http_invoke_url: https://{{ sf-url }}/d4e6r2g9trt5********
          status: ACTIVE
          ```

      1. Create a version of the `budget-queue-handler` function:

          ```bash
          yc serverless function version create \
            --function-name budget-queue-handler \
            --memory 512m \
            --execution-timeout 5s \
            --runtime golang119 \
            --entrypoint budget_queue_handler.HandleBudgetQueueMessage \
            --service-account-id <service_account_ID> \
            --environment TELEGRAM_BOT_API_TOKEN=<Telegram_bot_API_token> \
            --environment TELEGRAM_BOT_CHAT_ID=<Telegram_user_ChatID> \
            --source-path="./src_queue.zip"
          ```

          Where:

          * `--service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the `service-account-for-budget` service account you saved in the previous step. This is the service account to invoke the function.
          * `--environment`: Environment variables:

              * `TELEGRAM_BOT_API_TOKEN`: API token of the Telegram bot you saved in the previous step.
              * `TELEGRAM_BOT_CHAT_ID`: `ChatID` of the Telegram user you saved in the previous step.

          * `--source-path`: Path to the `src_queue.zip` archive.

          Result:

          ```text
          done (29s)
          id: d4e41l4gj7rk********
          function_id: d4e6r2g9trt5********
          created_at: "2024-02-24T07:43:32.464Z"
          runtime: golang119
          entrypoint: budget_queue_handler.HandleBudgetQueueMessage
          resources:
            memory: "536870912"
          execution_timeout: 5s
          service_account_id: ajed1o6dd581********
          image_size: "5464064"
          status: ACTIVE
          tags:
            - $latest
          environment:
            TELEGRAM_BOT_API_TOKEN: 7150638333:AAGujjyua-0VrIm7j9iG3mOxmz1********
            TELEGRAM_BOT_CHAT_ID: "59529*****"
          log_options:
            folder_id: b1g9d2k0itu4********
          ```

    - API {#api}

      To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call.

      To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

    {% endlist %}


## Create a trigger for {{ message-queue-name }} {#create-queue-trigger}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, specify the trigger name: `budget-queue-trigger`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select the resources you created in the previous steps:
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_queue }}** field, select `budget-queue`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_service-account }}** field, select `service-account-for-budget`.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select the `budget-queue-handler` function and specify the `service-account-for-budget` service account. This is the service account to invoke the function.

  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  To create a trigger for {{ message-queue-name }} that invokes the `budget-queue-handler` function, run the following command:

  ```bash
  yc serverless trigger create message-queue \
    --name budget-queue-trigger \
    --queue <queue_ID> \
    --queue-service-account-id <service_account_ID> \
    --invoke-function-name budget-queue-handler \
    --invoke-function-service-account-id <service_account_ID> \
    --batch-size 1 \
    --batch-cutoff 10s
  ```

  Where:

  * `--queue`: `budget-queue` ID you saved when creating the queue.
  * `--queue-service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the `service-account-for-budget` service account you saved in the previous step. The system will use the service account to read messages from the queue.
  * `--invoke-function-service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the `service-account-for-budget` service account you saved in the previous step. This is the service account to invoke the function.

  Result:

  ```text
  id: a1sqq6341kvh********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-02-24T08:35:39.296084612Z"
  name: budget-queue-trigger
  rule:
    message_queue:
      queue_id: yrn:yc:ymq:{{ region-id }}:b1g9d2k0itu4********:budget-queue
      service_account_id: ajed1o6dd581********
      batch_settings:
        size: "1"
        cutoff: 10s
      invoke_function:
        function_id: d4e6r2g9trt5********
        function_tag: $latest
        service_account_id: ajed1o6dd581********
  status: ACTIVE
  ```

  For more information about the `yc serverless trigger create message-queue` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/trigger/create/message-queue.md).

- API {#api}

  To create a trigger for {{ message-queue-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}


## Create {{ compute-name }} VMs {#create-vms}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**: 

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the `sample-subnet-{{ region-id }}-b` subnet you created earlier.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the information required to access the VM:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify a username, e.g., `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Specify the VM name, `target-instance-1`.
      * In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ ui-key.yacloud.component.label-set.button_add-label }}** and enter `target-for-stop:true`. Click **Enter** to save the label.

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Create a virtual machine:

  ```bash
  yc compute instance create \
    --name target-instance-1 \
    --labels target-for-stop=true \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=sample-subnet-{{ region-id }}-b,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
    --ssh-key ~/.ssh/<key_name>.pub
  ```

  Where `--ssh-key` is the path to the public SSH key The VM will automatically create the user called `yc-user` for this key.

  Result:

  ```
  done (39s)
  id: epdbhj4gssbp********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-02-24T09:29:16Z"
  name: target-instance-1
  labels:
    target-for-stop: "true"
  zone_id: {{ region-id }}-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epd4uuhf52oe********
    auto_delete: true
    disk_id: epd4uuhf52oe********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:b8:**:**:**
      subnet_id: e2l1ejkvq4jv********
      primary_v4_address:
        address: 192.168.1.9
        one_to_one_nat:
          address: 158.160.**.***
          ip_version: IPV4
  serial_port_settings:
    ssh_authorization: INSTANCE_METADATA
  gpu_settings: {}
  fqdn: epdbhj4gssbp********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  ```

  For more information about the `yc compute instance create` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  To create a VM, use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

Similarly, create two more VMs: `target-instance-2` and `target-instance-3`. For the latter, set the `target-for-stop` label to `false`.


## Make sure the trigger stops the VMs and sends Telegram notifications {#test}

Wait until the resource use of your VMs reaches the threshold values specified in your budget. Make sure that, when it happens, the `target-instance-1` and `target-instance-2` virtual machines stop, and the Telegram bot sends you a budget trigger notification:

```text
Budget trigger was triggered!
```


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../functions/operations/trigger/trigger-delete.md) the {{ sf-name }} triggers.
1. [Delete](../../functions/operations/function/function-delete.md) the {{ sf-name }} functions.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM instances.
1. [Delete](../../message-queue/operations/message-queue-delete-queue.md) the {{ message-queue-name }} queue.
1. [Delete](../../vpc/operations/subnet-delete.md) the subnet, then [delete](../../vpc/operations/network-delete.md) the cloud network.
