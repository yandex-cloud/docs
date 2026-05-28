# Broadcasts in {{ video-name }}

With {{ video-name }}, you can stream [live broadcasts](#streams) in the integrated [video player](./player.md). Each broadcast is a separate [episode](#episodes).

## Broadcasts {#streams}

A _broadcast_ is the main {{ video-name }} resource for live video streaming.

In the broadcast settings, the video signal source is configured.

The following stream input protocols are supported: [RTMP](https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol) and [SRT](https://en.wikipedia.org/wiki/Secure_Reliable_Transport).

Types of input streams:

{% include [push-pull](../../_includes/video/push-pull.md) %}

## Episodes {#episodes}

Each broadcast consists of _episodes_. There are two types of episodes:

* `{{ ui-key.yacloud_video.streams.label_episode-type-live }}`: Real-time viewing with rewind support.
* `{{ ui-key.yacloud_video.streams.label_episode-type-broadcast }}`: Event with defined start and end times and recording.

You can upload custom thumbnails for your episodes. The thumbnail will appear in the {{ video-name }} interface and in the player on the website hosting the broadcast episode.

{% include [image-characteristic](../../_includes/video/image-characteristic.md) %}

You can [publish](../operations/streams/get-link.md) a broadcast episode using a direct link or by posting it to a website. To embed a specific part of a broadcast on a website, set a time interval when creating or editing the episode.

You can group broadcast episodes into [playlists](./playlists.md) in any order. For more information on publishing playlists, see [{#T}](../operations/playlists/get-link.md).

Once a broadcast episode is over, you can keep its recording available or remove it.

{% include [streams-limits-notice](../../_includes/video/streams-limits-notice.md) %}

### Statuses {#statuses}

You can view statuses under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** in the relevant column.

Broadcast episodes can have the following statuses:

* `{{ ui-key.yacloud_video.streams.status_offline }}`: The broadcast has been created but not started yet.
* `{{ ui-key.yacloud_video.streams.status_preparing }}`: Preparation of a fault-tolerant {{ yandex-cloud }} infrastructure for video transcoding is ongoing. Awaiting video signal. The broadcast gets this status a few minutes before it starts.
* `{{ ui-key.yacloud_video.streams.status_ready }}`: The infrastructure is ready, the video signal is received. You can start your broadcast.
* `{{ ui-key.yacloud_video.streams.status_on-air }}`: The broadcast is on. The broadcast gets this status as soon as you click **{{ ui-key.yacloud_video.streams.action_start-stream }}** or automatically at a specified time.
* `{{ ui-key.yacloud_video.streams.status_finished }}`: The broadcast is over. The broadcast gets this status as soon as you click **{{ ui-key.yacloud_video.streams.action_stop-stream }}** or automatically at a specified time. You can add a completed broadcast to a playlist.

### Broadcast episode publishing settings {#stream-parameters}

You can change the following basic playback settings for broadcast episodes when [generating](../operations/streams/get-link.md) a direct link or website embed code:

* Muted playback by default.
* Automatic start of playback when opened.
* Displaying broadcast controls in the player.

{% include [iframe-settings](../../_includes/video/iframe-settings.md) %}

## See also {#see-also}

* [Getting started with a video broadcast](../streaming.md)
* [Getting started with API](../api-ref/quickstart.md)
