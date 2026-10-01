---
title: PlaybackSpeed — SDK видеоплеера {{ video-full-name }} для iOS
description: Настройка скорости воспроизведения в SDK видеоплеера {{ video-name }} для iOS.
---

# PlaybackSpeed

```swift
public struct PlaybackSpeed: Equatable
```

Скорость воспроизведения.

## Содержание {#contents}

На этой странице:

- [Свойства](#properties)
- [Инициализаторы](#initializers)

## Описание {#discussion}

Используйте предопределенные константы или создайте значение с произвольной скоростью. Чтобы проверить доступность скорости для текущего контента, вызовите метод `canSet(playbackSpeed:)` объекта [YaPlayer](./YaPlayer.md#methods).

## Соответствие протоколам {#inheritance}

Структура соответствует протоколу `Equatable`.

## Свойства {#properties}

#|
|| **Имя** | **Тип** | **Описание** ||
|| `rate` | `Float` | Коэффициент скорости воспроизведения. ||
|| `paused` | `PlaybackSpeed` | Воспроизведение приостановлено. Скорость равна нулю. ||
|| `x025` | `PlaybackSpeed` | Скорость 0,25×. ||
|| `x050` | `PlaybackSpeed` | Скорость 0,5×. ||
|| `x075` | `PlaybackSpeed` | Скорость 0,75×. ||
|| `x100` | `PlaybackSpeed` | Обычная скорость: 1×. ||
|| `x125` | `PlaybackSpeed` | Скорость 1,25×. ||
|| `x150` | `PlaybackSpeed` | Скорость 1,5×. ||
|| `x175` | `PlaybackSpeed` | Скорость 1,75×. ||
|| `x200` | `PlaybackSpeed` | Скорость 2×. ||
|| `allCases` | `[PlaybackSpeed]` | Все предопределенные скорости воспроизведения от 0,25× до 2×. ||
|#

## Инициализаторы {#initializers}

```swift
public init(rate: Float)
```

Создает скорость воспроизведения с произвольным коэффициентом.

Параметры:

- `rate` — коэффициент скорости. Допустимый диапазон зависит от контента.

## Примеры {#examples}

```swift
if player.canSet(playbackSpeed: .x150) {
  try? player.set(playbackSpeed: .x150)
}
```

---
