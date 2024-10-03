---
title: How to edit a line in {{ video-full-name }}
description: Follow this guide to edit a {{ video-full-name }} line.
---

# Editing a line

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** tab, in the line with the required line, click the ![image](../../../_assets/console-icons/ellipsis.svg) icon and select **{{ ui-key.yacloud_video.common.action_edit }}**.
   1. Change the line name.
   1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** field, select the [required protocol](../../concepts/streams.md#lines): `RTMP` or `SRT`.
   1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** field, select:

      {% include [push-pull](../../../_includes/video/push-pull.md) %}

   1. If you selected the `Pull` stream type, enter the address of your broadcast server in the **{{ ui-key.yacloud_video.stream-lines.label_url }}** field.
   1. To change the cover:

      1. If the line already has a cover, hover over the cover preview and click the ![image](../../../_assets/console-icons/circle-xmark.svg) icon.
      1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new image for the cover.

         {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

   1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

   Use the [StreamLineService/Update](../../api-ref/grpc/stream_line_service.md#Update) gRPC API call.

{% endlist %}