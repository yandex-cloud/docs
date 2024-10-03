---
title: How to edit a playlist in {{ video-full-name }}
description: Follow this guide to edit a playlist in {{ video-name }}.
---

# Editing a playlist

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/bars-play.svg) **Playlists** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the playlist and select **{{ ui-key.yacloud_video.common.action_edit }}**.
   1. Edit your playlist title and description.
   1. In the **Playback order** section:

      * To delete a video or broadcast from a playlist, click ![image](../../../_assets/console-icons/trash-bin.svg) in the appropriate row.

      * To reorder videos or broadcasts in a playlist, move them around by holding down ![image](../../../_assets/console-icons/grip.svg).

         {% note info %}

         After you reorder videos or broadcasts in a playlist, viewers will only see the changes after refreshing the video player page.

         {% endnote %}

      * To add a video or completed broadcast to a playlist, click **Add video**. In the window that opens:

         1. On the `Videos` or `Broadcasts` tab, select the videos or broadcasts you want to add.
         1. Click **{{ ui-key.yacloud_video.common.action_add }}**.
   1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}

#### See also {#see-also}

* [Playlists in {{ video-name }}](../../concepts/playlists.md)
* [{#T}](get-link.md)
* [{#T}](delete.md)