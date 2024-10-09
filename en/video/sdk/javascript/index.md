---
title: Getting started with JavaScript SDK for Cloud Video Player
description: This page summarizes the basic controls for Cloud Video Player using JavaScript SDK.
---

# Getting Started with the video player SDK for JavaScript

You can integrate a [video player](../../concepts/player.md) with content from Cloud Video into your [JavaScript](https://en.wikipedia.org/wiki/JavaScript) project using the Cloud Video Player SDK for JavaScript.

## Connecting a player on your page {#add-player}

To connect a player to a page, add the following code to it:

```html
<script src="https://storage.yandexcloud.net/videoplatform-public/player/yandex-video-player-iframe-api-bundles/1.0-11944/js/player-sdk.js"></script>
```

## Initializing a player {#initialize-player}

To initialize a player, add the following code to the page:

```javascript
var player = Ya.playerSdk.init({
    /** @type {(string|HTMLElement)} where the player will be created */
    element: 'video-player',
    /** @type {string} playable content link */
    source: 'https://runtime.video.cloud.yandex.net/player/...',
    /** @type {boolean} autoplay when loading content */
    autoplay: false
});
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

For more information on initializing a player, see the following sections:

* [Player initialization parameters](./initialization.md)
* [Interface: PlayerSdkInitConfig](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) API reference
* [Interface: PlayerSdkSourceParams](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) API reference

## Player controls {#player-controls}

For information on player control methods, see the following sections:

* [Player methods](./player-methods.md)
* [Interface: PlayerSdkApi](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) API reference

## Player state {#player-state}
    
For information about an object containing player state parameters, see the following sections:

* [Player state](./player-state.md)
* [Interface: PlayerSdkState](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) API reference

## Player events {#player-events}

For information about player events, see the following sections:

* [Player events](./player-events.md)
* [Interface: PlayerSdkEventHandlers](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) API reference
