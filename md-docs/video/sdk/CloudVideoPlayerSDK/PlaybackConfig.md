[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > iOS > CloudVideoPlayer > Structs > PlaybackConfig

# PlaybackConfig

```swift
public struct PlaybackConfig
```

Конфигурация воспроизведения.

## Contents
- [Properties](#properties)
- [Initializers](#initializers)

## Discussion

Передается при установке источника через `YaPlayer/set(source:config:)`. Определяет начальное поведение плеера.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `autoplay` | `Bool` | Автоматически начинать воспроизведение после загрузки источника. |
| `isMuted` | `Bool` | Начинать воспроизведение без звука. |
| `startPosition` | `Time` | Позиция, с которой начинается воспроизведение. |

## Initializers

```swift
public init(autoplay: Bool, isMuted: Bool, startPosition: Time = .zero)
```

Создает конфигурацию воспроизведения.

## Examples

```swift
let config = PlaybackConfig(autoplay: true, isMuted: false, startPosition: Time(sec: 30))
player.set(source: endpoint, config: config)
```

---