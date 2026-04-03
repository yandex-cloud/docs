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

Once the task is created, the queued message count will increase by one and a trigger will fire. Make sure messages arrive in the queue and are handled. To do this, view the queue statistics.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder housing `converter-queue`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Select `converter-queue`.
  1. Under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, you can see the queued and processed message counts.
  1. Go to **{{ ui-key.yacloud.common.monitoring }}**. View the **Overall queue stats** charts.

{% endlist %}

### View the function logs {#function-logs}

The trigger should invoke the converter function for each message in the queue. To make sure the function is invoked, check its logs.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the `ffmpeg-converter` function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select `ffmpeg-converter`.
  1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** tab and specify the period to view the logs for.

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
  1. If video conversion to GIF has not been completed, the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field will return:

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