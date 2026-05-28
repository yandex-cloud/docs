---
title: How to get an embed code or link to a broadcast in {{ video-full-name }}
description: Follow this guide to get a {{ video-full-name }} embed code or link to a broadcast.
---

# Getting an embed code or link to a broadcast

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select the broadcast you need.
  1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, select an episode.

  1. Specify the required playback settings for the broadcast episode:

      1. `{{ ui-key.yacloud_video.streams.label_episode-mute }}`
      1. `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`
      1. `{{ ui-key.yacloud_video.streams.label_episode-hidden }}`.

      {% include [iframe-settings](../../../_includes/video/iframe-settings.md) %}

  1. Select the preferred broadcast link format:

      * `html`: HTML embed code in Iframe format.
      * `link`: Direct link to the broadcast.

  1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

- API {#api}

  Use the [getPlayerURL](../../api-ref/Episode/getPlayerURL.md) REST API method for the [Episode](../../api-ref/Episode/index.md) resource or the [EpisodeService/GetPlayerURL](../../api-ref/grpc/Episode/getPlayerURL.md) gRPC API call.

{% endlist %}