[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Environment

# Environment

```swift
public struct Environment
```

Окружение SDK — точка входа для создания плееров и управления глобальной конфигурацией.

## Contents
- [Properties](#properties)
- [Methods](#methods)
- [Initializers](#initializers)

## Discussion

Создайте один экземпляр `Environment` при запуске приложения. Используйте его для получения экземпляров `YaPlayer`.

## Обновление конфигурации

Конфигурацию можно обновить в любой момент без пересоздания окружения.

## Сетевые заголовки

Добавьте глобальные заголовки для всех сетевых запросов плеера.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `from` | `From` | Идентификатор приложения из текущей конфигурации. |

## Initializers

```swift
@available(*, deprecated, renamed: "init(configuration:)", message: "Use API with Configuration instead")
public init(from: From)
```

Создает окружение SDK.

**Parameters:**

- `from`: Идентификатор приложения.

---

```swift
public init(configuration: Configuration)
```

Создает окружение SDK с заданной конфигурацией.

**Parameters:**

- `configuration`: Конфигурация SDK с идентификатором приложения и опциональным провайдером информации о пользователе.

## Methods

```swift
public mutating func update(configuration: Configuration)
```

Обновляет конфигурацию SDK без пересоздания окружения.

**Parameters:**

- `configuration`: Новая конфигурация.

---

```swift
public func setGlobalNetworkHeaders(_ headers: [String: String])
```

Устанавливает HTTP-заголовки, добавляемые ко всем сетевым запросам плеера.

**Parameters:**

- `headers`: Словарь заголовков в формате `[имя: значение]`.

---

```swift
public func setNetworkHeaders(for contentId: ContentId, headers: [String: String])
```

Устанавливает HTTP-заголовки для запросов конкретного контента.

## Examples

```swift
let configuration = Configuration(from: From(raw: "my-ios-app"))
let environment = Environment(configuration: configuration)

// ViewController.swift
let player = environment.player()
```

```swift
var newConfig = Configuration(from: From(raw: "my-ios-app"), clientInfoProvider: provider)
environment.update(configuration: newConfig)
```

```swift
environment.setGlobalNetworkHeaders(["Authorization": "Bearer \(token)"])
```

---