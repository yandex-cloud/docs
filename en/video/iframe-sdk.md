# Reference guide on Cloud Video Player SDK for IFrame

You can embed a [video player](./concepts/player.md) with content from {{ video-name }} to an HTML page using Cloud Video Player SDK for IFrame.

Add an [iframe](https://en.wikipedia.org/wiki/HTML_element#Frames) container to the page code:

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/{video_content_id}?autoplay=1&mute=1"
></iframe>
```

Where `{video_content_id}` is the video content ID. For more information, see [{#T}](./operations/video/get-link.md) and [{#T}](./operations/streams/get-link.md).

The embed code contains an iframe container that shows the player with the specified video.

You can also set up the [video size](#size) and [playback parameters](#parameters).

## Setting up the video size {#size}

To specify your video size, set the following parameters in the `iframe` tag: `height` for the height and `width` for the width.

Example:

```html
<iframe width="560" height="315"
  frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/{video_content_id}"
></iframe>
```

To adjust the video to the container width, change the embed code as follows:

```html
<div style="min-width: 100%">
  <div style="position: relative; padding-bottom: 56.25%; height: 0;">
    <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
        frameborder="0"
        scrolling="no"
        allowfullscreen
        allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
        src="https://runtime.video.cloud.yandex.net/player/{video_content_id}?autoplay=1&mute=true"
    ></iframe>
  </div>
</div>
```

## Setting up the playback parameters {#parameters}

Customize your player appearance and video playback using special parameters.

To the embed code URL, after `?`, add `parameter=value` pairs separated by `&`:

```http
https://https://runtime.video.cloud.yandex.net/player/{video_content_id}?{param1=value1}&...&{paramN=valueN}
```

You can see the list of parameters and their possible values in the table below. If you do not specify the parameters, the player will start with default parameters.

#|

|| **Parameter:** | **Description:** ||
|| `allow_muted`  |
Automatically play video in mute mode once the player loads:

* `false`: Muted autoplay is prohibited.
* `true`: Muted autoplay is allowed.

The `allow_muted` parameter has priority over `autoplay`. When using `allow_muted=false`, autoplay will occur only in case it is possible in unmuted mode.
||
|| `autoplay` |
Automatically play video once the player loads:

* `0`: Auto playback is off.
* `1`: Auto playback is on.

The default value is `0`.

For the autoplay option to work correctly in all browsers, use the `autoplay=1` parameter along with the `mute=1` parameter.
||
|| `hidden` |
Using this parameter, you can hide the player interface elements. All of them are shown by default.

{% cut "List of interface elements" %}

* `*`: All interface elements.
* `contextMenu`: Context menu.
* `fullscreen`: Full screen toggle button.
* `live`: **Go back to live** button.
* `mobileSeekButtons`: Rewind and fast forward buttons in the mobile interface.
* `play`: Interface element displaying the **Play**, **Pause**, and **Repeat** buttons. It turns off play or pause when clicking the player.
* `playbackRate`: Playback rate.
* `poster`: Poster.
* `preloader`: Load indicator.
* `settings`: Settings button.
* `startScreen`: Start screen.
* `startScreenPlay`: Play button on the start screen.
* `subtitlesToggle`: Button to toggle subtitles.
* `timeline`: Timeline. It turns off rewinding and fast forwarding from the keyboard or by touching the sensor screen.
* `timelinePreview`: Preview on the timeline.
* `time`: Current playback time.
* `title`: Video name.
* `sound`: Mute button.
* `volumeSlider`: Volume slider.

{% endcut %}

To hide several interface elements, provide a string with comma-separated values, e.g., `hidden=startScreenPlay,play`.
||
|| `lang` |
Player interface language.

{% cut "List of languages" %}

* `ru`: Russian
* `en`: English
* `be`: Belarusian
* `id`: Indonesian
* `kk`: Kazakh
* `tr`: Turkish
* `tt`: Tatar
* `uk`: Ukrainian
* `uz`: Uzbek

{% endcut %}

If you do not specify the parameters or provide an unsupported value, the player interface language will be defined based on user data.
||
|| `loop` |
Video looping:

* `false`: Video looping is off.
* `true`: Video looping is on.

The default value is `false`.
||
|| `mute` |
Mute the video once the player loads:

* `false`: Sound is on.
* `true`: Sound is off.

The default value is `false`.
||
||  `play_on_visible` |
Stop the video when the player is not visible on the screen and play the video when it is visible. The parameter affects both video content and ad videos. It can take the following values:

* `false`: Video plays when the player is not visible on the screen.
* `true`: Video does not play when the player is not visible on the screen.
* Player visibility ratio that is sufficient for playing. You must specify the value of this parameter as a decimal fraction with the full stop (`.`) as a delimiter.

The default value is `false`. When `true`, the visibility ratio is `0.5`.

{% note info %}

When `play_on_visible=true`, the `autoplay` parameter is ignored. The parameter works only in the browsers that can define the player's precise visibility.

{% endnote %}
||
||  `preload` |
Preload the video:

* `false`: Preload the video.
* `true`: Do not preload the video.

The default value is `false`.

When `autoplay=1`, the `preload` parameter is ignored.
||
||  `volume`  |
Volume at the player startup.

It may take values from `0` to `1` inclusive, e.g., `volume=0.5`.

If `mute=1`, the parameter value is ignored.
||
|#

### Example {#example}

This example shows the video autoplay in muted mode:

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&mute=true"
></iframe>
```

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&mute=true"
></iframe>
