# Converting a video to a GIF in Python

You'll create a video converter using [FFmpeg](https://ffmpeg.org/) and {{ message-queue-full-name }}. This guide is intended for Linux and macOS users.

{% if lang == "ru" %}

@[youtube](uyIMvEtr3cI)

{% endif %}

To create an application:

1. [Before you start](#before-begin).
1. [Create resources](#create-resources).
1. [Create an API function](#create-api-function).
1. [Create a converter function](#create-converter-function).
1. [Create a trigger](#create-trigger).
1. [Test the application](#test-app).

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* A fee for function calls (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* A fee for querying the database {% if audience == "external" %} (see [{{ ydb-full-name }} pricing](../ydb/pricing/serverless.md)). {% endif %}
* A fee for storing data in a bucket (see [{{ objstorage-full-name }} pricing](../storage/pricing.md)).

{% endif %}

## Create resources {#create-resources}

1. [Download](https://{{ s3-storage-host }}/doc-files/video-converting.zip) the archive with the files needed to create a video converter.
1. [Create](../iam/operations/sa/create.md) a service account named `ffmpeg-sa` and [assign](../iam/operations/sa/assign-role-for-sa.md) it the following roles:

   * `ymq.reader`.
   * `ymq.writer`.
   * `lockbox.payloadViewer`.
   * `storage.viewer`.
   * `storage.uploader`.
   * `ydb.admin`.
   * `serverless.functions.invoker`.

1. [Create a static key](../iam/operations/sa/create-access-key.md) for the service account. Save the **Key ID** and **Your secret key**.
1. [Create a secret](../lockbox/quickstart.md) named `ffmpeg-sa-secret` in {{ lockbox-name }}. Under **Version**, specify:

   * `ACCESS_KEY_ID` as the key and **Key ID** from the previous step as the value.
   * `SECRET_ACCESS_KEY` as the key and **Your secret key** from the previous step as the value.

   Save the secret **ID** from the **Information about secret** section.

1. [Create a message queue](../message-queue/operations/message-queue-new-queue.md) named `converter-queue` in {{ message-queue-full-name }}. Save the queue **URL** from the **General information** section.
1. [Create a database](../ydb/quickstart.md#serverless) {{ ydb-short-name }} in Serverless mode. Save the **Endpoint** from the **Document API endpoint** section.
1. {% if audience == "external" %} [Create a table](../ydb/operations/schema.md#create-table) {% endif %} in the database:

   * **Table name**: `tasks`.
   * **Table type**: {% if audience == "external" %} [Document table](../ydb/operations/schema.md#create-table). {% endif %}
   * **Columns**: One column with the name `task_id` and the `String` type. {% if audience == "external" %} Set the [Partition key](../ydb/operations/schema.md#create-table) attribute. {% endif %}

1. [Create a bucket](../storage/operations/buckets/create) named `converter-bucket` in {{ objstorage-full-name }}.

## Create an API function {#create-api-function}

The function implements an API which you can use to perform the following actions:

* `convert`: Transfer a video to convert. The function writes the task to the `tasks` table{% if audience == "external" %} using the [Document API](../ydb/docapi/tools/aws-http.md). {% endif %}
* `get_task_status`: Get the task status. The function checks whether the task is completed and returns a link to a GIF file.

{% list tabs %}

- Management console

   1. [Create](../functions/operations/function/function-create.md) a function named `ffmpeg-api`.
   1. [Create](../functions/operations/function/version-manage.md#version-create) a function version:

      1. Create a file named `requirements.txt` and specify the following library in it:

         ```
         boto3
         ```

      1. Create a file named `index.py` and paste the contents of `ffmpeg-api.py` from the archive into it.
      1. Indicate the following:

         * Runtime environment: `python37`.
         * Entry point: `index.handle_api`.
         * Timeout: 5 seconds.
         * Service account: `ffmpeg-sa`.

      1. Add environment variables:

         * `DOCAPI_ENDPOINT`: The **Endpoint** from the database configuration.
         * `SECRET_ID`: The {{ lockbox-name }} secret **ID**.
         * `YMQ_QUEUE_URL`: The {{ message-queue-name }} queue **URL**.

{% endlist %}

## Create a converter function {#create-converter-function}

A converter function is run by a trigger. It performs video processing and registers the execution result in the `tasks` table.

Video conversion is done using the FFmpeg utility. The FFmpeg executable file is more than 70 MB in size. To upload it along with the function code, create a ZIP archive and upload it via {{ objstorage-name }}. Learn more about [code upload formats](../functions/concepts/function.md).

{% list tabs %}

- Management console

   1. [Create](../functions/operations/function/function-create.md) a function named `ffmpeg-converter`.
   1. Create an `src.zip` archive with the following files:

      * The `requirements.txt` file:

         ```
         boto3
         requests
         ```

      * The `index.py` file with the contents of `ffmpeg-converter.py` from the archive.
      * The FFmpeg executable file. To get it, go to the [FFmpeg official website](http://ffmpeg.org/download.html), the **Linux Static Builds** section, and download the archive with the 64-bit FFmpeg version.

   1. [Upload](../storage/operations/objects/upload.md) `src.zip` to `converter-bucket`.
   1. [Create](../functions/operations/function/version-manage.md#version-create) a function version:

      1. Indicate the following:

         * Upload method: `Object Storage`.
         * Bucket: `converter-bucket`.
         * Object: `src.zip`.
         * Runtime environment: `python37`.
         * Entry point: `index.handle_process_event`.
         * Timeout: 600 seconds.
         * Amount of RAM: 2048 MB.
         * Service account: `ffmpeg-sa`.

      1. Add environment variables:

         * `DOCAPI_ENDPOINT`: The **Endpoint** from the database configuration.
         * `SECRET_ID`: The {{ lockbox-name }} secret **ID**.
         * `YMQ_QUEUE_URL`: The {{ message-queue-name }} queue **URL**.
         * `S3_BUCKET`: The `converter-bucket`.

{% endlist %}

## Create a trigger {#create-trigger}

A message queue is handled using a [trigger for {{ message-queue-name }}](../functions/concepts/trigger/ymq-trigger.md). It invokes the converter function when messages arrive in `converter-queue`.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.
   1. Select **{{ sf-name }}**.
   1. Go to the **Triggers** tab.
   1. Click **Create trigger**.
   1. Under **Basic parameters**:
      * Name the trigger `ffmpeg-trigger`.
      * In the **Type** field, select **Message Queue**.
   1. Under **Message Queue settings**, select  `converter-queue` and `ffmpeg-sa` with rights to read messages from it.
   1. Under **Function settings**:
      * Select the function to be invoked by the trigger: `ffmpeg-converter`.
      * Specify the [function version tag](../functions/concepts/function.md#tag): `$latest`.
      * Specify the service account to be used to invoke the function: `ffmpeg-sa`.
   1. Click **Create trigger**.

{% endlist %}

## Test the application {#test-app}

### Create a task {#create-task}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the `ffmpeg-api` function.
   1. Select **{{ sf-name }}**.
   1. Select `ffmpeg-api`.
   1. Go to the **Testing** tab.
   1. In the **Input** field, enter:

      ```json
      {"action":"convert", "src_url":"<link to video>"}
      ```

   1. Click **Run test**.
   1. You'll see the task ID in the **Function output** field:

      ```json
      { "task_id": "c4269ceb-8d3a-40fe-95f0-84cf16e8c17f" }
      ```

{% endlist %}

### View the queue statistics {#ymq-stat}

After the task is created, the number of messages in the queue increases by one and a trigger fires. Make sure that messages arrive in the queue and are handled. To do this, view the queue statistics.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with `converter-queue`.
   1. Select **{{ message-queue-name }}**.
   1. Select `converter-queue`.
   1. Under **General information**, you can see the number of enqueued messages and those being handled.
   1. Go to **Monitoring**. View the **Overall queue stats** charts.

{% endlist %}

### View the function logs {#function-logs}

The trigger should invoke the converter function for each message in the queue. To make sure the function is invoked, check its logs.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the `ffmpeg-converter` function.
   1. Select **{{ sf-name }}**.
   1. Select `ffmpeg-converter`.
   1. Go to the **Logs** tab and specify the period to view them for.

{% endlist %}

### Get a link to a GIF file {#get-link}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the `ffmpeg-api` function.
   1. Select **{{ sf-name }}**.
   1. Select `ffmpeg-api`.
   1. Go to the **Testing** tab.
   1. In the **Input** field, enter the following request:

      ```json
      {"action":"get_task_status", "task_id":"<job ID>"}
      ```

   1. Click **Run test**.
   1. If video conversion to GIF is not completed, the **Function output** field returns:

      ```json
      {
          "ready": false
      }
      ```

      Otherwise, you'll get a link to the GIF file:

      ```json
      {
          "ready": true,
          "gif_url": "https://{{ s3-storage-host }}/converter-bucket/1b4db1a6-f2b2-4b1c-b662-37f7a62e6e2e.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=qxLftbbZ91U695ysemyZ%2F20210831%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20210831T110351Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=f4a5fe7848274a09be5b221fbf8a9f6f2b385708cfa351861a4e69df4ee4183c"
      }
      ```

{% endlist %}

## How to delete created resources {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. [Delete](../message-queue/operations/message-queue-delete-queue.md) the `converter-queue`.
1. [Delete](../ydb/operations/manage-database.md#delete-db) the database.
1. [Delete](../storage/operations/objects/delete.md) all objects from the `converter-bucket`.
1. [Delete](../storage/operations/buckets/delete.md) the `converter-bucket`.
1. [Delete](../functions/operations/function/function-delete.md) the `ffmpeg-api` and `ffmpeg-converter` functions.
1. [Delete](../functions/operations/trigger/trigger-delete.md) the `ffmpeg-trigger`.
