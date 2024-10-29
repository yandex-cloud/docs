---
title: How to create a channel in {{ video-full-name }}
description: Follow this guide to create a {{ video-full-name }} channel.
---

# Creating a channel

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   {% include [create-channel](../../../_includes/video/create-channel.md) %}

- API {#api}

   Use the [ChannelService/Create](../../api-ref/grpc/Channel/create.md) gRPC API call.

{% endlist %}