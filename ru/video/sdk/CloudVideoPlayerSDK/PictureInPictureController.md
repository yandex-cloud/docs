# PictureInPictureController

## Contents

- [PictureInPictureEvent](#pictureinpictureevent)
- [PictureInPictureController](#pictureinpicturecontroller)

---

## PictureInPictureEvent

```swift
public enum PictureInPictureEvent
```

Событие режима «Картинка в картинке» (Picture-in-Picture, PiP).

### Discussion

Публикуется через `PictureInPictureController/pipStatusEventsDispenser`.

### Cases

| Case | Description |
|------|-------------|
| `willStart` | PiP-режим начинает запускаться. |
| `didStart` | PiP-режим успешно запущен. |
| `willStop` | PiP-режим начинает останавливаться. |
| `didStop` | PiP-режим остановлен. |
| `failed` | Ошибка при запуске PiP-режима. |

---

## PictureInPictureController

```swift
public protocol PictureInPictureController: AnyObject
```

Контроллер режима «Картинка в картинке» (Picture-in-Picture).

### Discussion

Получить экземпляр можно через `VideoSurface/getPipController()`.

### Inheritance

- `AnyObject`

### Properties

| Name | Type | Description |
|------|------|-------------|
| `isPictureInPicturePossible` | `Bool` | `true`, если PiP-режим доступен для запуска в данный момент. |
| `isPictureInPictureActive` | `Bool` | `true`, если PiP-режим активен. |
| `isPictureInPictureSuspended` | `Bool` | `true`, если PiP-режим приостановлен системой. |
| `canStartPictureInPictureAutomatically` | `Bool` | Управляет автоматическим запуском PiP при сворачивании приложения. |
| `pipStatusEventsDispenser` | `AnyPublisher<PictureInPictureEvent, Never>` | Поток событий PiP-режима. |

### Methods

```swift
func start()
```

Запускает PiP-режим.

---

```swift
func stop()
```

Останавливает PiP-режим.

### Examples

```swift
guard let pip = videoSurface.getPipController() else { return }
pip.canStartPictureInPictureAutomatically = true

pip.pipStatusEventsDispenser
  .sink { event in
    switch event {
      case .didStart: print("PiP запущен")
      case .didStop:  print("PiP остановлен")
      case .failed(let error): print("Ошибка PiP: \(error)")
      default: break
    }
  }
  .store(in: &cancellables)
```

---
