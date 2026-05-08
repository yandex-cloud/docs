# VideoView

```swift
public final class VideoView: UIView
```

UIView-компонент для отображения видео со встроенным скином управления.

## Contents
- [Methods](#methods)

## Discussion

`VideoView` расширяет базовый `VideoSurface` встроенными элементами управления: кнопками воспроизведения и паузы, полосой прогресса, индикатором буферизации, поддержкой полноэкранного режима, экраном ошибки и возможностью отображения логотипа.

Используйте `VideoView`, если нужен готовый скин плеера. Для минималистичного встраивания без скина или для реализации собственного скина используйте `VideoSurface` из `CloudVideoPlayer`.

## Базовое использование в UIKit

## Использование в SwiftUI

## Inheritance

- `UIView`

## Methods

```swift
public func setupLogo(_ configuration: (UIImageView) -> Void)
```

Настраивает логотип, отображаемый поверх видео.

**Parameters:**

- `configuration`: Замыкание для настройки `UIImageView` логотипа.

---

```swift
public func reset()
```

Отключает плеер от представления.

---

```swift
public func attach(player: YaPlayer)
```

Подключает плеер к представлению.

**Parameters:**

- `player`: Экземпляр плеера для отображения.

---

```swift
public func getPipController() -> PictureInPictureController?
```

Возвращает контроллер режима «Картинка в картинке» (PiP), если он доступен.

**Returns:** Экземпляр `PictureInPictureController` или `nil`, если устройство не поддерживает PiP.

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
