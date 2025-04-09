# Converting a video to a GIF in Python

You will create a video converter using [FFmpeg](https://ffmpeg.org/) and {{ message-queue-full-name }}. This guide is intended for Linux and macOS users.



To create an application:

1. [Get your cloud ready](#before-begin).
1. [Prepare the resources](#create-resources).
1. [Create an API function](#create-api-function).
1. [Create a converter function](#create-converter-function).
1. [Create a trigger](#create-trigger).
1. [Test the application](#test-app).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for invoking functions (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for querying the database  (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)). 
* Fee for storing data in a bucket (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).


## Prepare the resources {#create-resources}

1. [Download](https://{{ s3-storage-host }}/doc-files/video-converting.zip) the archive with the files required to create a video converter.
1. [Create](../../iam/operations/sa/create.md) a service account named `ffmpeg-sa` and [assign](../../iam/operations/sa/assign-role-for-sa.md) the following roles to it:

   * `ymq.reader`
   * `ymq.writer`
   * `{{ roles-lockbox-payloadviewer }}`
   * `storage.viewer`
   * `storage.uploader`
   * `ydb.admin`
   * `{{ roles-functions-invoker }}`

1. [Create a static key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account. Save the **Key ID** and **Your secret key**.
1. [Create a secret](../../lockbox/quickstart.md) named `ffmpeg-sa-secret` in {{ lockbox-name }}. Under **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**, specify:

   * `ACCESS_KEY_ID` as the key with **Key ID** from the previous step for value.
   * `SECRET_ACCESS_KEY` as the key with **Your secret key** from the previous step for value.

   Save the secret **{{ ui-key.yacloud.lockbox.label_secret-id }}** from the **{{ ui-key.yacloud.lockbox.label_secret-general-section }}** section.

1. [Create a message queue](../../message-queue/operations/message-queue-new-queue.md) named `converter-queue` in {{ message-queue-full-name }}. Save the queue **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** from the **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** section.
1. [Create a {{ ydb-short-name }} database](../../ydb/quickstart.md#serverless) in `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}` mode. Save the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** from the **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}** section.
1.  [Create a table](../../ydb/operations/schema.md#create-table)  in the database:

    * **{{ ui-key.yacloud.ydb.table.form.field_name }}**: `tasks`.
    * **{{ ui-key.yacloud.ydb.table.form.field_type }}**:  [{{ ui-key.yacloud.ydb.table.form.label_document-table }}](../../ydb/operations/schema.md#create-table). 
    * **{{ ui-key.yacloud.ydb.table.form.label_columns }}**: One column titled `task_id` with `String` for type.  Set the [{{ ui-key.yacloud.ydb.table.form.column_shard }}](../../ydb/operations/schema.md#create-table) attribute. 

1. [Create a bucket](../../storage/operations/buckets/create) with restricted access in {{ objstorage-full-name }}.

## Create an API function {#create-api-function}

The function implements an API which you can use to perform the following actions:

* `convert`: Provide a video for conversion. The function writes the task to the `tasks` table  using the [Document API](../../ydb/docapi/tools/aws-http.md). 
* `get_task_status`: Get the task status. The function checks whether the task is completed and returns a link to a GIF file.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Create](../../functions/operations/function/function-create.md) a function named `ffmpeg-api`.
  1. [Create](../../functions/operations/function/version-manage.md) a function version:

     1. Create a file named `requirements.txt` and specify the library in it:

        ```
        boto3
        ```

     1. Create a file named `index.py` and paste into it the contents of the `ffmpeg-api.py` file from the archive.
     1. Specify the following settings:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python37`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handle_api`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `ffmpeg-sa`

     1. Add these environment variables:

        * `DOCAPI_ENDPOINT`: **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** from the database configuration.
        * `SECRET_ID`: {{ lockbox-name }} secret **{{ ui-key.yacloud.lockbox.label_secret-id }}**.
        * `YMQ_QUEUE_URL`: {{ message-queue-name }} queue **{{ ui-key.yacloud.ymq.queue.overview.label_url }}**.

{% endlist %}

## Create a converter function {#create-converter-function}

A converter function is run by a trigger. It performs video processing and registers the execution result in the `tasks` table.

Video conversion is performed using the FFmpeg utility. The FFmpeg executable file is larger than 70 MB. To upload it along with the function code, create a ZIP archive and upload it via {{ objstorage-name }}. Learn more about [code upload formats](../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. [Create](../../functions/operations/function/function-create.md) a function named `ffmpeg-converter`.
  1. Create an archive named `src.zip` with the following files:

     * `requirements.txt` file:

       ```
       boto3
       requests
       ```
      
     * The `index.py` file with the contents of `ffmpeg-converter.py` from the archive.
     * The FFmpeg executable file. On the [FFmpeg official website](http://ffmpeg.org/download.html), download the 64-bit FFmpeg archive from the **Linux Static Builds** section and make the file executable by running the `chmod +x ffmpeg` command.

  1. [Upload](../../storage/operations/objects/upload.md) the `src.zip` archive to the bucket you created earlier.
  1. [Create](../../functions/operations/function/version-manage.md) a function version:

     1. Specify the following settings:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python37`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-storage }}` upload method
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_bucket }}**: Name of the bucket you created earlier.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_object }}**: `src.zip`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handle_process_event`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `600`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `2048 {{ ui-key.yacloud.common.units.label_megabyte }}`
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `ffmpeg-sa`

     1. Add these environment variables:

        * `DOCAPI_ENDPOINT`: **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** from the database configuration.
        * `SECRET_ID`: {{ lockbox-name }} secret **{{ ui-key.yacloud.lockbox.label_secret-id }}**.
        * `YMQ_QUEUE_URL`: {{ message-queue-name }} queue **{{ ui-key.yacloud.ymq.queue.overview.label_url }}**.
        * `S3_BUCKET`: Name of the bucket you created earlier.

{% endlist %}

## Create a trigger {#create-trigger}

The message queue is processed using a [trigger for {{ message-queue-name }}](../../functions/concepts/trigger/ymq-trigger.md). It invokes the converter function when messages get into `converter-queue`. 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** tab.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Enter a name for the trigger: `ffmpeg-trigger`.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select the `converter-queue` message queue and the `ffmpeg-sa` service account with permissions to read from it.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * Select the function for the trigger to invoke: `ffmpeg-converter`.
     * Specify the [function version tag](../../functions/concepts/function.md#tag): `$latest`.
     * Specify the service account that will be used to invoke the function: `ffmpeg-sa`.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

## Test the application {#test-app}

### Create a task {#create-task}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the `ffmpeg-api` function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `ffmpeg-api` function.
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, enter:

     ```json
     {"action":"convert", "src_url":"<link_to_video>"}
     ```

     Where `<link_to_video>` is a link to an [MP4](https://en.wikipedia.org/wiki/MP4_file_format) video file saved to [Yandex Disk](https://disk.yandex.com).

  1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. You will see the task ID in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field:

     ```json
     { "task_id": "c4269ceb-8d3a-40fe-95f0-84cf********" }
     ```

{% endlist %}

### View the queue statistics {#ymq-stat}

After the task is created, the number of messages in the queue increases by one and a trigger fires. Make sure that messages make it into the queue and get processed. To do this, view the queue statistics.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing `converter-queue`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Select the `converter-queue` queue.
  1. Under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, you can see how many messages are in the queue and how many are being processed.
  1. Go to **{{ ui-key.yacloud.common.monitoring }}**. View the **Overall queue stats** charts.

{% endlist %}

### View the function logs {#function-logs}

The trigger should invoke the converter function for each message in the queue. To make sure the function is invoked, check its logs.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the `ffmpeg-converter` function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `ffmpeg-converter` function.
  1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** tab and specify the period to view them for.

{% endlist %}

### Get a link to a GIF file {#get-link}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the `ffmpeg-api` function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `ffmpeg-api` function.
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, enter the following request:

     ```json
     {"action":"get_task_status", "task_id":"<job_ID>"}
     ```

  1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. If video conversion to GIF is not completed, the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field returns:

     ```json
     {
         "ready": false
     }
     ```

     Otherwise, you will get a link to the GIF file:

     ```json
     {
         "ready": true,
         "gif_url": "https://{{ s3-storage-host }}/<bucket_name>/1b4db1a6-f2b2-4b1c-b662-37f7********.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=qxLftbbZ91U695ysemyZ%2F202********{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20210831T110351Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=f4a5fe7848274a09be5b221fbf8a9f6f2b385708cfa351861a4e69df********"
     }
     ```

{% endlist %}

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the resources you created:

1. [Delete](../../message-queue/operations/message-queue-delete-queue.md) `converter-queue`.
1. [Delete](../../ydb/operations/manage-databases.md#delete-db) the database.
1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
1. [Delete](../../functions/operations/function/function-delete.md) the `ffmpeg-api` and `ffmpeg-converter` functions.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the `ffmpeg-trigger` trigger.
