---
title: VideoSurface — SDK видеоплеера {{ video-full-name }} для iOS
description: Отображение видео с помощью VideoSurface в SDK видеоплеера {{ video-name }} для iOS.
---

# VideoSurface

```swift
public final class VideoSurface: UIView
```

Компонент `UIView` для отображения видео.

## Содержание {#contents}

На этой странице:

- [Инициализаторы](#initializers)
- [Методы](#methods)

## Описание {#discussion}

Добавьте `VideoSurface` в иерархию представлений и подключите к нему экземпляр [YaPlayer](./YaPlayer.md). Область отображения видео автоматически масштабируется в соответствии со значением `bounds`.

Для использования в SwiftUI оберните `VideoSurface` в `UIViewRepresentable`.

## Наследование {#inheritance}

Класс наследуется от `UIView`.

## Примечания {#notes}

Чтобы подключить готовую оболочку плеера, используйте [VideoView](../CloudVideoPlayerSDKUI/VideoView.md) из библиотеки `CloudVideoPlayerUI`.

## Инициализаторы {#initializers}

```swift
public init()
```

Создает поверхность для отображения видео.

## Методы {#methods}

```swift
public func reset()
```

Отключает плеер от поверхности.

---

```swift
public func getPipController() -> PictureInPictureController?
```

Возвращает контроллер режима «Картинка в картинке» (PiP), если он доступен.

Возвращаемое значение: экземпляр `PictureInPictureController` или `nil`, если устройство не поддерживает PiP.

---

```swift
public func attach(player: YaPlayer)
```

Подключает плеер к поверхности для отображения видео.

Параметры:

- `player` — экземпляр плеера, видео которого нужно отображать.

## Примеры {#examples}

```swift
let surface = VideoSurface()
view.addSubview(surface)
surface.frame = UIScreen.main.bounds

surface.attach(player: player)
```

---
