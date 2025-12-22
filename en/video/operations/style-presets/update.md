---
title: How to update or duplicate a player preset in {{ video-full-name }}
description: Follow this guide to update or duplicate a player preset in {{ video-full-name }}.
---

# Updating or duplicating a player preset

## Updating a player preset {#update}

You can update the pre-installed `Default Style Preset` and `Summarization Style Preset` player presets or [create](create.md) your own preset.

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** tab, select the preset.
  1. In the **{{ ui-key.yacloud_video.presets.label_title }}** field, update the preset name.
  1. Under **{{ ui-key.yacloud_video.presets.section_wigets-settings }}**:
     * Enable or disable the relevant widgets.
     * Change their position in the player interface.
  1. Under **{{ ui-key.yacloud_video.presets.section_styles-settings }}**:
     * Change the color scheme.
     * Set the sizes of elements.
     * Configure other visual settings.
  1. Optionally, to open a new window to see what videos and playlist will look like with the selected template, click **{{ ui-key.yacloud_video.presets.button_open-preset-template-dialog }}**.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [update](../../api-ref/StylePreset/update.md) REST API method for the [StylePreset](../../api-ref/StylePreset/index.md) resource or the [StylePresetService/Update](../../api-ref/grpc/StylePreset/update.md) gRPC API call.

{% endlist %}

## Duplicating a player preset {#duplicate}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** tab, in the relevant preset row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.datalens.component.plugin-with-menu.view.button_duplicate }}**.
  1. The duplicate will appear in the preset list. Change the widget and style settings, if required.
  
- API {#api}

  To duplicate a preset:
  
  1. Get information about the existing preset using the [get](../../api-ref/StylePreset/get.md) REST API method for the [StylePreset](../../api-ref/StylePreset/index.md) resource or the [StylePresetService/Get](../../api-ref/grpc/StylePreset/get.md) gRPC API call.
  1. Create a new preset with the same parameters using the [create](../../api-ref/StylePreset/create.md) REST API method for the [StylePreset](../../api-ref/StylePreset/index.md) resource or the [StylePresetService/Create](../../api-ref/grpc/StylePreset/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](create.md)
* [{#T}](delete.md)
* [{#T}](get.md)
* [{#T}](set-default.md)