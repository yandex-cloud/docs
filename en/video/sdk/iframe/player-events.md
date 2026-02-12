---
title: '{{ video-player-name }} events in the IFrame SDK'
description: This page describes possible {{ video-player-name }} events to which you can subscribe in the IFrame SDK.
---

# Player events

You can use `postMessage` in the IFrame SDK to subscribe to [Cloud Video Player](../../concepts/player.md) events. The iframe sends events to the parent window.

## Event subscription format {#event-format}

The `message` handler is used to receive events from the player.

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event) {
        // Event handling
        console.log('Player event:', event.data.event, event.data);
    }
});
```

## Initialization events {#initialization-events}

#### inited {#inited}

The player is initialized and ready for use.

Event parameters:
* `vsid` (string): Unique player session ID.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'inited') {
        console.log('Player initialized, vsid:', event.data.vsid);
    }
});
```

#### resourcesIdle {#resourcesidle}

Player resources are loaded and the player is idle.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'resourcesIdle') {
        console.log('Player resources loaded');
    }
});
```

#### contentImpression {#contentimpression}

The content is displayed to the user (impression).

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'contentImpression') {
        console.log('Content displayed');
    }
});
```

## Playback events {#playback-events}

#### started {#started}

Video playback started (first play after loading content).

Event parameters:
* `time` (number): Current playback time, in seconds.
* `duration` (number): Video duration, in seconds.
* `title` (string): Video title. This is an optional parameter.
* `description` (string): Video description. This is an optional parameter.
* `contentId` (string): Content ID. This is an optional parameter.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'started') {
        console.log('Playback started');
        console.log('Time:', event.data.time);
        console.log('Duration:', event.data.duration);
        console.log('Title:', event.data.title);
    }
});
```

#### resumed {#resumed}

Playback resumed after pause.

Event parameters:
* `time` (number): Current playback time, in seconds.
* `duration` (number): Video duration, in seconds.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'resumed') {
        console.log('Playback resumed at', event.data.time, 'seconds');
    }
});
```

#### paused {#paused}

Playback paused.

Event parameters:
* `time` (number): Current playback time, in seconds.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'paused') {
        console.log('Playback paused at', event.data.time, 'seconds');
    }
});
```

#### ended {#ended}

Video playback ended.

Event parameters:
* `time` (number): Playback end time, in seconds.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'ended') {
        console.log('Playback ended');
    }
});
```

## Time and position events {#time-events}

#### timeupdate {#timeupdate}

Changing the current playback time. This event is generated regularly during playback.

Event parameters:
* `time` (number): Current playback time, in seconds.
* `duration` (number): Video duration, in seconds.
* `watchedTime` (number): Total watch time, in seconds.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'timeupdate') {
        console.log('Current time:', event.data.time);
        console.log('Duration:', event.data.duration);
        console.log('Watched:', event.data.watchedTime);
    }
});
```

#### durationchange {#durationchange}

Changing the video duration.

Event parameters:
* `duration` (number): Updated video duration, in seconds.

This event may occur:
* When you change content.
* Periodically for live streams, as the duration keeps increasing.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'durationchange') {
        console.log('Duration changed:', event.data.duration);
    }
});
```

#### rewound {#rewound}

User changed the video playback position.

Event parameters:
* `time` (number): Updated playback time, in seconds.
* `previousTime` (number): Previous playback time, in seconds.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'rewound') {
        console.log('Playback position changed from', event.data.previousTime, 'to', event.data.time);
    }
});
```

## Audio events {#audio-events}

#### volumechange {#volumechange}

Changing the volume and muted status.

Event parameters:
* `volume` (number): Volume level from 0 to 1.
* `muted` (boolean): Sound muted status. If `true`, sound is off; if `false`, sound is on.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'volumechange') {
        console.log('Volume:', event.data.volume);
        console.log('Muted:', event.data.muted);
    }
});
```

## Error events {#error-events}

#### error {#error}

A playback error occurred.

Event parameters:
* `time` (number): Time when the error occurred, in seconds.
* `code` (string): Error code.

Possible error codes:
* `'0'`: Unknown error.
* `'1'`: Error loading video.
* `'2'`: Network error.
* `'3'`: Decoding error.
* `'4'`: Video not supported.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'error') {
        console.error('Playback error');
        console.error('Error code:', event.data.code);
        console.error('Time:', event.data.time);
    }
});
```

## Ad events {#ad-events}

#### adShown {#adshown}

Ad playback started.

Event parameters:
* `time` (number): Ad start time, in seconds.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'adShown') {
        console.log('Ad playback started');
    }
});
```

#### adEnd {#adend}

Ad playback ended.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'adEnd') {
        console.log('Ad playback ended');
    }
});
```

#### adPodStart {#adpodstart}

Ad pod playback started.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'adPodStart') {
        console.log('Ad pod playback started');
    }
});
```

## Display events {#display-events}

#### sizeChange {#sizechange}

The video was resized.

Event parameters:
* `videoWidth` (number): Video width, in pixels.
* `videoHeight` (number): Video height, in pixels.
* `isAd` (boolean): Indicates whether the current video is an ad.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'sizeChange') {
        console.log('Video size:', event.data.videoWidth, 'x', event.data.videoHeight);
        console.log('This video is an ad:', event.data.isAd);
    }
});
```

#### fullscreenchange {#fullscreenchange}

Changing the fullscreen mode state.

Event parameters:
* `isFullscreen` (boolean): Fullscreen mode status, `true` for enabled and `false` for disabled.

Handling example:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'fullscreenchange') {
        console.log('Fullscreen mode:', event.data.isFullscreen ? 'enabled' : 'disabled');
    }
});
```

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](./initialization.md)
* [{#T}](./player-methods.md)