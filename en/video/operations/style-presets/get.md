---
title: How to get player preset information in {{ video-full-name }}
description: Follow this guide to get information about a player preset in {{ video-full-name }}.
---

# Getting player preset information

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. Navigate to the ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** tab.
  1. Find the preset you need in the list of presets. The preset information is displayed in a table where:
     * `Name`: Preset name.
     * `ID`: Unique preset ID.
     * `Updated`: Date and time of the most recent update.
     * `Default preset`: Status.
  1. To view detailed information, click the required preset.

- API {#api}

  To get a list of player presets, use the [list](../../api-ref/StylePreset/list.md) REST API method for the [StylePreset](../../api-ref/StylePreset/index.md) resource or the [StylePresetService/List](../../api-ref/grpc/StylePreset/list.md) gRPC API call.

  To get information about a player preset, use the [get](../../api-ref/StylePreset/get.md) REST API method for the [StylePreset](../../api-ref/StylePreset/index.md) resource or the [StylePresetService/Get](../../api-ref/grpc/StylePreset/get.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](delete.md)
* [{#T}](set-default.md)