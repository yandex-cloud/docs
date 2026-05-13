# Configuration

## Contents

- [ClientInfoProvider](#clientinfoprovider)
- [Configuration](#configuration)

---

## ClientInfoProvider

```swift
public protocol ClientInfoProvider
```

Протокол для передачи информации о пользователе в SDK.

### Discussion

Реализуйте этот протокол, чтобы передавать идентификатор пользователя в телеметрию.

### Methods

```swift
func userId() -> ClientUserId?
```

Возвращает идентификатор текущего пользователя или `nil`, если пользователь неизвестен.

### Examples

```swift
struct MyClientInfoProvider: ClientInfoProvider {
  func userId() -> ClientUserId? {
    // Return your app's current user ID
    return ClientUserId(raw: currentUserId)
  }
}
```

---

## Configuration

```swift
public struct Configuration
```

Конфигурация SDK.

### Discussion

Передается при создании `Environment`. Содержит обязательный идентификатор приложения и опциональный провайдер информации о пользователе.

### Initializers

```swift
public init(from: From, clientInfoProvider: ClientInfoProvider? = nil)
```

Создает конфигурацию SDK.

### Examples

```swift
let config = Configuration(
  from: From(raw: "my-ios-app"),
  clientInfoProvider: MyClientInfoProvider()
)
let environment = Environment(configuration: config)
```

---