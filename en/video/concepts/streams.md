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

You can group broadcast episodes into [playlists](./playlists.md) in any order. For details on publishing playlists, see [{#T}](../operations/playlists/get-link.md).

Once a broadcast episode is over, you can keep its recording available or remove it.

{% include [streams-limits-notice](../../_includes/video/streams-limits-notice.md) %}

### Statuses {#statuses}

You can view statuses under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** in the relevant column.

Broadcast episodes can have the following statuses:

* `{{ ui-key.yacloud_video.streams.status_offline }}`: The broadcast is off. Displayed in two cases:
  * The broadcast is not started yet.
  * The broadcast ended either through disabling the **{{ ui-key.yacloud_video.streams.label_enable-broadcast }}** option or automatically at a specified time.
* `{{ ui-key.yacloud_video.streams.status_preparing }}`: Preparation of a fault-tolerant {{ yandex-cloud }} infrastructure for video transcoding is ongoing. Awaiting video signal. The broadcast gets this status a few minutes before it starts.
* `{{ ui-key.yacloud_video.streams.status_ready }}`: The infrastructure is ready, the video signal is received. You can start your broadcast.
* `{{ ui-key.yacloud_video.streams.status_on-air }}`: The broadcast is on. The broadcast gets this status as soon as you click ![play](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.streams.label_start-broadcast }}** or automatically at a specified time.

### Broadcast episode publishing settings {#stream-parameters}

You can change the following basic playback settings for broadcast episodes when [generating](../operations/streams/get-link.md) a direct link or website embed code:

{% include [publication-parameters](../_includes/video/publication-parameters.md) %}

{% include [iframe-settings](../../_includes/video/iframe-settings.md) %}

By default, there is a 15–20 second delay between the source and playback of the stream, which ensures high image quality and resilience to unstable connections. For scenarios with active viewer interaction, you can reduce the latency to 4-5 seconds, but this will require a high-quality network.

## Checking broadcast status {#streams-monitoring}

You can [monitor your broadcast status](../operations/streams/monitoring.md) with the help of summary metrics and the broadcast event log.

The following metrics are available:

* Video/audio FPS: Frames per second for video and audio tracks. These values ​​must match the settings of your broadcasting software. A drop in FPS may indicate a lack of hardware performance.

* Video/audio bitrate: Amount of multimedia data per unit of time. Sharp bitrate drops may indicate network or signal source issues.

* Stream drift: Graph for lag between video/audio tracks and real time. Shows the difference in your broadcasting software performance and the amount of data sent.

* Stream drift semaphore: Semaphore that changes its color depending on the difference between the current Stream Drift and the average Stream Drift over the last 30 seconds. The possible values are as follows:

  * Green: Good indicator, the difference is within the normal range (under 500 ms).
  * Yellow: Time to check source signal or network. Difference from 500 to 1,000 ms.
  * Red: Source signal or network issues, the broadcast will be interrupted. Difference in excess of 1,000 ms.

Look up the event log to see everything that has happened with the broadcast chronologically. Monitor errors and warnings to quickly identify issues.
Each event log entry contains the following:

* Broadcast date: Time the event occurred.
* Message: Event description.
* Status: Event type. There are two types of events:
  * `Information`: Informational message. For example, change in broadcast status.
  * `Error`: Error messages.

## Broadcast viewing statistics {#streams-statistics}

You can [view statistics](../operations/streams/get-statistics.md) for each broadcast and its episodes. To customize the statistics, select the calculation period and time interval. The difference from the previous period will help you estimate the growth or decline of interest in the broadcast.

{% include [statistics-description](../_includes/video/statistics-description.md) %}

This data will help you understand which devices and platforms are most popular among your audience and optimize your broadcast accordingly.

#### See also {#see-also}

* [Getting started with a video broadcast](../streaming.md)
* [Getting started with API](../api-ref/quickstart.md)
