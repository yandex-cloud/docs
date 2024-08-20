---
title: "How to delete a broadcast in {{ video-full-name }}"
description: "Follow this guide to delete a {{ video-full-name }} broadcast."
---

# Deleting a broadcast

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, in the line with the required broadcast, click the ![image](../../../_assets/console-icons/ellipsis.svg) icon and select **{{ ui-key.yacloud_video.common.action_delete }}**.
   1. Click **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

   Use the [StreamService/Delete](../../api-ref/grpc/stream_service.md#Delete) gRPC API call.

{% endlist %}