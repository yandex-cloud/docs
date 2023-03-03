{% note info %}

This guide is intended for Linux users. On Windows, you can follow its steps in [WSL]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows/wsl/about){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows/wsl/about){% endif %}.

{% endnote %}

You will create a [function](../functions/concepts/function.md) and a [Node.js app]{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-sdk/example/example-nodejs){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-sdk/example/example-nodejs){% endif %} that will make small queries to a {{ ydb-short-name }} database. You deploy the application using Bash scripts and use the `tcs` command to compile.

A function with an associated [service account](../iam/concepts/users/service-accounts.md) is authorized in {{ ydb-short-name }} via the metadata service.

The application creates a {{ ydb-short-name }} database connection driver, a session, and a transaction, and runs a query using the `ydb` library. This library is installed as a [dependency](../functions/lang/nodejs/dependencies.md) when creating a function version. The DB connection parameters are passed to the application via environment variables.

To set up a connection to the {{ ydb-short-name }} database:

1. [Before you start](#before-begin).
1. [Prepare the environment](#prepare-environment).
1. [Create a service account](#create-sa).
1. [Create an authorized key](#create-key).
1. [Create a {{ ydb-short-name }} database](#create-database).
1. [Create a function](#create-function).
1. [Test the function](#test-function).

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The infrastructure support cost for this scenario includes:

* A fee for using the function (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* A fee for querying the database (see [{{ ydb-full-name }} pricing]{% if audience == "external" %}(../ydb/pricing/serverless.md){% else %}(https://cloud.yandex.com/en/docs/ydb/pricing/serverless){% endif %}).

{% endif %}

## Prepare the environment {#prepare-environment}

1. Clone the [examples repository](https://github.com/ydb-platform/ydb-nodejs-sdk/tree/main/examples/basic-example-v1) using Git:

   ```
   git clone https://github.com/ydb-platform/ydb-nodejs-sdk.git
   ```

1. In the repository, go to the folder with the project files: `examples/basic-example-v1`.
1. Install and initialize the [{{ yandex-cloud }} CLI](../cli/quickstart.md).
1. Install the [jq](https://stedolan.github.io/jq/download/) utility. In the root of the folder with the project files, start the terminal and run the command:

   ```bash
   sudo apt-get install jq
   ```

1. Install [Node.js](https://nodejs.org/en/download/package-manager/) by running the command below:

   ```
   curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - \
   sudo apt-get install -y nodejs
   ```

1. Install dependencies by running the command below:

   ```
   npm install
   ```

## Create a service account {#create-sa}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
   1. Go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. Enter the service account name: `sa-function`.
   1. Click **Add role** and choose the `editor role`.
   1. Click **Create**.

- CLI

   Run the command:

   ```bash
   yc iam service-account create --name sa-function
   ```

   For more information about the `yc iam service-account create` command, see the [CLI reference](../cli/cli-ref/managed-services/iam/service-account/create.md).

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the service account parameters:

      ```
      resource "yandex_iam_service_account" "sa" {
        name = "sa-function"
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iam_service_account).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

- API

   To create a service account, use the [create](../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../iam/api-ref/ServiceAccount/index.md) resource.

{% endlist %}

## Create an authorized key {#create-key}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose the `sa-function` service account and click the line with its name.
   1. Click **Create new key** in the top panel.
   1. Click **Create authorized key**.
   1. Select the encryption algorithm.
   1. Enter a description of the key so that you can easily find it in the management console.
   1. Save public and private keys to the `service_account_key_file.json` file:

      ```json
      {
         "service_account_id": "<sa-function service account ID>",
         "key_algorithm": "RSA_2048",
         "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
         "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
      }
      ```

- CLI

   Run the command:

   ```bash
   yc iam key create --service-account-name sa-function -o service_account_key_file.json
   ```

   For more information about the `yc iam key create` command, see the [CLI reference](../cli/cli-ref/managed-services/iam/key/create.md).

   If successful, a private key (`privateKey`) and public key ID (`id`) will be written to the `service_account_key_file.json` file.

- {{ TF }}

   1. In the configuration file, describe the key parameters:

      ```
      resource "yandex_iam_service_account_key" "sa-auth-key" {
        service_account_id = "<sa-function service account ID>"
        key_algorithm      = "RSA_2048"
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_key).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

- API

   To create an access key, use the [create](../iam/api-ref/Key/create.md) method for the [Key](../iam/api-ref/Key/index.md) resource.

{% endlist %}

## Create a {{ ydb-short-name }} database {#create-database}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a database.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter a name for the database. Naming requirements:

      {% include [name-format](../_includes/name-format.md) %}

   1. Under **Database type**, select the **Serverless** option.
   1. Click **Create database**.

      Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it's ready for use, the status changes to `Running`.

   1. Click on the name of the created database.
   1. Save the **Endpoint** and **Database** field values under **Connection**. You'll need them in the next step.

{% endlist %}

## Create a function {#create-function}

{% note info %}

Before creating a function, make sure the `.env` file and the `create-func.sh` and `create-func-ver.sh` files from the `deploy` folder have the `LF` (Line Feed) character set.

{% endnote %}

1. Edit the `.env` file:

   * `ENDPOINT`: String in <protocol>://<**Endpoint** field value under **Connection**> format. For example, if the protocol is `grpcs` and the endpoint is `{{ ydb.host-serverless }}:{{ ydb.port-serverless }}`, enter `{{ ydb.ep-serverless }}`.
   * `DATABASE`: Value of the **Database** field under **Connection**.
   * `FUNCTION_NAME`: `func-test-ydb`.
   * `FOLDER_ID`: ID of the folder.
   * `SERVICE_ACCOUNT_ID`: ID of the `sa-function` service account.

1. Start the command line in the project root and run the command:

   ```bash
   ./deploy/create-func.sh
   ```

   This script creates a new function in your folder and makes it public.

1. Create the function version:

   ```bash
   ./deploy/create-func-ver.sh
   ```

## Test the function {#test-function}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the function is located.
   1. In the list of services, select **{{ sf-name }}**.
   1. Select the `func-test-ydb` function.
   1. Go to the **Overview** tab.
   1. Under **General information**, click the function call link.
   1. In the browser address bar, add the `api_key` parameter to the link, such as `?api_key=b95`.
   1. If a connection to the DB is successful, a table named `b95` is created and a single record is added to it. A message in JSON format appears on the page, such as:

      ```json
      {
         "info": "b95 table created, one record inserted"
      }
      ```

{% endlist %}

## How to delete created resources {#clear-out}

To stop paying for the resources created:

* [Delete the database](../ydb/operations/manage-databases.md#delete-db).
* [Delete the function](../functions/operations/function/function-delete.md).
