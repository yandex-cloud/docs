# YaPlayer

```swift
public final class YaPlayer
```

Main player object for video content playback.

## Contents

- [Properties](#properties)
- [Methods](#methods)

## Discussion

`YaPlayer` manages the full playback lifecycle: source loading, start, pause, rewind/fast forward, audio management, and speed.

Create instances via `Environment/player()`.

## State monitoring

Use Combine publishers to respond to state changes.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `currentSource` | `ContentIdEndpoint?` | Current playback source. |

## Methods

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

**Parameters:**

- `time`: Target position.

**Returns**: `true` if rewind/fast forward is successful.

---

```swift
public func set(isMute: Bool)
```

Enables or disables audio.

**Parameters:**

- `isMute`: `true` to mute, `false` to unmute.

---

```swift
public func set(volume: Float)
```

Sets volume level.

**Parameters:**

- `volume`: Volume level from `0.0` (silence) to `1.0` (maximum).

---

```swift
public func set(playbackSpeed: PlaybackSpeed) throws
```

Sets playback speed.

**Parameters:**

- `playbackSpeed`: Desired playback speed.

**Throws:** Error if the specified speed is not supported for the current content.

---

```swift
public func canSet(playbackSpeed: PlaybackSpeed) -> Bool
```

Checks whether current content supports the specified playback speed.

**Parameters:**

- `playbackSpeed`: Speed to check.

**Returns:** `true` if the speed is available for the current content.

## Examples

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
