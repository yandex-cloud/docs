---
title: Cloud Video Player initialization parameters in JavaScript SDK
description: This page describes the parameters you can use when initializing Cloud Video Player in JavaScript SDK.
---

# Player initialization parameters

You can provide starting parameters to [Cloud Video Player](../../concepts/player.md) when [initializing](./index.md#initialize-player) it.

## Playback controls {#playback-controls}

#### element {#element}

Embed element. This is a required parameter. This can be either an `HTMLElement` pointer or an ID selector.

Player creation examples:

* By providing a pointer:

    ```javascript
    var element = document.getElementById('video-player');
    var player = Ya.playerSdk.init({ element, ...});
    ```
* By providing an ID selector:

    ```javascript
    var player = Ya.playerSdk.init({ element: 'video-player', ...});
    ```

#### source {#source}

Playable content link.

Player creation examples:

```javascript
var player = Ya.playerSdk.init({ ..., source: 'https://runtime.video.cloud.yandex.net/player/...', ...});
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

#### autoplay {#autoplay}

Autoplay when loading content.

In some cases, autoplay may [fail](https://developer.chrome.com/blog/autoplay/).

Autoplay is disabled by default.

Player creation examples with disabled autoplay:

```javascript
var player = Ya.playerSdk.init({ ..., autoplay: false, ...});
```

#### muted {#muted}

`muted` status when creating a player. If `true`, sound is off; if `false`, sound is on.

If the sound is on, autoplay may [fail](https://developer.chrome.com/blog/autoplay/).

Player creation examples with enabled sound:

```javascript
var player = Ya.playerSdk.init({ ..., muted: false, ...});
```

#### volume {#volume}

Volume level of a video from `0` (muted) to `1` (maximum volume).

The default value is `1`.

Player creation example with the `0.5` volume:

```javascript
var player = Ya.playerSdk.init({ ..., volume: 0.5, ...});
```

#### startPosition {#startposition}

Starting position of content playback when loading (in seconds).

The default values are:

* For the `VOD` [video type](./player-state.md#video-type-desc): Beginning of the video (zero second).
* For the `LIVE` and `EVENT` video types: Live.

Player creation example with the `10` starting position:

```javascript
var player = Ya.playerSdk.init({ ..., startPosition: 10, ...});
```

#### hiddenControls {#hiddencontrols}

Using `hiddenControls`, you can hide the player interface elements.

All the controls are shown by default.

As a value, you can provide either an array of interface elements to hide or a string listing such elements separated by commas.

Examples:

* Hide the play/pause and settings buttons by providing `hiddenControls` as a string:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: 'play,settings', ...});
    ```

* Hide the play/pause and settings buttons by providing `hiddenControls` as an array:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: ['play','settings'], ...});
    ```

* You can hide all interface elements using the `*` meta element:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: '*', ...});
    ```

* To hide all interface elements except the specified one, you can use the `!` operator. For example, the following code will hide all controls except the play/pause button:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: '*,!play', ...});
    ```

Interface elements you can hide:

* `*`: All interface elements.
* `play`: Interface element displaying the **Play**, **Pause**, and **Repeat** buttons. It turns off play/pause when clicking on the player.
* `contextMenu`: Context menu.
* `fullscreen`: Full screen toggle button.
* `live`: **Go back to live** button.
* `mobileSeekButtons`: Rewind and fast forward buttons in the mobile interface.
* `nextAdInfo`: Time until the next ad.
* `playbackRate`: Playback rate.
* `poster`: Poster.
* `preloader`: Loading spinner.
* `settings`: Settings button.
* `startScreen`: Start screen.
* `startScreenPlay`: Play button on the start screen.
* `subtitlesToggle`: Subtitles toggle button.
* `timeline`: Timeline. Disables rewinding and fast forwarding from the keyboard or by touching the sensor screen.
* `timelinePreview`: Preview on the timeline.
* `time`: Current playback time.
* `title`: Video title.
* `sound`: Mute button.
* `volumeSlider`: Volume slider.

#### See also {#see-also}

* [Interface: PlayerSdkInitConfig](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) in the API reference
* [Interface: PlayerSdkSourceParams](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) in the API reference
