---
title: How to delete a line in {{ video-full-name }}
description: Follow this guide to delete a {{ video-full-name }} line.
---

# Deleting a line

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** tab, in the line with the required line, click the ![image](../../../_assets/console-icons/ellipsis.svg) icon and select **{{ ui-key.yacloud_video.common.action_delete }}**.
   1. Click **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

   Use the [StreamLineService/Delete](../../api-ref/grpc/stream_line_service.md#Delete) gRPC API call.

{% endlist %}