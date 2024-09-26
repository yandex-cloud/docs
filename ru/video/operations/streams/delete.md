---
title: "Как удалить трансляцию в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете удалить трансляцию {{ video-full-name }}."
---

# Удалить трансляцию

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** в строке с нужной трансляцией нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Stream/delete.md) для ресурса [Stream](../../api-ref/Stream/index.md) или вызовом gRPC API [StreamService/Delete](../../api-ref/grpc/stream_service.md#Delete).

{% endlist %}