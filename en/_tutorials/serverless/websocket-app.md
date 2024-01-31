# Creating an interactive serverless application using WebSocket

In this tutorial, you will deploy an online game based on Node.js using WebSocket.

The game's static resources will be stored in a {{ objstorage-name }} bucket and its data in {{ ydb-name }} databases. The game data will be transferred in {{ yds-name }} streams and handled by {{ sf-name }} functions. For messaging between the app components, we will use a {{ message-queue-name }} queue. Secrets are securely delivered to the app using {{ lockbox-name }}. An {{ api-gw-name }} API gateway will accept user requests and redirect them to {{ sf-name }} functions.

Game user authorization is based on integration with Telegram.

To create an online game:

1. [Prepare the environment](#prepare).
1. [Create {{ ydb-full-name }} databases](#create-ydb-database).
1. [Create a {{ yds-full-name }} data stream](#yds-create).
1. [Create a {{ lockbox-full-name }} secret](#secrets-create).
1. [Deploy the project](#app-deploy).
1. [Create access keys for service accounts](#create-extra-sa-keys).
1. [Create a new secret version and deploy your project again](#update-and-deploy).
1. [Create a {{ api-gw-full-name }} API gateway](#apigw-create).
1. [Connect a domain to a Telegram bot](#api-gw-connect).
1. [Test your application](#test-api).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for this tutorial includes:

* Fee for data operations and the amount of stored data (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* Fee for using a data stream (see [{{ yds-full-name }} pricing](../../data-streams/pricing.md)).
* Secret storage fees (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for data storage and operations with data (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for requests to the created API gateways and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for queue requests and outgoing traffic (see [{{ message-queue-full-name }} pricing](../../message-queue/pricing.md)).
* Fee for function calls and computing resources allocated to execute the functions (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).

## Prepare the environment {#prepare}

{% list tabs group=operating_system %}

- Windows {#windows}

   1. [Install the WSL](https://docs.microsoft.com/en-us/windows/wsl/install) utility to run a Linux environment.
   1. Run the Linux subsystem (by default, Ubuntu).
   1. Next, configure the environment as described in this guide for Linux.

- Linux {#linux}

   {% note info %}

   If you use a distribution other than Ubuntu, install the specified utilities using your package manager commands.

   {% endnote %}

   1. Install the following utilities in the specified order using commands in the terminal:

      * [WebStorm](https://www.jetbrains.com/webstorm/) or [IntelliJ IDEA Community Edition](https://www.jetbrains.com/idea/).
         ```bash
         sudo snap install webstorm --classic
         ```

      * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

         ```bash
         sudo apt-get install curl git -y
         ```

      * The [jq](https://stedolan.github.io/jq/download/) utility:
         ```bash
         sudo apt-get install jq
         ```

      * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

         ```bash
         curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
         exec -l $SHELL
         yc version
         ```

      * [AWS CLI](https://aws.amazon.com/cli/):

         ```bash
         curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
         sudo installer -pkg AWSCLIV2.pkg -target /
         ```

      * [YDB CLI](https://ydb.tech/ru/docs/reference/ydb-cli/install):

         ```bash
         curl -sSL https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
         ```

      * [Node.js](https://nodejs.org/en/) `16.16.0`:

         ```bash
         sudo apt-get install curl
         curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash
         sudo apt-get install nodejs
         node -v
         npm -v
         ```

      * [TypeScript](https://www.typescriptlang.org/):

         ```bash
         sudo npm install -g typescript
         ```


   1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a {{ yandex-cloud }} CLI profile with basic parameters.

- macOS {#macos}

   1. Install the following utilities in the specified order using commands in the terminal:
      * [Homebrew](https://brew.sh):

         ```bash
         /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
         ```

      * [WebStorm](https://www.jetbrains.com/webstorm/) or [IntelliJ IDEA Community Edition](https://www.jetbrains.com/idea/).
         ```bash
         brew install --cask webstorm
         ```

      * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

         ```bash
         brew install curl git
         ```

      * The [jq](https://stedolan.github.io/jq/download/) utility:
         ```bash
         brew install jq
         ```

      * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

         ```bash
         curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
         exec -l $SHELL
         yc version
         ```

      * [AWS CLI](https://aws.amazon.com/cli/):

         ```bash
         curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
         sudo installer -pkg AWSCLIV2.pkg -target /
         ```

      * [YDB CLI](https://ydb.tech/ru/docs/reference/ydb-cli/install):

         ```bash
         curl -sSL https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
         ```

      * [Node.js](https://nodejs.org/en/) `16.16.0`:

         ```bash
         brew install node@16
         brew install nvm
         node -v
         npm -v
         ```

         If you are using Zsh, run this command:
         ```bash
         echo 'export NVM_DIR=~/.nvm' >> ~/.zshrc
         echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.zshrc
         source ~/.zshrc
         ```

      * [TypeScript](https://www.typescriptlang.org/):

         ```bash
         npm install -g typescript
         ```

   1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a {{ yandex-cloud }} CLI profile with basic parameters.

{% endlist %}

### Download a project {#download-project}

Clone a repository with the `yc-serverless-serverless-game` project:

```bash
git clone --branch sls-demo-0323 https://github.com/yandex-cloud-examples/yc-serverless-serverless-game.git
```

### Register the Telegram bot {#create-bot}

Register your bot in Telegram and get a token.

1. To register the new bot, launch the [BotFather](https://t.me/BotFather) bot and run this command:

   ```
   /newbot
   ```

1. In the `name` field, enter a name for the bot being created, such as `Serverless Game With WebSockets`. This is the name users will see when communicating with the bot.

1. In the `username` field, enter the user name for the bot being created, such as `ServerlessGameWithWebSocketsBot`. You can use the user name to search for the bot in Telegram. The user name must end with `...Bot` or `..._bot`.

1. You will get the `t.me/ServerlessGameWithWebSocketsBot` address and token in response.

1. Save the username to the `TG_BOT_LOGIN` variable:

   ```bash
   echo "export TG_BOT_LOGIN=<bot_username>" >> ~/.bashrc && . ~/.bashrc
   echo $TG_BOT_LOGIN
   ```

1. Save the token to the `TG_BOT_TOKEN` variable:

   ```bash
   echo "export TG_BOT_TOKEN=<token>" >> ~/.bashrc && . ~/.bashrc
   echo $TG_BOT_TOKEN
   ```

### Get an access token {#create-token}

{% list tabs %}

- Federated account

   Get an IAM token and save it to the `YC_IAM_TOKEN` variable:

   ```bash
   echo "export YC_IAM_TOKEN=$(yc iam create-token)" >> ~/.bashrc && . ~/.bashrc
   echo $YC_IAM_TOKEN
   ```

- Yandex account

   Get an OAUTH token and save it to the `OAUTH_TOKEN` variable:

   ```bash
   echo "export OAUTH_TOKEN=$(yc config get token)" >> ~/.bashrc && . ~/.bashrc
   echo $OAUTH_TOKEN
   ```

{% endlist %}

### Create a service account {#setup-sa}

1. Create a service account named `sls-deploy` and save its name to the `SERVICE_ACCOUNT_GAME` variable:

   ```bash
   export SERVICE_ACCOUNT_GAME=$(yc iam service-account create --name sls-deploy \
     --description "service account for serverless game" \
     --format json | jq -r .)

   echo $SERVICE_ACCOUNT_GAME
   ```

1. The `id` line in the command output will show the service account ID. Save it to the `SERVICE_ACCOUNT_GAME_ID` variable:

   ```bash
   echo "export SERVICE_ACCOUNT_GAME_ID=<service_account_ID>" >> ~/.bashrc && . ~/.bashrc
   ```

1. Assign the service account the `{{ roles-editor }}` role:

   ```bash
   echo "export YC_FOLDER_ID=$(yc config get folder-id)" >> ~/.bashrc && . ~/.bashrc
   echo $YC_FOLDER_ID

   echo "export YC_CLOUD_ID=$(yc config get cloud-id)" >> ~/.bashrc && . ~/.bashrc
   echo $YC_CLOUD_ID

   yc resource-manager folder add-access-binding $YC_FOLDER_ID \
   --subject serviceAccount:$SERVICE_ACCOUNT_GAME_ID \
   --role {{ roles-editor }}
   ```

1. Create an authorized key for the service account:

   ```bash
   yc iam key create \
     --service-account-name sls-deploy \
     --output sls-deploy.sa

   echo "export SA_KEY_FILE=$PWD/sls-deploy.sa" >> ~/.bashrc && . ~/.bashrc
   echo $SA_KEY_FILE
   ```

1. Create a static access key for your service account:

   ```bash
   yc iam access-key create --service-account-id $SERVICE_ACCOUNT_GAME_ID
   ```

   Result:

   ```
   access_key:
       id: ajeibet3219********
       service_account_id: ajehr1tv2eo1********
       created_at: "2023-03-13T10:20:58.471421425Z"
       key_id: YCAS33CT2mPCVFh3K********
   secret: YCNhBcdvfDdssIuBa-FDl6zZz0MSky********
   ```

1. Save `key_id` to the `AWS_ACCESS_KEY_ID` variable and the secret key named `secret` to the `AWS_SECRET_ACCESS_KEY` variable:

   ```bash
   echo "export AWS_ACCESS_KEY_ID=<key_ID>" >> ~/.bashrc && . ~/.bashrc
   echo $AWS_ACCESS_KEY_ID

   echo "export AWS_SECRET_ACCESS_KEY=<secret key>" >> ~/.bashrc && . ~/.bashrc
   echo $AWS_SECRET_ACCESS_KEY
   ```

1. Set up the AWS CLI:

   ```bash
   aws configure
   ```

   Enter the following parameters:

   * `AWS Access Key ID`: Previously obtained ID of the service account access key ( `key_id`).
   * `AWS Secret Access Key`: Previously obtained service account secret key (`secret`).
   * `Default region name`: Use `{{ region-id }}`.
   * `Default output format`: Leave it blank.

1. Check the configuration:

   ```bash
   echo $AWS_ACCESS_KEY_ID
   echo $AWS_SECRET_ACCESS_KEY
   aws configure list
   ```

## Create {{ ydb-name }} databases {#create-ydb-database}

Create a database named `game-data` to store the game data and a database named `data-streams` for a {{ yds-name }} stream.

1. Create the `game-data` database in serverless mode:

   ```bash
   yc ydb database create game-data --serverless
   ```

   Result:

   ```
   done (8s)
   id: etn0ejcvmjm4********
   folder_id: b1geoelk7fld********
   created_at: "2023-03-30T15:01:19Z"
   name: game-data
   status: PROVISIONING
   endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaom********/etn0ejcvmjm4********
   serverless_database:
     storage_size_limit: "53687091200"
   location_id: {{ region-id }}
   ...
   ```

1. Save the `endpoint` value from the previous command output to the `YDB_ENDPOINT` variable. In our example, it equals `grpcs://ydb.serverless.yandexcloud.net:2135`.

   ```bash
   echo "export YDB_ENDPOINT=<Document_API_DB_endpoint>" >> ~/.bashrc && . ~/.bashrc
   echo $YDB_ENDPOINT
   ```

1. Save the `database` value from the previous command output to the `YDB_DATABASE` variable. In our example, it equals `/{{ region-id }}/b1gia87mbaom********/etn0ejcvmjm4********`.

   ```bash
   echo "export YDB_DATABASE=<table_name>" >> ~/.bashrc && . ~/.bashrc
   echo $YDB_DATABASE
   ```

1. Create the `data-streams` database in serverless mode:

   ```bash
   yc ydb database create data-streams --serverless
   ```

   Result:

   ```
   done (7s)
   id: etn16k0e1757********
   folder_id: b1geoelk7fld********
   created_at: "2023-03-30T15:02:44Z"
   name: data-streams
   status: PROVISIONING
   endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaom********/etn16k0e1757********
   serverless_database:
     storage_size_limit: "53687091200"
   location_id: {{ region-id }}
   ```

1. Save the `endpoint` value from the previous command output to the `YDB_DATA_STREAMS_ENDPOINT` variable. In our example, it equals `grpcs://ydb.serverless.yandexcloud.net:2135`.

   ```bash
   echo "export YDB_DATA_STREAMS_ENDPOINT=<Document_API_DB_endpoint>" >> ~/.bashrc && . ~/.bashrc
   echo $YDB_DATA_STREAMS_ENDPOINT
   ```

1. Save the `database` value from the previous command output to the `YDB_DATA_STREAMS_DATABASE` variable. In our example, it equals `/{{ region-id }}/b1gia87mbaom********/etn16k0e1757********`.

   ```bash
   echo "export YDB_DATA_STREAMS_DATABASE=<table_name>" >> ~/.bashrc && . ~/.bashrc
   echo $YDB_DATA_STREAMS_DATABASE
   ```

1. Check that everything is done correctly:

   ```bash
   ydb \
     --endpoint $YDB_ENDPOINT \
     --database $YDB_DATABASE \
     --sa-key-file $SA_KEY_FILE \
   discovery whoami \
     --groups
   ```

   Result:

   ```text
   User SID: ajeien4d11sc043********

   Group SIDs:
   all-users@well-known
   ```

### Create a table {#ydb-table-create}

1. Go to the `files` directory in the `yc-serverless-serverless-game` folder.

1. Create a table using the `db-example.sql` file:

   ```bash
   ydb \
     --endpoint $YDB_ENDPOINT \
     --database $YDB_DATABASE \
     --sa-key-file $SA_KEY_FILE \
   scripting yql --file db-example.sql
   ```

1. Add a record for the initial configuration:

   ```bash
   ydb \
     --endpoint $YDB_ENDPOINT \
     --database $YDB_DATABASE \
     --sa-key-file $SA_KEY_FILE \
   scripting yql --file db-update.sql
   ```

1. Check the execution result:

   ```bash
   ydb \
     --endpoint $YDB_ENDPOINT \
     --database $YDB_DATABASE \
     --sa-key-file $SA_KEY_FILE \
   scheme describe Config
   ```

   Result:

   ```
   Columns:
   ┌────────────────────┬─────────┬────────┬─────┐
   | Name               | Type    | Family | Key |
   ├────────────────────┼─────────┼────────┼─────┤
   | name               | Utf8?   |        | K0  |
   | grid_cell_size     | Uint32? |        |     |
   | max_active_players | Uint8?  |        |     |
   | max_inactive_sec   | Int32?  |        |     |
   | player_size        | Uint32? |        |     |
   | transport          | Utf8?   |        |     |
   | world_size_x       | Uint32? |        |     |
   | world_size_y       | Uint32? |        |     |
   └────────────────────┴─────────┴────────┴─────┘

   Storage settings:
   Store large values in "external blobs": false

   Column families:
   ┌─────────┬──────┬─────────────┬────────────────┐
   | Name    | Data | Compression | Keep in memory |
   ├─────────┼──────┼─────────────┼────────────────┤
   | default |      | None        |                |
   └─────────┴──────┴─────────────┴────────────────┘

   Auto partitioning settings:
   Partitioning by size: true
   Partitioning by load: false
   Preferred partition size (Mb): 2048
   Min partitions count: 1
   ```

## Create a {{ yds-name }} data stream {#yds-create}

{% list tabs group=instructions %}

- AWS CLI {#cli}

   ```bash
   echo $YDB_DATA_STREAMS_DATABASE

   aws kinesis create-stream \
     --endpoint https://yds.serverless.yandexcloud.net \
     --stream-name $YDB_DATA_STREAMS_DATABASE/notify-state-change \
     --shard-count 1
   ```

{% endlist %}

## Create a {{ lockbox-name }} secret {#secrets-create}

1. Create a secret named `game-secrets` and transfer the `YDB_ENDPOINT` and `YDB_DATABASE` variable values to it:

   ```bash
   yc lockbox secret create --name game-secrets \
     --description "The secrets for the serverless game" \
     --payload "[{'key': 'ydb_endpoint', 'text_value': $YDB_ENDPOINT},{'key': 'ydb_db', 'text_value': $YDB_DATABASE}]"
   ```

1. Save the ID of the created secret to the `LOCKBOX_SECRET_ID` variable:

   ```bash
   echo "export LOCKBOX_SECRET_ID=$(jq -r <<<  \
   "$(yc lockbox secret list --format json | jq '.[]' -c | grep game-secrets)" .id)"  \
   >> ~/.bashrc && . ~/.bashrc

   echo $LOCKBOX_SECRET_ID
   ```

1. Transfer the `TG_BOT_TOKEN` variable value to the secret:

   ```bash
   yc lockbox secret add-version --id $LOCKBOX_SECRET_ID \
   --payload "[{'key': 'tg_bot_token', 'text_value': '$TG_BOT_TOKEN'}]"
   ```

1. Transfer keys to the secret (we will get their values later). So far, set them to `null`.

   ```bash
   yc lockbox secret add-version --id $LOCKBOX_SECRET_ID \
   --payload "[{'key': 'ymq_writer_key_id', 'text_value': 'null'},\
   {'key': 'ymq_writer_key_secret', 'text_value': 'null'},\
   {'key': 'ymq_capture_queue_url', 'text_value': 'null'},\
   {'key': 'yds_writer_key_id', 'text_value': 'null'},\
   {'key': 'yds_writer_key_secret', 'text_value': 'null'},\
   {'key': 'yds_state_change_stream', 'text_value': 'notify-state-change'},\
   {'key': 'yds_state_change_database', 'text_value': '$YDB_DATA_STREAMS_DATABASE'}]"
   ```

## Deploy the project {#app-deploy}

1. Go to the `files` directory in the `yc-serverless-serverless-game` folder.

1. Change the configuration for {{ objstorage-name }}. Since the bucket name must be unique, replace it with a custom bucket name in the following files:


   * The `serverless.yaml` file:

      ```yaml
      sls-game-files:
        type: yc::ObjectStorageBucket
      ```

   * The `upload-to-s3.ts` file in the `scripts` directory:

      ```ts
      Bucket: 'sls-game-files',
      ```

      For instance, replace `sls-game-files` with `sls-game-files-example`.

1. Set the `APP_ENV` variable to build your project:

   ```bash
   echo "export APP_ENV=production" >> ~/.bashrc && . ~/.bashrc
   echo $APP_ENV
   ```

1. Build and deploy the project. In the `yc-serverless-serverless-game` folder root, run the following commands one by one:

   ```bash
   nvm use
   nvm install
   npm ci

   npm run build
   npm run deploy
   ```

## Create access keys for service accounts {#create-extra-sa-keys}

The following service accounts were created when deploying the project:
* `yds-writer-sa` with the `yds.writer` role to write data to the {{ yds-name }} stream.
* `ymq-writer-sa` with the `ymq.writer` role to write data to the {{ message-queue-name }} queue.

1. Create a static access key for the `yds-writer-sa` service account:

   ```bash
   echo "export YDS_WRITER_SA_ID=$(jq -r <<<  \
   "$(yc iam service-account list --format json | jq '.[]' -c | grep yds-writer-sa)" .id)"  \
   >> ~/.bashrc && . ~/.bashrc

   yc iam access-key create --service-account-id $YDS_WRITER_SA_ID
   ```

   Result:

   ```text
   access_key:
       id: ajeibet32197********
       service_account_id: ajehr6tv2eoo********
       created_at: "2023-03-13T10:20:58.471421425Z"
       key_id: YCASD3CT9mPCVFh3K********
   secret: YCNhBcdvfDdssIuBa-FDl6zZz0MSky********
   ```

1. Copy `key_id` and save it to the `YDS_WRITER_KEY_ID` variable:

   ```bash
   echo "export YDS_WRITER_KEY_ID=<key_ID>" >> ~/.bashrc && . ~/.bashrc
   echo $YDS_WRITER_KEY_ID
   ```
1. Copy the value of the secret named `secret` and save it to the `YDS_WRITER_KEY_SECRET` variable:

   ```bash
   echo "export YDS_WRITER_KEY_SECRET=<secret>" >> ~/.bashrc && . ~/.bashrc
   echo $YDS_WRITER_KEY_SECRET
   ```

1. Create a static access key for the `ymq-writer-sa` service account:

   ```bash
   echo "export YMQ_WRITER_SA_ID=$(jq -r <<<  \
   "$(yc iam service-account list --format json | jq '.[]' -c | grep ymq-writer-sa)" .id)"  \
   >> ~/.bashrc && . ~/.bashrc

   yc iam access-key create --service-account-id $YMQ_WRITER_SA_ID
   ```

1. Copy `key_id` and save it to the `YMQ_WRITER_KEY_ID` variable:

   ```bash
   echo "export YMQ_WRITER_KEY_ID=<key_ID>" >> ~/.bashrc && . ~/.bashrc

   echo $YMQ_WRITER_KEY_ID
   ```

1. Copy the value of the secret named `secret` and save it to the `YMQ_WRITER_KEY_SECRET` variable:

   ```bash
   echo "export YMQ_WRITER_KEY_SECRET=<secret>" >> ~/.bashrc && . ~/.bashrc
   echo $YMQ_WRITER_KEY_SECRET
   ```

## Create a new secret version and deploy your project again {#secrets-update}

1. Transfer new values to the `game-secrets` secret:

   1. In the [management console]({{ link-console-main }}), select your working folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
   1. Select `capturing-queue`.
   1. Copy the value from the **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** field and save it to the `YMQ_CAPTURE_QUEUE_URL` variable:

      ```bash
      echo "export YMQ_CAPTURE_QUEUE_URL=<URL>" >> ~/.bashrc && . ~/.bashrc
      ```

   1. Check the variable values to transfer to the secret:

      ```bash
      echo $LOCKBOX_SECRET_ID
      echo $YMQ_WRITER_KEY_ID
      echo $YMQ_WRITER_KEY_SECRET
      echo $YDS_WRITER_KEY_ID
      echo $YDS_WRITER_KEY_SECRET
      echo $YMQ_CAPTURE_QUEUE_URL
      ```

   1. Transfer the values to the secret:

      ```bash
      yc lockbox secret add-version --id $LOCKBOX_SECRET_ID \
      --payload "[{'key': 'ymq_writer_key_id', 'text_value': '$YMQ_WRITER_KEY_ID'},\
      {'key': 'ymq_writer_key_secret', 'text_value': '$YMQ_WRITER_KEY_SECRET'},\
      {'key': 'ymq_capture_queue_url', 'text_value': '$YMQ_CAPTURE_QUEUE_URL'},\
      {'key': 'yds_writer_key_id', 'text_value': '$YDS_WRITER_KEY_ID'},\
      {'key': 'yds_writer_key_secret', 'text_value': '$YDS_WRITER_KEY_SECRET'}]"
      ```

1. Go to the `yc-serverless-serverless-game` folder root and deploy the project again:

   ```bash
   npm run deploy
   ```

## Create a {{ api-gw-name }} API gateway {#apigw-create}

The following service accounts were created when deploying the project:
* `apigw-s3-viewer` with the `storage.viewer` role to read objects from the {{ objstorage-name }} bucket.
* `apigw-fn-caller` with the `{{ roles-functions-invoker }}` role to invoke {{ sf-name }} functions.

1. Save the IDs of the `apigw-s3-viewer` and `apigw-fn-caller` service accounts to the `APIGW_S3_VIEWER_ID` and `APIGW_FN_CALLER_ID` variables, respectively:

   ```bash
   echo "export APIGW_S3_VIEWER_ID=$(jq -r <<<  \
   "$(yc iam service-account list --format json | jq '.[]' -c | grep apigw-s3-viewer)" .id)"  \
   >> ~/.bashrc && . ~/.bashrc

   echo "export APIGW_FN_CALLER_ID=$(jq -r <<<  \
   "$(yc iam service-account list --format json | jq '.[]' -c | grep apigw-fn-caller)" .id)"  \
   >> ~/.bashrc && . ~/.bashrc
   ```

1. Make changes to the API gateway specification. Go to the `files` directory in the `yc-serverless-serverless-game` folder and run this command:

   ```bash
   cp apigw-example.yml apigw.yml
   ```

1. Get the IDs of the resources you created at the previous steps:

   ```bash
   echo $APIGW_S3_VIEWER_ID
   echo $APIGW_FN_CALLER_ID

   yc storage bucket list
   yc serverless function list
   ```

1. Make the following changes to the `apigw.yml` file:

   1. In every `bucket: serverless-game-files` line, replace the bucket name with a custom one.
   1. In every `service_account_id: <sa-id-for-object-storage>` line, replace `<sa-id-for-object-storage>` with the `$APIGW_S3_VIEWER_ID` variable value.
   1. In every `service_account_id: <sa-id-for-functions>` line, replace `<sa-id-for-functions>` with the ` $APIGW_FN_CALLER_ID` variable value.
   1. In line `58`, replace `<yandex-cloud-nodejs-dev-get-state-function-id>` with the `yandex-cloud-nodejs-dev-get-state` function ID.
   1. In line `65`, replace `<yandex-cloud-nodejs-dev-get-config-function-id>` with the `yandex-cloud-nodejs-dev-get-config` function ID.
   1. In line `72`, replace `<yandex-cloud-nodejs-dev-move-function-id>` with the `yandex-cloud-nodejs-dev-move` function ID.
   1. In line `79`, replace `<yandex-cloud-nodejs-dev-login-function-id>` with the `yandex-cloud-nodejs-dev-login` function ID.
   1. In line `101`, replace `<yandex-cloud-nodejs-dev-ws-message-function-id>` with the `yandex-cloud-nodejs-dev-ws-message` function ID.
   1. In line `106`, replace `<yandex-cloud-nodejs-dev-ws-connect-function-id>` with the `yandex-cloud-nodejs-dev-ws-connect` function ID.
   1. In line `111`, replace `<yandex-cloud-nodejs-dev-ws-disconnect-function-id>` with the `yandex-cloud-nodejs-dev-ws-disconnect` function ID.
   1. In line `118`, replace `<yandex-cloud-nodejs-dev-auth-function-id>` with the `yandex-cloud-nodejs-dev-auth` function ID.

1. Deploy an instance of {{ api-gw-name }}:

   ```bash
   yc serverless api-gateway create \
     --name serverless-game-api \
     --spec=apigw.yml \
     --description "for serverless-game-api"
   ```

   If you made an error in the API gateway specification, fix it and run this command:

   ```bash
   yc serverless api-gateway update \
     --name serverless-game-api \
     --spec=apigw.yml
   ```

## Connect a domain to a Telegram bot {#api-gw-connect}

1. Run this command:

   ```bash
   yc serverless api-gateway get --name serverless-game-api
   ```

1. Copy the API gateway's service domain. You can find it in the previous command output in the `domain` field.

1. Find a Telegram bot named [BotFather](https://t.me/BotFather) and type the `/setdomain` command.
1. Select your bot from the list and send it the API gateway's service domain. Add `https://` before the domain name. For example, if the API gateway's service domain is `d5d920bqkitf********.apigw.yandexcloud.net`, the URL will look like `https://d5d920bqkitf********.apigw.yandexcloud.net`.

## Test the app {#test-app}

Follow the link that you sent to the Telegram bot, sign in, and open the game.

The game has player statistics available. If the API gateway's service domain is `d5d920bqkitf********.apigw.yandexcloud.net`, the `https://d5d920bqkitf********.apigw.yandexcloud.net/stats.html` URL will open a page with statistics for all players.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../ydb/operations/manage-databases.md#delete-db) the {{ ydb-name }} databases.
* [Delete](../../data-streams/operations/manage-streams.md#delete-data-stream) the {{ yds-name }} stream.
* [Delete](../../lockbox/operations/secret-delete.md) the {{ lockbox-name }} secret.
* [Delete all objects from the bucket](../../storage/operations/objects/delete.md) and then [delete the empty {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
* [Delete](../../api-gateway/operations/api-gw-delete.md) the {{ api-gw-name }} API gateway.
* [Delete](../../functions/operations/function/function-delete.md) the {{ sf-name }} functions.
* [Delete](../../message-queue/operations/message-queue-delete-queue.md) the {{ message-queue-name }} queue.
