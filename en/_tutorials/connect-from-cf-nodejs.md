In this scenario, you'll create a [function](../functions/concepts/function.md) with an application in [Node.js](https://nodejs.org/en/), which runs a simple query against a {{ ydb-short-name }} database. You deploy the application using Bash scripts and use the `tcs` command to compile.

A function with an associated [service account](../iam/concepts/users/service-accounts.md) is authorized in {{ ydb-short-name }} via the metadata service.

The application creates a {{ ydb-short-name }} database connection driver, a session, and a transaction, and runs a query using the `ydb` library. This library is installed as a [dependency](../functions/lang/nodejs/dependencies.md) when creating a function version. The DB connection parameters are passed to the application via environment variables.

## Before you start {#before-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost for this scenario includes:

* A fee for using the function (see [{{ sf-full-name }} pricing](../functions/pricing.md).
* A fee for querying the database (see [{{ ydb-full-name }} pricing](../ydb/pricing/serverless.md)).


## Prepare the environment {#prepare-environment}

1. Clone the [examples repository](https://github.com/yandex-cloud/examples/tree/master/serverless/functions/YDB-connect-from-serverless-function) using Git.
1. Install and initialize the following software programs:
    * [The {{ yandex-cloud }} command line interface](../cli/quickstart.md#install).
    * [jq](https://stedolan.github.io/jq/download/).
    * [Node.js](https://nodejs.org/en/download/package-manager/).
    * `npm` and `npx`.
1. Install dependencies by running the command below:
    ```
    npm install
    ```

## Create a service account {#create-sa}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
  1. Go to the **Service accounts** tab.
  1. Click **Create service account**.
  1. Enter a name for the service account, such as `sa-function`. Naming requirements:

      {% include [name-format](../_includes/name-format.md) %}

  1. Click **Add role** and choose the `editor` role.
  1. Click **Create**.

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

      Wait until the database starts. When a database is being created, it has the  `Provisioning` status. When it's ready for use, the status changes to `Running`.
  1. Click on the name of the created database.
  1. Save the values of the following fields:
      * **Endpoint** and **Database** from the **YDB endpoint** section.
      * **Endpoint** from the **Document API endpoint** section.

      You'll need them in the next step.

{% endlist %}

## Create a table in the database {#create-table}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder containing the database.
  1. In the list of services, select **{{ ydb-name }}**.
  1. Select the database.
  1. Go to the **Navigation** tab.
  1. In the top right-hand corner, click **Create**. Then, in the resulting menu, click **Table**.
  1. In the **Name** field, enter `series`. Fill in the remaining fields however you'd like.
  1. Click **Create table**.

{% endlist %}

## Create a function {#create-function}

1. Edit the `main.env` file:
    * `FUNCTION_NAME`: Function name.
    * `folder_id`: ID of the folder.
    * `SERVICE_ACCOUNT_ID`: Service account ID.
    * `DOCUMENT_API_ENDPOINT`: Value of the **Endpoint** field under **Document API endpoint**.
    * `DATABASENAME`: Value of the **Database** field under **YDB endpoint**.
    * `ENTRYPOINT`: String in the following format <protocol>://**Endpoint** field value under **YDB endpoint**>. For example, if the protocol is `grpcs` and the endpoint is `ydb.serverless.yandexcloud.net:2135`, enter `grpcs://ydb.serverless.yandexcloud.net:2135`.
    * `YDB_SDK_LOGLEVEL`: Logging level. Legal values: `fatal`, `error`, `warn`, `info`, `debug`, and `trace`.
1. Create a function:
    ```
    ./first-setup-func.sh
    ```
1. Create the function version:
    ```
    ./deploy.sh
    ```

## Test the function {#test-function}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder containing the function.
  1. In the list of services, select **{{ sf-name }}**.
  1. Select a function.
  1. Go to the **Browse** tab.
  1. Under **General information**, click on the call link.
  1. Once a successful connection to the database is established, the page will display a description of the `series` table fields in JSON format. For example:

      ```json
      {
        "driver": true,
        "tableDef": {
          "info": "Describe table  series",
          "columns": [
            {
              "name": "series_id",
              "type": 4
            },
            {
              "name": "title",
              "type": 4608
            },
            {
              "name": "series_info",
              "type": 4608
            },
            {
              "name": "release_date",
              "type": 48
            }
          ]
        }
      }
      ```

{% endlist %}