---
title: How to upload a video to {{ video-full-name }}
description: Follow this guide to upload a video to {{ video-full-name }}.
---

# Uploading a video

## Uploading one video {#single}

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, click **{{ ui-key.yacloud_video.videos.action_create-video }}**.
  1. Click **Select file** on the upload page and choose the video you want to upload.

      {% include [video-characteristic](../../../_includes/video/video-characteristic.md) %}

      Wait for the upload to end.

  1. **{{ ui-key.yacloud_video.videos.label_title }}** your video. The title will be displayed on all the resources hosting the video.
  1. In the **{{ ui-key.yacloud_video.videos.label_accessRights }}** field, set the access permissions for the video:

      * `{{ ui-key.yacloud_video.videos.label_access_rights-auth-system-access }}`: Video will be available to users authorized within your [organization](../../../organization/quickstart.md).
      * `{{ ui-key.yacloud_video.videos.label_access_rights-public }}`: Video will be publicly available.

  1. Optionally, to add a cover for a video, in the **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** field, click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and choose a cover image.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. {% include [add-subtitles-optional](../../../_includes/video/add-subtitles-optional.md) %}
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

  This will open the video management page. After processing is complete, the video will be available for viewing.

  To check the video for availability:

  1. Under **{{ ui-key.yacloud_video.videos.title_past-code }}**, select the `link` tab.
  1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Open a new browser page and paste the obtained URL to the address bar.
  1. Click the Play button.

- REST API {#api}

  To create a video in {{ video-name }} using the API, register the video on your channel and then upload the video file over the [tus](https://tus.io/protocols/resumable-upload) protocol. If the upload fails, resume it from the point where the failure occurred.

  1. Register your video on the channel:

      {% include [register-video-rest-api-command](../../../_includes/video/register-video-rest-api-command.md) %}

      Where:
      * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) required for [authenticating](../../api-ref/authentication.md) with the {{ video-name }} API.
      * `<channel_ID>`: ID of the channel where you want to create the video.
      * `<video_name>`: Name the video will get when uploaded to the channel.
      * `<video_file_size>`: Size of the video file to upload, in bytes.
      * `<video_file_name>`: Name of the video file you are going to upload.

      {% include [register-video-rest-api-output](../../../_includes/video/register-video-rest-api-output.md) %}

      Save the video upload link (`url` field value) and video ID (`videoId` field value) as you will need them later.

  1. Upload the video file:

      {% include [create-video-upload-file-curl](../../../_includes/video/create-video-upload-file-curl.md) %}

  1. Make sure your video file has been fully uploaded by specifying the video ID you saved before:

      {% include [verify-video-upload-rest](../../../_includes/video/verify-video-upload-rest.md) %}

      If you see `PROCESSING` or `READY` in the `status` field, the video file has been fully uploaded.

  1. If you see `WAIT_UPLOADING` in the `status` field, the video file upload was interrupted. In this case you need to resume and complete the upload. To do this, you need to know the `offset` point the previous upload attempt was interrupted at.

      {% include [resume-video-upload-curl](../../../_includes/video/resume-video-upload-curl.md) %}

      Check once again that the video file has been fully uploaded. If the upload was interrupted again, repeat this step.

- gRPC API {#grpc-api}

  To create a video in {{ video-name }} using the API, register the video on your channel and then upload the video file over the [tus](https://tus.io/protocols/resumable-upload) protocol. If the upload fails, resume it from the point where the failure occurred.

  1. Register your video on the channel:

      {% include [register-video-grpc-api-command](../../../_includes/video/register-video-grpc-api-command.md) %}

      Where:
      * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) required for [authenticating](../../api-ref/authentication.md) with the {{ video-name }} API.
      * `<channel_ID>`: ID of the channel where you want to create the video.
      * `<video_name>`: Name the video will get when uploaded to the channel.
      * `<video_file_size>`: Size of the video file to upload, in bytes.
      * `<video_file_name>`: Name of the video file you are going to upload.

      {% include [register-video-grpc-api-output](../../../_includes/video/register-video-grpc-api-output.md) %}

      Save the video upload link (`url` field value) and video ID (`videoId` field value) as you will need them later.

  1. Upload the video file:

      {% include [create-video-upload-file-curl](../../../_includes/video/create-video-upload-file-curl.md) %}

  1. Make sure your video file has been fully uploaded by specifying the video ID you saved before:

      {% include [verify-video-upload-grpc](../../../_includes/video/verify-video-upload-grpc.md) %}

      If you see `PROCESSING` or `READY` in the `status` field, the video file has been fully uploaded.

  1. If you see `WAIT_UPLOADING` in the `status` field, the video file upload was interrupted. In this case you need to resume and complete the upload. To do this, you need to know the `offset` point the previous upload attempt was interrupted at.

      {% include [resume-video-upload-curl](../../../_includes/video/resume-video-upload-curl.md) %}

      Check once again that the video file has been fully uploaded. If the upload was interrupted again, repeat this step.

{% endlist %}


## Uploading multiple videos {#multiple}

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, click **{{ ui-key.yacloud_video.videos.action_create-video }}**.
  1. On the upload page, click **Select file** and select the videos you want to upload.

      {% include [video-characteristic](../../../_includes/video/video-characteristic.md) %}

      Wait until all files are uploaded.

  As soon as they are processed, the videos will be available for viewing.

  If required, [add](./update.md) subtitles and [change](./update.md) the name and cover separately for each video you uploaded.

{% endlist %}


#### See also {#see-also}

[{#T}](./update.md)