---
title: How to manage summarization in {{ video-full-name }}
description: Follow this guide to manage summarization in {{ video-full-name }}.
---

# Managing summarization

You can [add](#enable) and [delete](#disable) summarization while uploading or editing a video. Summarization automatically creates a short summary of your video conveying its main points and key message. When enabled, the system automatically adds timecodes to videos. You can adjust the suggested timecodes or [add custom ones manually](add-timecodes.md).

You can customize the summarization appearance using [presets](../style-presets/create.md).

{% include [free-neuro](../../../_includes/video/free-neuro.md) %}

## Enabling summarization {#enable}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.

      {% note info %}

      Summarization is not available if the video is in the `{{ ui-key.yacloud_video.videos.status_processing }}` status or is longer than four hours.

      {% endnote %}

  1. Enable **{{ ui-key.yacloud_video.videos.field_summarization }}**.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}


## Disabling summarization {#disable}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Disable **{{ ui-key.yacloud_video.videos.field_summarization }}**.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}
