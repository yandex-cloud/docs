---
title: Time — SDK видеоплеера {{ video-full-name }} для iOS
description: Работа со временем и позицией воспроизведения в SDK видеоплеера {{ video-name }} для iOS.
---

# Time

```swift
public struct Time
```

Временная позиция в медиапотоке.

## Содержание {#contents}

На этой странице:

- [Свойства](#properties)
- [Инициализаторы](#initializers)
- [Методы](#methods)

## Описание {#discussion}

Используется для задания позиции воспроизведения, представления длительности и диапазонов буферизации. Поддерживает арифметические операции и сравнение.

## Соответствие протоколам {#inheritance}

Структура соответствует протоколам `AdditiveArithmetic` и `Comparable`.

## Свойства {#properties}

#|
|| **Имя** | **Тип** | **Описание** ||
|| `timeInterval` | `TimeInterval` | Значение в секундах в виде `TimeInterval`. ||
|| `zero` | `Time` | Нулевая временная позиция. ||
|#

## Инициализаторы {#initializers}

```swift
public init(sec time: TimeInterval)
```

Создает временную позицию из значения в секундах.

Параметры:

- `time` — время в секундах.

---

```swift
public init(ms time: Int64)
```

Создает временную позицию из значения в миллисекундах.

Параметры:

- `time` — время в миллисекундах.

## Методы {#methods}

```swift
public static func - (lhs: Time, rhs: Time) -> Time
```

Вычитает одно значение времени из другого.

---

```swift
public static func + (lhs: Time, rhs: Time) -> Time
```

Складывает два значения времени.

## Примеры {#examples}

```swift
let startTime = Time(sec: 30)
let offset = Time(ms: 500)
let result = startTime + offset

await player.seek(to: startTime)
```

---
