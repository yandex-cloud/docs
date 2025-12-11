---
title: How to edit a video in {{ video-full-name }}
description: Follow this guide to edit a video in {{ video-full-name }}.
---

# Editing a video

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Edit the name of your video.
  1. Optionally, under **{{ ui-key.yacloud_video.videos.label_description }}**, specify the timecodes for your video in the following format:
   
     {% include [video-timecodes](../../../_includes/video/video-timecodes.md) %}

  1. In the **{{ ui-key.yacloud_video.videos.label_accessRights }}** list, edit the video access type:
      * **{{ ui-key.yacloud_video.videos.label_access_rights-sign-url-access }}**: Video will be available via a dedicated link.
      
        {% include [video-temporary-links](../../../_includes/video/video-temporary-links.md) %}

      * **{{ ui-key.yacloud_video.videos.label_access_rights-public }}**: Video will be available indefinitely to anyone with a link to it.
  1. To change the cover:

      1. If the video has a cover, hover over the cover preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new thumbnail image.

          {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Enable or disable [summarization](../../concepts/videos.md#summarization).
  
  1. To add [subtitles](../../concepts/videos.md#subtitles), click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.common.action_add }}** and choose how to add subtitles:

     * ![image](../../../_assets/console-icons/magic-wand.svg) **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**: To generate subtitles automatically based on the video analysis. In the window that opens, specify the original language of the video and the subtitle languages and click **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**.

     * ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud_video.common.upload }}**: To upload subtitles from a file. In the window that opens, specify the subtitle language, select the file with the subtitles, and wait for it to upload. Click **{{ ui-key.yacloud_video.common.action_create }}**.

  1. To delete subtitles, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.

  1. To edit [neural translation](../../concepts/videos.md#translation), delete the old languages and add the new ones:
      
      1. Under **{{ ui-key.yacloud_video.videos.label_neuro-translation }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of neural translation language.
      1. Click ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_video.common.action_delete }}**.
      1. Click **{{ ui-key.yacloud_video.common.action_add }}**.
      1. In the window that opens, select the video language.
      1. Select languages for translation. 
      1. Click **{{ ui-key.yacloud_video.common.action_create }}**.

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [update](../../api-ref/Video/update.md) REST API method for the [Video](../../api-ref/Video/index.md) resource or the [VideoService/Update](../../api-ref/grpc/Video/update.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

[{#T}](get-link.md)