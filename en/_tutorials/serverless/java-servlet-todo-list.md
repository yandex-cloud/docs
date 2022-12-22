Learn how to use serverless technologies and the Java Servlet API to create a simple web application for managing a task list.

To create a web application:
1. [Before you start](#before-begin).
1. [Prepare the environment](#preare).
1. [Create a {{ objstorage-full-name }} bucket](#create-bucket).
1. [Create a {{ ydb-short-name }} database](#create-db).
1. [Create functions {{ sf-full-name }}](#create-functions).
1. [Create an API gateway](#create-api-gw).
1. [Test your application](#test).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources to support a web application includes:
* A fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* A fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* A fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).


## Prepare the environment {#prepare}

1. [Download](https://storage.yandexcloud.net/doc-files/servlet.zip) the archive with project files.
1. [Create](../../iam/operations/sa/create.md#create-sa) a service account and [assign](../../iam/operations/roles/grant.md#access-to-sa) it the `viewer` and `editor` roles for your folder.

## Create a {{ objstorage-name }} bucket {#create-bucket}

Create a [bucket](../../storage/concepts/bucket.md) and upload `index.html` there:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. Select **{{ objstorage-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Enter the bucket name, following the [naming guidelines](../../storage/concepts/bucket.md#naming).
      1. If necessary, limit the maximum bucket size.
      1. Select the type of [access](../../storage/concepts/bucket.md#bucket-access).
      1. Select the default [storage class](../../storage/concepts/storage-class.md).
      1. Click **Create bucket** to complete the operation.
   1. Select the created bucket.
   1. Click **Upload**.
   1. In the window that opens, in the project folder, select the `src/main/resources/index.html` file and click **Open**.
   1. Select the [storage class](../../storage/concepts/storage-class.md) for the file and click **Upload**.

{% endlist %}

## Create a {{ ydb-name }} database {#create-db}

1. Create a database in [Serverless mode](../../ydb/concepts/serverless-and-dedicated.md#serverless):

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the bucket.
      1. Select **{{ ydb-name }}**.
      1. Click **Create database**.
      1. Enter the database **Name**. Naming requirements:

         {% include [name-format](../../_includes/name-format.md) %}

      1. Under **Database type**, select **Serverless**.
      1. Click **Create database**.
      1. Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it's ready for use, the status changes to `Running`.
      1. Select the database created.
      1. Under **Connection**, find the **Endpoint** and **Database location** fields and save their values. You'll need them when creating functions.

   {% endlist %}

1. Create a table named `Tasks`:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the database.
      1. Select **{{ ydb-name }}**.
      1. Select a database on the **Databases** page.
      1. To open the DB root directory, go to the **Navigation** tab.
      1. To make a query to the database, click **SQL query** in the upper-right corner. The **Query** page opens.
      1. In the **Query** field, enter:

         ```sql
         CREATE TABLE Tasks (
           TaskId Utf8,
           Name Utf8,
           Description Utf8,
           CreatedAt Datetime,
           PRIMARY KEY (TaskId)
         );
         ```

      1. Click **Run**.

   - CLI

      Run the query:

      ```bash
      ydb -e grpcs://<YDB endpoint> -d <database> \
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

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you created the bucket and database.
   1. Select **{{ sf-name }}**.
   1. Click **Create function**.
   1. Enter the name `add-task` and a function description.
   1. Click **Create**.
   1. Under **Editor**, select the **Java 11** runtime environment and click **Continue**.
   1. Prepare the function code. For this, in the **Method** field, select **ZIP archive**, and specify the path to the downloaded `servlet.zip` archive, then click **Open**.
   1. In the **Entry point** field, enter `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
   1. In the **Timeout, sec** field, enter `5`.
   1. In the **Service account** field, enter the account that you created when [preparing the environment](#prepare).
   1. Add environment variables:
      * `ENDPOINT`: Enter the name of the **Endpoint** field that you saved when [creating the {{ ydb-short-name }} database](#create-db).
      * `DATABASE`: Enter the value from the **Database location** field that you also saved when [creating your {{ ydb-short-name }} database](#create-db).
   1. Click **Create version**.
   1. Repeat steps 3–12 and create a function named `list-tasks` with the entry point `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
   1. Repeat steps 3–12 and create a function named `delete-task` with the entry point `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- CLI

   1. Create a function named `add-task`:

      ```bash
      yc serverless function create --name=add-task
      ```

      Result:

      ```bash
      id: d4ejb1799eko6re4omb1
      folder_id: aoek49ghmknnpj1ll45e
      created_at: "2021-03-08T14:07:32.134Z"
      name: add-task
      log_group_id: eolm8aoq9vcppsieej6h
      http_invoke_url: https://functions.yandexcloud.net/d4ejb1799eko6re4omb1
      status: ACTIVE
      ```

   1. Create a version of the `add-task` function:

      ```bash
      yc serverless function version create \
        --function-name=add-task \
        --runtime java11 \
        --entrypoint yandex.cloud.examples.serverless.todo.AddTaskServlet \
        --memory 128m \
        --execution-timeout 5s \
        --source-path ./servlet.zip \
        --environment DATABASE=<database>,ENDPOINT=<YDB endpoint>
      ```

      Where:
      * `function-name`: The name of the function you want to create a version of.
      * `runtime`: The runtime environment.
      * `entrypoint`: The entry point specified in the \<function file name>.\<handler name> format.
      * `memory`: The amount of RAM.
      * `execution-timeout`: The maximum function execution time before the timeout is reached.
      * `source-path`: ZIP archive with the function code and required dependencies.
      * `environment`: Environment variables in key=value format.

      Result:

      ```bash
      done (1s)
      id: d4evvn8obisajd51plaq
      function_id: d4ejb1799eko6re4omb1
      ...
      tags:
      - $latest
      log_group_id: ckg3qh8h363p40gmr9gn
      ```

   1. Repeat steps 1–2 and create a function named `list-tasks` with the entry point `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
   1. Repeat steps 1–2 and create a function named `delete-task` with the entry point `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- API

   Use the [create](../../functions/functions/api-ref/Function/create) and the [createVersion](../../functions/functions/api-ref/Function/createVersion) API methods.

- {{ yandex-cloud }} Toolkit

   You can create a function and its version using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Create an API gateway {#create-api-gw}

To ensure interaction between services, create an API gateway:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you created your bucket, database, and functions.
   1. Select **{{ api-gw-name }}**.
   1. Click **Create API gateway**.
   1. Enter a name and description of the gateway.
   1. In the **Specification** field, add the specification:

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
              service_account: <service account>
            operationId: static
        /add:
           post:
             x-yc-apigateway-integration:
               type: cloud-functions
               function_id: <add-task ID>
             operationId: addTask
        /list:
          get:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <list-tasks ID>
            operationId: listTasks
        /delete:
          delete:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <delete-task ID>
            operationId: deleteTask
      ```

      Where:
      * `bucket`: Name of the bucket containing `index.html`.
      * `service_account`: ID of the service account created when [preparing the environment](#prepare).
      * `/add` section, `function_id` parameter: ID of the `add-task` function.
      * `/list` section, `function_id` parameter: ID of the `list-tasks` function.
      * `/delete` section, `function_id` parameter: ID of the `delete-task` function.
   1. Click **Create**.

- CLI

   1. Save the following specification to `todo.yaml`:

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
              service_account: <service account>
            operationId: static
        /add:
          post:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <add-task ID>
            operationId: addTask
        /list:
          get:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <list-tasks ID>
            operationId: listTasks
        /delete:
          delete:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <delete-task ID>
            operationId: deleteTask
      ```

      Where:
      * `bucket`: Name of the bucket containing `index.html`.
      * `service_account`: ID of the service account created when [preparing the environment](#prepare).
      * `/add` section, `function_id` parameter: ID of the `add-task` function.
      * `/list` section, `function_id` parameter: ID of the `list-tasks` function.
      * `/delete` section, `function_id` parameter: ID of the `delete-task` function.

   1. Create an API gateway:

      ```bash
      yc serverless api-gateway create \
        --name todo-list \
        --spec=todo.yaml \
        --description "simple todo list"
      ```

      Result:

      ```bash
      done (41s)
      id: d5delqeel34qjjfcdj81
      folder_id: b1g86q4m5vej8lkljme5
      created_at: "2021-03-08T14:07:32.134Z"
      name: todo-list
      description: simple todo list
      status: ACTIVE
      domain: d5delqeel34qjjfcdj81.apigw.yandexcloud.net
      log_group_id: ckg2hdmevnvcngprqvqb
      ```

- {{ yandex-cloud }} Toolkit

   You can create an API gateway using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Test the application {#test}

To open the app, follow the link in the **Service domain** field of the created API gateway.

## How to delete created resources {#clear-out}

To stop paying for the resources created:
* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete the database](../../ydb/operations/manage-database.md#delete-db).
* [Delete the functions](../../functions/operations/function/function-delete.md).
* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).