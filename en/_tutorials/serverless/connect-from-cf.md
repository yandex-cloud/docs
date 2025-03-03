Create a [function](../../functions/concepts/function.md) with a [Python](https://python.org/) application that runs a simple query against a [{{ ydb-full-name }}](../../ydb/) database.

A function with an associated [service account](../../iam/concepts/users/service-accounts.md) is authorized in {{ ydb-short-name }} via the metadata service.

The application creates a {{ ydb-short-name }} database connection driver, a session, and a transaction, and runs a query using the `ydb` library. This library is installed as a [dependency](../../functions/lang/python/dependencies.md) when creating a function version. The DB connection parameters are passed to the application via environment variables.

To create a function and connect to the database:
1. [Get your cloud ready](#before-begin).
1. [Create a service account](#create-sa).
1. [Create a {{ ydb-short-name }} database](#create-database).
1. [Create a function](#create-function).
1. [Test the function](#test-function).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for this scenario includes:
* Fee for using the function (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for running queries to the database (see [{{ ydb-name }} pricing](../../ydb/pricing/serverless.md)).

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your service account.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account, e.g., `sa-function`. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `{{ roles-editor }}`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

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

     Wait for the DB to start. While being created, the database will have the `Provisioning` status. Once it is ready for use, its status will change to `Running`.
  1. Click the name of the database you created.
  1. Under **{{ ui-key.yacloud.ydb.overview.section_connection }}**, find the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field and save its value. You will need it at the next step.

{% endlist %}

## Create a function {#create-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [Management console]({{ link-console-main }}), select the folder you want to create a function in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter a name and description for the function. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**, select `Python` as the runtime environment, disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**, create a file named `index.py` and paste the following code into it:

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

  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**, create a file named `requirements.txt` and paste the following text into it:

     ```txt
     ydb
     ```

  1. Specify the entry point: `index.handler`.
  1. Select a service account, e.g., `sa-function`.
  1. Configure the environment variables:
     * `YDB_ENDPOINT`: Enter the first part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`), e.g., `{{ ydb.ep-serverless }}`.
     * `YDB_DATABASE`: Enter the second part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Test the function {#test-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** and check out the testing results.

     If a DB connection is established and a query is executed, the function status will change to `Done` and its output will contain the following text:

     ```json
     {
       "statusCode": 200,
       "body": "True"
     }
     ```

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the DB](../../ydb/operations/manage-databases.md#delete-db).
1. [Delete the function](../../functions/operations/function/function-delete.md).