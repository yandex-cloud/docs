---
title: How to delete a broadcast in {{ video-full-name }}
description: Follow this guide to delete a {{ video-full-name }} broadcast.
---

# Deleting a broadcast

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_video.common.action_delete }}** next to the broadcast.
  1. Click **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

  Use the [delete](../../api-ref/Stream/delete.md) REST API method for the [Stream](../../api-ref/Stream/index.md) resource or the [StreamService/Delete](../../api-ref/grpc/Stream/delete.md) gRPC API call.

{% endlist %}