---
title: 'PlaybackSpeed: {{ video-full-name }} player SDK for iOS'
description: Setting playback speed in the {{ video-name }} player SDK for iOS.
---

# PlaybackSpeed

```swift
public struct PlaybackSpeed: Equatable
```

Playback speed

## Contents {#contents}

This page displays:

- [Properties](#properties)
- [Initializers](#initializers)

## Description {#discussion}

Use predefined constants or define a value with a custom rate. To check whether the playback speed is supported for the current content, call the `canSet(playbackSpeed:)` method for the [YaPlayer](./YaPlayer.md#methods) object.

## Protocol conformance {#inheritance}

The structure conforms to the `Equatable` protocol.

## Properties {#properties}

#|
|| **Name** | **Type** | **Description** ||
|| `rate` | `Float` | Playback speed factor ||
|| `paused` | `PlaybackSpeed` | Playback paused. The playback speed is zero ||
|| `x025` | `PlaybackSpeed` | 0.25× playback speed ||
|| `x050` | `PlaybackSpeed` | 0.5× playback speed ||
|| `x075` | `PlaybackSpeed` | 0.75× playback speed ||
|| `x100` | `PlaybackSpeed` | Normal (1×) speed 1× ||
|| `x125` | `PlaybackSpeed` | 1.25× playback speed ||
|| `x150` | `PlaybackSpeed` | 1.5× playback speed ||
|| `x175` | `PlaybackSpeed` | 1.75× playback speed ||
|| `x200` | `PlaybackSpeed` | 2× playback speed ||
|| `allCases` | `[PlaybackSpeed]` | All preset playback speed options from 0.25× to 2× ||
|#

## Initializers {#initializers}

```swift
public init(rate: Float)
```

Defines a playback speed with a custom factor.

Parameters:

- `rate`: Playback speed factor. The valid range depends on the content.

## Examples {#examples}

```swift
if player.canSet(playbackSpeed: .x150) {
  try? player.set(playbackSpeed: .x150)
}
```

---
