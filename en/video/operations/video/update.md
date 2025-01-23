---
title: How to edit a video in {{ video-full-name }}
description: Follow this guide to edit a video in {{ video-full-name }}.
---

# Editing a video

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Edit the video title and description.
  1. In the **{{ ui-key.yacloud_video.videos.label_accessRights }}** list, edit the video access type:
      * **{{ ui-key.yacloud_video.videos.label_access_rights-sign-url-access }}**: Available via a dedicated link.
      
        {% include [video-temporary-links](../../../_includes/video/video-temporary-links.md) %}

      * **{{ ui-key.yacloud_video.videos.label_access_rights-public }}**: Available indefinitely to anyone with a link to it.
  1. To change the cover:

      1. If the video has a cover, hover over the cover preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new cover image.

          {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. To edit [subtitles](../../concepts/videos.md#subtitles), delete and add them as needed:

      1. Click ![image](../../../_assets/console-icons/xmark.svg) to the right of the name of the subtitle file you want to update.
      1. In the **{{ ui-key.yacloud_video.videos.label_subtitles }}** field, click **{{ ui-key.yacloud_video.common.action_add }}**.
      1. In the window that opens, select the subtitle language.
      1. Click **Select file** and select a subtitle file.
      1. Click **{{ ui-key.yacloud_video.common.action_create }}**.

          Wait for the file to upload.

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [update](../../api-ref/Video/update.md) REST API method for the [Video](../../api-ref/Video/index.md) resource or the [VideoService/Update](../../api-ref/grpc/Video/update.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

[{#T}](get-link.md)