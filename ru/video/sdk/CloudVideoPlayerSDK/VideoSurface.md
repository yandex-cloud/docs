# VideoSurface

```swift
public final class VideoSurface: UIView
```

UIView-компонент для отображения видео.

## Contents
- [Methods](#methods)
- [Initializers](#initializers)

## Discussion

Добавьте `VideoSurface` в иерархию представлений и подключите к нему экземпляр `YaPlayer`. Поверхность автоматически масштабируется по размеру своих `bounds`.

Для использования в SwiftUI оберните `VideoSurface` через `UIViewRepresentable`.

## Inheritance

- `UIView`

## Notes

Если нужен встроенный скин плеера, используйте `VideoView` из `CloudVideoPlayerUI`.

## Initializers

```swift
public init()
```

Создает поверхность для отображения видео.

## Methods

```swift
public func reset()
```

Отключает плеер от поверхности.

---

```swift
public func getPipController() -> PictureInPictureController?
```

Возвращает контроллер режима «Картинка в картинке» (PiP), если он доступен.

**Returns:** Экземпляр `PictureInPictureController` или `nil`, если устройство не поддерживает PiP.

## Examples

```swift
let surface = VideoSurface()
view.addSubview(surface)
surface.frame = UIScreen.main.bounds

surface.attach(player: player)
```

---
