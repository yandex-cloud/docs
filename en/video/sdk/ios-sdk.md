---
title: How to embed Cloud Video Player into an iOS app
description: Follow this guide to integrate Cloud Video Player into your mobile app for iOS.
---

# Video player SDK for iOS

You can embed a [video player](../concepts/player.md) with {{ video-name }} content into your mobile app for iOS. The video player SDK for iOS will help you do this.

To use the SDK, install and configure the [Xcode](https://developer.apple.com/xcode/) development environment (version 15.3 or higher) with the [Swift](https://www.swift.org/install/macos/) programming language (version 5.8 or higher).

## Adding a video player SDK library {#add-library}

{% list tabs group=programming_language %}

- Xcode SPM {#xcode-spm}

  1. In the **Project Navigator** Xcode window, select your project. 
  1. In the top panel, click **File** and select **Add Package Dependencies...**.
  1. In the search box ![image](../../_assets/console-icons/magnifier.svg), enter `https://github.com/yandex-cloud/cloud-video-player-ios-sdk/`. Then, select the `cloud-video-player-ios-sdk` package.
  1. In the **Dependency Rule** field, select **Up to Next Major Version** and specify the version: `0.1.0-beta`.
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
          from: "0.1.0-beta"
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

1. Create the `Environment` and `YaPlayer` objects:

    ```swift
    let environment = Environment(from: From(raw: "you-app-bundle"))

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
    player.set(source: ContentId(rawValue: "https://runtime.video.cloud.yandex.net/player/..."))
    player.play()
    ```

{% include [video-content-id-desc](../../_includes/video/video-content-id-desc.md) %}

{% cut "Full code to set up the start of playback" %}

```swift
import CloudVideoPlayer

let environment = Environment(from: From(raw: "you-app-bundle"))

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

    player.set(source: ContentId(rawValue: "https://runtime.video.cloud.yandex.net/player/..."))
    player.play()
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
      self.view.addSubview(surface)
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
  self.view.addSubview(surface)
  videoView.frame = UIScreen.main.bounds
}

override func viewDidLoad() {
  super.viewDidLoad()
  videoView.attach(player: player)
}
```

{% endcut %}