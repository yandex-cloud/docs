---
title: How to create a playlist in {{ video-full-name }}
description: Follow this guide to create a playlist in {{ video-name }}.
---

# Creating a playlist

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud_video.playlists.title_playlists }}** tab, click **{{ ui-key.yacloud_video.playlists.action_create-playlist }}**.
  1. Enter a name and description for your playlist.
  1. To add a video or completed broadcast to a playlist, click **{{ ui-key.yacloud_video.playlists.action_add-playlist-video }}** in the **{{ ui-key.yacloud_video.playlists.title_playlists-video-list }}** section. In the window that opens, do the following:

      1. On the `Videos` or `Broadcasts` tab, select the videos or broadcasts you want to add.

          In playlists, only videos with [permanent links](../../concepts/videos.md#permanent-link) will be available for viewing.

      1. Click **{{ ui-key.yacloud_video.common.action_add }}**.
  1. In the **{{ ui-key.yacloud_video.presets.label_style-preset }}** list, select a player [preset](../../concepts/presets.md) from those available in the channel or create a new one.
  1. Click **{{ ui-key.yacloud_video.common.action_create }}**.

{% endlist %}

#### See also {#see-also}

* [Playlists in {{ video-name }}](../../concepts/playlists.md)
* [{#T}](get-link.md)
* [{#T}](update.md)
* [{#T}](delete.md)