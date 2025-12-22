---
title: How to delete a player preset in {{ video-full-name }}
description: Follow this guide to delete a player preset in {{ video-full-name }}.
---

# Deleting a player preset

{% note warning %}

You cannot delete the default template. If you need it deleted, [select](set-default.md) a different template as the default first.

{% endnote %}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the template row and select **{{ ui-key.yacloud_video.common.action_delete }}**.
  
     If the template is used in any video or playlist, the system will notify you. After deleting the template, the default template will be applied instead.
  
  1. Confirm the deletion.

- API {#api}

  Use the [delete](../../api-ref/StylePreset/delete.md) REST API method for the [StylePreset](../../api-ref/StylePreset/index.md) resource or the [StylePresetService/Delete](../../api-ref/grpc/StylePreset/delete.md) gRPC API call.

   If the template is used in any video or playlist, the default template will be applied instead.

{% endlist %}

#### See also {#see-also}

* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](get.md)
* [{#T}](set-default.md)