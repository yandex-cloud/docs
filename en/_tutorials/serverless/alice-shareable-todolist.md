# Developing a skill for Alice and a website with authorization

In this scenario, you'll develop a skill for Alice and deploy a web app for creating, reading and editing to-do lists with Alice's help, as well as for sharing the lists with other users on the website.

{% if lang == "ru" %}

@[youtube](PMWMDTBKFAc)

{% endif %}

To deploy a project:

1. [Prepare the environment](#prepare)
1. [Create resources](#create-resources)
1. [Set the project variables](#set-variables)
1. [Deploy the project](#deploy)
1. [Register Alice's skill](#register-skill)
1. [Test Alice's skill](#test-skill)

## Prepare the environment {#prepare}

1. [Download the archive](https://storage.yandexcloud.net/doc-files/alice-shareable-todolist.zip) with project files or clone the [examples repository](https://github.com/yandex-cloud/examples/tree/master/serverless/alice-shareable-todolist) using Git.

1. [Create a folder](../../resource-manager/operations/folder/create.md) if you don't have any. For convenience, you can use a separate folder named `alice-skill`.

1. Install and initialize the following software programs:
    * [Yandex Cloud CLI](../../cli/quickstart.md).
    * [{{ ydb-short-name }} CLI](https://ydb.tech/en/docs/getting_started/cli);
    * [Bash command interpreter](http://www.gnu.org/software/bash/).
    * [AWS CLI](../../storage/tools/aws-cli).
    * [jq](https://stedolan.github.io/jq/download/).
    * [Node.js](https://nodejs.org/en/download/package-manager/).
    * [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).

1. To finalize the project, you'll additionally need:
    * [The Go programming language](https://go.dev/).
    * The [go-swagger](https://goswagger.io/) utility.
    * The [api-spec-converter](https://www.npmjs.com/package/api-spec-converter) utility.

## Create resources {#create-resources}

1. [Create a bucket](../../storage/operations/buckets/create) named `frontend-statics` in {{ objstorage-name }}.

1. [Create an API gateway](../../api-gateway/operations/api-gw-create) named `gate-1`. Save the **ID** and **Service domain** field values from the **General information** section to use them in the configuration.

1. {% if product == "yandex-cloud" %}[Create a database](../../ydb/quickstart.md#serverless){% endif %}{% if product == "cloud-il" %}Create a database{% endif %} in Serverless mode. Save the **Database** and **Endpoint** field values from the **YDB endpoint** section to use them in the configuration.

1. [Create an app]{% if lang == "ru" %}(https://oauth.yandex.ru/){% endif %}{% if lang == "en" %}(https://oauth.yandex.com/){% endif %} in Yandex.OAuth:

    1. Go to the [service website]{% if lang == "ru" %}(https://oauth.yandex.ru/){% endif %}{% if lang == "en" %}(https://oauth.yandex.com/){% endif %} and log in.

    1. Click **Create new client**:

    1. Select the desired name for the client app and upload an icon.

    1. Under **Platforms**, select **Web services**. Specify two Callback URIs:
        * `https://social.yandex.net/broker/redirect`.
        * `https://<API gateway service domain>/receive-token`.

        Please note that the specified `receive-token` URL may be unavailable until the current specification is uploaded to the API gateway. The specification will be uploaded during the project's deployment.

    1. Under **Permissions**, expand **Yandex ID API (login)** and select **Access to user avatar (login:avatar)**.

    For more information about the Yandex.OAuth features, see the [documentation]{% if lang == "ru" %}(https://yandex.ru/dev/oauth/doc/dg/tasks/register-client.html){% endif %}{% if lang == "en" %}(https://yandex.com/dev/oauth/doc/dg/tasks/register-client.html){% endif %}.

## Set the project variables {#set-variables}

Configure the project using the values you got when creating your resources.

### Create a variables.json file {#set-variables-variables}

The `variables.json` file contains the project deployment configuration. To create a file from the `variables-template.json` template, go to the project folder and run the command:

```
cp variables-template.json variables.json
```

Set the project parameters in the `variables.json` file:

* `folder-id`: ID of the cloud folder.
* `domain`: API gateway service domain.
* `oauth-client-id`: ID of the client app registered in [Yandex.OAuth]{% if lang == "ru" %}(https://oauth.yandex.ru/){% endif %}{% if lang == "en" %}(https://oauth.yandex.com/){% endif %}.
* `database`: DB from the {{ ydb-name }} configuration.
* `database-endpoint`: Endpoint from the {{ ydb-name }} configuration.
* `yc-profile`: Yandex Cloud CLI [profile name](../../cli/operations/profile/profile-list.md).
* `secure-config-path`: Path to the secret file.
* `storage-bucket`: Name of the bucket you created for storing static data, `frontend-statics`.
* `gateway-id`: ID of the API gateway.

### Create a secure-config.json file {#set-variables-secure-config}

The `secure-config.json` file contains secrets. You can create it from the `secure-config-template.json` template. To do this, run the command:

```
cp secure-config-template.json secure-config.json
```

Substitute the values from the variables:

* `oauth_secret`: Password of the client app registered in [Yandex.OAuth]{% if lang == "ru" %}(https://oauth.yandex.ru/){% endif %}{% if lang == "en" %}(https://oauth.yandex.com/){% endif %}.
* `hash`: A random 64-byte string that is base64 encoded, such as `qrJagO5NVwOj0FeTmgYSwUN+XXkiQJMWifvrklF53wT55q80Xk8vmEB3kxhtpDnA1WDC893Z9Bh6QcqKLbAUWQ==`.
* `block`: A random 32-byte string that is base64 encoded, such as `uwk0duFgn2nYyfu2VzJe+MnWKWQrfKaiZijIzGZ8fqQ=`.

You can generate random values at [generate.plus](https://generate.plus/en/base64).

Make sure the `variables.json` file contains the correct path to `secure-config.json`.

## Deploy the project {#deploy}

Transfer the project files to {{ yandex-cloud }} and update the configuration.

### Apply a data schema {#deploy-schema}

To create tables in the database, run the command:

```
./upload_ydb_schema.sh
```

### Upload the backend code to {{ sf-name }} {#deploy-backend}

Use {{ TF }} to automate your operations. Before you start, [initialize it](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

To do this, go to the folder with the app.tf config file and run the command:

```
terraform init
```

Once {{ TF }} is initialized, run the command passing the [OAuth token](../../iam/concepts/authorization/oauth-token) value to be used for authorization in {{ yandex-cloud }}:

```
terraform apply -var-file ./variables.json -var yc-token=<OAuth token>
```

As a result, {{ TF }} automatically creates or updates the required resources.

### Upload the frontend code to {{ objstorage-name }} {#deploy-frontend}

To deploy the frontend web app, compile static files and upload them to {{ objstorage-name }}.

1. Before doing that, make sure you have Node.js and the npm package manager installed.

1. Go to the `frontend` subfolder and perform the compilation:

    ```
    npm run build
    ```

    Result:

    ```
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

    ```
    ./upload_static.sh
    ```

    Result:

    ```
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

```
./update_gateway.sh
```

Result:

```
done (2s)
id: d5dc6k34opmskp7ela3d
folder_id: b1guj13dic1461knkpbw
created_at: "2021-06-03T11:18:00.379Z"
name: gate-1
status: ACTIVE
domain: d5dc6k87opmskp7elb3q.apigw.yandexcloud.net
log_group_id: ckg57bweoekkrkddsknd
```

## Register Alice's skill {#register-skill}

### Create a dialog {#create-dialog}

1. Go to the [Yandex.Dialogs](https://dialogs.yandex.ru/) website and log in to the console.
1. Click **Create dialog** and select the **Alice skill** dialog type.
1. In the **Skill name** field, set **To-do lists**.
1. Under **Backend**, select **{{ yandex-cloud }} function** and choose the `todo-list-alice` function that you previously created in Yandex Cloud Functions from the list.
1. Enable **Use data storage in the skill**.

Set the other parameters as you wish. For example, you can specify different word forms to activate the skill and choose a voice or skill access type.
Learn more in the Yandex.Dialogs [documentation](https://yandex.ru/dev/dialogs/alice/doc/publish.html).

### Configure authorization on the Alice page {#configure-authorization}

1. Go to the **Main settings** tab and find the **Account linking** section.
1. In the **Authorization** line, click **Create**.
1. Enter the following:
    * **ID** and **Application secret**: The ID and password you got when you registered the app on the [Yandex.OAuth]{% if lang == "ru" %}(https://oauth.yandex.ru/){% endif %}{% if lang == "en" %}(https://oauth.yandex.com/){% endif %} website.
    * **Authorization URL**: {% if lang == "ru" %}`https://oauth.yandex.ru/authorize`{% endif %}{% if lang == "en" %}`https://oauth.yandex.com/authorize`{% endif %}.
    * **Get token URL**: {% if lang == "ru" %}`https://oauth.yandex.ru/token`{% endif %}{% if lang == "en" %}`https://oauth.yandex.com/token`{% endif %}.
    * **Refresh token URL**: {% if lang == "ru" %}`https://oauth.yandex.ru/token`{% endif %}{% if lang == "en" %}`https://oauth.yandex.com/token`{% endif %}.

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

To debug the skill, use the **Testing** tab in the [Yandex.Dialogs](https://dialogs.yandex.ru/developer) console or one of the [surfaces](https://yandex.ru/dev/dialogs/alice/doc/surfaces.html) you selected when designing the skill.

### In the console {#console-test}

Go to the **Testing** tab. You'll see a chat with Alice on the left and an interaction protocol in JSON format on the right.

Below is a sample dialog:

```
Let me help you with your lists!

	Hi Alice, Create a Grocery list.

Done, I've created the "grocery" list.

	Add milk to the Grocery.

Done, I've added "milk" to the "grocery".

	Add bread.

What list should I add "bread" to?

	Grocery.

Done, I've added "bread" to the "grocery".

	Add eggs.

What list should I add "eggs" to?

	Grocery.

Done, I've added "eggs" to the "grocery".

	Alice, tell me what's on the Grocery list.

Grocery:
1. Milk.
2. Bread.
3. Eggs.
```

### Using a surface {#device-test}

To start a dialog, use any device or service supported by [Alice](https://yandex.ru/alice).

### On the website {#site-test}

In your browser, follow the URL specified in the **Service domain** field of your API gateway and log in. The "My lists" page opens. In any of the lists, you can add or remove items and grant other users access to the list.

