---
title: Cloud Video Player states in JavaScript SDK
description: This page describes the possible states of Cloud Video Player in JavaScript SDK.
---

# Player state

You can get information about the video player state and [parameters](#player-params) using a [special object](#player-state) which contains fields with state values.

## Video player parameters {#player-params}

#### Video types in the player {#video-type-desc}

The [video player](../../concepts/player.md) supports three _types of videos_:

* `VOD`: Standard [video](../../concepts/videos.md) with a fixed beginning, end, and duration.

    An example of such a video is a movie.
* `EVENT`: [Live stream](../../concepts/streams.md) where only the beginning is fixed, and duration is constantly increasing as the right edge of the timeline keeps crawling forward. 

    A user can rewind or fast forward to any point on the video timeline, from the beginning to what is now its right edge. If a user’s playback position matches the right edge, this user is considered to be online. At some point, the right edge may stop crawling, in which case the video type will change to `VOD`.

    An example of such a video is a soccer game live stream.
* `LIVE`: Live stream where the right and left edges of its timeline continiously change over time.

    A user can only rewind or fast forward between the current left and right timeline edges. As with `EVENT` videos, if a user’s playback position matches the right timeline edge, this user is considered to be online.

    An example of such a video is a live stream of a TV channel.

The video type is specified in the [videoType](#state-videoType) field of the object with [player states](#player-state).

#### Current time {#current-time-desc}

_Current time_ marks the current playback position on the timeline. You can get the current time from the [currentTime](#state-currentTime) field of the object with [player states](#player-state).

Current time is measured in seconds.

`LIVE` videos use [Unix timestamps](https://en.wikipedia.org/wiki/Unix_time). For the `VOD` and `EVENT` types, it is measured in seconds from the start of the video, which has the `0` value.

> Example 1: For `VOD` and `EVENT` video types, `currentTime` may indicate `10`. This means that the current playback position on the timeline is 10 seconds from the start of the video.

> Example 2: For a `LIVE` video, the `currentTime` field may indicate `1600000000`. This means that the current playback position on the timeline matches `new Date(1600000000 * 1000)` in absolute time, i.e., `Sep 13 2020 14:26:40 GMT+0200`.

#### Duration {#duration-desc}

_Duration_ indicates the difference between the right and left edges of the video timeline. You can get the video duration from the [duration](#state-duration) field of the object with [player states](#player-state).

Duration is measured in seconds.

For the `LIVE` video type, duration is always `Infinity`.

#### Video start time in UTC {#utc-start-time-desc}.

_Video start time in UTC_ indicates the start time of a live stream in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format. You can get this value from the [utcStartTime](#state-utcStartTime) field of the object with [player states](#player-state).

Video start time is measured in seconds.

For `LIVE` videos, the value is always `0`.

For the `EVENT` video type, it is always a non-null value in `Unix Timestamp` format.

> Example: The `utcStartTime` field may indicate `1600000000`. This means the video started at `new Date(1600000000 * 1000)`, or `Sep 13 2020 14:26:40 GMT+0200`.

For `VOD` videos, this is an optional value. For example, a `VOD` video may get this value if it was created from an `EVENT` video. The value is `undefined` when it is not specified. If specified, the value is in `utcStartTime` format (same as for `EVENT`).

#### Seekable range {#seekable-range-desc}

_Seekable range_ indicates the timeline range where the user can move the current playback position. You can get this value from the [seekableRange](#state-seekableRange) field of the object with [player states](#player-state).

Format:

```javascript
{
    /** @type {number} left edge of the range in seconds */
    start,
    /** @type {number} right edge of the range in seconds */
    end,
}
```

For `VOD` and `EVENT` videos, the `start` field is always set to `0`. The `end` field value matches the right edge of the timeline. In the case of `EVENT` videos, this value is constantly increasing.

For the `LIVE` type, the `start` and `end` values are specified in `Unix Timestamp` format. The `end` value is constantly increasing.

> For example, if the `seekableRange` field of a `LIVE` broadcast contains an object with the `start === 1600000000` and `end === 1600001000` fields, the user’s seekable range has `1600000000` and `1600001000` as its left and right edges.

#### Playback status {#status-desc}.

You can get the _playback status_ value from the [status](#state-status) field of the object with [player states](#player-state).

The playback status may take one of the following values:

* `idle`: Player is waiting for content to play.
* `init`: Initializing the player after the first playable content is set.
* `buffering`: Player is in buffering state and cannot play the video, e.g., due to lack of data.
* `play`: Video playback is in progress.
* `pause`: Player is paused.
* `end`: Current video playback ended at the right edge of the timeline. 
* `fatal`: Current video cannot be played; the user gets an error screen. To start a video, the user can try switching to other content.
* `broken`: Player is broken and cannot play the video, the user gets an error screen. Switching to other content is not possible.
* `destroyed`: `destroy` method was called, the player is destroyed and can no longer play the video.
* `cancelled`: Live stream was cancelled.
* `preparing`: Live stream is about to start.
* `finished`: Live stream ended.

## Player state object {#player-state}

A player state is an object with the following fields:

* [source](#state-source)
* [status](#state-status)
* [error](#state-error)
* [currentTime](#state-currentTime)
* [duration](#state-duration)
* [videoType](#state-videoType)
* [muted](#state-muted)
* [volume](#state-volume)
* [utcStartTime](#state-utcStartTime)
* [seekableRange](#state-seekableRange)
* [bufferedRanges](#state-bufferedRanges).

#### source {#state-source}

Link to current content. If no content is provided, the `source` field is set to `undefined`.

#### status {#state-status}

[Playback status](#status-desc).

It can take the following values:

* `'idle'`
* `'init'`
* `'buffering'`
* `'play'`
* `'pause'`
* `'end'`
* `'fatal'`
* `'broken'`
* `'destroyed'`
* `'cancelled'`
* `'preparing'`
* `'finished'`

The default value is `'idle'`.

#### error {#state-error}

Player error.

If there are no errors at the moment, this field is `undefined`. In case of an error, its value is an object of the following format:

```javascript
{
    /** @type {string} error code */
    code,
    /** @type {string} error message */
    message,
}
```

If the field contains an error object, this means, at the moment, the player cannot start or resume video playback. In this case, the [status](#state-status) field value will be either `'fatal'` or `'broken'`.

The default value is `undefined`.

#### currentTime {#state-currentTime}

[Current time](#current-time-desc) (timeline position) in seconds.

The default value is `NaN`.

#### duration {#state-duration}

Video [duration](#duration-desc) in seconds.

The default value is `NaN`.

#### videoType {#state-videoType}

[Video type](#video-type-desc).

It can take the following values:

* `undefined`
* `'VOD'`
* `'EVENT'`
* `'LIVE'`

The default value is `undefined`.

#### muted {#state-muted}

Video `muted` status. If `true`, sound is off; if `false`, sound is on.

The default [value](./initialization.md#muted) is the one provided in the configuration on player initialization. If no value was provided on initialization, the default value is `true`.

#### volume {#state-volume}

Video volume level ranging from `0` (muted) to `1` (maximum volume).

The default [value](./initialization.md#volume) is the one provided in the configuration on player initialization. If no value was provided on initialization, the default value is `1`.

#### utcStartTime {#state-utcStartTime}

[Video start time in UTC](#utc-start-time-desc) specified in seconds or `undefined`.

The default value is `undefined`.

#### seekableRange {#state-seekableRange}

[Seekable range](#seekable-range-desc).

The default value is `{ start: NaN, end: NaN }`.

#### bufferedRanges {#state-bufferedRanges}

Buffered ranges. This is an array of objects in the following format:

```javascript
{
    /** @type {number} buffer start in seconds */
    start,
    /** @type {number} buffer end in seconds */
    end,
}
```

Array elements define the timeline ranges for which there is buffered data for playback.

The default value is an empty array (`[]`).


#### See also {#see-also}

* [Interface: PlayerSdkState](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) in the API reference