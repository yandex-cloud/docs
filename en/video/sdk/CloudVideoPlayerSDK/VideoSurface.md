---
title: 'VideoSurface: {{ video-full-name }} player SDK for iOS'
description: Displaying video with VideoSurface in the {{ video-full-name }} player SDK for iOS.
---

# VideoSurface

```swift
public final class VideoSurface: UIView
```

`UIView` for displaying videos.

## Contents {#contents}

This page displays:

- [Initializers](#initializers)
- [Methods](#methods)

## Description {#discussion}

Add `VideoSurface` to the view hierarchy and attach a [YaPlayer](./YaPlayer.md) instance to the component. The video display area automatically resizes to match the `bounds` value.

To use `VideoSurface` in SwiftUI, wrap it in `UIViewRepresentable`.

## Inheritance {#inheritance}

The class is inherited from `UIView`.

## Notes {#notes}

To add a ready-made player shell, use [VideoView](../CloudVideoPlayerSDKUI/VideoView.md) from the `CloudVideoPlayerUI` library.

## Initializers {#initializers}

```swift
public init()
```

Creates a surface for the video.

## Methods {#methods}

```swift
public func reset()
```

Disconnects the player from the surface.

---

```swift
public func getPipController() -> PictureInPictureController?
```

Returns the Picture-in-Picture (PiP) mode controller, if available.

Return value: `PictureInPictureController` instance or `nil` if your device does not support PiP.

---

```swift
public func attach(player: YaPlayer)
```

Attaches the player to the video display surface.

Parameters:

- `player`: Player instance whose video you want to display.

## Examples {#examples}

```swift
let surface = VideoSurface()
view.addSubview(surface)
surface.frame = UIScreen.main.bounds

surface.attach(player: player)
```

---
