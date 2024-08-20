---
title: "Как изменить канал в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить канал {{ video-full-name }}."
---

# Изменить канал

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. В строке нужного канала нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Измените имя и описание канала.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь вызовом gRPC API [ChannelService/Update](../../api-ref/grpc/channel_service.md#Update).

{% endlist %}

#### См. также {#see-also}

[{#T}](../video/upload.md)