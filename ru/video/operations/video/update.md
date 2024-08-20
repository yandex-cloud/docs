---
title: "Как изменить видео в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить видео в сервисе {{ video-full-name }}."
---

# Изменить видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Измените название и описание видео.
  1. Чтобы изменить обложку:

      1. Если у видео уже есть обложка, наведите указатель на превью обложки и нажмите значок ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите новое изображение для обложки.

          {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь вызовом gRPC API [VideoService/Update](../../api-ref/grpc/video_service.md#Update).

{% endlist %}

#### См. также {#see-also}

[{#T}](get-link.md)