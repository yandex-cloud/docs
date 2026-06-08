# PictureInPictureController

## Contents

- [PictureInPictureEvent](#pictureinpictureevent)
- [PictureInPictureController](#pictureinpicturecontroller)

---

## PictureInPictureEvent

```swift
public enum PictureInPictureEvent
```

Picture-in-Picture (PiP) mode event.

### Discussion

Published via `PictureInPictureController/pipStatusEventsDispenser`.

### Cases

| Case | Description |
|------|-------------|
| `willStart` | PiP mode is starting. |
| `didStart` | PiP mode successfully started. |
| `willStop` | PiP mode begins to stop. |
| `didStop` | PiP mode stopped. |
| `failed` | Error starting PiP mode. |

---

## PictureInPictureController

```swift
public protocol PictureInPictureController: AnyObject
```

Picture-in-Picture mode controller.

### Discussion

You can get an instance via `VideoSurface/getPipController()`.

### Inheritance

- `AnyObject`

### Properties

| Name | Type | Description |
|------|------|-------------|
| `isPictureInPicturePossible` | `Bool` | `true` if PiP mode is available and can be started at the moment. |
| `isPictureInPictureActive` | `Bool` | `true` if PiP mode is active. |
| `isPictureInPictureSuspended` | `Bool` | `true` if PiP mode is suspended by the system. |
| `canStartPictureInPictureAutomatically` | `Bool` | Controls automatic start of PiP mode when the app is minimized. |
| `pipStatusEventsDispenser` | `AnyPublisher<PictureInPictureEvent, Never>` | PiP mode event flow. |

### Methods

```swift
func start()
```

Starts PiP mode.

---

```swift
func stop()
```

Stops PiP mode.

### Examples

```swift
guard let pip = videoSurface.getPipController() else { return }
pip.canStartPictureInPictureAutomatically = true

pip.pipStatusEventsDispenser
  .sink { event in
    switch event {
      case .didStart: print("PiP started")
      case .didStop:  print("PiP stopped")
      case .failed(let error): print("PiP error: \(error)")
      default: break
    }
  }
  .store(in: &cancellables)
```

---
