---
title: How to download a video in {{ video-full-name }}
description: Follow this guide to download a video from {{ video-full-name }}.
---

# Downloading a video

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, download a video using one of the following methods:
     * In the row with the video, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud_video.common.action_download }}**.
     * Select the video and click ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud_video.common.action_download }}** in the top-right corner of the window that opens.

- REST API {#api}

  Run this command:

  ```bash
  curl \
    --request POST \
    --header 'Authorization: Bearer <IAM_token>' \
    --url 'https://video.{{ api-host }}/video/v1/videos/<video_ID>:generateDownloadURL'
  ```

  {% include [download-api-parameters-description](../../../_includes/video/download-api-parameters-description.md) %}

  {% include [download-video-link-output](../../../_includes/video/download-video-link-output.md) %}

- gRPC API {#grpc-api}

  Run this command:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \
    -d '{
      "videoId": "<video_ID>"
    }' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GenerateDownloadURL
  ```

  {% include [download-api-parameters-description](../../../_includes/video/download-api-parameters-description.md) %}

  {% include [download-video-link-output](../../../_includes/video/download-video-link-output.md) %}

{% endlist %}