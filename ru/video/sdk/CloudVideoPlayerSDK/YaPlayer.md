# YaPlayer

```swift
public final class YaPlayer
```

Основной объект плеера для воспроизведения видеоконтента.

## Contents
- [Properties](#properties)
- [Methods](#methods)

## Discussion

`YaPlayer` управляет полным жизненным циклом воспроизведения: загрузкой источника, запуском, паузой, перемоткой, управлением звуком и скоростью.

Создавайте экземпляры через `Environment/player()`.

## Мониторинг состояния

Используйте Combine-паблишеры для реакции на изменения состояния.

## Properties

| Name | Type | Description |
|------|------|-------------|
| `currentSource` | `ContentIdEndpoint?` | Текущий источник воспроизведения. |

## Methods

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

**Parameters:**

- `time`: Целевая позиция.

**Returns:** `true`, если перемотка выполнена успешно.

---

```swift
public func set(isMute: Bool)
```

Включает или отключает звук.

**Parameters:**

- `isMute`: `true` — выключить звук, `false` — включить.

---

```swift
public func set(volume: Float)
```

Устанавливает уровень громкости.

**Parameters:**

- `volume`: Уровень громкости от `0.0` (тишина) до `1.0` (максимум).

---

```swift
public func set(playbackSpeed: PlaybackSpeed) throws
```

Устанавливает скорость воспроизведения.

**Parameters:**

- `playbackSpeed`: Желаемая скорость воспроизведения.

**Throws:** Ошибка, если заданная скорость не поддерживается для текущего контента.

---

```swift
public func canSet(playbackSpeed: PlaybackSpeed) -> Bool
```

Проверяет, поддерживает ли текущий контент заданную скорость воспроизведения.

**Parameters:**

- `playbackSpeed`: Скорость для проверки.

**Returns:** `true`, если скорость доступна для текущего контента.

## Examples

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
