# Deploying a web application using the Java Servlet API


Learn how to use the serverless technology and Java Servlet API to create a simple web application for managing a to-do list.

To create a web app:

1. [Get your cloud ready](#before-begin).
1. [Set up your environment](#prepare).
1. [Create a {{ objstorage-full-name }} bucket](#create-bucket).
1. [Create a {{ ydb-short-name }}](#create-db).
1. [Create {{ sf-full-name }}](#create-functions).
1. [Create an API gateway](#create-api-gw).
1. [Test your application](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources for web application support includes:

* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* Fee for the number of function calls, computing resources allocated for the function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).

## Set up your environment {#prepare}

1. [Create](../../iam/operations/sa/create.md#create-sa) a service account and [assign](../../iam/operations/roles/grant.md#cloud-or-folder) it the following [roles](*roles) for your folder:

    * [`functions.functionInvoker`](../../functions/security/index.md#functions-functionInvoker)
    * [`storage.viewer`](../../storage/security/index.md#storage-viewer)
    * [`ydb.editor`](../../ydb/security/index.md#ydb-editor).
1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-serverless-servlet) with the project:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-serverless-servlet
    ```
1. Add the contents of the `yc-serverless-servlet` local repository you cloned to the `servlet.zip` archive. You will need this archive later to create functions in {{ sf-full-name }}.


## Create an {{ objstorage-full-name }} bucket {#create-bucket}

Create a [bucket](*bucket) and upload `index.html` to it:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**, and in the window that opens:

      1. Enter a bucket name consistent with the [naming conventions](*bucket_name).
      1. Limit the maximum bucket size, if required.
      1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
      1. Select the default [storage class](*storage_class).
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. Select the bucket you created.
  1. Click ![arrow-up-from-line](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** in the top-right corner of the page. In the project's folder, select `src/main/resources/index.html`.
  1. Select the storage class for the file and click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. To create a bucket, run this command, specifying a unique [bucket name](*bucket_name):

      ```bash
      yc storage bucket create \
        --name <bucket_name> \
        --default-storage-class standard
      ```

      Result:

      ```text
      name: sample-bucket
      folder_id: b1g5bhjofg7o********
      anonymous_access_flags: {}
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      created_at: "2026-06-01T04:44:30.688587Z"
      resource_id: e3eqmpmknkus********
      ```

      For more information about the `yc storage bucket create` command, see the [CLI reference](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

  1. To upload the `index.html` file to the bucket, run this command:

      ```bash
      yc storage s3api put-object \
        --bucket <bucket_name> \
        --key index.html \
        --body "<local_path_to_file>" \
        --content-type "text/html"
      ```

      Where:

      * `--bucket`: Name of the bucket you created earlier.
      * `--body`: Local path to `index.html` you pulled from the repository. Here is an example: `/Users/myuser/repositories/yc-serverless-servlet/src/main/resources/index.html`.

      Result:

      ```text
      etag: '"f38989ca9039c275f5f56840********"'
      request_id: 72d413fc********
      ```

      For more information about the `yc storage s3api put-object` command, see the [CLI reference](../../cli/cli-ref/storage/cli-ref/s3api/put-object.md).

{% endlist %}

## Create a {{ ydb-full-name }} database {#create-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. Create a database in [serverless mode](*ydb_modes):

      1. In the [management console]({{ link-console-main }}), select the folder where you created the bucket.
      1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
      1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
      1. Specify the database **[{{ ui-key.yacloud.ydb.forms.label_field_name }}](*name)**.
      1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
      1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
      1. Wait for the database to start. While being created, your database will have the `Provisioning` status. Once it is ready for use, its status will change to `Running`.
      1. Select the created database.
      1. Under **{{ ui-key.yacloud.ydb.overview.section_connection }}**, find the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field and save its value. You will need it later to create functions.
  1. Create a table named `Tasks`:

      1. To open the database root directory, in the left-hand menu, select ![folder](../../_assets/console-icons/folder.svg) **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
      1. To query your database, click **{{ ui-key.yacloud.ydb.browse.button_sql-query }}** in the top-right corner. On the **{{ ui-key.yacloud.ydb.sql.label_query }}** page that opens:

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
          1. Click ![triangle-right-fill](../../_assets/console-icons/triangle-right-fill.svg) **{{ ui-key.yacloud.ydb.sql.button_run }}**.

- CLI {#cli}

  1. Create a database in [serverless mode](../../ydb/concepts/serverless-and-dedicated.md#serverless), specifying its [name](*name) in this command:

      ```bash
      yc ydb database create <DB_name> \
        --serverless
      ```

      Result:

      ```text
      done (22s)
      id: etnm3b9gco6k********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-01T04:54:48Z"
      name: sample-database
      status: PROVISIONING
      endpoint: {{ ydb.ep-serverless }}/?database=/{{ region-id }}/b1gj9ja2h4ct********/etnm3b9gco6k********
      serverless_database:
        storage_size_limit: "53687091200"
      location_id: {{ region-id }}
      backup_config:
        backup_settings:
          - name: daily
            backup_schedule:
              daily_backup_schedule:
                execute_time:
                  hours: 17
            backup_time_to_live: 604800s
            type: SYSTEM
      document_api_endpoint: {{ ydb.document-api-endpoint }}/{{ region-id }}/b1gj9ja2h4ct********/etnm3b9gco6k********
      monitoring_config: {}
      ```

      Save the value of the `endpoint` field. You will need this name at the next steps.

      For more information about the `yc ydb database create` command, see the [CLI reference](../../cli/cli-ref/ydb/cli-ref/database/create.md).
  1. [Install]({{ ydb.docs }}reference/ydb-cli/install) the `YDB CLI` utility for managing YDB databases.
  1. Save the [IAM token](../../iam/concepts/authorization/iam-token.md) for authentication of queries via `YDB CLI` to the `IAM_TOKEN` environment variable:

        ```bash
        export IAM_TOKEN=$(yc iam create-token)
        ```
  1. Create a table named `Tasks`:

      ```bash
      ydb \
        --endpoint {{ ydb.ep-serverless }} \
        --database "/{{ region-id }}/b1gj9ja2h4ct********/etnjkrvloo7k********" \
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

      Where:

      * `--endpoint`: First part of the `endpoint` field value saved when creating the database (preceding `/?database=`), e.g., `{{ ydb.ep-serverless }}`.
      * `--database`: Second part of the `endpoint` field value (following `/?database=`). Here is an example: `/{{ region-id }}/b1gj9ja2h4ct********/etnjkrvloo7k********`.

{% endlist %}

## Create {{ sf-name }} {#create-functions}

Create a [function](*functions) for each servlet:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you created the bucket and the database.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Specify `add-task` for the function **{{ ui-key.yacloud.common.name }}** and, optionally, add a **{{ ui-key.yacloud.common.description }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**, select `{{ java-full-ver }}` as the runtime, disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Prepare the function code. To do this, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` in the **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** field.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** field, click **Attach file** and select `servlet.zip` you created earlier.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, enter `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
  1. Set **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** to `10`.
  1. In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, select the account you created when [setting up your environment](#prepare).
  1. Add these environment variables:
     * `ENDPOINT`: Enter the first part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value you saved when [creating a {{ ydb-short-name }} database](#create-db) (the one between `grpcs://` and `/?database=`), e.g., `{{ ydb.host-serverless }}:2135`.
     * `DATABASE`: Enter the second part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}** and wait for the function version to compile.
  1. On the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page that opens, enable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
  1. Repeat steps 3 through 14 to create a function named `list-tasks` with the `yandex.cloud.examples.serverless.todo.ListTasksServlet` entry point.
  1. Repeat steps 3 through 14 to create a function named `delete-task` with the `yandex.cloud.examples.serverless.todo.DeleteTaskServlet` entry point.

- CLI {#cli}

  1. Create a function named `add-task`:

      ```bash
      yc serverless function create \
        --name add-task
      ```

      Result:

      ```text
      id: d4e3reah34e0********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-01T05:07:13.071Z"
      name: add-task
      http_invoke_url: https://{{ sf-url }}/d4e3reah34e0********
      status: ACTIVE
      ```

      Save the `id` of your new function. You will need it later to create an API gateway.

      For more information about the `yc serverless function create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/function/create.md).
  1. Create a version of the `add-task` function:

      ```bash
      yc serverless function version create \
        --function-name add-task \
        --runtime {{ java-cli-ver }} \
        --service-account-id <service_account_ID> \
        --entrypoint "yandex.cloud.examples.serverless.todo.AddTaskServlet" \
        --memory 128m \
        --execution-timeout 10s \
        --source-path "./servlet.zip" \
        --environment ENDPOINT="<YDB_endpoint>",DATABASE="<DB_name>"
      ```

      Where:

      * `--function-name`: Name of the function whose version you want to create.
      * `--runtime`: Runtime.
      * `--service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the service account you created when [setting up your environment](#prepare).
      * `--entrypoint`: Entry point in `<function_file_name>.<handler_name>` format.
      * `--memory`: RAM amount available to the function.
      * `--execution-timeout`: Maximum function execution time before timeout.
      * `--source-path`: Local path to the previously created `servlet.zip` archive with the function code and required dependencies.
      * `--environment`: Environment variables in `key=value` format:

          * `ENDPOINT`: First part of the `endpoint` field value you saved when creating your database (the one between `grpcs://` and `/?database=`), e.g., `{{ ydb.host-serverless }}:2135`.
          * `DATABASE`: Second part of the `endpoint` field value (following `/?database=`). Here is an example: `/{{ region-id }}/b1gj9ja2h4ct********/etnjkrvloo7k********`.

      Result:

      ```text
      done (52s)
      id: d4eve0ahaf3e********
      function_id: d4e3reah34e0********
      created_at: "2026-06-01T05:18:34.900Z"
      ...
      log_options:
        folder_id: b1g5bhjofg7o********
      ```

      For more information about the `yc serverless function version create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/function/version/create.md).
  1. Make the function public:

      ```bash
      yc serverless function allow-unauthenticated-invoke add-task
      ```

      For more information about the `yc serverless function allow-unauthenticated-invoke` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/function/allow-unauthenticated-invoke.md).
  1. Repeat steps 1 through 3 to create a function named `list-tasks` with the `yandex.cloud.examples.serverless.todo.ListTasksServlet` entry point.
  1. Repeat steps 1 through 3 to create a function named `delete-task` with the `yandex.cloud.examples.serverless.todo.DeleteTaskServlet` entry point.

{% endlist %}

## Create an API gateway {#create-api-gw}

To enable interaction between services, create an [API gateway](*api_gw):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created your bucket, database, and functions.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. Specify the gateway **[{{ ui-key.yacloud.common.name }}](*name)** and, optionally, add a **{{ ui-key.yacloud.common.description }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, add this specification:

      {% include [api-gateway-spec](../_tutorials_includes/java-servlet-todo-list/api-gateway-spec.md) %}

        Where:

        * `bucket`: Name of the bucket to which you uploaded the `index.html` file.
        * `service_account_id`: [ID](../../iam/operations/sa/get-id.md) of the service account you created when [setting up your environment](#prepare).
        * `/add` section, `function_id` parameter: `add-task` function [ID](../../functions/operations/function/function-info.md).
        * `/list` section, `function_id` parameter: `list-tasks` function ID.
        * `/delete` section, `function_id` parameter: `delete-task` function ID.

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. In the list of API gateways that opens, click the one you created and save its URL (the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field value).

- CLI {#cli}

  1. Create a file named `todo.yaml` and save the following specification to it:

      {% include [api-gateway-spec](../_tutorials_includes/java-servlet-todo-list/api-gateway-spec.md) %}

      Where:

      * `bucket`: Name of the bucket to which you uploaded the `index.html` file.
      * `service_account_id`: [ID](../../iam/operations/sa/get-id.md) of the service account you created when [setting up your environment](#prepare).
      * `/add` section, `function_id` parameter: `add-task` function ID you saved earlier.
      * `/list` section, `function_id` parameter: `list-tasks` function ID you saved earlier.
      * `/delete` section, `function_id` parameter: `delete-task` function ID you saved earlier.
  1. Create your API gateway by specifying the local path to the `todo.yaml` file you created earlier in this command:

      ```bash
      yc serverless api-gateway create \
        --name todo-list \
        --spec "./todo.yaml" \
        --description "simple todo list"
      ```

      Result:

      ```text
      done (2s)
      id: d5d9ut8546r7********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-01T05:49:08.648Z"
      name: todo-list
      description: simple todo list
      status: ACTIVE
      domain: d5d9ut8546r7********.wnq2w1o5.apigw.yandexcloud.net
      connectivity: {}
      log_options:
        folder_id: b1g5bhjofg7o********
      execution_timeout: 300s
      ```

      Save the domain name (the `domain` field value) of your new API gateway. The gateway will be available at `https://<domain_name>`.

      For more information about the `yc serverless api-gateway create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/api-gateway/create.md).

{% endlist %}

## Test the application {#test}

To open the application, navigate to your new API gateway's URL in your browser. If everything is configured correctly, you will be able to create, view, and delete tasks in the application that opens.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the functions](../../functions/operations/function/function-delete.md).
* [Delete the database](../../ydb/operations/manage-databases.md#delete-db).
* [Delete](../../storage/operations/objects/delete.md) the `index.html` file, then [delete](../../storage/operations/buckets/delete.md) the bucket.

[*name]: {% include [name-format](../../_includes/_popups/name-format-general.md) %}

[*bucket_name]: The bucket name must be unique within {{ objstorage-full-name }}. For more information, see [{#T}](../../storage/concepts/bucket.md#naming).

[*storage_class]: {{ objstorage-full-name }} allows you to store objects in storages of various classes depending on how long you want to store your objects and how often you access them. For more information, see [{#T}](../../storage/concepts/storage-class.md).

[*ydb_modes]: `Serverless` {{ ydb-short-name }} databases require zero configuration, administration, load monitoring, or resource management from the user. For more information, see [{#T}](../../ydb/concepts/serverless-and-dedicated.md).

[*functions]: With {{ sf-full-name }} functions, you can place your code in {{ yandex-cloud }} and run on request or trigger. For more information, see [{#T}](../../functions/concepts/function.md).

[*bucket]: A bucket is a portion of {{ objstorage-full-name }} allocated for user data. For more information, see [{#T}](../../storage/concepts/bucket.md).

[*api_gw]: An API gateway is an interface for working with services on the internet or within {{ yandex-cloud }}, set in a declarative way using a specification. For more information, see [{#T}](../../api-gateway/concepts/index.md).

[*roles]: A role is a set of permissions that defines the allowed scope of operations with {{ yandex-cloud }} resources. For more information, see [{#T}](../../iam/concepts/access-control/roles.md).
