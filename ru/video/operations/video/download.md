---
title: Как скачать видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете скачать видео из сервиса {{ video-full-name }}.
---

# Скачать видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** скачайте видео одним из способов:
     * В строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud_video.common.action_download }}**.
     * Выберите видео и на открывшейся странице в правом верхнем углу нажмите ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud_video.common.action_download }}**.

- REST API {#api}

  Выполните команду:

  ```bash
  curl \
    --request POST \
    --header 'Authorization: Bearer <IAM-токен>' \
    --url 'https://video.{{ api-host }}/video/v1/videos/<идентификатор_видео>:generateDownloadURL'
  ```

  {% include [download-api-parameters-description](../../../_includes/video/download-api-parameters-description.md) %}

  {% include [download-video-link-output](../../../_includes/video/download-video-link-output.md) %}

- gRPC API {#grpc-api}

  Выполните команду:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
      "videoId": "<идентификатор_видео>"
    }' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GenerateDownloadURL
  ```

  {% include [download-api-parameters-description](../../../_includes/video/download-api-parameters-description.md) %}

  {% include [download-video-link-output](../../../_includes/video/download-video-link-output.md) %}

{% endlist %}