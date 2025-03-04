---
title: How to add timecodes to a video in {{ video-full-name }}
description: Follow this guide to add timecodes to a video in {{ video-name }}.
---

# Adding timecodes to a video

To add timecodes to a video:

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Under **{{ ui-key.yacloud_video.videos.label_description }}**, specify the timecodes for your video in the following format:
   
      {% include [video-timecodes](../../../_includes/video/video-timecodes.md) %}

      Example:

      ```
      00:00 Greeting
      00:30 Configuring the management console
      02:45 Adding users
      05:50 Logging out from account
      ```

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.
  1. Start playback on the video preview page.

     ![add-timecodes](../../../_assets/video/add-timecodes.png)
     
  1. Fast-forward your video to check timecodes and chapter headers.

{% endlist %}