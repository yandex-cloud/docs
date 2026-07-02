[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Structs > PlaybackSpeed

# PlaybackSpeed

```swift
public struct PlaybackSpeed: Equatable
```

Скорость воспроизведения.

## Contents
- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Используйте предопределенные константы или создайте значение с произвольной скоростью. Доступность конкретной скорости для текущего контента можно проверить через `YaPlayer/canSet(playbackSpeed:)`.

## Inheritance

- `Equatable`

## Properties

| Name | Type | Description |
|------|------|-------------|
| `rate` | `Float` | Коэффициент скорости воспроизведения. |

## Initializers

```swift
public init(rate: Float)
```

Создает скорость воспроизведения с произвольным коэффициентом.

**Parameters:**

- `rate`: Коэффициент скорости. Допустимый диапазон зависит от контента.

## Examples

```swift
if player.canSet(playbackSpeed: .x150) {
  try? player.set(playbackSpeed: .x150)
}
```

---