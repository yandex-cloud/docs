# VideoSurface

```swift
public final class VideoSurface: UIView
```

UIView component for displaying videos.

## Contents

- [Methods](#methods)
- [Initializers](#initializers)

## Discussion

Add `VideoSurface` to the view hierarchy and attach a `YaPlayer` instance to the component. The surface automatically scales to fit its `bounds`.

To use `VideoSurface` in SwiftUI, wrap it in `UIViewRepresentable`.

## Inheritance

- `UIView`

## Notes

If you need a built-in player skin, use `VideoView` from `CloudVideoPlayerUI`.

## Initializers

```swift
public init()
```

Creates a surface for the video.

## Methods

```swift
public func reset()
```

Disconnects the player from the surface.

---

```swift
public func getPipController() -> PictureInPictureController?
```

Returns the Picture-in-Picture (PiP) mode controller, if available.

**Returns:** `PictureInPictureController` instance, or `nil` if the device does not support PiP.

## Examples

```swift
let surface = VideoSurface()
view.addSubview(surface)
surface.frame = UIScreen.main.bounds

surface.attach(player: player)
```

---
