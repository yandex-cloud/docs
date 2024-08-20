---
title: "Как создать линию в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете создать линию {{ video-full-name }}."
---

# Создать линию

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** нажмите кнопку **{{ ui-key.yacloud_video.stream-lines.action_create-line }}**.
  1. Введите имя линии.
  1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** выберите [нужный протокол](../../concepts/streams.md#lines): `RTMP` или `SRT`.
  1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** выберите:

      {% include [push-pull](../../../_includes/video/push-pull.md) %}

  1. Если вы выбрали тип потока `Pull`, в поле **{{ ui-key.yacloud_video.stream-lines.label_url }}** укажите адрес вашего сервера трансляций.
  1. В поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

- API {#api}

  Воспользуйтесь вызовом gRPC API [StreamLineService/Create](../../api-ref/grpc/stream_line_service.md#Create).

{% endlist %}