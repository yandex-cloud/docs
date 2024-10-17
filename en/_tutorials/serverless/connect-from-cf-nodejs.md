{% note info %}

This guide is intended for Linux users. On Windows, you can follow its steps in [WSL](https://docs.microsoft.com/en-us/windows/wsl/about).

{% endnote %}

You will create a [function](../../functions/concepts/function.md) and a [Node.js app](https://ydb.tech/docs/en/reference/ydb-sdk/example/example-nodejs) that will make small queries to a [{{ ydb-short-name }}](https://ydb.tech/) database. You will deploy the application using Bash scripts and use the `tcs` command to compile it.

A function with an associated [service account](../../iam/concepts/users/service-accounts.md) is authorized in {{ ydb-short-name }} via the metadata service.

The application creates a {{ ydb-short-name }} database connection driver, a session, and a transaction, and runs a query using the `ydb` library. This library is installed as a [dependency](../../functions/lang/nodejs/dependencies.md) when creating a [function version](../../functions/concepts/function.md#version). The DB connection parameters are passed to the application via environment variables.

To set up a connection to a {{ ydb-short-name }} database:
1. [Prepare your cloud](#before-begin).
1. [Prepare the environment](#prepare-environment).
1. [Create a service account](#create-sa).
1. [Create an authorized key](#create-key).
1. [Create a {{ ydb-short-name }} database](#create-database).
1. [Create a function](#create-function).
1. [Test the function](#test-function).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost for this scenario includes:
* Fee for using the function (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for querying the database (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).


## Prepare the environment {#prepare-environment}

1. Clone the [examples repository](https://github.com/yandex-cloud/examples/tree/master/serverless/functions/YDB-connect-from-serverless-function) using Git:

   ```bash
   git clone https://github.com/yandex-cloud/examples.git
   ```

1. Install and initialize the [{{ yandex-cloud }} CLI](../../cli/quickstart.md).
1. Go to the project root directory:

   ```bash
   cd ~/examples/serverless/functions/YDB-connect-from-serverless-function
   ```

   Make sure to run all further commands in this directory.
1. Install the [jq](https://stedolan.github.io/jq/download/) utility:

   ```bash
   sudo apt-get install jq
   ```

1. Install [Node.js](https://nodejs.org/en/download/package-manager/):

   ```bash
   curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - \
   sudo apt-get install -y nodejs
   ```

1. Install the dependencies:

   ```bash
   npm install
   ```

   Result:

   ```text
   up to date, audited 269 packages in 1s

   29 packages are looking for funding
      run `npm fund` for details

   found 0 vulnerabilities
   ```

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a service account.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter the service account name: `sa-function`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `{{ roles-editor }}`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

   1. [Create](../../iam/operations/sa/create.md#create-sa) a service account:

      ```bash
      yc iam service-account create --name sa-function
      ```

      Result:

      ```text
      id: aje028do8n9r********
      folder_id: b1g681qpemb4********
      created_at: "2023-08-23T06:24:49.759304161Z"
      name: sa-function
      ```

   1. [Assign](../../iam/operations/sa/set-access-bindings.md#assign-role-to-sa) the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```text
      ...1s...done (4s)
      effective_deltas:
      - action: ADD
         access_binding:
            role_id: viewer
            subject:
            id: aje028do8n9r********
            type: serviceAccount
      ```

   For more information about the commands, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/index.md).

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the service account parameters:

      ```hcl
      resource "yandex_iam_service_account" "sa" {
        name = "sa-function"
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account).
   1. Make sure the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

   To create a service account and assign it a [role](../../iam/concepts/access-control/roles.md), use the [create](../../iam/api-ref/ServiceAccount/create.md) and [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) methods for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource.

{% endlist %}

## Create an authorized key {#create-key}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Select the `sa-function` service account and click the row with its name.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
   1. Select the encryption algorithm.
   1. Enter a description for the [authorized key](../../iam/concepts/authorization/key.md) so you can easily find it in the management console.
   1. Save both the private and public parts of the authorized key to the `examples/serverless/functions/YDB-connect-from-serverless-function/service_account_key_file.json` file:

      ```json
      {
        "service_account_id": "<sa-function_service_account_ID>",
        "key_algorithm": "RSA_2048",
        "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
        "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
      }
      ```

- CLI {#cli}

   Run this command:

   ```bash
   yc iam key create --service-account-name sa-function -o service_account_key_file.json
   ```

   For more information about the `yc iam key create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/key/create.md).

   If successful, the private part of the authorized key (`privateKey`) and the ID of its public part (`id`) will be written to the `service_account_key_file.json` file.

- {{ TF }} {#tf}

   1. In the configuration file, describe the authorized key parameters:

      ```hcl
      resource "yandex_iam_service_account_key" "sa-auth-key" {
        service_account_id = "<sa-function_service_account_ID>"
        key_algorithm      = "RSA_2048"
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_key).
   1. Make sure the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

   To create an authorized access key, use the [create](../../iam/api-ref/Key/create.md) method for the [Key](../../iam/api-ref/Key/index.md) resource.

{% endlist %}

## Create a {{ ydb-short-name }} database {#create-database}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a database.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
   1. Name the database. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
   1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

      Wait for the DB to start. When a database is being created, it has the `Provisioning` status. Once it is ready for use, its status will change to `Running`.
   1. Click the name of the created database.
   1. Save the value of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field from the **{{ ui-key.yacloud.ydb.overview.section_connection }}** section. You will need it at the next step.

{% endlist %}

## Create a function {#create-function}

{% note info %}

Before creating a function, make sure the `.env` file and the `create-func.sh` and `create-func-ver.sh` files from the `deploy` directory have the `LF` (line feed) character set.

{% endnote %}

1. Go to the project root directory:

   ```bash
   cd ~/examples/serverless/functions/YDB-connect-from-serverless-function
   ```

1. Edit the `.env` file:
   * `ENDPOINT`: First part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`), e.g., `{{ ydb.ep-serverless }}`.
   * `DATABASE`: Second part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
   * `FUNCTION_NAME`: `func-test-ydb`.
   * `FOLDER_ID`: Folder ID.
   * `SERVICE_ACCOUNT_ID`: ID of the `sa-function` service account.

1. Create a function:

   ```bash
   ./deploy/create-func.sh
   ```

   This script creates a new function in your folder and makes it public.
1. Create a function version:

   ```bash
   ./deploy/create-func-ver.sh
   ```

   Result:

   ```text
   npx tsc --build tsconfig.json
   rm: couldn't delete '../build/func.zip': File or folder does not exist
   adding: queries/ (stored 0%)
   adding: queries/clients-table.js (deflated 57%)
   adding: queries/helpers.js.map (deflated 43%)
   adding: queries/helpers.js (deflated 48%)
   adding: queries/clients-table.js.map (deflated 59%)
   adding: index.js (deflated 49%)
   adding: index.js.map (deflated 56%)
   adding: database.js.map (deflated 62%)
   adding: index-local.js (deflated 42%)
   adding: package.json (deflated 55%)
   adding: database.js (deflated 60%)
   adding: index-local.js.map (deflated 43%)
   yc function version create func-test-ydb
   done (27s)
   id: abcd2d363b4b********
   function_id: efghm9el0ja9********
   created_at: "2023-08-15T07:41:07.591Z"
   runtime: nodejs16
   entrypoint: index.handler
   resources:
         memory: "268435456"
   execution_timeout: 5s
   service_account_id: hijk3hlu8gqe********
   image_size: "33497088"
   status: ACTIVE
   tags:
         - $latest
   log_group_id: lmnoivbe341g********
   environment:
         DATABASE: /{{ region-id }}/b1gia87mbaom********/etnilt3o6v9e********
         ENDPOINT: grpcs://ydb.serverless.yandexcloud.net:2135
   log_options:
         folder_id: pqrs81qpemb********
   ```

## Test the function {#test-function}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the function is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select the `func-test-ydb` function.
   1. Go to the **{{ ui-key.yacloud.common.overview }}** tab.
   1. In the **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** field, click the link.
   1. In your browser address bar, add the `api_key` parameter to the link, e.g., `?api_key=b95`:

      ```http request
      https://functions.yandexcloud.net/efghm9el0ja9********?api_key=b95
      ```

   1. If a connection to the DB is successful, a table named `b95` will be created and a single record will be added to it. A message in JSON format will appear on the page, e.g.:

      ```json
      {
        "info": "b95 table created, one record inserted"
      }
      ```

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the DB](../../ydb/operations/manage-databases.md#delete-db).
1. [Delete the function](../../functions/operations/function/function-delete.md).