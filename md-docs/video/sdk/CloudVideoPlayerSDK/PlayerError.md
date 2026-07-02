[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Structs > PlayerError

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

Протокол ошибки плеера.

### Discussion

Все ошибки, возникающие в плеере, соответствуют этому протоколу. Получить поток ошибок можно через `YaPlayer/errorDidDetected(queue:)`.

### Inheritance

- `Error`

### Properties

| Name | Type | Description |
|------|------|-------------|
| `type` | `PlayerErrorType` | Тип ошибки — определяет критичность. |
| `details` | `PlayerErrorDetails` | Подробная информация об ошибке. |

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

Конкретная реализация `PlayerError`, возвращаемая плеером.

### Inheritance

- `PlayerError`

### Properties

| Name | Type | Description |
|------|------|-------------|
| `type` | `PlayerErrorType` | Тип ошибки. |
| `details` | `PlayerErrorDetails` | Подробная информация об ошибке. |

---

## PlayerErrorDetails

```swift
public struct PlayerErrorDetails
```

Подробная информация об ошибке плеера.

### Properties

| Name | Type | Description |
|------|------|-------------|
| `code` | `Int` | Код ошибки. |
| `domain` | `String` | Домен ошибки. |
| `description` | `String` | Описание ошибки. |
| `userInfo` | `[String: Any]` | Дополнительная информация об ошибке. |

---

## PlayerErrorType

```swift
public enum PlayerErrorType: String, Encodable
```

Тип (критичность) ошибки плеера.

### Inheritance

- `String`
- `Encodable`

### Cases

| Case | Description |
|------|-------------|
| `error` | Некритичная ошибка — воспроизведение может продолжиться. |
| `fatal` | Фатальная ошибка — воспроизведение невозможно. |

---