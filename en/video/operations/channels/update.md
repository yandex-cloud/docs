---
title: "How to edit a channel in {{ video-full-name }}"
description: "Follow this guide to edit a {{ video-full-name }} channel."
---

# Editing a channel

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. In the line of the proper channel, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
   1. Edit the channel name and description.
   1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

   Use the [ChannelService/Update](../../api-ref/grpc/channel_service.md#Update) gRPC API call.

{% endlist %}

#### See also {#see-also}

[{#T}](../video/upload.md)