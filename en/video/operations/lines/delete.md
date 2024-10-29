---
title: How to delete a line in {{ video-full-name }}
description: Follow this guide to delete a {{ video-full-name }} line.
---

# Deleting a line

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** tab, in the row with the line you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Click **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

  Use the [delete](../../api-ref/StreamLine/delete.md) REST API method for the [StreamLine](../../api-ref/StreamLine/index.md) resource or the [StreamLineService/Delete](../../api-ref/grpc/StreamLine/delete.md) gRPC API call.

{% endlist %}