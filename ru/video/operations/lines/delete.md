---
title: Как удалить линию в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете удалить линию {{ video-full-name }}.
---

# Удалить линию

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** в строке с нужной линией нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/StreamLine/delete.md) для ресурса [StreamLine](../../api-ref/StreamLine/index.md) или вызовом gRPC API [StreamLineService/Delete](../../api-ref/grpc/stream_line_service.md#Delete).

{% endlist %}