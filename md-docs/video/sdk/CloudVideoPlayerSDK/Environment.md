[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Environment

# Environment

```swift
public struct Environment
```

Окружение SDK — точка входа для создания плееров и управления глобальной конфигурацией.

## Содержание {#contents}

На этой странице:

- [Свойства](#properties)
- [Инициализаторы](#initializers)
- [Методы](#methods)

## Описание {#discussion}

Создайте один экземпляр `Environment` при запуске приложения. Используйте его для получения экземпляров `YaPlayer`.

## Обновление конфигурации {#configuration-update}

Конфигурацию можно обновить в любой момент без пересоздания окружения.

## Сетевые заголовки {#network-headers}

Добавьте глобальные заголовки для всех сетевых запросов плеера.

## Свойства {#properties}

#|
|| **Имя** | **Тип** | **Описание** ||
|| `from` | `From` | Идентификатор приложения из текущей конфигурации. ||
|#

## Инициализаторы {#initializers}

```swift
@available(*, deprecated, renamed: "init(configuration:)", message: "Use API with Configuration instead")
public init(from: From)
```

Создает окружение SDK.

Параметры:

- `from` — идентификатор приложения.

---

```swift
public init(configuration: Configuration)
```

Создает окружение SDK с заданной конфигурацией.

Параметры:

- `configuration` — конфигурация SDK с идентификатором приложения и необязательным провайдером информации о пользователе.

## Методы {#methods}

```swift
public mutating func update(configuration: Configuration)
```

Обновляет конфигурацию SDK без пересоздания окружения.

Параметры:

- `configuration` — новая конфигурация.

---

```swift
public func setGlobalNetworkHeaders(_ headers: [String: String])
```

Устанавливает HTTP-заголовки, добавляемые ко всем сетевым запросам плеера.

Параметры:

- `headers` — словарь заголовков в формате `[имя: значение]`.

---

```swift
public func setNetworkHeaders(for endpoint: ContentIdEndpoint, headers: [String: String])
```

Устанавливает HTTP-заголовки для запросов конкретного контента.

---

```swift
public static func set(telemetryEndpoint: QuasiEndpoint?)
```

Переопределяет эндпоинт для отправки телеметрии.

Параметры:

- `telemetryEndpoint` — пользовательский эндпоинт или `nil` для восстановления значения по умолчанию.

---

```swift
public static func set(perfEndpoint: QuasiEndpoint?)
```

Переопределяет эндпоинт для отправки данных о производительности (perf-событий).

Параметры:

- `perfEndpoint` — пользовательский эндпоинт или `nil` для восстановления значения по умолчанию.

---

```swift
public func player() -> YaPlayer
```

Создает новый экземпляр плеера.

Возвращаемое значение: новый экземпляр `YaPlayer`.

## Примеры {#examples}

```swift
let configuration = Configuration(from: From(raw: "my-ios-app"))
var environment = Environment(configuration: configuration)

// ViewController.swift
let player = environment.player()
```

```swift
let newConfig = Configuration(from: From(raw: "my-ios-app"), clientInfoProvider: provider)
environment.update(configuration: newConfig)
```

```swift
environment.setGlobalNetworkHeaders(["Authorization": "Bearer \(token)"])
```

---