---
title: How to select a player preset in {{ video-full-name }}
description: Follow this guide to select a player preset for a given video in {{ video-full-name }}.
---

# Selecting a player preset

## Video template

To change the default template assigned to a given video at the channel level:

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the video and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Pick a template from the **{{ ui-key.yacloud_video.presets.label_style-preset }}** list.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [update](../../api-ref/Video/update.md) REST API method for the [Video](../../api-ref/Video/index.md) resource or the [VideoService/Update](../../api-ref/grpc/Video/update.md) gRPC API call by providing the `style_preset_id` parameter.

{% endlist %}

## Playlist template

To change the default template assigned to a given playlist at the channel level:

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud_video.playlists.title_playlists }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the playlist and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Pick a template from the **{{ ui-key.yacloud_video.presets.label_style-preset }}** list.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [update](../../api-ref/Playlist/update.md) REST API method for the [Playlist](../../api-ref/Playlist/index.md) resource or the [PlaylistService/Update](../../api-ref/grpc/Playlist/update.md) gRPC API call by providing the `style_preset_id` parameter.

{% endlist %}

A single template will apply to all videos in the playlist, even if a different template was assigned to one of the videos.

#### See also {#see-also}

* [{#T}](../video/update.md)
* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](set-default.md)