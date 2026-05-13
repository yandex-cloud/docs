# From

```swift
public struct From
```

Идентификатор приложения, использующего SDK.

## Contents
- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Передается при создании `Configuration` и используется в телеметрии для идентификации сервиса.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `raw` | `String` | Строковый идентификатор приложения. |

## Initializers

```swift
public init(raw: String)
```

Создает идентификатор приложения.

**Parameters:**

- `raw`: Строковый идентификатор. Рекомендуется использовать
  уникальное имя сервиса, например `"weather-app"`.

## Examples

```swift
let from = From(raw: "my-ios-app")
let config = Configuration(from: from)
```

---