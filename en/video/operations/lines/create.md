---
title: How to create a line in {{ video-full-name }}
description: Follow this guide to create a {{ video-full-name }} line.
---

# Creating a line

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. In the ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** tab, click **{{ ui-key.yacloud_video.stream-lines.action_create-line }}**.
   1. Enter a name for the line.
   1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** field, select the [required protocol](../../concepts/streams.md#lines): `RTMP` or `SRT`.
   1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** field, select:

      {% include [push-pull](../../../_includes/video/push-pull.md) %}

   1. If you selected the `Pull` stream type, enter the address of your broadcast server in the **{{ ui-key.yacloud_video.stream-lines.label_url }}** field.
   1. In the **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** field, click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select an image for the cover.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

   1. Click **{{ ui-key.yacloud_video.common.action_create }}**.

- API {#api}

   Use the [StreamLineService/Create](../../api-ref/grpc/stream_line_service.md#Create) gRPC API call.

{% endlist %}