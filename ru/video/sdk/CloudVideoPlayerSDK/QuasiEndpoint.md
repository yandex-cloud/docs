# QuasiEndpoint

```swift
public struct QuasiEndpoint
```

HTTP-эндпоинт для переопределения адреса для отправки телеметрии.

## Contents
- [Initializers](#initializers)

## Discussion

Используется в `Environment/set(telemetryEndpoint:)` для замены стандартного эндпоинта телеметрии на пользовательский.

## Initializers

```swift
public init(
url: URL,
httpMethod: String = "POST",
httpHeaders: [String: String] = ["Content-Type": "application/json"]
)
```

Создает HTTP-эндпоинт.

## Examples

```swift
let endpoint = QuasiEndpoint(url: URL(string: "https://my-telemetry.example.com/log")!)
Environment.set(telemetryEndpoint: endpoint)
```

---
