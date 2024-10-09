---
title: How to get an embed code or link to a video in {{ video-full-name }}
description: Follow this guide to get an embed code or link to a video in {{ video-full-name }}.
---

# Getting an embed code or link to a video

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![video](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, select the video.
  1. Under **{{ ui-key.yacloud_video.videos.title_past-code }}**:

      1. Set the required playback parameters for the video:

          1. `{{ ui-key.yacloud_video.streams.label_episode-mute }}`.
          1. `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`.
          1. `Display controls in the player`.

          {% include [iframe-settings](../../../_includes/video/iframe-settings.md) %}

      1. Select the preferred video link format:

          * `html`: HTML embed code in Iframe format.
          * `link`: Direct link to the video.

      1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

- API {#api}

  Use the [VideoService/GetPlayerURL](../../api-ref/grpc/video_service.md#GetPlayerURL) gRPC API call or the [getPlayerURL](../../api-ref/Video/getPlayerURL.md) REST API method for the [Video](../../api-ref/Video/index.md) resource.

{% endlist %}