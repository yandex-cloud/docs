---
title: How to look up broadcast viewing statistics in {{ video-full-name }}
description: Follow this guide to look up viewing statistics for a broadcast and its episodes in {{ video-name }}.
---

# Looking up broadcast viewing statistics

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select the broadcast you need.
  1. On the page that opens, go to the **{{ ui-key.yacloud_video.streams.title_stream-view-statistics-tab }}** tab.
     To see episode statistics, select and episode and navigate to the **{{ ui-key.yacloud_video.common.statistics }}** tab.
  1. At the top of the tab, select the time interval for the statistics.

      {% include [statistics-time-interval](../../_includes/video/statistics-time-interval.md) %}

  1. {% include [statistics-grouping](../../_includes/video/statistics-grouping.md) %}

  For a detailed description of the statistical data you can view, see the [{#T}](../../concepts/streams.md#streams-statistics) section.

{% endlist %}
