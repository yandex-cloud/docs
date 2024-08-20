---
title: "How to edit a broadcast in {{ video-full-name }}"
description: "Follow this guide to edit a {{ video-full-name }} broadcast."
---

# Editing a broadcast

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, in the line with the required broadcast, click the ![image](../../../_assets/console-icons/ellipsis.svg) icon and select **{{ ui-key.yacloud_video.common.action_edit }}**.
   1. Edit the broadcast name and description.
   1. Select or [create](../lines/create.md) a new line.
   1. To change the cover:

      1. If the line broadcast has a cover, hover over the cover preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new image for the cover.

         {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

   1. Select the preferred [broadcast](../../concepts/streams.md#streams) stream type:

      * `{{ ui-key.yacloud_video.streams.label_type-on-demand }}`: Start and end the broadcast manually from the {{ video-name }} interface.
      * `{{ ui-key.yacloud_video.streams.label_type-schedule }}`: Start and end the broadcast automatically at the specified time.

   1. If you selected the `{{ ui-key.yacloud_video.streams.label_type-schedule }}` stream type, specify the start and end date and time of the broadcast.
   1. (Optional) To place part of the broadcast on the website, select it as a separate episode:

      1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.streams.action_add-stream-episode }}**.
      1. Enter a name and description for the episode.
      1. Specify the start and end date and time of the episode.
      1. In the **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** field, click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select an image for the cover.

         {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

      You can add any number of episodes. To delete an episode you do not need, click ![image](../../../_assets/console-icons/trash-bin.svg).

   1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

   Use the [StreamService/Update](../../api-ref/grpc/stream_service.md#Update) gRPC API call.

{% endlist %}