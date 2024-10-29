---
title: How to create a channel in {{ video-full-name }}
description: Follow this guide to create a {{ video-full-name }} channel.
---

# Creating a channel

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  {% include [create-channel](../../../_includes/video/create-channel.md) %}

- API {#api}

  Use the [create](../../api-ref/Channel/create.md) REST API method for the [Channel](../../api-ref/Channel/index.md) resource or the [ChannelService/Create](../../api-ref/grpc/Channel/create.md) gRPC API call.
  
  For more information about creating a channel, see [Getting started with the {{ video-full-name }} API](../../api-ref/quickstart.md#create-channel).

{% endlist %}