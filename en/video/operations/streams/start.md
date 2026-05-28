---
title: How to start a broadcast in {{ video-full-name }}
description: Follow this guide to start a {{ video-full-name }} broadcast.
---

# Starting a broadcast

To start a broadcast:
1. [Get a server address and broadcast key](#get-key).
1. [Configure broadcasting software](#configure-soft).
1. [Start your broadcast](#start-stream).
1. [Check if the broadcast is available](#test).

## Get a server address and broadcast key {#get-key}

{% include [get-key](../../../_includes/video/get-key.md) %}

## Configure broadcasting software {#configure-soft}

You will need a video recording and streaming program, such as [Open Broadcaster Software (OBS)](https://obsproject.com).

In the program, specify {{ ui-key.yacloud_video.stream-lines.label_stream-key }} and {{ ui-key.yacloud_video.stream-lines.label_server-address }} received earlier and start your broadcast.

### OBS configuration example {#configure-obs}

1. In the right-hand panel, go to **Controls** → **Settings** → **Stream**.
1. In the **Destination** section:

     * In the **Service** field, select **Custom...**.
     * In the **Server** field, specify the server address you got earlier.
     * In the **Stream Key** field, specify the broadcast key you got earlier.
    
1. In the left-hand panel, select **Output** → **Stream**.
    
     * Under **Video Bitrate**, set a value based on screen resolution and internet speed. You can measure your internet speed using [Yandex.Internetometer](https://yandex.ru/internet). Your stream bitrate must not exceed the **Outgoing connection** value.
     * In the **Video Encoder** field, select the video encoding format.
    
1. In the **Recording** section:
    
     * In the **Recording Path** field, specify the path to save your stream to.
     * In the **Recording Format** field, select the video file format.
    
1. Click **OK**.
1. In the **Sources** panel at the bottom left, click ![plus-sign](../../../_assets/console-icons/plus.svg) to add a source.
    
     * In the window that opens, select a source, e.g., **Video Capture Device**.
     * In the window that opens, specify the source name and click **OK**.
     * Select the video streaming device, e.g., a webcam, and click **OK**.
    
1. In the center of the window, you can set the size and position of the video stream.

For more information, see [{#T}](../../operations/streams/obs-config-help.md).

## Start your broadcast {#start-stream}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Go back to the ![streams](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab in {{ video-name }}.
  1. Select the broadcast you created earlier.
  1. Enable **Accept signal**.
  1. In OBS Studio, click **Start broadcast** in the bottom-right **Controls** panel.
  1. In the **{{ ui-key.yacloud_video.streams.label_start-broadcast }}** field, wait for the ![play](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.streams.label_start-broadcast }}** button to become active and click it. If the field is set to `{{ ui-key.yacloud_video.streams.label_start-broadcast-auto }}`, no further actions are required.
   
- API {#api}

  Use the [performAction](../../api-ref/Stream/performAction.md) REST API method for the [Stream](../../api-ref/Stream/index.md) resource or the [StreamService/PerformAction](../../api-ref/grpc/Stream/performAction.md) gRPC API call.

{% endlist %}

{% include [streams-limits-notice](../../../_includes/video/streams-limits-notice.md) %}

## Check if the broadcast is available {#test}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, select the broadcast episode with the `On air` status.
  1. On the episode page, open the `link` tab.
  1. Click ![image](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Open a new browser page and paste the obtained URL to the address bar.
  1. Click the play button to make sure the broadcast is available.

- API {#api}

  Use the [getPlayerURL](../../api-ref/Episode/getPlayerURL.md) REST API method for the [Episode](../../api-ref/Episode/index.md) resource or the [EpisodeService/GetPlayerURL](../../api-ref/grpc/Episode/getPlayerURL.md) gRPC API call.

{% endlist %}