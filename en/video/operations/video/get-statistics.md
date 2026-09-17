---
title: How to look up video viewing statistics in {{ video-full-name }}
description: Follow this guide to look up your video viewing statistics in {{ video-name }}.
---

# Looking up video viewing statistics

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, select the [video](../../concepts/videos.md).
  1. On the page that opens, go to the **{{ ui-key.yacloud_video.common.statistics }}** tab.
  1. At the top of the tab, select the time interval for the statistics.

      {% include [statistics-time-interval](../../_includes/video/statistics-time-interval.md) %}

  1. {% include [statistics-grouping](../../_includes/video/statistics-grouping.md) %}

  For a detailed description of the available statistics, see [this section](../../concepts/videos.md#video-statistics).

{% endlist %}
