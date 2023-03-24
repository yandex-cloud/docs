In this scenario, you'll create a [function](../functions/concepts/function.md) with an application in [Python](https://python.org/), which runs a simple query against a {{ ydb-full-name }} database.

A function with an associated [service account](../iam/concepts/users/service-accounts.md) is authorized in {{ ydb-short-name }} via the metadata service.

The application creates a {{ ydb-short-name }} database connection driver, a session, and a transaction, and runs a query using the `ydb` library. This library is installed as a [dependency](../functions/lang/python/dependencies.md) when creating a function version. The DB connection parameters are passed to the application via environment variables.

To create a function and connect to the database:
1. [Before you start](#before-begin).
1. [Create a service account](#create-sa).
1. [Create a {{ ydb-short-name }} database](#create-database).
1. [Create a function](#create-function).
1. [Test the function](#test-function).

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost for this scenario includes:
* A fee for using the function (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* A fee for making queries to the database (see [{{ ydb-name }} pricing](../ydb/pricing/serverless.md)).


## Create a service account {#create-sa}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
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

      Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it's ready for use, the status changes to `Running`.
   1. Click on the name of the created database.
   1. Under **{{ ydb-short-name }} endpoint**, find the **Endpoint** and **Database** fields and save their values. You'll need them in the next step.

{% endlist %}

## Create a function {#create-function}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create the function.
   1. In the list of services, select **{{ sf-name }}**.
   1. Click **Create function**.
   1. Enter a name and description for the function. Naming requirements:

      {% include [name-format](../_includes/name-format.md) %}

   1. Click **Create**.
   1. Under **Editor**, select the **Python** runtime environment and click **Continue**.
   1. Under **Function code**, clear the contents of the `index.py` file and paste the following code into it:

      ```python
      import os
      import ydb
      import ydb.iam

      # Create driver in global space.
      driver = ydb.Driver(
         endpoint=os.getenv('YDB_ENDPOINT'),
         database=os.getenv('YDB_DATABASE'),
         credentials=ydb.iam.MetadataUrlCredentials(),
      )

      # Wait for the driver to become active for requests.
      driver.wait(fail_fast=True, timeout=5)

      # Create the session pool instance to manage YDB sessions.
      pool = ydb.SessionPool(driver)

      def execute_query(session):
        # Create the transaction and execute query.
        return session.transaction().execute(
          'select 1 as cnt;',
          commit_tx=True,
          settings=ydb.BaseRequestSettings().with_timeout(3).with_operation_timeout(2)
        )

      def handler(event, context):
        # Execute query with the retry_operation helper.
        result = pool.retry_operation_sync(execute_query)
        return {
          'statusCode': 200,
          'body': str(result[0].rows[0].cnt == 1),
        }
      ```

   1. Under **Function code**, create a file named `requirements.txt` and paste the following text into it:

      ```txt
      ydb
      ```

   1. Specify the entry point: `index.handler`.
   1. Select a service account, such as `sa-function`.
   1. Configure the environment variables:
      * `YDB_ENDPOINT`: Enter a string like `<protocol>://<database endpoint>`.

         For example, if the protocol is `grpcs` and the endpoint is `{{ ydb.host-serverless }}:{{ ydb.port-serverless }}`, enter `{{ ydb.ep-serverless }}`.
      * `YDB_DATABASE`: Enter the previously saved **Database** field value. For example: `/{{ region-id }}/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e`.
   1. In the upper-right corner of the **Editor** section, click **Create version**.

{% endlist %}

## Test the function {#test-function}

{% list tabs %}

- Management console

   1. Go to the **Testing** tab.
   1. Click **Run test** and check out the testing results.

      If a DB connection is established and a query is executed, the function status changes to `Done` and its output contains the following text:

      ```json
      {
        "statusCode": 200,
        "body": "True"
      }
      ```

{% endlist %}

## How to delete created resources {#clear-out}

To stop paying for the resources created:
1. [Delete the database](../ydb/operations/manage-databases.md#delete-db).
1. [Delete the function](../functions/operations/function/function-delete.md).
