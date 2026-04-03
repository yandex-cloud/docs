1. [Get your cloud ready](#before-begin).
1. [Create resources](#create-resources).
1. [Create an API function](#create-api-function).
1. [Create a converter function](#create-converter-function).
1. [Create a trigger](#create-trigger).
1. [Test the application](#test-app).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](paid-resources.md) %}


## Create resources {#create-resources}

1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter) with configuration files:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter.git
   ```

1. [Create](../../../iam/operations/sa/create.md) a service account named `ffmpeg-sa` and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the following roles:

   * `ymq.reader`
   * `ymq.writer`
   * `{{ roles-lockbox-payloadviewer }}`
   * `storage.viewer`
   * `storage.uploader`
   * `ydb.admin`
   * `{{ roles-functions-invoker }}`

1. [Create a static key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account. Save the **Key ID** and **Your secret key**.
1. [Create a secret](../../../lockbox/operations/secret-create.md) named `ffmpeg-sa-secret` in {{ lockbox-name }}:

      1. Select **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**: **{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}**.
      1. Under **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**, specify:

         * `ACCESS_KEY_ID` as the key and **Key ID** from the previous step as the value.
         * `SECRET_ACCESS_KEY` as the key and **Your secret key** from the previous step as the value.

         Save the secret **{{ ui-key.yacloud.lockbox.label_secret-id }}** from the **{{ ui-key.yacloud.lockbox.label_secret-general-section }}** section.

1. [Create a message queue](../../../message-queue/operations/message-queue-new-queue.md) named `converter-queue` in {{ message-queue-full-name }}. Save the queue **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** from the **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** section.
1. [Create a {{ ydb-short-name }} database](../../../ydb/quickstart.md#serverless) in `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}` mode. Save the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** from the **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}** section.
1.  [Create a table](../../../ydb/operations/schema.md#create-table)  in the database:

    * **{{ ui-key.yacloud.ydb.table.form.field_name }}**: `tasks`.
    * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: [{{ ui-key.yacloud.ydb.table.form.label_document-table }}](../../../ydb/operations/schema.md#create-table).
    * **{{ ui-key.yacloud.ydb.table.form.label_columns }}**: One column named `task_id` of the `String` type. Set the [{{ ui-key.yacloud.ydb.table.form.column_shard }}](../../../ydb/operations/schema.md#create-table) attribute.

1. [Create a bucket](../../../storage/operations/buckets/create) with restricted access in {{ objstorage-full-name }}.


## Create an API function {#create-api-function}

The function implements an API which you can use to perform the following actions:

* `convert`: Provide a video for conversion. The function writes the task to the `tasks` table  using the [Document API](../../../ydb/docapi/tools/aws-http.md). 
* `get_task_status`: Get the task status. The function checks whether the task has been completed and returns a link to a GIF file.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Create](../../../functions/operations/function/function-create.md) a function named `ffmpeg-api`.
  1. [Create](../../../functions/operations/function/version-manage.md) a function version:

     1. Create a file named `requirements.txt` and specify these libraries in it:

        ```text
        boto3
        yandexcloud
        ```

     1. Create a file named `index.py` and paste into it the contents of the `ffmpeg-api.py` file from the `ffmpeg-api.zip` archive.
     1. Specify the following parameters:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handle_api`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `ffmpeg-sa`.

     1. Add these environment variables:

        * `DOCAPI_ENDPOINT`: **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** from the database configuration.
        * `SECRET_ID`: {{ lockbox-name }} secret **{{ ui-key.yacloud.lockbox.label_secret-id }}**.
        * `YMQ_QUEUE_URL`: **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** of the {{ message-queue-name }}-enabled queue.

{% endlist %}


## Create a converter function {#create-converter-function}

A converter function is run by a trigger. It processes videos and registers the result in the `tasks` table.

Video conversion is based on the FFmpeg utility. The FFmpeg executable is larger than 70 MB. To upload it along with the function code, create a ZIP archive and upload it via {{ objstorage-name }}. Learn more about [code upload formats](../../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. [Create](../../../functions/operations/function/function-create.md) a function named `ffmpeg-converter`.
  1. Create an `src.zip` archive with the following files:

     * `requirements.txt` file:

       ```text
       boto3
       requests
       yandexcloud
       ```
      
     * The `index.py` file with the contents of the `ffmpeg-converter.py` file from the `src.zip` archive.
     * The FFmpeg executable. On [FFmpeg's official website](http://ffmpeg.org/download.html), navigate to the **Linux Static Builds** section, download the 64-bit FFmpeg archive, and make the file executable by running the `chmod +x ffmpeg` command.

  1. [Upload](../../../storage/operations/objects/upload.md) `src.zip` to the bucket you created earlier.
  1. [Create](../../../functions/operations/function/version-manage.md) a function version:

     1. Specify the following parameters:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-storage }}` upload method.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_bucket }}**: Name of the bucket you created earlier.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_object }}**: `src.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handle_process_event`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `600`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `2048 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `ffmpeg-sa`.

     1. Add these environment variables:

        * `DOCAPI_ENDPOINT`: **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** from the database configuration.
        * `SECRET_ID`: {{ lockbox-name }} secret **{{ ui-key.yacloud.lockbox.label_secret-id }}**.
        * `YMQ_QUEUE_URL`: **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** of the {{ message-queue-name }}-enabled queue.
        * `S3_BUCKET`: Name of the bucket you created earlier.

{% endlist %}


## Create a trigger {#create-trigger}

A message queue is handled using a [trigger for {{ message-queue-name }}](../../../functions/concepts/trigger/ymq-trigger.md). It invokes the converter function as messages arrive in `converter-queue`. 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** tab.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Enter a name for the trigger: `ffmpeg-trigger`.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}**, select the `converter-queue` message queue and the service account named `ffmpeg-sa` with permission to read messages from it.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * Select the function for the trigger to invoke: `ffmpeg-converter`.
     * Specify the [function version tag](../../../functions/concepts/function.md#tag): `$latest`.
     * Specify the service account which will invoke the function: `ffmpeg-sa`.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Test the application {#test-app}

{% include [test-app](test-app.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../../message-queue/operations/message-queue-delete-queue.md) `converter-queue`.
1. [Delete](../../../ydb/operations/manage-databases.md#delete-db) the database.
1. [Delete](../../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../../storage/operations/buckets/delete.md) the bucket.
1. [Delete](../../../functions/operations/function/function-delete.md) the `ffmpeg-api` and `ffmpeg-converter` functions.
1. [Delete](../../../functions/operations/trigger/trigger-delete.md) the `ffmpeg-trigger` trigger.
