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

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

  This will open the video management page. After processing is complete, the video will be available for viewing.

  To check the video for availability:

  1. Under **{{ ui-key.yacloud_video.videos.title_past-code }}**, select the `link` tab.
  1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Open a new browser page and paste the obtained URL to the address bar.
  1. Click the Play button.

- API {#api}

  Use the [VideoService/Create](../../api-ref/grpc/video_service.md#Create) gRPC API call.

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

  If you need to, [edit](./update.md) the title and cover separately for each video you uploaded.

{% endlist %}

#### See also {#see-also}

[{#T}](./update.md)