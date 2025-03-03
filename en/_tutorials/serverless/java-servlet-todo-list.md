

Learn how to use serverless technologies and the Java Servlet API to create a simple web application for managing a task list.

To create a web application:

1. [Get your cloud ready](#before-begin).
1. [Prepare the environment](#prepare).
1. [Create an {{ objstorage-full-name }} bucket](#create-bucket).
1. [Create a {{ ydb-short-name }} database](#create-db).
1. [Create functions {{ sf-full-name }}](#create-functions).
1. [Create an API gateway](#create-api-gw).
1. [Test your application](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources to support a web application includes:

* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* Fee for the number of function calls, computing resources allocated to a function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).


## Prepare the environment {#prepare}

1. [Create](../../iam/operations/sa/create.md#create-sa) a service account and [assign](../../iam/operations/roles/grant.md#cloud-or-folder) it the `{{ roles-editor }}` role for your folder.
1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-serverless-servlet) containing the project:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-serverless-servlet
    ```
1. Add the contents of the `yc-serverless-servlet` local repository you cloned to the `servlet.zip` archive. You will need this archive later to create {{ sf-full-name }} functions.


## Create an {{ objstorage-name }} bucket {#create-bucket}

Create a [bucket](../../storage/concepts/bucket.md) and upload `index.html` there:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. On the bucket creation page:
     1. Enter a name for the bucket according to the [naming requirements](../../storage/concepts/bucket.md#naming).
     1. Limit the maximum bucket size, if required.
     1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
     1. Select the default [storage class](../../storage/concepts/storage-class.md).
     1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.
  1. Select the created bucket.
  1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}** and select the `src/main/resources/index.html` file in the project folder.
  1. Select the [storage class](../../storage/concepts/storage-class.md) for the file and click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.

{% endlist %}

## Create a {{ ydb-name }} database {#create-db}

1. Create a database in [Serverless mode](../../ydb/concepts/serverless-and-dedicated.md#serverless):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the bucket.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
     1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
     1. Enter the database **{{ ui-key.yacloud.ydb.forms.label_field_name }}**. The naming requirements are as follows:

        {% include [name-format](../../_includes/name-format.md) %}

     1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
     1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
     1. Wait until the database starts. While being created, your database will have the `Provisioning` status. Once it is ready for use, its status will change to `Running`.
     1. Select the database created.
     1. Under **{{ ui-key.yacloud.ydb.overview.section_connection }}**, find the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field and save its value. You will need it when creating functions.

   {% endlist %}

1. Create a table named `Tasks`:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the database.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
     1. Select a database on the **{{ ui-key.yacloud.ydb.databases.label_title }}** page.
     1. To open the DB root directory, go to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
     1. To make a query to the database, click **{{ ui-key.yacloud.ydb.browse.button_sql-query }}** in the top-right corner. The **{{ ui-key.yacloud.ydb.sql.label_query }}** page opens.
     1. In the **{{ ui-key.yacloud.ydb.sql.label_query }}** field, enter:

        ```sql
        CREATE TABLE Tasks (
          TaskId Utf8,
          Name Utf8,
          Description Utf8,
          CreatedAt Datetime,
          PRIMARY KEY (TaskId)
        );
        ```

     1. Click **{{ ui-key.yacloud.ydb.sql.button_run }}**.

   - CLI {#cli}

     Run this request:

     ```bash
     ydb -e grpcs://<YDB_endpoint> -d <DB_name> \
     scripting yql -s \
     "CREATE TABLE Tasks
     (
       TaskId Utf8,
       Name Utf8,
       Description Utf8,
       CreatedAt Datetime,
       PRIMARY KEY (TaskId)
     );"
     ```

   {% endlist %}

## Create {{ sf-name }} functions {#create-functions}

Create a [function](../../functions/concepts/function.md) for each servlet:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you created the bucket and database.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter a name, e.g., `add-task`, and description for the function.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**, select the `java21` runtime environment, disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Prepare the function code. To do this, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` in the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** field, click **Attach file** and select the `servlet.zip` archive created earlier.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, enter `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
  1. Set **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** to `10`.
  1. In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, enter the account that you created when [preparing the environment](#prepare).
  1. Add these environment variables:
     * `ENDPOINT`: Enter the first part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value saved when [creating the {{ ydb-short-name }} database](#create-db) (the one between `grpcs://` and `/?database=`), e.g., `ydb.serverless.yandexcloud.net:2135`.
     * `DATABASE`: Enter the second part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value saved when [creating the {{ ydb-short-name }} database](#create-db) (the one following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. On the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page, enable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
  1. Repeat steps 3-14 and create a function named `list-tasks` with the `yandex.cloud.examples.serverless.todo.ListTasksServlet` entry point.
  1. Repeat steps 3-14 and create a function named `delete-task` with the `yandex.cloud.examples.serverless.todo.DeleteTaskServlet` entry point.

- CLI {#cli}

  1. Create a function named `add-task`:

     ```bash
     yc serverless function create --name=add-task
     ```

     Result:

     ```text
     id: d4ejb1799eko********
     folder_id: aoek49ghmknn********
     created_at: "2021-03-08T14:07:32.134Z"
     name: add-task
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://{{ sf-url }}/d4ejb1799eko********
     status: ACTIVE
     ```

  1. Create a version of the `add-task` function:

     ```bash
     yc serverless function version create \
       --function-name=add-task \
       --runtime java21 \
       --entrypoint yandex.cloud.examples.serverless.todo.AddTaskServlet \
       --memory 128m \
       --execution-timeout 10s \
       --source-path ./servlet.zip \
       --environment DATABASE=<DB_name>,ENDPOINT=<YDB_endpoint>
     ```

     Where:

     * `--function-name`: Name of the function whose version you want to create.
     * `--runtime`: Runtime environment.
     * `entrypoint`: Entry point in `<function_file_name>`.`<handler_name>` format.
     * `--memory`: Amount of RAM.
     * `--execution-timeout`: Maximum running time of the function until timeout.
     * `--source-path`: Path to the previously created `servlet.zip` archive with the function code and required dependencies.
     * `--environment`: Environment variables in `key=value` format.

     Result:

     ```text
     done (1s)
     id: d4evvn8obisa********
     function_id: d4ejb1799eko********
     ...
     tags:
     - $latest
     log_group_id: ckg3qh8h363p********
     ```

  1. Make the function public:

     ```bash
     yc serverless function allow-unauthenticated-invoke add-task
     ```

     Result:

     ```text
     done (1s)
     ```

  1. Repeat steps 1-3 and create a function named `list-tasks` with the `yandex.cloud.examples.serverless.todo.ListTasksServlet` entry point.
  1. Repeat steps 1-3 and create a function named `delete-task` with the `yandex.cloud.examples.serverless.todo.DeleteTaskServlet` entry point.

- API {#api}

  Use the [create](../../functions/functions/api-ref/Function/create), [createVersion](../../functions/functions/api-ref/Function/createVersion), and [setAccessBindings](../../functions/functions/api-ref/Function/setAccessBindings) API methods for the [Function](../../functions/functions/api-ref/Function) resource.

- {{ yandex-cloud }} Toolkit {#yc-toolkit}

  You can create a function and its version using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).

{% endlist %}

## Create an API gateway {#create-api-gw}

To ensure interaction between services, create an API gateway:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created your bucket, database, and functions.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. Enter a name and description of the gateway.
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, add the specification:

     ```yaml
     openapi: 3.0.0
     info:
       title: ToDo list
       version: 1.0.0
     paths:
       /:
         get:
           x-yc-apigateway-integration:
             type: object-storage
             bucket: <bucket>
             object: index.html
             presigned_redirect: false
             service_account: <service_account>
           operationId: static
       /add:
          post:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <add-task_ID>
            operationId: addTask
       /list:
         get:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <list-tasks_ID>
           operationId: listTasks
       /delete:
         delete:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <delete-task_ID>
           operationId: deleteTask
       ```

       Where:

       * `bucket`: Name of the bucket containing `index.html`.
       * `service_account`: ID of the service account you created when [preparing the environment](#prepare).
       * `/add` section, `function_id` parameter: `add-task` function ID.
       * `/list` section, `function_id` parameter: `list-tasks` function ID.
       * `/delete` section, `function_id` parameter: `delete-task` function ID.

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.

- CLI {#cli}

  1. Save the following specification to the `todo.yaml` file:

     ```yaml
     openapi: 3.0.0
     info:
       title: ToDo list
       version: 1.0.0
     paths:
       /:
         get:
           x-yc-apigateway-integration:
             type: object-storage
             bucket: <bucket>
             object: index.html
             presigned_redirect: false
             service_account: <service_account>
           operationId: static
       /add:
         post:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <add-task_ID>
           operationId: addTask
       /list:
         get:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <list-tasks_ID>
           operationId: listTasks
       /delete:
         delete:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <delete-task_ID>
           operationId: deleteTask
     ```

     Where:

     * `bucket`: Name of the bucket containing `index.html`.
     * `service_account`: ID of the service account you created when [preparing the environment](#prepare).
     * `/add` section, `function_id` parameter: `add-task` function ID.
     * `/list` section, `function_id` parameter: `list-tasks` function ID.
     * `/delete` section, `function_id` parameter: `delete-task` function ID.

  1. Create an API gateway:

     ```bash
     yc serverless api-gateway create \
       --name todo-list \
       --spec=todo.yaml \
       --description "simple todo list"
     ```

     Result:

     ```text
     done (41s)
     id: d5delqeel34q********
     folder_id: b1g86q4m5vej********
     created_at: "2021-03-08T14:07:32.134Z"
     name: todo-list
     description: simple todo list
     status: ACTIVE
     domain: {{ api-host-apigw }}
     log_group_id: ckg2hdmevnvc********
     ```

- {{ yandex-cloud }} Toolkit {#yc-toolkit}

  You can create an API gateway using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).

{% endlist %}

## Test the application {#test}

To open the app, follow the link in the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field of the created API gateway.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete the database](../../ydb/operations/manage-databases.md#delete-db).
* [Delete the functions](../../functions/operations/function/function-delete.md).
* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
