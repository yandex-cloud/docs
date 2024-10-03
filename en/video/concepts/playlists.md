# Playlists

In {{ video-name }}, you can [group](../operations/playlists/create.md) videos and completed broadcasts into playlists in desired order and [reorder](../operations/playlists/update.md) them.

In the [video player](./player.md), viewers see the full list of [videos](./videos.md) and [broadcasts](./streams.md) inside a playlist. If you reorder videos or broadcasts inside a playlist, viewers will only see the changes after refreshing the video player page.

{% note info %}

The full list of videos and broadcasts inside the playlist in the player is available to viewers even with `{{ ui-key.yacloud_video.streams.label_episode-hidden }}` enabled.

{% endnote %}

As soon as a video or broadcast from the playlist is over, the next one in the list will automatically start. Playlist playback will be interrupted if the next video or broadcast requires viewer access permissions.

You can [publish](../operations/playlists/get-link.md) your playlists using direct links or by posting them to a website.

## Playlist publishing parameters {#playlist-parameters}

You can change the following basic video playback settings for a playlist when [generating](../operations/playlists/get-link.md) a direct link or website embed code:

* Default sound setting for video playback.
* Automatic start of playback when opened.
* Displaying video controls in the player.

{% include [iframe-settings](../../_includes/video/iframe-settings.md) %}