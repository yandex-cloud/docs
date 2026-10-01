[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Типы данных > QuasiEndpoint

# QuasiEndpoint

```swift
public struct QuasiEndpoint
```

HTTP-эндпоинт для отправки телеметрии и данных о производительности (perf-событий).

## Содержание {#contents}

На этой странице:

- [Инициализаторы](#initializers)

## Описание {#discussion}

Используется в методах `set(telemetryEndpoint:)` и `set(perfEndpoint:)` структуры [Environment](Environment.md#methods) для замены стандартных эндпоинтов на пользовательские.

## Инициализаторы {#initializers}

```swift
public init(
  url: URL,
  httpMethod: String = "POST",
  httpHeaders: [String: String] = ["Content-Type": "application/json"]
)
```

Создает HTTP-эндпоинт.

## Примеры {#examples}

```swift
let endpoint = QuasiEndpoint(url: URL(string: "https://my-telemetry.example.com/log")!)
Environment.set(telemetryEndpoint: endpoint)

let perfEndpoint = QuasiEndpoint(url: URL(string: "https://my-telemetry.example.com/perf")!)
Environment.set(perfEndpoint: perfEndpoint)
```

---