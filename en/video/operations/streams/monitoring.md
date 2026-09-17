---
title: Checking broadcast status in {{ video-full-name }}
description: How to monitor broadcast quality in {{ video-full-name }}.
---

# Checking broadcast status

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select the broadcast you need.
  1. On the page that opens, go to the **{{ ui-key.yacloud_video.streams.title_stream-event-journal-tab }}** tab.
  1. At the top of the tab, select the time interval you want the measures for.

      You can set the time interval:
      * By specifying the start and end date and time.
      * By selecting the intervals you need on the `Day`, `Week`, `Month`, `Quarter`, or `Year` tabs.

      After you select a time interval, the data will be automatically refreshed.

  For a detailed description of the measures, see [{#T}](../../concepts/streams.md#stream-parameters).

{% endlist %}
