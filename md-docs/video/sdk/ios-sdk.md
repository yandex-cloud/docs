[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Video](../index.md) > Видеоплеер > [SDK](index.md) > iOS > Начало работы

# SDK видеоплеера для iOS

С помощью [SDK](https://github.com/yandex-cloud/cloud-video-player-ios-sdk/) вы можете встроить в приложение для iOS [видеоплеер](../concepts/player.md) для воспроизведения контента из Cloud Video.

Для работы с SDK нужна среда разработки [Xcode](https://developer.apple.com/xcode/) версии 16.4 или выше и [Swift](https://www.swift.org/install/macos/) версии 5.10 или выше. Минимальная поддерживаемая версия iOS — 15.

## Подключение библиотеки SDK видеоплеера {#add-library}

{% list tabs group=programming_language %}

- Xcode SPM {#xcode-spm}

  1. В окне Xcode навигатора проектов (**Project Navigator**) выберите свой проект. 
  1. На верхней панели нажмите **File** и выберите **Add Package Dependencies...**
  1. В строке поиска ![image](../../_assets/console-icons/magnifier.svg) введите `https://github.com/yandex-cloud/cloud-video-player-ios-sdk/` и выберите пакет `cloud-video-player-ios-sdk`.
  1. В поле **Dependency Rule** выберите **Up to Next Major Version** и укажите версию `0.1.7`.
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
          from: "0.1.7"
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

### Настройка воспроизведения {#playback-settings}

Чтобы задать начальную позицию, состояние звука и автоматический запуск воспроизведения, передайте объект [PlaybackConfig](CloudVideoPlayerSDK/PlaybackConfig.md) в метод `set(source:config:)`:

```swift
let config = PlaybackConfig(
  autoplay: true,
  isMuted: false,
  startPosition: Time(sec: 30)
)
player.set(source: source, config: config)
```

В примере `player` — созданный ранее экземпляр `YaPlayer`, а `source` — источник `ContentIdEndpoint`. Плеер начнет воспроизведение с 30-й секунды со звуком. Если не передать `config`, используется конфигурация `PlaybackConfig.base`: воспроизведение с начала, со звуком, без автоматического запуска.

Чтобы изменить скорость воспроизведения, проверьте ее доступность с помощью метода `canSet(playbackSpeed:)`, затем вызовите `set(playbackSpeed:)`:

```swift
if player.canSet(playbackSpeed: .x150) {
  do {
    try player.set(playbackSpeed: .x150)
  } catch {
    print("Не удалось изменить скорость: \(error)")
  }
}
```

Предопределенные значения скорости приведены в справочнике [PlaybackSpeed](CloudVideoPlayerSDK/PlaybackSpeed.md#properties).

### Отслеживание состояния плеера {#state-monitoring}

Чтобы получать уведомления об изменении состояния плеера, подпишитесь на события с помощью [Combine](https://developer.apple.com/documentation/combine). Например, создайте объект, который отслеживает состояние плеера, позицию воспроизведения и ошибки:

```swift
import Combine
import CloudVideoPlayer

final class PlayerObserver {
  private var subscriptions = Set<AnyCancellable>()

  init(player: YaPlayer) {
    player.playerStatusDidChange()
      .sink { status in
        print("Состояние плеера: \(status)")
      }
      .store(in: &subscriptions)

    player.periodicTimePublisher(interval: 1)
      .sink { time in
        print("Позиция воспроизведения: \(time)")
      }
      .store(in: &subscriptions)

    player.errorDidDetected()
      .sink { error in
        print("Ошибка воспроизведения: \(error)")
      }
      .store(in: &subscriptions)
  }
}
```

Создайте экземпляр `PlayerObserver(player: player)` и сохраните его, например в свойстве контроллера. Подписки должны храниться, пока вы отслеживаете события. При освобождении объекта подписки отменяются. По умолчанию события доставляются в главную очередь `.main`. Чтобы выбрать другую очередь, передайте параметр `queue` в метод подписки.

Полный список свойств и методов приведен в справочнике [YaPlayer](CloudVideoPlayerSDK/YaPlayer.md).

### Возврат к прямому эфиру {#go-to-live}

Чтобы вернуться к прямому эфиру после перемотки трансляции, вызовите асинхронный метод `goToLive()`:

```swift
Task {
  do {
    try await player.goToLive()
  } catch {
    print("Не удалось перейти к прямому эфиру: \(error)")
  }
}
```

Метод перемещает позицию воспроизведения на правую границу шкалы времени трансляции. Если переход невозможен, например при воспроизведении видео по запросу (VOD), метод возвращает ошибку.

#### Полезные ссылки {#see-also}

Справочники по библиотекам SDK:

* [CloudVideoPlayer](CloudVideoPlayerSDK/Environment.md) — основная библиотека с объектами `Environment`, `YaPlayer`, `VideoSurface` и настройками воспроизведения.
* [CloudVideoPlayerUI](CloudVideoPlayerSDKUI/VideoView.md) — дополнительная библиотека интерфейсных элементов с готовой оболочкой плеера `VideoView`.