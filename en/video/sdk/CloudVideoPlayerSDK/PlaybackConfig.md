---
title: PlaybackConfig, a {{ video-full-name }} SDK for iOS
description: Configuring autoplayback, sound settings, and start position in the {{ video-name }} SDK for iOS.
---

# PlaybackConfig

```swift
public struct PlaybackConfig
```

Playback configuration

## Contents {#contents}

This page displays:

- [Properties](#properties)
- [Initializers](#initializers)

## Description {#discussion}

Provided when setting the source via the `set(source:config:)` method of a [YaPlayer](./YaPlayer.md#methods) object. Defines the initial behavior of the player.

## Properties {#properties}

#|
|| **Name** | **Type** | **Description** ||
|| `autoplay` | `Bool` | Automatically start playback after loading the source. ||
|| `isMuted` | `Bool` | Start playback without sound. ||
|| `startPosition` | `Time` | Position from which playback starts. ||
|| `base` | `PlaybackConfig` | Default configuration: playback from the beginning, not muted, no automatic start. ||
|#

## Initializers {#initializers}

```swift
public init(autoplay: Bool, isMuted: Bool, startPosition: Time = .zero)
```

Creates a playback configuration.

## Examples {#examples}

```swift
let config = PlaybackConfig(autoplay: true, isMuted: false, startPosition: Time(sec: 30))
player.set(source: endpoint, config: config)
```

---
