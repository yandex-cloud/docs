1. [Get your cloud ready](#before-begin).
1. [Set up hosting for the URL shortener page](#object-storage).
1. [Create a service account](#service-account).
1. [Create a database in {{ ydb-full-name }}](#ydb).
1. [Set up a function in {{ sf-full-name }}](#function).
1. [Publish your URL shortener via {{ api-gw-full-name }}](#api-gw).
1. [Test the URL shortener](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [serverless-paid-resources](../../_includes/serverless/serverless-url-shortener/paid-resources.md) %}

## Set up hosting for the URL shortener page {#object-storage}

To create a bucket, upload your URL shortener's HTML page to it, and configure it for static website hosting:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your working folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. On the bucket creation page:
     1. Enter a name for the bucket.

        {% note warning %}

        Bucket names are unique throughout {{ objstorage-name }}, which means you cannot create two buckets with the same name, even in different folders belonging to different clouds.

        {% endnote %}

     1. Set the maximum size to `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     1. Set object read access to `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
     1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.
  1. Copy the HTML code and paste it into `index.html`:

     {% cut "HTML code" %}

     {% include [serverless-index-html-config](../../_includes/serverless/serverless-url-shortener/html-config.md) %}

     {% endcut %}

  1. Click the name of the bucket you created.
  1. Click **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
  1. Specify the `index.html` file you set up earlier.
  1. Click **{{ ui-key.yacloud.storage.button_upload }}**.
  1. In the left-hand panel, select the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
  1. Select **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**.
  1. Specify the website's home page: `index.html`.
  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

{% endlist %}

## Create a service account {#service-account}

To create a service account to enable interaction between the shortener components:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name the [service account](../../iam/concepts/users/service-accounts.md): `serverless-shortener`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `editor`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Click the name of the service account you created.

     Save the service account ID, as you will need it later.

{% endlist %}

## Create a database in {{ ydb-name }} {#ydb}

To create a database in {{ ydb-name }} and configure it to store URLs:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to your working folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Enter the database name: `for-serverless-shortener`.
  1. Select **{{ ui-key.yacloud.ydb.forms.label_serverless-type }}** as the database type.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
  1. Wait for the database to start.

     While being created, your database will have the `Provisioning` status. Once it is ready for use, its status will change to `Running`.
  1. Click the database name.

     Save the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value, as you will need it later.
  1. In the left-hand panel, select the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
  1. Select **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** on the right side of the page.
  1. Configure the table:
     * **{{ ui-key.yacloud.ydb.table.form.field_name }}** tables: `links`.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: `{{ ui-key.yacloud.ydb.table.form.label_row-table }}`.
  1. Add columns:
     * Column name: `id`; data type: `Utf8`. Set **{{ ui-key.yacloud.ydb.table.form.column_primary-key }}**.
     * Column name: `link`; data type: `Utf8`.
  1. Click **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

{% endlist %}

## Set up a function in {{ sf-name }} {#function}

To create and set up a URL shortening function:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to your working folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter the name: `for-serverless-shortener`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. From the **Python** drop-down list, select the `python312` runtime environment.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Copy the function code and paste it into `index.py` under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**.

     {% cut "Function code" %}

     {% include [serverless-index-function-config](../../_includes/serverless/serverless-url-shortener/function-config.md) %}

     {% endcut %}

  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**, create a file named `requirements.txt` and paste the following text into it:

     {% include [serverless-requirements](../../_includes/serverless/serverless-url-shortener/requirements.md) %}

  1. Specify the entry point: `index.handler`.
  1. Set the timeout to `5`.
  1. Select the `serverless-shortener` service account.
  1. Add these environment variables:
     * `endpoint`: Enter the first part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`), e.g., `{{ ydb.ep-serverless }}`.
     * `database`: Enter the second part of the previously saved **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`), e.g., `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}**, enable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.

  Save the function ID, as you will need it later.

{% endlist %}

## Publish your URL shortener via {{ api-gw-name }} {#api-gw}

To publish your URL shortener via {{ api-gw-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to your working folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter `for-serverless-shortener`.
  1. Copy and paste the following code under **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**:

     {% cut "API gateway specification" %}

     ```yaml
     openapi: 3.0.0
     info:
       title: for-serverless-shortener
       version: 1.0.0
     paths:
       /:
         get:
           x-yc-apigateway-integration:
             type: object_storage
             bucket: <bucket_name>#<-- bucket name
             object: index.html # <-- HTML file name
             presigned_redirect: false
             service_account: <service_account_id> # <-- service_account_ID
           operationId: static
       /shorten:
         post:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <function_id> # <-- function ID
           operationId: shorten
       /r/{id}:
         get:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <function_id> # <-- function ID
           operationId: redirect
           parameters:
           - description: id of the url
             explode: false
             in: path
             name: id
             required: true
             schema:
               type: string
             style: simple
     ```

     {% endcut %}

     Edit the specification code as follows:
     * Replace `<service_account_id>` with the ID of the service account you created.
     * Replace `<function_id>` with the ID of the function you created.
     * Replace `<bucket_name>` with the name of the bucket you created.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Click the name of the API gateway you created.
  1. Copy the `url` value from the specification.

     Use this URL to [test the URL shortener](#test).

{% endlist %}

## Test the URL shortener {#test}

{% include [serverless-test-shortener](../../_includes/serverless/serverless-url-shortener/test-shortener.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../api-gateway/operations/api-gw-delete.md) `for-serverless-shortener`.
1. [Delete](../../functions/operations/function/function-delete.md) the function in `for-serverless-shortener`.
1. [Delete](../../ydb/operations/manage-databases.md#delete-db) the `for-serverless-shortener` YDB database.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
