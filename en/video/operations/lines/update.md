---
title: How to edit a line in {{ video-full-name }}
description: Follow this guide to edit a {{ video-full-name }} line.
---

# Editing a line

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** tab, in the row with the line you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Change the line name.
  1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** field, select the [required protocol](../../concepts/streams.md#lines), `RTMP` or `SRT`.
  1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** field, select:

      {% include [push-pull](../../../_includes/video/push-pull.md) %}

  1. If you selected the `Pull` stream type, enter the address of your broadcast server in the **{{ ui-key.yacloud_video.stream-lines.label_url }}** field.
  1. To change the cover:

      1. If the line already has a cover, hover over the cover preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new cover image.

          {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [update](../../api-ref/StreamLine/update.md) REST API method for the [StreamLine](../../api-ref/StreamLine/index.md) resource or the [StreamLineService/Update](../../api-ref/grpc/StreamLine/update.md) gRPC API call.

{% endlist %}