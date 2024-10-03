---
title: How to download a video in {{ video-full-name }}
description: Follow this guide to download videos from {{ video-full-name }}.
---

# Downloading a video

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the line with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_download }}**.

- API {#api}

   Use the [VideoService/Get](../../api-ref/grpc/video_service.md#Get) gRPC API call.

{% endlist %}