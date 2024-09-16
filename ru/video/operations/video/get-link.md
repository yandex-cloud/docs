---
title: "Как получить код вставки или ссылку на видео в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете получить код вставки и ссылку на видео в сервисе {{ video-full-name }}."
---

# Получить код вставки или ссылку на видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![video](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите видео.
  1. В блоке **{{ ui-key.yacloud_video.videos.title_past-code }}**:

      1. Задайте необходимые параметры воспроизведения видео:

          1. `{{ ui-key.yacloud_video.streams.label_episode-mute }}`;
          1. `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`;
          1. `Показывать элементы управления в плеере`.

          {% include [iframe-settings](../../../_includes/video/iframe-settings.md) %}

      1. Выберите нужный формат ссылки на видео:

          * `html` — HTML-код для вставки видео в формате Iframe.
          * `link` — прямая ссылка на видео.

      1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

- API {#api}

  Воспользуйтесь вызовом gRPC API [VideoService/GetPlayerURL](../../api-ref/grpc/video_service.md#GetPlayerURL) или методом REST API [getPlayerURL](../../api-ref/Video/getPlayerURL.md) для ресурса [Video](../../api-ref/Video/index.md).

{% endlist %}