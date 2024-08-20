---
title: "How to edit a video in {{ video-full-name }}"
description: "Follow this guide to edit a video in {{ video-full-name }}."
---

# Editing a video

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the line with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
   1. Edit the video title and description.
   1. To change the cover:

      1. If the video has a cover, hover over the cover preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new image for the cover.

         {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

   1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

   Use the [VideoService/Update](../../api-ref/grpc/video_service.md#Update) gRPC API call.

{% endlist %}

#### See also {#see-also}

[{#T}](get-link.md)