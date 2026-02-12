---
title: Getting started with the JavaScript SDK for {{ video-player-name }}
description: This page describes the basic controls for {{ video-player-name }} in the JavaScript SDK.
---

# Getting Started with the video player SDK for JavaScript

You can integrate a [video player](../../concepts/player.md) with content from {{ video-name }} into your [JavaScript](https://en.wikipedia.org/wiki/JavaScript) project using the {{ video-player-name }} SDK for JavaScript.

## Adding a player to your page {#add-player}

To connect a player to a page, add the following code to it:

```html
<script src="https://runtime.video.cloud.yandex.net/player/js/player-sdk.js"></script>
```

## Initializing a player {#initialize-player}

To initialize a player, add the following code to the page:

```javascript
var player = Ya.playerSdk.init({
    /** @type {(string|HTMLElement)} to create the player in */
    element: 'video-player',
    /** @type {string} link to playable content */
    source: 'https://runtime.video.cloud.yandex.net/player/...',
    /** @type {boolean} autoplay when loading content */
    autoplay: false
});
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

For more information on initializing a player, see:

* [Player initialization parameters](./initialization.md)
* [Interface: PlayerSdkInitConfig](../../api-ref/javascript/interfaces/PlayerSdkInitConfig.md) in the API reference
* [Interface: PlayerSdkSourceParams](../../api-ref/javascript/interfaces/PlayerSdkSourceParams.md) in the API reference

## Player controls {#player-controls}

For information on player control methods, see:

* [Player methods](./player-methods.md)
* [Interface: PlayerSdkApi](../../api-ref/javascript/interfaces/PlayerSdkApi.md) in the API reference

## Player state {#player-state}
    
For information about the object containing player state parameters, see:

* [Player state](./player-state.md)
* [Interface: PlayerSdkState](../../api-ref/javascript/interfaces/PlayerSdkState.md) in the API reference

## Player events {#player-events}

For information about player events, see:

* [Player events](./player-events.md)
* [Interface: PlayerSdkEventHandlers](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) in the API reference
