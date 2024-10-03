---
title: How to publish a video in {{ video-full-name }}
description: Follow this guide to publish a video uploaded to {{ video-full-name }} and check its availability.
---

# Publishing a video

You can publish a video and check its availability.

## Publish your video {#publish-video}

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. [Upload](upload.md) a video.
  1. Wait until the video is completely uploaded, processed, and gets the `{{ ui-key.yacloud_video.videos.status_ready }}` status.

  {% include [default-visibility-status](../../../_includes/video/default-visibility-status.md) %}

- API {#api}

  Use the [VideoService/Create](../../api-ref/grpc/video_service.md#Create) gRPC API call.

{% endlist %}

## Check if the video is available {#test}

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, select your video.
  1. On the opened page with video parameters, select the `link` tab under **{{ ui-key.yacloud_video.videos.title_past-code }}**.
  1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Open a new browser page and paste the obtained URL to the address bar.
  1. Click the Play button.

- API {#api}

  Use the [VideoService/GetPlayerURL](../../api-ref/grpc/video_service.md#GetPlayerURL) gRPC API call.

{% endlist %}

#### See also {#see-also}

[{#T}](get-link.md)
[{#T}](download.md)