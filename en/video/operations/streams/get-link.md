---
title: "How to get an embed code or broadcast link in {{ video-full-name }}"
description: "Follow this guide to get the {{ video-full-name }} embed code or link to the broadcast."
---

# Getting an embed code or link to a broadcast

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select a stream.
   1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, click **</> {{ ui-key.yacloud_video.streams.title_past-code }}**.

   1. Set the required playback parameters for the broadcast:

      1. `{{ ui-key.yacloud_video.streams.label_episode-mute }}`.
      1. `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`.
      1. `Displaying controls in the player`.

      {% include [iframe-settings](../../../_includes/video/iframe-settings.md) %}

   1. Select the preferred broadcast link format:

      * `html`: HTML embed code in Iframe format.
      * `link`: Direct link to the broadcast.

   1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

- API {#api}

   Use the [EpisodeService/GetPlayerURL](../../api-ref/grpc/episode_service.md#GetPlayerURL) gRPC API call.

{% endlist %}