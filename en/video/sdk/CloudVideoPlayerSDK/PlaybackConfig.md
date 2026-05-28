# PlaybackConfig

```swift
public struct PlaybackConfig
```

Playback configuration

## Contents

- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Passed when setting the source via `YaPlayer/set(source:config:)`. Defines the initial behavior of the player.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `autoplay` | `Bool` | Automatically start playback after loading the source. |
| `isMuted` | `Bool` | Start playback without sound. |
| `startPosition` | `Time` | Position from which playback starts. |

## Initializers

```swift
public init(autoplay: Bool, isMuted: Bool, startPosition: Time = .zero)
```

Creates a playback configuration.

## Examples

```swift
let config = PlaybackConfig(autoplay: true, isMuted: false, startPosition: Time(sec: 30))
player.set(source: endpoint, config: config)
```

---
