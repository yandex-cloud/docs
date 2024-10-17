---
title: Как создать канал в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете создать канал {{ video-full-name }}.
---

# Создать канал

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  {% include [create-channel](../../../_includes/video/create-channel.md) %}

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Channel/create.md) для ресурса [Channel](../../api-ref/Channel/index.md) или вызовом gRPC API [ChannelService/Create](../../api-ref/grpc/Channel/create.md).
  
  Подробности о создании канала см. в инструкции [Как начать работать с API {{ video-full-name }}](../../api-ref/quickstart.md#create-channel).

{% endlist %}