# Creating a skill for Alice and a website with authorization


In this tutorial, you will develop a [skill for Alice](https://yandex.ru/dev/dialogs/alice/doc/ru/about) and deploy a web app to create, read, and edit to-do lists using Alice, and share such lists with other website users.

The project's data is stored in a [{{ objstorage-full-name }}](../../storage/) bucket and [{{ ydb-full-name }}](../../ydb/) database. [{{ sf-full-name }}](../../functions/) process requests; [{{ api-gw-full-name }}](../../api-gateway/) enables service interaction.



To deploy a project:

1. [Get your cloud ready](#before-begin).
1. [Set up your environment](#prepare).
1. [Create resources](#create-resources).
1. [Set the project variables](#set-variables).
1. [Deploy the project](#deploy).
1. [Register a skill for Alice](#register-skill).
1. [Test the skill](#test-skill).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for the number of function calls, computing resources allocated for the functions, and outbound traffic (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* Fee for storing data in a bucket (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for the number of requests to the API gateway and outbound traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for logging operations and data storage in a log group (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).



## Set up your environment {#prepare}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Install Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install) to use Linux.
  1. Run WSL (Ubuntu by default).
  1. Configure the environment as described in this guide for Linux.

- Linux {#linux}

  {% note info %}

  If you are using a distribution other than Ubuntu, install the specified software using your package manager.

  {% endnote %}

  1. Clone the [yc-serverless-alice-shareable-todolist](https://github.com/yandex-cloud-examples/yc-serverless-alice-shareable-todolist) repository:

     ```bash
     git clone https://github.com/yandex-cloud-examples/yc-serverless-alice-shareable-todolist.git
     ```

  1. Install and configure the following:

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md)
     * [{{ ydb-short-name }} CLI](https://ydb.tech/docs/{{ lang }}/reference/ydb-cli/install)
     * [Bash](http://www.gnu.org/software/bash/)
     * [AWS CLI](../../storage/tools/aws-cli.md)
     * [jq](https://stedolan.github.io/jq/download/)
     * [Node.js](https://nodejs.org/en/download/package-manager/)
     * [npm package manager](https://{{ lang }}.wikipedia.org/wiki/Npm)
     * [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md)
     * [Go programming language](https://go.dev/doc/install)

  1. Optionally, to finalize the project, additionally install:

     * [go-swagger](https://goswagger.io/go-swagger/install/)
     * [api-spec-converter](https://www.npmjs.com/package/api-spec-converter)

{% endlist %}


## Create resources {#create-resources}

### Create a bucket {#create-bucket}

Create a [bucket](../../storage/concepts/bucket.md) to store static data in:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-public-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}


### Create an API gateway {#create-api-gw}

Create an [API gateway](../../api-gateway/concepts/index.md) for interaction between services:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter `gate-1`.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Wait for the API gateway status to change to `Active`.
  1. Select the created API gateway.
  1. Find the **{{ ui-key.yacloud.common.id }}** and **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** fields and save their values. You will need them to configure the skill.

{% endlist %}


### Create a database {#db-create}

Create a {{ ydb-short-name }} database in [Serverless mode](../../ydb/concepts/serverless-and-dedicated.md#serverless):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the bucket.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Specify a **{{ ui-key.yacloud.ydb.forms.label_field_name }}** for the database. Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
  1. Wait for the database status to change to `Running`.
  1. Select the created database.
  1. Under **{{ ui-key.yacloud.ydb.overview.section_connection }}**, find the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field and save its value. You will need it when creating functions.

{% endlist %}


### Create an app {#create-app}

[Create](https://yandex.ru/dev/id/doc/ru/register-client) an application in {{ yandex-oauth }}:

{% list tabs %}

- Interface {{ yandex-oauth }}

  1. Go to the [Yandex OAuth website]({{ ya-oauth-url }}) and log in.
  1. Click **Create app**.
  1. Specify the appropriate app name and upload an icon.
  1. Under **Platforms**, select `Web services` and click **Save and continue**.
  1. Under **Platforms**, specify the following URIs in the **Redirect URI** field:

      * `https://social.yandex.net/broker/redirect`
      * `<API_gateway_service_domain>/receive-token`.

      Leave the **Suggest Hostname** field blank.

  1. Click **Save and continue**.
  1. Under **Permissions**, select `Access to user avatar` and click **Save and continue**.
  1. Under **Email address**, specify your email address and click **Save and continue**.
  1. Verify the data and click **Everything is correct. Create the app**.

  You can read more about the service features in the {{ yandex-oauth }} [documentation](https://yandex.com/dev/oauth/doc/dg/tasks/register-client.html).

{% endlist %}

## Set the project variables {#set-variables}

Configure the project using the values you got when creating your resources.

### Create the secrets file {#set-variables-secure-config}

Create a file named `secure-config.json` with secrets:

{% list tabs group=programming_language %}

- Bash {#bash}

  1. To create a file from the `secure-config-template.json` template, navigate to the `yc-serverless-alice-shareable-todolist` project files folder and run this command:

      ```bash
      cp secure-config-template.json secure-config.json
      ```

  1. Open the `secure-config.json` file in `nano`:

      ```bash
      nano secure-config.json
      ```

  1. Substitute these variable values into the file:

      * `oauth_secret`: Password of the app (**Client Secret**) registered in [Yandex OAuth](https://oauth.yandex.com/).
      * `hash`: Base64-encoded random 64-byte string, e.g., `qrJagO5NVwOj0FeTmgYSwUN+XXkiQJMWifvrklF53wT55q80Xk8vmEB3kxhtpDnA1WDC893Z9Bh6QcqK********`. You can generate a random value in your terminal using `openssl rand -base64 64 | tr -d '\n'`.
      * `block`: Base64-encoded random 32-byte string, e.g., `uwk0duFgn2nYyfu2VzJe+MnWKWQrfKaiZijI********`. You can generate a random value in your terminal using `openssl rand -base64 32 | tr -d '\n'`.

      You can generate random values at [generate.plus](https://generate.plus/en/base64).

{% endlist %}


### Create the configuration file {#set-variables-variables}

Create a file named `variables.json` with project deployment configuration:

{% list tabs group=programming_language %}

- Bash {#bash}

  1. To create a file from the `variables-template.json` template, navigate to the project files folder and run this command:

      ```bash
      cp variables-template.json variables.json
      ```

  1. Open the `variables.json` file in `nano`:

      ```bash
      nano variables.json
      ```

  1. Substitute these variable values into the file:

      * `folder-id`: Cloud [folder ID](../../resource-manager/operations/folder/get-id.md).
      * `domain`: `gate-1` API gateway service domain without `https://`, e.g., `d5dbo25bol8n********.apigw.yandexcloud.net`.
      * `oauth-client-id`: **ClientID** field value of the app registered in [{{ yandex-oauth }}]({{ ya-oauth-url }}).
      * `database`: Database location, the second part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
      * `database-endpoint`: First part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `grpcs://` and preceding `/?database=`), e.g., `ydb.serverless.yandexcloud.net:2135`.
      * `yc-profile`: {{ yandex-cloud }} CLI [profile name](../../cli/operations/profile/profile-list.md).
      * `secure-config-path`: Path to the `secure-config.json` [secrets file](#set-variables-secure-config).
      * `storage-bucket`: Name of the bucket you created for storing static data.
      * `gateway-id`: API gateway `gate-1` ID.

{% endlist %}

## Deploy your project {#deploy}

Transfer the project files to {{ yandex-cloud }} and update the configuration.


### Apply a data schema {#deploy-schema}

To create tables in the database, navigate to the project files folder and run this command:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  ./upload_ydb_schema.sh
  ```

{% endlist %}


### Get an OAuth token {#get-oauth-token}

Get an [OAuth token](../../iam/concepts/authorization/oauth-token.md):

1. Go to [{{ yandex-oauth }}]({{ link-cloud-oauth }}). Before issuing a token, the service may request data access.
1. Save the new token: you will need it for code uploading.


### Upload the backend code to {{ sf-name }} {#deploy-backend}

Use {{ TF }} to automate your operations. Before you start, [initialize it](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Run the following command in the folder with the `app.tf` configuration file:

      ```bash
      terraform init
      ```

      {% note info %}

      If you encounter a `permission denied` error during {{ TF }} provider initialization, run the `sudo chown $(whoami) ~/yc-serverless-alice-shareable-todolist` command to edit current user's access permissions for the project folder.

      {% endnote %}

  1. After successful initialization, create resources by providing the OAuth token for {{ yandex-cloud }} authorization:

      ```bash
      terraform apply -var-file ./variables.json -var yc-token=<OAuth_token>
      ```

      As a result, {{ TF }} will automatically create or update the required resources.

{% endlist %}


### Upload the frontend code to {{ objstorage-name }} {#deploy-frontend}

To deploy the frontend web app, build the static files and upload them to {{ objstorage-name }}.

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Before compiling static files, make sure you have Node.js and the npm package manager [installed](#prepare).
  1. Navigate to the `yc-serverless-alice-shareable-todolist/frontend` directory and run the following command:

      ```bash
      npm run build
      ```

      If during the compilation you encounter the

      * `ERR_OSSL_EVP_UNSUPPORTED` error, create a `NODE_OPTIONS` variable:

         ```bash
         export NODE_OPTIONS=--openssl-legacy-provider
         ```
      * `npm ERR! Could not resolve dependency`, run the command:

          ```bash
          npm install --legacy-peer-deps && npm install --force
          ```

      Result:

      ```text
      > todolist@0.1.0 build
      > react-scripts build

      Creating an optimized production build...
      Compiled successfully.

      File sizes after gzip:

        75.93 KB  build/static/js/2.84be0fca.chunk.js
        23.26 KB  build/static/css/2.ef9168ec.chunk.css
        2.63 KB   build/static/js/main.d9e069c9.chunk.js
        776 B     build/static/js/runtime-main.676997b0.js
        402 B     build/static/css/main.e5cbab88.chunk.css

      The project was built assuming it is hosted at /.
      You can control this with the homepage field in your package.json.

      The build folder is ready to be deployed.
      You may serve it with a static server:

        npm install -g serve
        serve -s build
      ```

  1. To upload the files to {{ objstorage-name }}, run this command:

      ```bash
      cd ../
      ./upload_static.sh
      ```

      Result:

      ```text
      ./upload_static.sh
      upload: frontend/build/robots.txt to s3://frontent-statics/robots.txt
      upload: frontend/build/manifest.json to s3://frontent-statics/manifest.json
      upload: frontend/build/static/css/main.e5cbab88.chunk.css.map to s3://frontent-statics/static/css/main.e5cbab88.chunk.css.map
      upload: frontend/build/index.html to s3://frontent-statics/index.html
      upload: frontend/build/asset-manifest.json to s3://frontent-statics/asset-manifest.json
      upload: frontend/build/static/js/2.84be0fca.chunk.js.LICENSE.txt to s3://frontent-statics/static/js/2.84be0fca.chunk.js.LICENSE.txt
      upload: frontend/build/static/css/main.e5cbab88.chunk.css to s3://frontent-statics/static/css/main.e5cbab88.chunk.css
      upload: frontend/build/static/js/main.d9e069c9.chunk.js to s3://frontent-statics/static/js/main.d9e069c9.chunk.js
      upload: frontend/build/static/js/2.84be0fca.chunk.js to s3://frontent-statics/static/js/2.84be0fca.chunk.js
      upload: frontend/build/static/js/runtime-main.676997b0.js to s3://frontent-statics/static/js/runtime-main.676997b0.js
      upload: frontend/build/static/js/runtime-main.676997b0.js.map to s3://frontent-statics/static/js/runtime-main.676997b0.js.map
      upload: frontend/build/static/js/main.d9e069c9.chunk.js.map to s3://frontent-statics/static/js/main.d9e069c9.chunk.js.map
      upload: frontend/build/static/css/2.ef9168ec.chunk.css to s3://frontent-statics/static/css/2.ef9168ec.chunk.css
      upload: frontend/build/static/css/2.ef9168ec.chunk.css.map to s3://frontent-statics/static/css/2.ef9168ec.chunk.css.map
      upload: frontend/build/static/js/2.84be0fca.chunk.js.map to s3://frontent-statics/static/js/2.84be0fca.chunk.js.map
      ```

{% endlist %}


### Update the API gateway configuration {#deploy-gateway}

To upload the current specification to {{ api-gw-name }}, run this command:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  ./update_gateway.sh
  ```

  Result:

  ```text
  done (2s)
  id: d5dsj4st2g81********
  folder_id: b1g86q4m5vej********
  created_at: "2024-10-22T16:01:54.777Z"
  name: gate-1
  status: ACTIVE
  domain: {{ api-host-apigw }}
  connectivity:
    network_id: enp3srbi9u49********
  log_options:
    folder_id: b1g86q4m5vej********
  execution_timeout: 300s
  ```

{% endlist %}


## Register a skill for Alice {#register-skill}

### Create a dialog {#create-dialog}

{% list tabs %}

- Yandex Dialogs console

  1. Go to [Yandex Dialogs](https://dialogs.yandex.ru/) and log in to the console.
  1. Click **Create dialog** and select the `Skill` dialog type.
  1. In the **Skill name** field, specify `To-do lists`.
  1. Under **Backend**, enable **Yandex Cloud function** and from the list select the `todolist-alice` function you created earlier in {{ sf-name }}.
  1. Enable **Use data storage in the skill**.
  1. Fill in the required fields under **Publication in folder**. Configure the other settings as needed. For example, you can specify various word forms to trigger the skill, select a voice, or set access type.
  1. Click **Save** at the bottom of the page.

  For more information, see the Yandex Dialogs [documentation](https://yandex.ru/dev/dialogs/alice/doc/publish.html).

{% endlist %}


### Configure authorization on the Alice page {#configure-authorization}

{% list tabs %}

- Yandex Dialogs console

  1. Go to the **Account linking** tab.
  1. Enter the following:

      * **Application ID**: `ClientID` field value of the app registered in [{{ yandex-oauth }}]({{ ya-oauth-url }}).
      * **Application secret**: `Client secret` field value of the app registered in [{{ yandex-oauth }}]({{ ya-oauth-url }}).
      * **Authorization URL**: `{{ ya-oauth-url }}/authorize`.
      * **Get token URL**: `{{ ya-oauth-url }}/token`.
      * **Refresh token URL**: `{{ ya-oauth-url }}/token`.

  1. Click **Save**.

  To learn more about OAuth 2.0, see [RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749).

{% endlist %}


### Add intents {#add-intents}

{% list tabs %}

- Yandex Dialogs console

  1. Go to the **Settings** tab.
  1. Go to the **Intents** tab and click **Create**.
  1. Add intents for every action possible in the dialog. The intents you make reside are in the project's `yc-serverless-alice-shareable-todolist/intents` folder.
  1. Enter the following:

      * **Name**: Any name you want displayed in the interface.
      * **ID**: Intent ID equal to the name of the file in the `intents` folder.
      * **Grammar**: Grammar text equal to the contents of the file in the `intents` folder.

  1. Click **Save**.
  1. To complete creating the dialog, click **Submit for moderation** on the right side of the page.

  To learn more about intents, see [Alice's skills](https://yandex.ru/dev/dialogs/alice/doc/nlu-docpage/).

{% endlist %}


## Test the skill {#test-skill}

To debug the skill, use the **Testing** tab in the [Yandex Dialogs](https://dialogs.yandex.ru/developer) console or one of the [devices](https://yandex.ru/dev/dialogs/alice/doc/surfaces.html) you selected when designing the skill.

{% list tabs %}

- In the Yandex Dialogs console:

  Navigate to the **Testing** tab. You will see a chat with Alice on the left and an interaction log in JSON format on the right.

  Dialog example:

  ```text
  Let me help you with your lists!

    Hi Alice. Create a Groceries list.

  Done, I created a Groceries list.

    Add milk to Groceries.

  Done, I added "milk" to Groceries.

    Add bread.

  What list should I add "bread" to?

    Groceries.

  Done, I added "bread" to Groceries.

    Add eggs.

  What list should I add "eggs" to?

    Groceries.

  Done, I added "eggs" to Groceries.

    Alice, tell me what's on the Groceries list.

  Groceries:
  1. Milk
  2. Bread
  3. Eggs
  ```

- On the surface

  To start a dialog, use any device or service supported by [Alice](https://yandex.ru/alice).

- On the website

  In your browser, follow the URL in the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field of your `gate-1` API gateway and log in. The **My lists** page will open. In any of the lists, you can add or remove items and grant other users access to the list.

{% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete](../../storage/operations/buckets/delete.md) the bucket.
* [Delete](../../ydb/operations/manage-databases.md#delete-db) the database.
* [Delete the functions](../../functions/operations/function/function-delete.md).
* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the log group](../../logging/operations/delete-group.md).
