# Out-of-the-box video layout solutions in IFrame

This guide offers examples of [video player](../../video/concepts/player.md) layouts you can choose from based on the purpose of your video. Pick one of the options and customize it as needed.

To use the examples to configure a video in IFrame:

1. Upload a video to [{{ video-full-name }}](../../video/hosting.md).
1. Save the link to the video.
1. Add the [iframe embedding code](../../video/sdk/iframe/index.md) to your HTML page code.
1. Copy the iframe embedding code from the example with the link to your video added to it.

If you want your video provided as a URL, copy its properties after `?` from the `src` field in the example.

You can configure some of the video player parameters in the {{ video-name }} interface:

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, select a video.
  1. [Set up](../../video/operations/video/update.md) the video.
  1. Copy the iframe embedding code on the **html** tab in the **{{ ui-key.yacloud_video.videos.title_past-code }}** section.
  1. Add the iframe embedding code to your HTML page code.
  1. To provide the video as a URL, copy the link content with settings on the **link** tab.

{% endlist %}

## Muted autoplay {#mute}

{% note info %}

Video autoplay may be restricted by browser policies. For more information, see [{#T}](../../video/autoplay-policy.md).

{% endnote %}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="<link>?autoplay=1&mute=true">
</iframe>
```

Where:
* `Where <link>` is a link to playable content, e.g., `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1`: Automatically starts video playback at player startup.
* `mute=true`: Mutes the video.

{% cut "Example" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&mute=true">
</iframe>

{% endcut %}


## Looped autoplay {#automatically-loop}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<link>?autoplay=1&loop=true">
</iframe>
```

Where:
* `Where <link>` is a link to playable content, e.g., `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1`: Automatically starts video playback at player startup.
* `loop=true`: Loops playback.

{% cut "Example" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&loop=true">
</iframe>

{% endcut %}


## Autoplay with hidden UI elements {#autoplay-hidden-elements}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<link>?autoplay=1&hidden=*,!time,!sound">
</iframe>
```

Where:
* `Where <link>` is a link to playable content, e.g., `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1`: Automatically starts video playback at player startup.
* `hidden=*,!time,!sound`: Hides all player UI elements except for current time and the mute/unmute button.

{% cut "Example" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&hidden=*,!time,!sound"
</iframe>

{% endcut %}


## No rewinding {#prohibit-rewinding}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<link>?autoplay=1&hidden=timeline,mobileSeekButtons,timelinePreview">
</iframe>
```

Where:
* `Where <link>` is a link to playable content, e.g., `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1`: Automatically starts video playback at player startup.
* `hidden=timeline,mobileSeekButtons,timelinePreview`: Hides the timeline, its preview, and rewind and fast forward buttons in the mobile interface. 

{% note info %}

Due to the specifics of the iPhone platform, rewinding will still be available in full-screen mode. To completely disable rewinding on iPhone, you need to hide the full-screen button (`fullscreen`) and disable the picture-in-picture (PiP) mode by removing `picture-in-picture` from the `allow` attribute.

{% endnote %}

{% cut "Example" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&hidden=timeline,mobileSeekButtons,timelinePreview">
</iframe>

{% endcut %}


## Setting up player widgets {#widgets}

```html
<iframe
    width="560" height="315"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<link>?player_color=yellow&autoplay=0&player_border_radius=10">
</iframe>
```

Where:
* `width`: Player section width.
* `height`: Player section height.
* `Where <link>` is a link to playable content, e.g., `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `player_color`: Sets the colors of player UI elements.
* `player_border_radius`: Rounds the player section corners.

{% cut "Example" %}

<iframe
    width="560" height="315"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?player_color=yellow&autoplay=0&player_border_radius=10">
</iframe>

{% endcut %}


## Configuring a video for a product card {#product_card}

For a product card, you want your video autoplayed when visible, on mute, and without controls.

```html
<iframe
    frameborder="10"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<link>?loop=true&allow_muted=true&play_on_visible=true&hidden=*">
</iframe>
```

Where:
* `frameborder`: Player section frame width.
* `Where <link>` is a link to playable content, e.g., `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `loop=true`: Loops playback.
* `allow_muted=true`: Autoplays video on mute.
* `play_on_visible=true`: Video is played back only if visible.
* `hidden=*`: Hides all player UI elements.

{% cut "Example" %}

<iframe
    frameborder="10"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?loop=true&allow_muted=true&play_on_visible=true&hidden=*">
</iframe>

{% endcut %}

## Recommending other videos {#playlist_settings}

Use the [playlist](../../video/concepts/playlists.md) feature to recommend other videos on the same topic at the end of the video:

1. Upload several videos to [{{ video-full-name }}](../../video/hosting.md).
1. [Create a playlist](../../video/operations/playlists/create.md) and add the videos to it.
1. Save the link to the playlist.
1. Add the [iframe embedding code](../../video/sdk/iframe/index.md) to your HTML page code.
1. Copy the iframe embedding code from the example with the link to your playlist added to it.

{% note info %}

The player section must be big enough to display the playlist.

{% endnote %}

```html
<iframe
    frameborder="0"
    width="300" height="400"
    scrolling="no"
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<link_to_playlist>?autoplay=0&mute=0&background_color=ffeaea&widget_text_color_primary=841327&playlist_selected_item_background_color=FF8EA2&player_border_radius=10&playlist_item_border_radius=5">
</iframe>
```

Where:
* `frameborder`: Player section frame width.
* `width`: Player section width.
* `height`: Player section height.
* `<link_to_playlist>`: Link to the playlist, e.g., `https://runtime.strm.yandex.ru/player/playlist/vplqibh5xiq5c45ij777`.
* `autoplay=0`: Auto playback off.
* `mute=0`: Sound on.
* Style parameters:
  * `background_color=ffeaea`: Background color of the player and widgets.
  * `widget_text_color_primary=841327`: Widget body text color.
  * `playlist_selected_item_background_color=FF8EA2`: Background color of the active playlist element.
  * `player_border_radius=10`: Rounding of the player section corners.
  * `playlist_item_border_radius=5`: Rounding of the playlist element corners.

Learn more about style parameters in [{#T}](../../video/sdk/iframe/initialization.md#styling).

{% cut "Example" %}

<iframe
    frameborder="0"
    width="300" height="400"
    scrolling="no"
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.strm.yandex.ru/player/playlist/vplqibh5xiq5c45ij777?autoplay=0&mute=0&background_color=ffeaea&widget_text_color_primary=841327&playlist_selected_item_background_color=FF8EA2&player_border_radius=10&playlist_item_border_radius=5">
</iframe>

{% endcut %}