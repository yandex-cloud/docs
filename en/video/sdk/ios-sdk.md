---
title: How to embed {{ video-player-name }} in an iOS app
description: Follow this guide to integrate {{ video-player-name }} into your mobile app for iOS.
---

# Video player SDK for iOS

The [SDK](https://github.com/yandex-cloud/cloud-video-player-ios-sdk/) allows you to embed a [player](../concepts/player.md) for {{ video-name }} content into your iOS app.

To use the SDK, you need the [Xcode](https://developer.apple.com/xcode/) IDE version 16.4 or higher and [Swift](https://www.swift.org/install/macos/) version 5.8 or higher.

## Adding a video player SDK library {#add-library}

{% list tabs group=programming_language %}

- Xcode SPM {#xcode-spm}

  1. In the **Project Navigator** Xcode window, select your project. 
  1. In the top panel, click **File** and select **Add Package Dependencies...**.
  1. In the search box ![image](../../_assets/console-icons/magnifier.svg), enter `https://github.com/yandex-cloud/cloud-video-player-ios-sdk/`. Then, select the `cloud-video-player-ios-sdk` package.
  1. In the **Dependency Rule** field, select **Up to Next Major Version** and specify the version: `0.1.6`.
  1. In the **Add to Project** field, select the project you want to add libraries to and click **Add Package**.
  1. In the pop-up window, specify the target to add the libraries to and click **Add Package**.
      
      The package contains the following libraries:
      * `CloudVideoPlayer`: Main library of the video player SDK for iOS.
      * `CloudVideoPlayerUI`: Additional library with a collection of interface elements (video player skin).

- Package.swift {#package-swift}

  1. In the **Project Navigator** Xcode window, select your project.
  1. Open `Package.swift`.
  1. Add the following dependency to the `dependencies` array:

      ```swift
      dependencies: [
        .package(
          url: "https://github.com/yandex-cloud/cloud-video-player-ios-sdk/",
          from: "0.1.6"
        )
      ],
      ```

  1. Add the libraries to the `dependencies` array of the target:

      ```swift
      .target(
        name: "MyTargetName",
        dependencies: [
          .product(name: "CloudVideoPlayer", package: "cloud-video-player-ios-sdk"),
          .product(name: "CloudVideoPlayerUI", package: "cloud-video-player-ios-sdk")
        ]
      ),
      ```

      Where:
      * `CloudVideoPlayer`: Main library of the video player SDK for iOS.
      * `CloudVideoPlayerUI`: Additional library with a collection of interface elements (video player skin).

  1. Save your changes.

{% endlist %}

## Importing the libraries {#import-library}

To import the libraries, add the following lines to your code file:

```swift
import CloudVideoPlayer
import CloudVideoPlayerUI
```

## Using the SDK {#usage}

### Set up the start of playback {#player-setup}

1. Import a library in the file:

    ```swift
    import CloudVideoPlayer
    ```

1. Create the `Configuration`, `Environment`, and `YaPlayer` objects:

    ```swift
    let environment = Environment(configuration: Configuration(from: From(raw: "your-app-bundle")))

    class ViewController: UIViewController {
      let player = environment.player()
    }
    ```

1. Create the `VideoSurface` UIView component, add it to the hierarchy, and attach to the player instance:

    ```swift
    let surface = VideoSurface()

    override func loadView() {
      super.loadView()
      self.view.addSubview(surface)
      surface.frame = UIScreen.main.bounds
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      surface.attach(player: player)
    }
    ```

1. Start playback:

    ```swift
    if let source = ContentIdEndpoint(url: URL(string: "https://runtime.video.cloud.yandex.net/player/...")!) {
      player.set(source: source)
      player.play()
    }
    ```

{% include [video-content-id-desc](../../_includes/video/video-content-id-desc.md) %}

{% cut "Full code to set up the start of playback" %}

```swift
import CloudVideoPlayer

let environment = Environment(configuration: Configuration(from: From(raw: "your-app-bundle")))

class ViewController: UIViewController {

  let player = environment.player()
  let surface = VideoSurface()

  override func loadView() {
    super.loadView()
    self.view.addSubview(surface)
    surface.frame = UIScreen.main.bounds
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    surface.attach(player: player)

    if let source = ContentIdEndpoint(url: URL(string: "https://runtime.video.cloud.yandex.net/player/...")!) {
      player.set(source: source)
      player.play()
    }
  }
}
```

{% include [video-content-id-desc](../../_includes/video/video-content-id-desc.md) %}

{% endcut %}

### Connecting a video player skin {#use-skin}

1. Import a library in the file:

    ```swift
    import CloudVideoPlayerUI
    ```

1. Create the `VideoView` UIView component, add it to the hierarchy, and connect to the player instance:

    ```swift
    let videoView = VideoView()

    override func loadView() {
      super.loadView()
      self.view.addSubview(videoView)
      videoView.frame = UIScreen.main.bounds
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      videoView.attach(player: player)
    }
    ```

{% cut "Full code to connect a video player skin" %}

```swift
import CloudVideoPlayerUI

let videoView = VideoView()

override func loadView() {
  super.loadView()
  self.view.addSubview(videoView)
  videoView.frame = UIScreen.main.bounds
}

override func viewDidLoad() {
  super.viewDidLoad()
  videoView.attach(player: player)
}
```

{% endcut %}

### Playback in SwiftUI {#swiftui}

To embed your player in SwiftUI, wrap `VideoView` from `CloudVideoPlayerUI` into `UIViewRepresentable`, then bind it to the `YaPlayer` instance created via `Environment`.

1. Import these libraries in the file:

    ```swift
    import SwiftUI
    import CloudVideoPlayer
    import CloudVideoPlayerUI
    ```

1. Create the `Environment` and `YaPlayer` objects:

    ```swift
    let environment = Environment(configuration: Configuration(from: From(raw: "your-app-bundle")))

    final class PlayerViewModel: ObservableObject {
      let player: YaPlayer = environment.player()

      init() {
        guard
          let url = URL(string: "https://runtime.video.cloud.yandex.net/player/..."),
          let source = ContentIdEndpoint(url: url)
        else {
          return
        }
        player.set(source: source)
        player.play()
      }
    }
    ```

1. Create the `UIViewRepresentable` type that creates your `VideoView` and calls `attach(player:)`:

    ```swift
    struct VideoViewRepresentable: UIViewRepresentable {
      let player: YaPlayer

      func makeUIView(context: Context) -> VideoView {
        let view = VideoView()
        view.attach(player: player)
        return view
      }

      func updateUIView(_ uiView: VideoView, context: Context) {
        uiView.attach(player: player)
      }
    }
    ```

1. Add the wrapper to the SwiftUI hierarchy:

    ```swift
    struct ContentView: View {
      @StateObject private var viewModel = PlayerViewModel()

      var body: some View {
        VideoViewRepresentable(player: viewModel.player)
          .aspectRatio(16 / 9, contentMode: .fit)
          .frame(maxHeight: .infinity, alignment: .top)
      }
    }
    ```

{% include [video-content-id-desc](../../_includes/video/video-content-id-desc.md) %}

{% cut "Full code for playback in SwiftUI" %}

```swift
import SwiftUI
import CloudVideoPlayer
import CloudVideoPlayerUI

let environment = Environment(configuration: Configuration(from: From(raw: "your-app-bundle")))

final class PlayerViewModel: ObservableObject {
  let player: YaPlayer = environment.player()

  init() {
    guard
      let url = URL(string: "https://runtime.video.cloud.yandex.net/player/..."),
      let source = ContentIdEndpoint(url: url)
    else {
      return
    }
    player.set(source: source)
    player.play()
  }
}

struct VideoViewRepresentable: UIViewRepresentable {
  let player: YaPlayer

  func makeUIView(context: Context) -> VideoView {
    let view = VideoView()
    view.attach(player: player)
    return view
  }

  func updateUIView(_ uiView: VideoView, context: Context) {
    uiView.attach(player: player)
  }
}

struct ContentView: View {
  @StateObject private var viewModel = PlayerViewModel()

  var body: some View {
    VideoViewRepresentable(player: viewModel.player)
      .aspectRatio(16 / 9, contentMode: .fit)
      .frame(maxHeight: .infinity, alignment: .top)
  }
}
```

{% include [video-content-id-desc](../../_includes/video/video-content-id-desc.md) %}

{% endcut %}

#### See also {#see-also}

SDK library references:

* [CloudVideoPlayer](./CloudVideoPlayerSDK/Environment.md): Main library with `Environment`, `YaPlayer`, and `VideoSurface` objects and playback settings.
* [CloudVideoPlayerUI](./CloudVideoPlayerSDKUI/VideoView.md): Additional UI component library with a ready-made `VideoView` player shell.