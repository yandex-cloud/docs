---
title: '{{ video-player-name }} initialization parameters in the IFrame SDK'
description: This page describes the parameters you can use to initialize {{ video-player-name }} in the IFrame SDK.
---

# Player initialization parameters

When creating an iframe with [{{ video-player-name }}](../../concepts/player.md), you can provide the initial playback and player appearance settings in the URL.

## Settings format {#format}

The settings are provided in the iframe URL after `?` as query parameters. To provide multiple parameters, separate them with `&`:

```html
<iframe
    src="https://runtime.video.cloud.yandex.net/player/...?param1=value1&param2=value2"
></iframe>
```

## Playback controls {#playback-controls}

#### autoplay {#autoplay}

Auto video playback at startup.

The possible values are:
* `0`: Auto playback off (default).
* `1`: Auto playback on.

For the autoplay option to work correctly in all browsers, use the `autoplay=1` parameter together with `mute=1`.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=1"></iframe>
```

#### mute {#mute}

Mute at startup.

The possible values are:
* `false`: Sound on (default).
* `true` or `1`: Sound off.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?mute=1"></iframe>
```

#### volume {#volume}

Volume at startup.

Teh values range from `0` (muted) to `1` (maximum volume), e.g., `volume=0.5`.

If set to `mute=1`, the parameter is ignored.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?volume=0.7"></iframe>
```

#### t {#t}

Time (in seconds) you want to start playback at.

The values range from `0` to video duration inclusive, e.g., `t=30` (start playback at 30 seconds in).

If you do not specify this parameter, your video will play from the beginning, and live stream, from the current moment.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?t=30"></iframe>
```

#### loop {#loop}

Playback looping.

The possible values are:
* `false`: Playback looping off (default).
* `true`: Playback looping on.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?loop=true"></iframe>
```

#### allow_muted {#allow-muted}

Auto video playback in mute mode at startup.

The possible values are:
* `false`: Muted autoplay not allowed.
* `true`: Muted autoplay allowed.

The `allow_muted` parameter has priority over `autoplay`. If `allow_muted=false`, autoplay will take place only if it is possible with sound.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?allow_muted=true"></iframe>
```

#### preload {#preload}

Video preload.

The possible values are:
* `false`: Video preload off (default).
* `true`: Video preload on.

When set to `autoplay=1`, the `preload` parameter is ignored.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?preload=true"></iframe>
```

#### play_on_visible {#play-on-visible}

Stopping playback if the player leaves the visible area and starting playback if the player is in it.

The parameter affects both video content and ads. It can take the following values:

* `false`: Video is played back if the player leaves the visible area (default).
* `true`: Video is not played back if the player leaves the visible area.
* Player visibility ratio sufficient for playback. Specify this value as a decimal fraction with a period (`.`) for a delimiter.

The default value is `false`. When set to `true`, the visibility ratio is `0.5`.

{% note info %}

When set to `play_on_visible=true`, the `autoplay` parameter is ignored. The parameter only works in browsers that can accurately calculate player visibility.

{% endnote %}

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?play_on_visible=0.7"></iframe>
```

## Interface display parameters {#ui-controls}

#### hidden {#hidden}

With this parameter, you can hide the player's interface elements. By default, all elements are displayed.

The possible values are:

* `*`: All interface elements.
* `*,!<excluded_item>`: All interface elements except the excluded one. For example, use `*,!play` to hide all interface elements except the play button.
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
* `startScreenPlay`: Play button on start screen.
* `subtitlesToggle`: Subtitles toggle button.
* `timeline`: Timeline. Disables rewinding and fast forwarding from the keyboard or by touching the sensor screen.
* `timelinePreview`: Preview on the timeline.
* `time`: Current playback time.
* `title`: Video title.
* `sound`: Mute button.
* `volumeSlider`: Volume slider.

To hide several interface elements, provide a string of comma-separated values, e.g., `hidden=startScreenPlay,play`.

{% note info %}

We do not recommend using `autoplay=0` and `hidden=*` together, since you cannot start a video with both.

{% endnote %}

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?hidden=title,settings"></iframe>
```

#### lang {#lang}

Player interface language.

The possible values are:

* `ru`: Russian
* `en`: English
* `be`: Belarusian
* `id`: Indonesian
* `kk`: Kazakh
* `tr`: Turkish
* `tt`: Tatar
* `uk`: Ukrainian
* `uz`: Uzbek

If you do not specify the parameters or provide an unsupported value, the player interface language will be based on user data.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?lang=en"></iframe>
```

#### object_fit {#object-fit}

Scale the thumbnail to fit the screen size when loading a video.

The possible values are:

* `contain`: Keep the original thumbnail aspect ratio, no cropping.
* `cover`: Resize the thumbnail to fill the entire frame by changing its aspect ratio or cropping (default).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?object_fit=contain"></iframe>
```

## Style parameters {#styling}

#### background_color {#background-color}

Background color of the player and widgets.

Supports all colors in [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) format consisting of three and six characters as well as standard HTML [color names](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?background_color=000000"></iframe>
```

#### player_color {#player-color}

Color of the player interface elements, i.e., the loading indicator, time scale, and play button on the start screen with `autoplay=0`.

Supports all colors in [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) format consisting of three and six characters as well as standard HTML [color names](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?player_color=FF0000"></iframe>
```

#### widget_text_color_primary {#widget-text-color-primary}

Color of widget body text.

Supports all colors in [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) format consisting of three and six characters as well as standard HTML [color names](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_text_color_primary=FFFFFF"></iframe>
```

#### widget_text_color_secondary {#widget-text-color-secondary}

Color of auxiliary widget text.

Supports all colors in [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) format consisting of three and six characters as well as standard HTML [color names](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_text_color_secondary=CCCCCC"></iframe>
```

#### widget_accent_color {#widget-accent-color}

Accent color of widget text.

Supports all colors in [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) format consisting of three and six characters as well as standard HTML [color names](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_accent_color=00FF00"></iframe>
```

#### playlist_selected_item_background_color {#playlist-selected-item-background-color}

Background color of an active playlist element.

Supports all colors in [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) format consisting of three and six characters as well as standard HTML [color names](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?playlist_selected_item_background_color=333333"></iframe>
```

#### widget_block_separator_color {#widget-block-separator-color}

Color of widget section separators.

Supports all colors in [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) format consisting of three and six characters as well as standard HTML [color names](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_block_separator_color=444444"></iframe>
```

#### player_border_radius {#player-border-radius}

Rounding of the player section corners.

The default value is `3`.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?player_border_radius=10"></iframe>
```

#### playlist_item_border_radius {#playlist-item-border-radius}

Rounding of the playlist element corners.

The default value is `3`.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?playlist_item_border_radius=5"></iframe>
```

#### widget_block_gap {#widget-block-gap}

Padding between the player and playlist section.

The default value is `0`.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_block_gap=20"></iframe>
```

#### playlist_item_gap {#playlist-item-gap}

Padding between playlist elements.

The default value is `10`.

Here is an example:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?playlist_item_gap=15"></iframe>
```

## Usage example {#example}

Example of an iframe with multiple parameters:

```html
<iframe
    width="640"
    height="360"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=1&t=10&lang=ru&player_color=FF0000"
></iframe>
```

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](./player-methods.md)
* [{#T}](./player-events.md)