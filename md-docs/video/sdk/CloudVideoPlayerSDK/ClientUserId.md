[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Structs > ClientUserId

# ClientUserId

```swift
public struct ClientUserId
```

Идентификатор пользователя, который задает клиентский сервис. Используется для отслеживания пользователя в телеметрии, например, для реализации счетчика зрителей.

## Contents
- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Передается через `ClientInfoProvider/userId()` в составе `Configuration`.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `raw` | `String` | Строковый идентификатор пользователя. |

## Initializers

```swift
public init(raw: String)
```

Создает идентификатор пользователя.

**Parameters:**

- `raw`: Строковый идентификатор пользователя.

---