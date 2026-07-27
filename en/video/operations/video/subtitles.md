---
title: How to manage subtitles in {{ video-full-name }}
description: Follow this guide to manage subtitles in {{ video-full-name }}.
---

# Managing subtitles

You can [add](#add) and [delete](#delete) subtitles while uploading or editing a video. After a video is uploaded, you will also be able to [download](#download) [subtitle](../../concepts/videos.md#subtitles) files.

{% include [free-neuro](../../../_includes/video/free-neuro.md) %}

## Adding subtitles {#add}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Under **{{ ui-key.yacloud_video.videos.label_subtitles }}**, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.common.action_add }}**.
  1. Choose how to add subtitles:

     * ![image](../../../_assets/console-icons/magic-wand.svg) **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**: To generate subtitles automatically based on the video analysis. In the window that opens, specify the original language of the video and the subtitle languages and click **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**.

     * ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud_video.common.upload }}**: To upload subtitles from a file. In the window that opens, specify the subtitle language, select the file with the subtitles, and wait for it to upload. Click **{{ ui-key.yacloud_video.common.action_create }}**.

        {% include [max-len-video-subtitle](../../../_includes/video/max-len-video-subtitle.md) %}
     
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  1. Create a subtitle record using the [Create](../../api-ref/Subtitle/create.md) REST API method for the [Subtitle](../../api-ref/Subtitle/) resource or the [SubtitleService.Create](../../api-ref/grpc/Subtitle/create.md) gRPC API call.

  1. Upload the subtitle file using the URL you got via the [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) REST API method for the [Subtitle](../../api-ref/Subtitle/) resource or the [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md) gRPC API call.

  1. {% include [transcode-subtitles](../../../_includes/video/transcode-subtitles.md) %}

{% endlist %}


## Updating subtitles {#update}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Under **{{ ui-key.yacloud_video.videos.label_subtitles }}**, select the update method:

     * To update subtitles uploaded from a file, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of their name and select ![image](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_video.videos.action_subtitles_upload_again }}**. In the window that opens, specify subtitles language, select the file, and wait for the upload to complete. Click **{{ ui-key.yacloud_video.common.action_create }}**.

     * To update generated subtitles, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.common.action_add }}** and select ![image](../../../_assets/console-icons/magic-wand.svg) **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**. In the window that opens, specify the languages you need to update the subtitles for and click **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**.

        {% include [max-len-video-subtitle](../../../_includes/video/max-len-video-subtitle.md) %}

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  1. Generate a new URL and upload the subtitle file using the [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) REST API method for the [Subtitle](../../api-ref/Subtitle/) resource or the [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md) gRPC API call.

  1. {% include [transcode-subtitles](../../../_includes/video/transcode-subtitles.md) %}

{% endlist %}


## Downloading subtitles {#download}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![video](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, select a video.
  1. Under **{{ ui-key.yacloud_video.videos.label_subtitles }}**, click ![image](../../../_assets/console-icons/arrow-down-to-line.svg) to the right of the name of the subtitle file to download.

{% endlist %}


## Deleting subtitles {#add}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Under **{{ ui-key.yacloud_video.videos.label_subtitles }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the subtitle file and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  1. To delete the subtitles, use the [Delete](../../api-ref/Subtitle/delete.md) REST API method for the [Subtitle](../../api-ref/Subtitle/) resource or the [SubtitleService.Delete](../../api-ref/grpc/Subtitle/delete.md) gRPC API call.
  1. After you delete the subtitles, run the transcoding. Use the [Transcode](../../api-ref/Video/transcode.md) REST API method for the [Video](../../api-ref/Video/) resource or the [VideoService.Transcode](../../api-ref/grpc/Video/transcode.md) gRPC API call and provide the following in the request:

     * Subtitle IDs to remain in the video, in the `subtitleIds` parameter for the REST API or `subtitle_ids` for the gRPC API. To delete all subtitles, provide an empty array.
     * Name of the `subtitleIds` field in the `fieldMask` parameter for the REST API or `subtitle_ids` in the `field_mask` parameter for the gRPC API.

{% endlist %}