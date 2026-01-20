---
title: Getting started with the IFrame SDK for Cloud Video Player
description: This page describes the basic controls for Cloud Video Player in the IFrame SDK.
---

# Getting started with the video player SDK for IFrame

You can integrate a [video player](../../concepts/player.md) with content from Cloud Video into your project using the Cloud Video Player SDK for IFrame. The SDK enables you to manage the player via the JavaScript API, using `postMessage` to communicate with the iframe.

## Adding a player to your page {#add-player}

To add a player to a page, add the iframe embed code:

```html
<iframe
    id="video-player"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/..."
></iframe>
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

## Initializing the SDK {#initialize-sdk}

To manage a player via JavaScript, get a reference to the iframe and use the `postMessage` method to send commands:

```javascript
// Getting a reference to the iframe
var iframe = document.getElementById('video-player');
var player = iframe.contentWindow;

// Function for sending commands to the player
function sendCommand(method, params) {
    player.postMessage({
        method: method,
        ...params
    }, '*');
}

// Function for subscribing to player events
window.addEventListener('message', function(event) {
    if (event.data && event.data.event) {
        console.log('Player event:', event.data.event, event.data);
    }
});
```

## Configuring player options {#player-parameters}

You can configure the player options when creating the iframe by adding them to the URL as query parameters:

```html
<iframe
    id="video-player"
    src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=1"
></iframe>
```

For more information, see [Player initialization parameters](./initialization.md).

## Player controls {#player-controls}

For more info on how to manage the player, see [Player methods](./player-methods.md).

Example of method usage:

```javascript
// Start playback
sendCommand('play', {});

// Pause playback
sendCommand('pause', {});

// Seek to 30 seconds
sendCommand('seek', { time: 30 });

// Set the volume to 50%
sendCommand('setVolume', { volume: 0.5 });
```

## Player events {#player-events}

For details, see [Player events](./player-events.md).

Example of a subscription to events:

```javascript
window.addEventListener('message', function(event) {
    if (!event.data || !event.data.event) return;
    
    switch(event.data.event) {
        case 'inited':
            console.log('Player initialized, vsid:', event.data.vsid);
            break;
        case 'started':
            console.log('Playback started');
            break;
        case 'paused':
            console.log('Playback paused');
            break;
        case 'timeupdate':
            console.log('Current time:', event.data.time);
            break;
    }
});
```

#### See also {#see-also}

* [{#T}](./initialization.md)
* [{#T}](./player-methods.md)
* [{#T}](./player-events.md)
