# PlayerError

## Contents

- [PlayerError](#playererror)
- [AnyPlayerError](#anyplayererror)
- [PlayerErrorDetails](#playererrordetails)
- [PlayerErrorType](#playererrortype)

---

## PlayerError

```swift
public protocol PlayerError: Error
```

Player error protocol.

### Discussion

All errors occurring in the player conform to this protocol. You can get the error stream via `YaPlayer/errorDidDetected(queue:)`.

### Inheritance

- `Error`

### Properties

| Name | Type | Description |
|------|------|-------------|
| `type` | `PlayerErrorType` | Error type: Determines the severity. |
| `details` | `PlayerErrorDetails` | Detailed error information |

### Examples

```swift
player.errorDidDetected()
  .sink { error in
    if error.type == .fatal {
      showErrorScreen()
    }
  }
  .store(in: &cancellables)
```

---

## AnyPlayerError

```swift
public struct AnyPlayerError: PlayerError
```

Specific implementation of `PlayerError` returned by the player.

### Inheritance

- `PlayerError`

### Properties

| Name | Type | Description |
|------|------|-------------|
| `type` | `PlayerErrorType` | Error type. |
| `details` | `PlayerErrorDetails` | Detailed error information. |

---

## PlayerErrorDetails

```swift
public struct PlayerErrorDetails
```

Detailed player error information.

### Properties

| Name | Type | Description |
|------|------|-------------|
| `code` | `Int` | Error code |
| `domain` | `String` | Error domain |
| `description` | `String` | Error description |
| `userInfo` | `[String: Any]` | Additional error information |

---

## PlayerErrorType

```swift
public enum PlayerErrorType: String, Encodable
```

Player error type (severity).

### Inheritance

- `String`
- `Encodable`

### Cases

| Case | Description |
|------|-------------|
| `error` | Non-critical error: Playback may continue. |
| `fatal` | Fatal error: Playback is impossible. |

---
