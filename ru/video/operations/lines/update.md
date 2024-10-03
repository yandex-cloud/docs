---
title: Как изменить линию в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете изменить линию {{ video-full-name }}.
---

# Изменить линию

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** в строке с нужной линией нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Измените имя линии.
  1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** выберите [нужный протокол](../../concepts/streams.md#lines): `RTMP` или `SRT`.
  1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** выберите:

      {% include [push-pull](../../../_includes/video/push-pull.md) %}

  1. Если вы выбрали тип потока `Pull`, в поле **{{ ui-key.yacloud_video.stream-lines.label_url }}** укажите адрес вашего сервера трансляций.
  1. Чтобы изменить обложку:

      1. Если у линии уже есть обложка, наведите указатель на превью обложки и нажмите значок ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите новое изображение для обложки.

          {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/StreamLine/update.md) для ресурса [StreamLine](../../api-ref/StreamLine/index.md) или вызовом gRPC API [StreamLineService/Update](../../api-ref/grpc/stream_line_service.md#Update).

{% endlist %}