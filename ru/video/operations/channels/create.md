---
title: "Как создать канал в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете создать канал {{ video-full-name }}."
---

# Создать канал

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  {% include [create-channel](../../../_includes/video/create-channel.md) %}

- API {#api}

  Воспользуйтесь вызовом gRPC API [ChannelService/Create](../../api-ref/grpc/channel_service.md#Create).
  
{% endlist %}