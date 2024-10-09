# Broadcasts in {{ video-name }}

With {{ video-name }}, you can stream [live broadcasts](#streams) in the integrated [video player](./player.md). Use [lines](#lines) and [episodes](#episodes) to customize your broadcast settings.

## Broadcasts {#streams}

A _broadcast_ is the main {{ video-name }} resource for live video streaming.

A broadcast is a one-time event implemented via a preset [line](#lines). To repeat your broadcast with the same signal source, create another broadcast on the same line.

Types of broadcast streams include:
* On demand: A broadcast is started and finished manually from the {{ video-name }} interface.
* On schedule: A broadcast is started and finished automatically at the specified time.

You can upload custom covers for your broadcasts. The cover will appear in the {{ video-name }} interface and the player on the website hosting the broadcast.

{% include [image-characteristic](../../_includes/video/image-characteristic.md) %}

You can [publish](../operations/streams/get-link.md) your broadcast using a direct link or by posting it to a website.

You can group completed broadcasts into [playlists](./playlists.md) in desired order. For more information on publishing playlists, see [{#T}](../operations/playlists/get-link.md).

Once a broadcast is over, you can keep its video available or remove it.

{% include [streams-limits-notice](../../_includes/video/streams-limits-notice.md) %}

### Statuses {#statuses}

* `{{ ui-key.yacloud_video.streams.status_offline }}`: The broadcast has been created but not started yet.
* `{{ ui-key.yacloud_video.streams.status_preparing }}`: Preparation of a fault-tolerant {{ yandex-cloud }} infrastructure for video transcoding is ongoing. Awaiting video signal. The broadcast gets this status a few minutes before it starts.
* `{{ ui-key.yacloud_video.streams.status_ready }}`: The infrastructure is ready, the video signal is received. You can start your broadcast.
* `{{ ui-key.yacloud_video.streams.status_on-air }}`: The broadcast is on. The broadcast gets this status as soon as you click **{{ ui-key.yacloud_video.streams.action_start-stream }}** or automatically at a specified time.
* `{{ ui-key.yacloud_video.streams.status_finished }}`: The broadcast is over. The broadcast gets this status as soon as you click **{{ ui-key.yacloud_video.streams.action_stop-stream }}** or automatically at a specified time. You can add a completed broadcast to a playlist.

### Broadcast publishing parameters {#stream-parameters}

You can change the following basic broadcast playback settings when [generating](../operations/streams/get-link.md) a direct link or website embed code:

* Default sound setting for video playback.
* Automatic start of playback when opened.
* Displaying broadcast controls in the player.

{% include [iframe-settings](../../_includes/video/iframe-settings.md) %}

## Lines {#lines}

In {{ video-name }}, you use _lines_ to configure the source of your video signal for [broadcasts](#streams).

You can set up multiple lines in advance and use them for different broadcasts.

The following stream input protocols are supported: [RTMP](https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol) and [SRT](https://en.wikipedia.org/wiki/Secure_Reliable_Transport).

Types of line input streams include:

{% include [push-pull](../../_includes/video/push-pull.md) %}

You can upload custom covers for your lines. A cover will be displayed in the {{ video-name }} interface. For cover parameters, see the [Broadcasts](#streams) section.

## Episodes {#episodes}

To split a broadcast into multiple parts, use _episodes_, i.e., time segments of the broadcast. For example, to embed only a portion of the broadcast on a site, make this portion into an episode. The default episode is the whole broadcast.

## See also {#see-also}

* [Getting started with video streaming](../streaming.md)
* [Getting started with API](../api-ref/quickstart.md)