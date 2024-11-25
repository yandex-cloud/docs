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

          1. `{{ ui-key.yacloud_video.streams.label_episode-mute }}`
          1. `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`
          1. `Display controls in the player`.

          {% include [iframe-settings](../../../_includes/video/iframe-settings.md) %}

      1. Select the preferred video link format:

          * `html`: HTML embed code in Iframe format.
          * `link`: Direct link to the video.

      1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

- REST API {#api}

  Run this command:

  {% include [get-video-link-rest](../../../_includes/video/get-video-link-rest.md) %}

  Where:
  * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) required for [authenticating](../../api-ref/authentication.md) with the {{ video-name }} API.
  * `<video_ID>`: ID of the video you want to get a link to.

  {% include [get-video-link-output](../../../_includes/video/get-video-link-output.md) %}

- gRPC API {#grpc-api}

  Run this command:

  {% include [get-video-link-grpc](../../../_includes/video/get-video-link-grpc.md) %}

  Where:
  * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) required for [authenticating](../../api-ref/authentication.md) with the {{ video-name }} API.
  * `<video_ID>`: ID of the video you want to get a link to.

  {% include [get-video-link-output](../../../_includes/video/get-video-link-output.md) %}

{% endlist %}