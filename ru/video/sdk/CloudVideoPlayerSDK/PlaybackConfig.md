---
title: PlaybackConfig — SDK видеоплеера {{ video-full-name }} для iOS
description: Настройка автовоспроизведения, звука и начальной позиции в SDK видеоплеера {{ video-name }} для iOS.
---

# PlaybackConfig

```swift
public struct PlaybackConfig
```

Конфигурация воспроизведения.

## Содержание {#contents}

На этой странице:

- [Свойства](#properties)
- [Инициализаторы](#initializers)

## Описание {#discussion}

Передается при установке источника с помощью метода `set(source:config:)` объекта [YaPlayer](./YaPlayer.md#methods). Определяет начальное поведение плеера.

## Свойства {#properties}

#|
|| **Имя** | **Тип** | **Описание** ||
|| `autoplay` | `Bool` | Автоматически начинать воспроизведение после загрузки источника. ||
|| `isMuted` | `Bool` | Начинать воспроизведение без звука. ||
|| `startPosition` | `Time` | Позиция, с которой начинается воспроизведение. ||
|| `base` | `PlaybackConfig` | Конфигурация по умолчанию: воспроизведение с начала, со звуком, без автоматического запуска. ||
|#

## Инициализаторы {#initializers}

```swift
public init(autoplay: Bool, isMuted: Bool, startPosition: Time = .zero)
```

Создает конфигурацию воспроизведения.

## Примеры {#examples}

```swift
let config = PlaybackConfig(autoplay: true, isMuted: false, startPosition: Time(sec: 30))
player.set(source: endpoint, config: config)
```

---
