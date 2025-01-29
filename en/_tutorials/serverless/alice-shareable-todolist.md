# Developing a skill for Alice and a website with authorization


In this scenario, you will develop a skill for Alice and deploy a web app for creating, reading and editing to-do lists with Alice's help, as well as for sharing the lists with other users on the website.


To deploy a project:
1. [Prepare your environment](#prepare).
1. [Create resources](#create-resources).
1. [Set the project variables](#set-variables).
1. [Deploy the project](#deploy).
1. [Register Alice's skill](#register-skill).
1. [Test the skill](#test-skill).

## Prepare your environment {#prepare}

1. [Download the archive](https://{{ s3-storage-host }}/doc-files/alice-shareable-todolist.zip) with project files or clone the [examples repository](https://github.com/yandex-cloud/examples/tree/master/serverless/alice-shareable-todolist) with Git.
1. [Create a folder](../../resource-manager/operations/folder/create.md) if you do not have any. For convenience, you can use a separate folder named `alice-skill`.
1. Install and initialize the following programs:
   * [{{ yandex-cloud }} CLI](../../cli/quickstart.md).
   * [{{ ydb-short-name }} CLI]({{ ydb.docs }}/reference/ydb-cli/install).
   * [Bash command interpreter](http://www.gnu.org/software/bash/).
   * [AWS CLI](../../storage/tools/aws-cli.md).
   * [jq](https://stedolan.github.io/jq/download/).
   * [Node.js](https://nodejs.org/en/download/package-manager/).
   * [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
1. To finalize the project, you will additionally need:
   * [The Go programming language](https://go.dev/).
   * The [go-swagger](https://goswagger.io/) utility.
   * The [api-spec-converter](https://www.npmjs.com/package/api-spec-converter) utility.

## Create resources {#create-resources}

1. [Create a bucket](../../storage/operations/buckets/create.md) with restricted access in {{ objstorage-full-name }}.
1. [Create an API gateway](../../api-gateway/operations/api-gw-create.md) named `gate-1`. Save the **{{ ui-key.yacloud.common.id }}** and **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field values to use them in the configuration.
1. [Create a database](../../ydb/quickstart.md#serverless) in Serverless mode. Save the value of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field from the **{{ ui-key.yacloud.ydb.overview.section_connection }}** section. You will need it when setting up your project.
1. [Create an app](https://oauth.yandex.com/) in Yandex OAuth:
   1. Go to the [service website](https://oauth.yandex.com/) and log in.
   1. Click **Create new client**.
   1. Select the desired name for the client app and upload an icon.
   1. Under **Platforms**, select **Web services**. Specify two Callback URIs:
      * `https://social.yandex.net/broker/redirect`.
      * `https://<API_gateway_service_domain>/receive-token`.

      Please note that the specified `receive-token` URL may be unavailable until the current specification is uploaded to the API gateway. The specification will be uploaded during the project's deployment.
   1. Under **Permissions**, expand **Yandex ID API (login)** and select **Access to user avatar (login:avatar)**.

   For more information about the Yandex OAuth features, see the [documentation](https://yandex.com/dev/oauth/doc/dg/tasks/register-client.html).

## Set the project variables {#set-variables}

Configure the project using the values you got when creating your resources.

### Create a variables.json file {#set-variables-variables}

The `variables.json` file contains the project deployment configuration. To create a file from the `variables-template.json` template, go to the project folder and run the command:

```bash
cp variables-template.json variables.json
```

In the `variables.json` file, set the project parameters:
* `folder-id`: ID of the cloud folder.
* `domain`: API gateway service domain.
* `oauth-client-id`: ID of the app registered in [Yandex OAuth](https://oauth.yandex.com/).
* `database-endpoint`: Endpoint, the first part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`), e.g., `{{ ydb.ep-serverless }}`.
* `database`: Database location, the second part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
* `yc-profile`: {{ yandex-cloud }} CLI [profile name](../../cli/operations/profile/profile-list.md).
* `secure-config-path`: Path to the secret file.
* `storage-bucket`: Name of the bucket you created for storing static data.
* `gateway-id`: API gateway ID.

### Create a secure-config.json file {#set-variables-secure-config}

The `secure-config.json` file contains secrets. You can create it from the `secure-config-template.json` template. To do this, run the following command:

```bash
cp secure-config-template.json secure-config.json
```

Substitute the values from the variables:
* `oauth_secret`: Password of the app registered in [Yandex OAuth](https://oauth.yandex.com/).
* `hash`: Base64-encoded random 64-byte string (e.g., `qrJagO5NVwOj0FeTmgYSwUN+XXkiQJMWifvrklF53wT55q80Xk8vmEB3kxhtpDnA1WDC893Z9Bh6QcqK********`). You can generate a random value in the terminal using `openssl rand -base64 64 | tr -d '\n'`.
* `block`: Base64-encoded random 32-byte string (e.g., `uwk0duFgn2nYyfu2VzJe+MnWKWQrfKaiZijI********`). You can generate a random value in the terminal using `openssl rand -base64 32 | tr -d '\n'`.

Make sure the `variables.json` file contains the correct path to `secure-config.json`.

## Deploy the project {#deploy}

Transfer the project files to {{ yandex-cloud }} and update the configuration.

### Apply a data schema {#deploy-schema}

To create tables in the database, run the command:

```bash
./upload_ydb_schema.sh
```

### Upload the backend code to {{ sf-name }} {#deploy-backend}

Use {{ TF }} to automate your operations. Before you start, [initialize it](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

To do this, in the folder with the `app.tf` configuration file, run the following command:

```bash
terraform init
```

Once {{ TF }} is initialized, run the command by delivering the [OAuth token](../../iam/concepts/authorization/oauth-token.md) value for authorization in {{ yandex-cloud }}:

```bash
terraform apply -var-file ./variables.json -var yc-token=<OAuth_token>
```

As a result, {{ TF }} automatically creates or updates the required resources.

### Upload the frontend code to {{ objstorage-name }} {#deploy-frontend}

To deploy the frontend web app, compile static files and upload them to {{ objstorage-name }}.
1. Before doing that, make sure you have Node.js and the npm package manager installed.
1. Go to the `frontend` subfolder and perform the compilation:

   ```bash
   npm run build
   ```

   Result:

   ```text
   npm run build

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

1. To upload the files to {{ objstorage-name }}, run the command:

   ```bash
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

### Update the API gateway configuration {#deploy-gateway}

To upload the current specification to {{ api-gw-name }}, run the command:

```bash
./update_gateway.sh
```

Result:

```text
done (2s)
id: d5dc6k34opm********
folder_id: b1guj13dic14********
created_at: "2021-06-03T11:18:00.379Z"
name: gate-1
status: ACTIVE
domain: {{ api-host-apigw }}
log_group_id: ckg57bweoekk********
```

## Register Alice's skill {#register-skill}

### Create a dialog {#create-dialog}

1. Go to the [Yandex Dialogs](https://dialogs.yandex.ru/) website and log in to the console.
1. Click **Create dialog** and select the **Alice skill** dialog type.
1. In the **Skill name** field, set **To-do lists**.
1. Under **Backend**, select **{{ yandex-cloud }} function**. In the list, choose the `todo-list-alice` function that you previously created in {{ sf-name }}.
1. Enable **Use data storage in the skill**.

Set the other parameters as you wish. For example, you can specify different word forms to activate the skill and choose a voice or skill access type. 

Learn more in the Yandex Dialogs [documentation](https://yandex.ru/dev/dialogs/alice/doc/publish.html).

### Configure authorization on the Alice page {#configure-authorization}

1. Go to the **Main settings** tab and find the **Account linking** section.
1. In the **Authorization** line, click **Create**.
1. Enter the following:
   * **ID** and **Application secret**: ID and password you obtained when registering your app with [Yandex OAuth](https://oauth.yandex.com/).
   * **Authorization URL**: `https://oauth.yandex.com/authorize`.
   * **Get token URL**: `https://oauth.yandex.com/token`.
   * **Refresh token URL**: `https://oauth.yandex.com/token`.

For more information about OAuth 2.0, see [RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749).

### Add intents {#add-intents}

1. Go to the **Intents** tab and click **Create**.
1. Add intents for each action that is possible in the dialog. The available intents are in the project's `intents` subfolder.
1. Enter the following:
   * **Name**: Any name that you want to be displayed in the interface.
   * **ID**: Intent ID that is the same as the filename in the `intents` folder.
   * **Grammar**: Grammar text that is the same as the contents of the file in the `intents` folder.

For more information about intents, see the [documentation for Alice's skills](https://yandex.ru/dev/dialogs/alice/doc/nlu-docpage/).

To complete the dialog creation, click **Publish** on the right of the page.

## Test the skill {#test-skill}

To debug the skill, use the **Testing** tab in the [Yandex Dialogs](https://dialogs.yandex.ru/developer) console or one of the [surfaces](https://yandex.ru/dev/dialogs/alice/doc/surfaces.html) you selected when designing the skill.

### In the console {#console-test}

Go to the **Testing** tab. You will see a chat with Alice on the left and an interaction protocol in JSON format on the right.

Below is a sample dialog:

```text
Let me help you with your lists!

	Hi Alice, Create a Grocery list.

Done, I've created the "grocery" list.

	Add milk to the Grocery.

Done, I've added "milk" to the "grocery".

	Add bread.

What list should I add "bread" to?

	Products

Done, I've added "bread" to the "grocery".

	Add eggs.

What list should I add "eggs" to?

	Products

Done, I've added "eggs" to the "grocery".

	Alice, tell me what's on the Grocery list.

Grocery:
1. milk
2. bread
3. eggs
```

### Using a surface {#device-test}

To start a dialog, use any device or service supported by [Alice](https://yandex.ru/alice).

### On the website {#site-test}

In your browser, follow the URL specified in the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field of your API gateway and log in. The **My lists** page opens. In any of the lists, you can add or remove items and grant other users access to the list.