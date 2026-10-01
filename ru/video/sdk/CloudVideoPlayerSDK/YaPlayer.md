---
title: YaPlayer — SDK видеоплеера {{ video-full-name }} для iOS
description: Управление воспроизведением и отслеживание состояния плеера в SDK {{ video-name }} для iOS.
---

# YaPlayer

```swift
public final class YaPlayer
```

Основной объект плеера для воспроизведения видеоконтента.

## Содержание {#contents}

На этой странице:

- [Свойства](#properties)
- [Методы](#methods)

## Описание {#discussion}

`YaPlayer` управляет воспроизведением: загрузкой источника, запуском, паузой, перемоткой, звуком и скоростью.

Чтобы создать экземпляр плеера, вызовите метод `player()` структуры [Environment](./Environment.md#methods).

## Мониторинг состояния {#state-monitoring}

Чтобы отслеживать изменения состояния плеера, подпишитесь на события с помощью Combine. Методы подписки возвращают объекты `PlayerPublisher`, которые передают новые значения подписчикам. Пример подписки приведен в разделе [Отслеживание состояния плеера](../ios-sdk.md#state-monitoring).

Во всех методах подписки параметр `queue` задает очередь доставки событий. По умолчанию используется главная очередь `.main`.

## Свойства {#properties}

#|
|| **Имя** | **Тип** | **Описание** ||
|| `currentSource` | `ContentIdEndpoint?` | Текущий источник воспроизведения. ||
|| `vsid` | `String` | Идентификатор сессии просмотра (View Session ID). ||
|| `status` | `PlayerStatus` | Текущее состояние плеера. ||
|| `watchedTime` | `Time` | Суммарное время просмотра текущего контента с момента последней установки источника. ||
|| `currentTime` | `Time?` | Текущая позиция воспроизведения. ||
|| `duration` | `Time?` | Общая длительность контента. ||
|| `remainingBufferedTime` | `Time?` | Длительность буферизованного фрагмента, начиная с текущей позиции воспроизведения. ||
|| `bufferTimeRanges` | `[Range<Time>]` | Буферизованные диапазоны времени. ||
|| `seekableTimeRanges` | `[Range<Time>]` | Доступные для перемотки диапазоны времени. ||
|| `isMuted` | `Bool?` | Текущее состояние звука. ||
|| `volume` | `Float?` | Текущий уровень громкости от `0.0` до `1.0`. ||
|| `videoType` | `VideoType?` | Тип воспроизводимого контента. ||
|| `onAir` | `Bool` | `true`, если воспроизведение находится на правой границе шкалы времени трансляции — в прямом эфире. ||
|| `latency` | `TimeInterval` | Текущая задержка воспроизведения относительно прямого эфира, в секундах. ||
|| `targetLatency` | `TimeInterval` | Целевая задержка воспроизведения относительно прямого эфира, в секундах. ||
|| `playbackSpeed` | `PlaybackSpeed` | Текущая скорость воспроизведения. ||
|#

## Методы {#methods}

```swift
public func set<AdditionalParams: Encodable>(source endpoint: ContentIdEndpoint, config: PlaybackConfig, additionalParams: AdditionalParams)
```

Устанавливает источник воспроизведения с дополнительными параметрами телеметрии.

---

```swift
public func set(source endpoint: ContentIdEndpoint, config: PlaybackConfig = .base)
```

Устанавливает источник воспроизведения.

---

```swift
public func reset()
```

Сбрасывает текущий источник и останавливает воспроизведение.

---

```swift
public func play()
```

Запускает воспроизведение.

---

```swift
public func pause()
```

Ставит воспроизведение на паузу.

---

```swift
public func seek(to time: Time) async -> Bool
```

Перематывает воспроизведение на указанную позицию.

Параметры:

- `time` — целевая позиция.

Возвращаемое значение: `true`, если перемотка выполнена успешно.

---

```swift
public func set(isMute: Bool)
```

Включает или отключает звук.

Параметры:

- `isMute`: `true` — выключить звук, `false` — включить.

---

```swift
public func set(volume: Float)
```

Устанавливает уровень громкости.

Параметры:

- `volume` — уровень громкости от `0.0` (тишина) до `1.0` (максимум).

---

```swift
public func set(playbackSpeed: PlaybackSpeed) throws
```

Устанавливает скорость воспроизведения.

Параметры:

- `playbackSpeed` — желаемая скорость воспроизведения.

Исключения: ошибка, если заданная скорость не поддерживается для текущего контента.

---

```swift
public func canSet(playbackSpeed: PlaybackSpeed) -> Bool
```

Проверяет, поддерживает ли текущий контент заданную скорость воспроизведения.

Параметры:

- `playbackSpeed` — скорость для проверки.

Возвращаемое значение: `true`, если скорость доступна для текущего контента.

---

```swift
public func playerStatusDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<PlayerStatus>
```

Возвращает объект `PlayerPublisher` для отслеживания изменений состояния плеера.

---

```swift
public func bufferTimeRangesDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<[Range<Time>]>
```

Возвращает объект `PlayerPublisher` для отслеживания изменений буферизованных диапазонов.

---

```swift
public func seekableTimeRangeDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<[Range<Time>]>
```

Возвращает объект `PlayerPublisher` для отслеживания изменений диапазонов, доступных для перемотки.

---

```swift
public func periodicTimePublisher(interval: TimeInterval, queue: DispatchQueue = .main) -> PlayerPublisher<TimeInterval>
```

Возвращает объект `PlayerPublisher` для периодического получения позиции воспроизведения.

Параметры:

- `interval` — интервал обновления позиции воспроизведения в секундах.

---

```swift
public func isMutedDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<Bool>
```

Возвращает объект `PlayerPublisher` для отслеживания изменений состояния звука.

---

```swift
public func volumeDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<Float>
```

Возвращает объект `PlayerPublisher` для отслеживания изменений уровня громкости.

---

```swift
public func errorDidDetected(queue: DispatchQueue = .main) -> PlayerPublisher<PlayerError>
```

Возвращает объект `PlayerPublisher` для получения ошибок воспроизведения.

---

```swift
public func goToLive() async throws
```

Перемещает позицию воспроизведения на правую границу шкалы времени трансляции — к прямому эфиру.

Исключения: ошибка, если операция невозможна, например при воспроизведении видео по запросу (VOD).

---

```swift
public func playbackSpeedDidChange(queue: DispatchQueue = .main) -> PlayerPublisher<PlaybackSpeed>
```

Возвращает объект `PlayerPublisher` для отслеживания изменений скорости воспроизведения.

## Примеры {#examples}

```swift
let environment = Environment(configuration: Configuration(from: From(raw: "my-app")))
let player = environment.player()

// Подключить поверхность для отображения
let surface = VideoSurface()
surface.attach(player: player)

// Установить источник и начать воспроизведение
if let source = ContentIdEndpoint(url: URL(string: "https://runtime.video.cloud.yandex.net/player/...")!) {
  player.set(source: source, config: PlaybackConfig(autoplay: true, isMuted: false))
}
```

```swift
player.playerStatusDidChange()
  .sink { status in
    switch status {
      case .play:      showPlayButton(false)
      case .pause:     showPlayButton(true)
      case .buffering: showSpinner(true)
      case .fatal:     showErrorScreen()
      default:         break
    }
  }
  .store(in: &cancellables)
```

---
