---
title: Как добавить Cloud Video Player в приложение iOS
description: Следуя данной инструкции, вы сможете интегрировать Cloud Video Player в ваше мобильное приложение для iOS.
---

# SDK видеоплеера для iOS

Вы можете добавить [видеоплеер](../concepts/player.md) с контентом из {{ video-name }} в ваше мобильное приложение для iOS. Для этого воспользуйтесь SDK видеоплеера для iOS.

Чтобы использовать SDK, вам понадобится установленная и настроенная среда разработки [Xcode](https://developer.apple.com/xcode/) версии 15.3 или выше с языком программирования [Swift](https://www.swift.org/install/macos/) версии 5.8 или выше.

## Подключение библиотеки SDK видеоплеера {#add-library}

{% list tabs group=programming_language %}

- Xcode SPM {#xcode-spm}

  1. В окне Xcode навигатора проектов (**Project Navigator**) выберите свой проект. 
  1. На верхней панели нажмите **File** и выберите **Add Package Dependencies...**
  1. В строке поиска ![image](../../_assets/console-icons/magnifier.svg) введите `https://github.com/yandex-cloud/cloud-video-player-ios-sdk/` и выберите пакет `cloud-video-player-ios-sdk`.
  1. В поле **Dependency Rule** выберите **Up to Next Major Version** и укажите версию `0.1.0-beta`.
  1. В поле **Add to Project** выберите проект, к которому вы хотите подключить библиотеки, и нажмите **Add Package**.
  1. Во всплывающем окне укажите, к какому таргету в проекте подключить библиотеки, и нажмите **Add Package**.
      
      Пакет содержит следующие библиотеки:
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
          from: "0.1.0-beta"
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

1. Создайте объекты `Environment` и `YaPlayer`:

    ```swift
    let environment = Environment(from: From(raw: "you-app-bundle"))

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
    player.set(source: ContentId(rawValue: "https://runtime.video.cloud.yandex.net/player/..."))
    player.play()
    ```

{% include [video-content-id-desc](../../_includes/video/video-content-id-desc.md) %}

{% cut "Полный код настройки запуска воспроизведения" %}

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
      self.view.addSubview(surface)
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
  self.view.addSubview(surface)
  videoView.frame = UIScreen.main.bounds
}

override func viewDidLoad() {
  super.viewDidLoad()
  videoView.attach(player: player)
}
```

{% endcut %}