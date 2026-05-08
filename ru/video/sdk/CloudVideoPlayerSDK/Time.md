# Time

```swift
public struct Time
```

Временная позиция в медиапотоке.

## Contents
- [Initializers](#initializers)

## Discussion

Используется для задания позиции воспроизведения, представления длительности и диапазонов буферизации. Поддерживает арифметические операции и сравнение.

## Initializers

```swift
public init(sec time: TimeInterval)
```

Создает временную позицию из значения в секундах.

**Parameters:**

- `time`: Время в секундах.

---

```swift
public init(ms time: Int64)
```

Создает временную позицию из значения в миллисекундах.

**Parameters:**

- `time`: Время в миллисекундах.

## Examples

```swift
let startTime = Time(sec: 30)
let offset = Time(ms: 500)
let result = startTime + offset

await player.seek(to: startTime)
```

---
