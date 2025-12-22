---
title: How to set a default player preset in {{ video-full-name }}
description: Follow this guide to select a default player preset in {{ video-full-name }}.
---

# Setting a default player preset

The default template applies to all videos and playlists on the channel unless a custom template is set. The system adds the `Default Style Preset` template for new channels.

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the template row and select **{{ ui-key.yacloud_video.presets.action_set-as-default }}**.
  
- API {#api}

  Use the [create](../../api-ref/Channel/create.md) or [update](../../api-ref/Channel/update.md) REST API method for the [Channel](../../api-ref/Channel/index.md) resource, [ChannelService/Create](../../api-ref/grpc/Channel/create.md) or [ChannelService/Update](../../api-ref/grpc/Channel/update.md) gRPC API call. Provide your settings in the `default_style_preset_id` parameter.

{% endlist %}

You cannot delete the default template.

#### See also {#see-also}

* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](delete.md)
* [{#T}](get.md)
* [{#T}](assign-to-video.md)