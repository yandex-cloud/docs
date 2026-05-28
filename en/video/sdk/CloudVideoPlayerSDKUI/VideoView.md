# VideoView

```swift
public final class VideoView: UIView
```

UIView component for displaying videos with the built-in control skin.

## Contents

- [Methods](#methods)

## Discussion

`VideoView` extends the basic `VideoSurface` design with integrated controls: play and pause buttons, a progress bar, a buffering indicator, full-screen support, an error screen, and logo display support.

Use `VideoView` if you need a turnkey player skin. For minimalistic embedding without a skin or to implement a custom skin, use `VideoSurface` from `CloudVideoPlayer`.

## Basic use in UIKit

## SwiftUI

## Inheritance

- `UIView`

## Methods

```swift
public func setupLogo(_ configuration: (UIImageView) -> Void)
```

Configures a logo displayed over the video.

**Parameters:**

- `configuration`: Closure for configuring the logo's `UIImageView`.

---

```swift
public func reset()
```

Detaches the player from the view.

---

```swift
public func attach(player: YaPlayer)
```

Attaches the player to the view.

**Parameters:**

- `player`: Player instance to display.

---

```swift
public func getPipController() -> PictureInPictureController?
```

Returns the Picture-in-Picture (PiP) mode controller, if available.

**Returns:** `PictureInPictureController` instance, or `nil` if the device does not support PiP.

## Examples

```swift
import CloudVideoPlayerUI

class PlayerViewController: UIViewController {
  private let player = environment.player()
  private let videoView = VideoView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(videoView)
    videoView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      videoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      videoView.heightAnchor.constraint(equalTo: videoView.widthAnchor, multiplier: 9.0 / 16.0)
    ])

    videoView.attach(player: player)
  }
}
```

```swift
import SwiftUI
import CloudVideoPlayerUI

struct VideoPlayerView: UIViewRepresentable {
  let player: YaPlayer

  func makeUIView(context: Context) -> VideoView {
    let view = VideoView()
    view.attach(player: player)
    return view
  }

  func updateUIView(_ view: VideoView, context: Context) {
    view.attach(player: player)
  }
}
```

---
