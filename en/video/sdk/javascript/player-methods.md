---
title: Cloud Video Player methods in JavaScript SDK
description: This page describes the methods you can use to manage Cloud Video Player in JavaScript SDK.
---

# Player methods

You can manage [Cloud Video Player](../../concepts/player.md) using the following JavaScript SDK methods:

#### setSource {#setsource}

Switches content.

Example of simple content switching:

```javascript
player.setSource('https://runtime.video.cloud.yandex.net/player/...');
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

Example of content switching with a specified starting position and disabled autoplay:

```javascript
player.setSource({
    source: 'https://runtime.video.cloud.yandex.net/player/...',
    startPosition: 10,
    autoplay: false
});
```

This example uses an object of the following format as the parameter:

```javascript
{
    /** @type {string} link to playable content */
    source,
    /**
     * @type {boolean} (optional) autoplay when switching to content.
     * By default, preserves the playback state used at time the method is called.
     * Autoplay may not work. See https://developer.chrome.com/blog/autoplay/
     * autoplay
     */
    autoplay,
    /** @type {number} (optional, the default value is 0) starting position in seconds */
    startPosition,
}
```

The method returns a promise which:

* Gets the `fulfilled` status if switching is successful.
* Gets the `rejected` status if switching fails. For example, if the content with a specified `id` was not found.

#### getState {#getstate}

Returns the player state as an object in the format described in [{#T}](./player-state.md).

Usage example:

```javascript
var state = player.getState();
```

#### play {#play}

Starts playback.

The method returns a promise which:

* Gets the `fulfilled` status if playback starts.
* Gets the `rejected` status if playback [fails](https://developer.chrome.com/blog/autoplay).

#### pause {#pause}

Pauses playback.

#### seek {#seek}

Rewinds or fast forwards a video to a specific position, which is provided as the parameter.

Example of jumping to the 10th second:

```javascript
player.seek(10);
```

#### setMuted {#setmuted}

Turns sound on/off.

The `boolean` type value is provided as the parameter.

Example of turning sound on:

```javascript
player.setMuted(false);
```

#### setVolume {#setvolume}

Sets video volume level in the range from `0` (muted) to `1` (maximum volume).

Example:

```javascript
player.setVolume(0.7);
```

#### on/once {#subscribe-methods}

Allows you to subscribe to [player events](./player-events.md).

If `once` is called, the subscription works only for the first triggering of the event; if `on` is called, for all triggerings.

These methods have the `on(eventName, handler)` and `once(eventName, handler)` signatures, respectively. The first parameter communicates the event name, the second communicates the handler.

The handler receives an object with the appropriate field from the [player state](./player-state.md).

Example of subscribing to all triggerings of the playback [StatusChange](./player-state.md#StatusChange) event:

```javascript
player.on('StatusChange', ({ status }) => {
    console.log(status);
});
```

#### off {#off}

Allows you to unsubscribe from the player events you subscribed to using the `on` or `once` [methods](./player-events.md#subscribe-methods).

The method has the `off(eventName, handler)` signature. The first parameter communicates the event name, the second communicates the handler you had used for subscription.

Example of unsubscribing from a handler function named `handler` for the playback [StatusChange](./player-events.md#StatusChange) event:

```javascript
player.off('StatusChange', handler);
```

#### destroy {#destroy}

Destroys the player and frees up the resources.

Returns a promise, which enters the `fulfilled` state as soon as the operation is completed.

Usage example:
```javascript
player.destroy();
```

#### See also {#see-also}

* [Interface: PlayerSdkApi](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) API reference
