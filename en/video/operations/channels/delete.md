---
title: How to delete a channel in {{ video-full-name }}
description: Follow this guide to delete a {{ video-full-name }} channel.
---

# Deleting a channel

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. In the row with the channel you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Click **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

  Use the [delete](../../api-ref/Channel/delete.md) REST API method for the [Channel](../../api-ref/Channel/index.md) resource or the [ChannelService/Delete](../../api-ref/grpc/Channel/delete.md) gRPC API call.

{% endlist %}