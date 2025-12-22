_Player presets_ allow you to configure video player appearance and features for [videos](../../video/concepts/videos.md) and [playlists](../../video/concepts/playlists.md) in the channel. With templates, you can:

* Configure widgets: a playlist, description, and summary. Enable the widgets you need and set their position in the player interface.
* Set player and widget styles: configure a color scheme, element sizes, and other visual settings.

### Default presets {#default-presets}

When you [create a channel](../../video/operations/channels/create.md), two presets are created automatically:

* `Default Style Preset`: Default preset with cloud styles.
* `Summarization Style Preset`: Preset that includes a widget for a video summary.

Default preset properties:

* The default preset styles apply to all videos and playlists on the channel unless they use a redefined preset.
* You cannot [delete](../../video/operations/style-presets/delete.md) the default preset, but you can [reassign](../../video/operations/style-presets/set-default.md) it.

You can [redefine the preset](../../video/operations/style-presets/assign-to-video.md) for a specific video or playlist in their settings.

You can also customize the appearance using the [video player SDK for IFrame](../../video/iframe-sdk.md). The SDK features more player settings, e.g., you can enable autoplay when the player loads, start video playback on mute, hide player controls, etc. 