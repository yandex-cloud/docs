---
title: How to start a broadcast in {{ video-full-name }}
description: Follow this guide to start a {{ video-full-name }} broadcast.
---

# Starting a broadcast

To start a broadcast:
1. [Get a server address and broadcast key](#get-key).
1. [Configure the program for broadcasting](#configure-soft).
1. [Start your broadcast](#start-stream).
1. [Check if the broadcast is available](#test).

## Get a server address and broadcast key {##get-key}

{% include [get-key](../../../_includes/video/get-key.md) %}

## Configure the program for broadcasting {#configure-soft}

You will need a video recording and streaming program, such as [Open Broadcaster Software (OBS)](https://obsproject.com).

In the program, specify {{ ui-key.yacloud_video.stream-lines.label_stream-key }} and {{ ui-key.yacloud_video.stream-lines.label_server-address }} received earlier and start your broadcast.

### OBS configuration example {#configure-obs}

1. [Download](https://obsproject.com/download) OBS.
1. [Install and set up](https://obsproject.com/kb/category/1) OBS.
1. Under **Controls**, click **Settings**.
1. In the **Stream** tab, set up the broadcast server:

   * In the **Service** field, select **Custom...**
   * In the **Server** field, enter the {{ ui-key.yacloud_video.stream-lines.label_server-address }} you got earlier.
   * In the **Stream Key** field, enter the {{ ui-key.yacloud_video.stream-lines.label_stream-key }} you got earlier.

1. Click **OK**.
1. Under **Sources**, click ![image](../../../_assets/console-icons/plus.svg), select what you want to broadcast, e.g., **Video Capture Device**, and click **OK**.
1. Select the video stream's source device, e.g., a webcam, and click **OK**.
1. Under **Controls**, click **Start Streaming**.

## Start your broadcast {#start-stream}

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select a stream.
   1. Click ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.streams.action_start-stream }}**.

- API {#api}

   Use the [StreamService/Create](../../api-ref/grpc/stream_service.md#Create) gRPC API call.

{% endlist %}

{% include [streams-limits-notice](../../../_includes/video/streams-limits-notice.md) %}

## Check if the broadcast is available {#test}

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select a stream.
   1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, click **</> {{ ui-key.yacloud_video.streams.title_past-code }}** and select the `link` tab.
   1. Click ![image](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
   1. Open a new browser page and paste the obtained URL to the address bar.
   1. Click the play button to make sure the broadcast is available.

- API {#api}

   Use the [EpisodeService/GetPlayerURL](../../api-ref/grpc/episode_service.md#GetPlayerURL) gRPC API call.

{% endlist %}