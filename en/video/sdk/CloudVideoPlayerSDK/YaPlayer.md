---
title: 'YaPlayer: {{ video-full-name }} player SDK for iOS'
description: Managing playback and monitoring the player state in the {{ video-name }} SDK for iOS.
---

# YaPlayer

```swift
public final class YaPlayer
```

Main player object for video content playback.

## Contents {#contents}

This page displays:

- [Properties](#properties)
- [Methods](#methods)

## Description {#discussion}

`YaPlayer` manages playback, including source loading, play, pause, rewind/fast forward, volume, and payback speed.

To create a player instance, call the `player()` method on the [Environment](./Environment.md#methods) struct.

## State monitoring {#state-monitoring}

To monitor changes in the player’s state, subscribe to events using Combine. The subscription methods return `PlayerPublisher` objects that provide subscribers with updated values. For a subscription example, see [Monitoring the player state](../ios-sdk.md#state-monitoring).

All subscription methods use the `queue` parameter to specify the event delivery queue. Its default value is `.main`.

## Properties {#properties}

#|
|| **Name** | **Type** | **Description** ||
|| `currentSource` | `ContentIdEndpoint?` | Current playback source ||
|| `vsid` | `String` | View session ID ||
|| `status` | `PlayerStatus` | Current state of the player ||
|| `watchedTime` | `Time` | Total playback time for the current content since the source was last set ||
|| `currentTime` | `Time?` | Current playback position ||
|| `duration` | `Time?` | Total content duration ||
|| `remainingBufferedTime` | `Time?` | Duration of the buffered fragment starting at the current playback position ||
|| `bufferTimeRanges` | `[Range<Time>]` | Buffered time ranges ||
|| `seekableTimeRanges` | `[Range<Time>]` | Seekable time ranges ||
|| `isMuted` | `Bool?` | Current audio state ||
|| `volume` | `Float?` | Current volume level, from `0.0` to `1.0` ||
|| `videoType` | `VideoType?` | Playback content type ||
|| `onAir` | `Bool` | `true` if playback is at the live edge of the broadcast timeline ||
|| `latency` | `TimeInterval` | Current playback latency behind live, in seconds ||
|| `targetLatency` | `TimeInterval` | Target playback latency behind live, in seconds ||
|| `playbackSpeed` | `PlaybackSpeed` | Current playback speed ||
|#

## Methods {#methods}

```swift
public func set<AdditionalParams: Encodable>(source endpoint: ContentIdEndpoint, config: PlaybackConfig, additionalParams: AdditionalParams)
```

Sets a playback source with additional telemetry parameters.

---

```swift
public func set(source endpoint: ContentIdEndpoint, config: PlaybackConfig = .base)
```

Sets a playback source.

---

```swift
public func reset()
```

Resets the current source and stops playback.

---

```swift
public func play()
```

Starts playback.

---

```swift
public func pause()
```

Pauses playback.

---

```swift
public func seek(to time: Time) async -> Bool
```

Rewinds/fast forwards to a specified position.

Parameters:

- `time`: Target position.

Return value: `true` if rewind/fast forward is successful.

---

```swift
public func set(isMute: Bool)
```

Enables or disables audio.

Parameters:

- `isMute`: `true` to mute, `false` to unmute.

---

```swift
public func set(volume: Float)
```

Sets volume level.

Parameters:

- `volume`: Volume level from `0.0` (muted) to `1.0` (maximum).

---

```swift
public func set(playbackSpeed: PlaybackSpeed) throws
```

Sets playback speed.

Parameters:

- `playbackSpeed`: Desired playback speed.

Exceptions: Throws an error if the specified speed is not supported for the current content.

---

```swift
public func canSet(playbackSpeed: PlaybackSpeed) -> Bool
```

Checks whether current content supports the specified playback speed.

Parameters:

- `playbackSpeed`: Speed to check.

Return value: `true` if the speed is available for the current content.

---

```swift
public func playerStatusDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<PlayerStatus>
```

Returns a `PlayerPublisher` object to monitor changes in the player state.

---

```swift
public func bufferTimeRangesDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<[Range<Time>]>
```

Returns a `PlayerPublisher` object to monitor changes in the buffered ranges.

---

```swift
public func seekableTimeRangeDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<[Range<Time>]>
```

Returns a `PlayerPublisher` object to monitor changes in the seekable ranges.

---

```swift
public func periodicTimePublisher(interval: TimeInterval, queue: DispatchQueue = .main) -> PlayerPublisher<TimeInterval>
```

Returns a `PlayerPublisher` object to periodically retrieve the playback position.

Parameters:

- `interval`: Playback position update interval, in seconds.

---

```swift
public func isMutedDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<Bool>
```

Returns a `PlayerPublisher` object to monitor changes in the audio state.

---

```swift
public func volumeDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<Float>
```

Returns a `PlayerPublisher` object to monitor changes in the volume level.

---

```swift
public func errorDidDetected(queue: DispatchQueue = .main) -> PlayerPublisher<PlayerError>
```

Returns a `PlayerPublisher` object to get notified of playback errors.

---

```swift
public func goToLive() async throws
```

Moves the playback position to the live edge of the broadcast timeline.

Exceptions: Throws an error if the operation is not available, e.g., during video-on-demand (VOD) playback.

---

```swift
public func playbackSpeedDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<PlaybackSpeed>
```

Returns a `PlayerPublisher` object to monitor changes in the playback speed.

## Examples {#examples}

```swift
let environment = Environment(configuration: Configuration(from: From(raw: "my-app")))
let player = environment.player()

// Connecting a surface for content
let surface = VideoSurface()
surface.attach(player: player)

// Setting a source and starting playback
if let source = ContentIdEndpoint(url: URL(string: "https://runtime.video.cloud.yandex.net/player/...")!) {
  player.set(source: source, config: PlaybackConfig(autoplay: true, isMuted: false))
}
```

```swift
player.playerStatusDidChange()
  .sink { status in
    switch status {
      case .play:      showPlayButton(false)
      case .pause:     showPlayButton(true)
      case .buffering: showSpinner(true)
      case .fatal:     showErrorScreen()
      default:         break
    }
  }
  .store(in: &cancellables)
```

---
