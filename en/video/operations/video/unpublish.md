---
title: How to unpublish a video in {{ video-full-name }}
description: Follow this guide to unpublish a video in {{ video-full-name }}.
---

# Unpublishing a video

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, select the video you need.
  1. On the opened page with video parameters, disable the **{{ ui-key.yacloud_video.videos.label_allow-access }}** option under **{{ ui-key.yacloud_video.videos.title_public-access-section }}**.

      The video will get the `{{ ui-key.yacloud_video.videos.status_unpublished }}` status and become unreachable via links.

- API {#api}

  Use the [VideoService/Update](../../api-ref/grpc/video_service.md#Update) gRPC API call.

{% endlist %}

If you [republish](publish.md) a video that was unpublished, it will become available again via its previous links.