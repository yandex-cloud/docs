---
title: "Как удалить канал в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете удалить канал {{ video-full-name }}."
---

# Удалить канал

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. В строке нужного канала нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

  Воспользуйтесь вызовом gRPC API [ChannelService/Delete](../../api-ref/grpc/channel_service.md#Delete).

{% endlist %}