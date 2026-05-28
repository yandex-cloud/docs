# PlaybackSpeed

```swift
public struct PlaybackSpeed: Equatable
```

Playback speed

## Contents

- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Use predefined constants or define a value with a custom rate. You can check whether a specific speed is available for the current content via `YaPlayer/canSet(playbackSpeed:)`.

## Inheritance

- `Equatable`

## Properties

| Name | Type | Description |
|------|------|-------------|
| `rate` | `Float` | Playback speed factor |

## Initializers

```swift
public init(rate: Float)
```

Defines a playback speed with a custom factor.

**Parameters:**

- `rate`: Playback speed factor. The valid range depends on the content.

## Examples

```swift
if player.canSet(playbackSpeed: .x150) {
  try? player.set(playbackSpeed: .x150)
}
```

---
