# SDK видеоплеера для iOS

С помощью [SDK](https://github.com/yandex-cloud/cloud-video-player-ios-sdk/) вы можете встроить в ваше iOS-приложение [видеоплеер](../concepts/player.md) для воспроизведения контента из {{ video-name }}.

Для работы с SDK нужна среда разработки [Xcode](https://developer.apple.com/xcode/) версии 16.4 или выше и [Swift](https://www.swift.org/install/macos/) версии 5.8 или выше.

## Подключение библиотеки SDK видеоплеера {#add-library}

{% list tabs group=programming_language %}

- Xcode SPM {#xcode-spm}

  1. В окне Xcode навигатора проектов (**Project Navigator**) выберите свой проект. 
  1. На верхней панели нажмите **File** и выберите **Add Package Dependencies...**
  1. В строке поиска ![image](../../_assets/console-icons/magnifier.svg) введите `https://github.com/yandex-cloud/cloud-video-player-ios-sdk/` и выберите пакет `cloud-video-player-ios-sdk`.
  1. В поле **Dependency Rule** выберите **Up to Next Major Version** и укажите версию `0.1.6`.
  1. В поле **Add to Project** выберите проект, к которому вы хотите подключить библиотеки, и нажмите **Add Package**.
  1. Во всплывающем окне укажите, к какому таргету в проекте подключить библиотеки, и нажмите **Add Package**.
      
      Пакет содержит библиотеки:
      * `CloudVideoPlayer` — основная библиотека SDK видеоплеера для iOS.
      * `CloudVideoPlayerUI` — дополнительная библиотека с набором интерфейсных элементов (оболочка видеоплеера).

- Package.swift {#package-swift}

  1. В окне Xcode навигатора проектов (**Project Navigator**) выберите свой проект.
  1. Откройте `Package.swift`.
  1. Добавьте в массив `dependencies` следующую зависимость:

      ```swift
      dependencies: [
        .package(
          url: "https://github.com/yandex-cloud/cloud-video-player-ios-sdk/",
          from: "0.1.6"
        )
      ],
      ```

  1. Добавьте библиотеки в массив `dependencies` конкретного таргета:

      ```swift
      .target(
        name: "MyTargetName",
        dependencies: [
          .product(name: "CloudVideoPlayer", package: "cloud-video-player-ios-sdk"),
          .product(name: "CloudVideoPlayerUI", package: "cloud-video-player-ios-sdk")
        ]
      ),
      ```

      Где:
      * `CloudVideoPlayer` — основная библиотека SDK видеоплеера для iOS.
      * `CloudVideoPlayerUI` — дополнительная библиотека с набором интерфейсных элементов (оболочка видеоплеера).

  1. Сохраните изменения.

{% endlist %}

## Импорт библиотек {#import-library}

Чтобы импортировать библиотеки, добавьте в файл с кодом следующие строки:

```swift
import CloudVideoPlayer
import CloudVideoPlayerUI
```

## Использование SDK {#usage}

### Настройте запуск воспроизведения {#player-setup}

1. Импортируйте библиотеку в файле:

    ```swift
    import CloudVideoPlayer
    ```

1. Создайте объекты `Configuration`, `Environment` и `YaPlayer`:

    ```swift
    let environment = Environment(configuration: Configuration(from: From(raw: "your-app-bundle")))

    class ViewController: UIViewController {
      let player = environment.player()
    }
    ```

1. Создайте UIView-компонент `VideoSurface`, добавьте его в иерархию и подключите к экземпляру плеера:

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

1. Запустите воспроизведение:

    ```swift
    if let source = ContentIdEndpoint(url: URL(string: "https://runtime.video.cloud.yandex.net/player/...")!) {
      player.set(source: source)
      player.play()
    }
    ```

Где `https://runtime.video.cloud.yandex.net/player/...` — ссылка на [видео](../operations/video/get-link.md), [трансляцию](../operations/streams/get-link.md) или [плейлист](../operations/playlists/get-link.md).

{% cut "Полный код настройки запуска воспроизведения" %}

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

Где `https://runtime.video.cloud.yandex.net/player/...` — ссылка на [видео](../operations/video/get-link.md), [трансляцию](../operations/streams/get-link.md) или [плейлист](../operations/playlists/get-link.md).

{% endcut %}

### Подключение оболочки видеоплеера {#use-skin}

1. Импортируйте библиотеку в файле:

    ```swift
    import CloudVideoPlayerUI
    ```

1. Создайте UIView-компонент `VideoView`, добавьте его в иерархию и подключите к экземпляру плеера:

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

{% cut "Полный код подключения оболочки видеоплеера" %}

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

### Воспроизведение в SwiftUI {#swiftui}

Чтобы встроить плеер в SwiftUI, оберните `VideoView` из `CloudVideoPlayerUI` в `UIViewRepresentable` и подключите к нему экземпляр `YaPlayer`, созданный через `Environment`.

1. Импортируйте библиотеки в файле:

    ```swift
    import SwiftUI
    import CloudVideoPlayer
    import CloudVideoPlayerUI
    ```

1. Создайте объекты `Environment` и `YaPlayer`:

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

1. Создайте тип `UIViewRepresentable`, который создает `VideoView` и вызывает `attach(player:)`:

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

1. Добавьте обертку в иерархию SwiftUI:

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

Где `https://runtime.video.cloud.yandex.net/player/...` — ссылка на [видео](../operations/video/get-link.md), [трансляцию](../operations/streams/get-link.md) или [плейлист](../operations/playlists/get-link.md).

{% cut "Полный код воспроизведения в SwiftUI" %}

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

Где `https://runtime.video.cloud.yandex.net/player/...` — ссылка на [видео](../operations/video/get-link.md), [трансляцию](../operations/streams/get-link.md) или [плейлист](../operations/playlists/get-link.md).

{% endcut %}

#### См. также {#see-also}

Справочники по библиотекам SDK:

* [CloudVideoPlayer](CloudVideoPlayerSDK/Environment.md) — основная библиотека с объектами `Environment`, `YaPlayer`, `VideoSurface` и настройками воспроизведения.
* [CloudVideoPlayerUI](CloudVideoPlayerSDKUI/VideoView.md) — дополнительная библиотека интерфейсных элементов с готовой оболочкой плеера `VideoView`.