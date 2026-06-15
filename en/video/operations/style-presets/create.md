---
title: How to create a player preset in {{ video-full-name }}
description: Follow this guide to create a player preset in {{ video-full-name }}.
---

# Creating a player preset

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** tab, click **{{ ui-key.yacloud_video.presets.action_create-preset }}**.
  1. In the **{{ ui-key.yacloud_video.presets.label_title }}** field, specify the preset name.
  1. Under **{{ ui-key.yacloud_video.presets.section_wigets-settings }}**:
     * Enable or disable the relevant widgets.
     * Set their location in the player interface.

  1. Under **{{ ui-key.yacloud_video.presets.section_styles-settings }}**:
     * Select a color scheme.
     * Set the sizes of elements.
     * Configure other visual settings.
  
  1. Under **{{ ui-key.yacloud_video.presets.section_logo-settings }}**:
     1. Enable the **{{ ui-key.yacloud_video.presets.field_logo-enabled }}** option to display your logo over the video.
     1. Upload the logo image (2 MB or less) in JPG, PNG, or GIF format.
     1. Enable **{{ ui-key.yacloud_video.presets.field_logo-show-with-controls }}** for the logo to disappear together with player controls when the user is not interacting with the video.
     1. In the **{{ ui-key.yacloud_video.presets.field_logo-redirect-on-click-url }}** field, add a URL that will open when the logo is clicked.
  
  1. Optionally, to see what the video and playlist will look like a separate window with the selected preset, click **{{ ui-key.yacloud_video.presets.button_open-preset-template-dialog }}**.
  1. Click **{{ ui-key.yacloud_video.common.action_create }}**.

- API {#api}

  Use the [create](../../api-ref/StylePreset/create.md) REST API method for the [StylePreset](../../api-ref/StylePreset/index.md) resource or the [StylePresetService/Create](../../api-ref/grpc/StylePreset/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)
* [{#T}](get.md)