---
title: Cloud Video Player events in JavaScript SDK
description: This page describes possible Cloud Video Player events which you can subscribe to in JavaScript SDK.
---

# Player events

Using the [on and once](./player-methods.md#subscribe-methods) methods of JavaScript SDK, you can subscribe to [Cloud Video Player](../../concepts/player.md) events:

#### SourceChange {#sourcechange}

Switching content.

The handler in the `{ source }` object receives a new [content link](./player-state.md#state-source).

Example:

```javascript
player.on('SourceChange', ({ source }) => {
    console.log(source);
});
```

#### StatusChange {#StatusChange}

Changing the [playback status](./player-state.md#state-status).

The handler in the `{ status }` object receives a new playback status value.

Example:

```javascript
player.on('StatusChange', ({ status }) => {
    console.log(status);
});
```

#### ErrorChange {#errorchange}

Getting or resetting an error.

The handler in the `{ error }` object receives an [error](./player-state.md#state-error).

An error is reset when switching content (if switching content is possible). In this case, the handler receives the `error` object with the `undefined` value.

Example:

```javascript
player.on('ErrorChange', ({ error }) => {
    console.log(error);
});
```

#### CurrentTimeChange {#currenttimechange}

Changing the position on the timeline.

The handler in the `{ currentTime }` object receives a new [current time](./player-state.md#state-currentTime) value.

Example:
```javascript
player.on('CurrentTimeChange', ({ currentTime }) => {
    console.log(currentTime);
});
```

#### DurationChange {#durationchange}

Changing the video duration.

The handler in the `{ duration }` object receives a new [duration](./player-state.md#state-duration) value.

This event may occur:
* When you change content.
* Periodically for the `EVENT` [type](./player-state.md#video-type-desc) videos as their duration continuously increases.
* When the `LIVE` video type changes to `VOD`.

Example:
```javascript
player.on('DurationChange', ({ duration }) => {
    console.log(duration);
});
```

#### VideoTypeChange {#videotypechange}

Changing the video type.

The handler in the `{ videoType }` object receives a new [video type](./player-state.md#state-videoType) value.

This event may occur:
* When you change content.
* When the `LIVE` or `EVENT` video type changes to `VOD`.

Example:
```javascript
player.on('VideoTypeChange', ({ videoType }) => {
    console.log(videoType);
});
```

#### MutedChange {#mutedchange}

Changing the video `muted` status.

The handler in the `{ muted }` object receives a new [muted](./player-state.md#state-muted) status value.

Example:

```javascript
player.on('MutedChange', ({ muted }) => {
    console.log(muted);
});
```

#### VolumeChange {#volumechange}

Changing the video sound volume.

The handler in the `{ volume }` object receives a new [volume level](./player-state.md#state-volume) value.

Example:
```javascript
player.on('VolumeChange', ({ volume }) => {
    console.log(volume);
});
```

#### UtcStartTimeChange {#utcstarttimechange}

Changing the UTC video start time.

The handler in the `{ utcStartTime }` object receives a new [UTC time](./player-state.md#state-utcStartTime) value.

This event may occur:
* When you change content.
* When the `LIVE` video type changes to `VOD`.

Example:

```javascript
player.on('UtcStartTimeChange', ({ utcStartTime }) => {
    console.log(utcStartTime);
});
```

#### SeekableRangeChange {#seekablerangechange}

Changing the seekable range.

The handler in the `{ seekableRange }` object receives a new [seekable range](./player-state.md#state-seekableRange) value.

This event may occur:
* When you change content.
* Periodically for the `LIVE` and `EVENT` type videos as their seekable range continuously increases.

Example:

```javascript
player.on('SeekableRangeChange', ({ seekableRange }) => {
    console.log(seekableRange.start, seekableRange.end);
});
```

#### BufferedRangesChange {#bufferedrangeschange}

Changing the buffered ranges.

The handler in the `{ bufferedRanges }` object receives an array with a new description of [buffered ranges](./player-state.md#state-bufferedRanges).

Example:

```javascript
player.on('BufferedRangesChange', ({ bufferedRanges }) => {
    console.log(bufferedRanges);
});
```


#### See also {#see-also}

* [Interface: PlayerSdkEventHandlers](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) in the API reference.