---
title: '{{ video-player-name }} methods in the IFrame SDK'
description: This page describes the methods you can use to manage {{ video-player-name }} in the IFrame SDK.
---

# Player methods

You can manage [{{ video-player-name }}](../../concepts/player.md) using the following IFrame SDK methods: Methods are called via `postMessage` to communicate with the iframe.

## Method call format {#method-format}

To call player methods, use the following format:

```javascript
var iframe = document.getElementById('video-player');
var player = iframe.contentWindow;

player.postMessage({
    method: 'methodName',
    // method parameters
}, '*');
```

## Methods to manage playback {#playback-methods}

#### play {#play}

Starts video playback.

Here is a possible use case:

```javascript
player.postMessage({
    method: 'play'
}, '*');
```

#### pause {#pause}

Pauses playback.

Here is a possible use case:

```javascript
player.postMessage({
    method: 'pause'
}, '*');
```

#### seek {#seek}

Rewinds or fast forward a video to a specific position.

Parameters:
* `time` (number): Playback position to seek to, in seconds.

Example of seeking to 30 seconds:

```javascript
player.postMessage({
    method: 'seek',
    time: 30
}, '*');
```

#### updateSource {#updatesource}

Switches the content to another video.

Parameters:
* `id` (string): New content ID.
* `params` (object): Optional parameters for loading content.

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

Example of switching to another video:

```javascript
player.postMessage({
    method: 'updateSource',
    id: 'vplayer/new-video-id',
    params: {
        autoplay: true
    }
}, '*');
```

After successfully switching content, the player will send the [`inited`](./player-events.md#inited) event with the new `vsid`.

## Methods to manage audio {#audio-methods}

#### setVolume {#setvolume}

Sets the audio volume level of a video.

Parameters:
* `volume` (number): Volume level of a video from `0` (muted) to `1` (maximum volume).

Example of setting the volume to 70%:

```javascript
player.postMessage({
    method: 'setVolume',
    volume: 0.7
}, '*');
```

#### mute {#mute}

Mutes a video.

Here is a possible use case:

```javascript
player.postMessage({
    method: 'mute'
}, '*');
```

#### unmute {#unmute}

Unmutes a video.

Here is a possible use case:

```javascript
player.postMessage({
    method: 'unmute'
}, '*');
```

## Methods to manage quality and tracks {#quality-methods}

#### setQuality {#setquality}

Sets the video quality.

Parameters:
* `quality` (string): Video quality. The possible values are:
  * `small`: 240p
  * `medium`: 360p
  * `large`: 480p
  * `hd720`: 720p
  * `hd1080`: 1080p
  * Manual quality setting, e.g., `'720p'` or `'1080p'`

Example of setting video quality to HD 720p:

```javascript
player.postMessage({
    method: 'setQuality',
    quality: 'hd720'
}, '*');
```

Or:

```javascript
player.postMessage({
    method: 'setQuality',
    quality: '720p'
}, '*');
```

#### setAudioTrack {#setaudiotrack}

Switches the audio track.

Parameters:
* `value` (string): Audio track ID.

Here is a possible use case:

```javascript
player.postMessage({
    method: 'setAudioTrack',
    value: 'audio-track-id'
}, '*');
```

## Methods to manage display {#display-methods}

#### setFullscreen {#setfullscreen}

Switches fullscreen mode.

Parameters:
* `fullscreen` (boolean): `true` to enter fullscreen, `false` to exit fullscreen.

Example of entering the fullscreen mode:

```javascript
player.postMessage({
    method: 'setFullscreen',
    fullscreen: true
}, '*');
```

Example of exiting the fullscreen mode:

```javascript
player.postMessage({
    method: 'setFullscreen',
    fullscreen: false
}, '*');
```

#### configureSkin {#configureskin}

Configures the display of player UI elements.

Parameters:
* `skinConfig` (object): Object with UI settings:
  * `hiddenControls` (array | string): Array of strings or comma-separated string with the names of UI elements to hide.

Available UI elements for `hiddenControls`:
* `*`: All interface elements.
* `play`: Play, pause, and replay buttons.
* `startScreenPlay`: Play button on the start screen.
* `sound`: Mute button.
* `volumeSlider`: Volume slider.
* `settings`: Settings button.
* `fullscreen`: Fullscreen button.
* `timeline`: Playback timeline (also disables seeking from the keyboard).
* `timelinePreview`: Preview on the timeline.
* `live`: **Go back to live** button.
* `poster`: Poster.
* `time`: Current playback time.
* `forward`: Fast forward button (mobile interface).
* `backward`: Rewind button (mobile interface).
* `preloader`: Loading spinner.
* `contextMenu`: Context menu.
* `startScreen`: Start screen.
* `playbackRate`: Playback rate.
* `nextAdInfo`: Time until the next ad.
* `subtitlesToggle`: Subtitle toggle button.
* `mobileSeekButtons`: Rewind and fast forward buttons in the mobile interface.
* `title`: Video title.

Example of hiding multiple elements using an array:

```javascript
player.postMessage({
    method: 'configureSkin',
    skinConfig: {
        hiddenControls: ['play', 'timeline', 'sound']
    }
}, '*');
```

Example of hiding elements using a string:

```javascript
player.postMessage({
    method: 'configureSkin',
    skinConfig: {
        hiddenControls: 'play,timeline,sound'
    }
}, '*');
```

Example of showing a previously hidden element (using `!` before the element name):

```javascript
player.postMessage({
    method: 'configureSkin',
    skinConfig: {
        hiddenControls: ['*', '!play'] // play will be shown, all other elements will be hidden
    }
}, '*');
```

## Handling method results {#method-results}

Some methods can return results through events. You can use the unique request ID to monitor method results:

```javascript
var requestId = 'unique-request-id-' + Date.now();

// Sending a command with the ID
player.postMessage({
    method: 'play',
    id: requestId
}, '*');

// Listening for a response
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'play:return' && event.data.id === requestId) {
        if (event.data.error) {
            console.error('Method execution error:', event.data.error);
        } else {
            console.log('Method executed successfully:', event.data.result);
        }
    }
});
```

Each method has a matching return event in `<methodName>:return` format.

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](./initialization.md)
* [{#T}](./player-events.md)