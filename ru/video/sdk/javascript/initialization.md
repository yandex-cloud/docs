---
title: Параметры инициализации плеера Cloud Video Player в SDK для JavaScript
description: На странице описаны параметры, которые можно использовать при инициализации видеоплеера Cloud Video Player в SDK для JavaScript.
---

# Параметры инициализации плеера

При [инициализации](./index.md#initialize-player) видеоплеера [Cloud Video Player](../../concepts/player.md) вы можете передать в него исходные параметры:

#### element {#element}

Элемент для вставки. Обязательный параметр. Это может быть либо указатель на `HTMLElement`, либо id-селектор.

Примеры создания плеера:

* с помощью передачи указателя:

    ```javascript
    var element = document.getElementById('video-player');
    var player = Ya.playerSdk.init({ element, ...});
    ```
* с помощью передачи id-селектора:

    ```javascript
    var player = Ya.playerSdk.init({ element: 'video-player', ...});
    ```

#### source {#source}

Ссылка на воспроизводимый контент.

Пример создания плеера:

```javascript
var player = Ya.playerSdk.init({ ..., source: 'https://runtime.video.cloud.yandex.net/player/...', ...});
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

#### autoplay {#autoplay}

Автовоспроизведение при загрузке контента.

В некоторых случаях автовоспроизведение может [не сработать](https://developer.chrome.com/blog/autoplay/).

По умолчанию автовоспроизведение включено.

Пример создания плеера с выключенным автовоспроизведением:

```javascript
var player = Ya.playerSdk.init({ ..., autoplay: false, ...});
```

#### muted {#muted}

Статус `muted` (выключенного звука) при создании плеера. Значение `true` — звук выключен, значение `false` — включен.

Если звук включен, то автовоспроизведение может [не сработать](https://developer.chrome.com/blog/autoplay/).

Пример создания плеера с включенным звуком:

```javascript
var player = Ya.playerSdk.init({ ..., muted: false, ...});
```

#### volume {#volume}

Уровень громкости звука видео в диапазоне от `0` (звук не слышен) до `1` (максимальная громкость).

Значение по умолчанию — `1`.

Пример создания плеера со значением уровня звука `0.5`:

```javascript
var player = Ya.playerSdk.init({ ..., volume: 0.5, ...});
```

#### startPosition {#startposition}

Стартовая позиция воспроизведения контента при загрузке (в секундах).

Значения по умолчанию:

* для [типа видео](./player-state.md#video-type-desc) `VOD` — начало видео (нулевая секунда);
* для типа видео `LIVE` и `EVENT` — прямой эфир.

Пример создания плеера со стартовой позицией `10` секунд:

```javascript
var player = Ya.playerSdk.init({ ..., startPosition: 10, ...});
```

#### hiddenControls {#hiddencontrols}

С помощью параметра `hiddenControls` можно скрыть элементы интерфейса плеера.

По умолчанию в плеере отображаются все элементы управления.

Значением может быть как массив элементов интерфейса, которые требуется скрыть, так и строка, в которой эти элементы перечислены через запятую.

Примеры:

* скрыть кнопки воспроизведения/паузы и настроек c помощью передачи значения `hiddenControls` в строке:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: 'play,settings', ...});
    ```

* скрыть кнопки воспроизведения/паузы и настроек c помощью передачи значения `hiddenControls` в массиве:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: ['play','settings'], ...});
    ```

* Скрыть все элементы интерфейса можно с помощью мета-элемента `*`:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: '*', ...});
    ```

* Скрыть все элементы интерфейса, за исключением заданного, можно с помощью оператора `!`. Например, этот код скроет все элементы управления, кроме кнопки воспроизведения/паузы:

    ```javascript
    var player = Ya.playerSdk.init({ ..., hiddenControls: '*,!play', ...});
    ```

Элементы интерфейса, которые можно скрыть:

* `*` — все элементы интерфейса.
* `play` — элемент интерфейса, в котором отображаются кнопки **Воспроизвести**, **Пауза**, **Повторить**. Отключает воспроизведение/паузу при нажатии на плеер.
* `contextMenu` — контекстное меню.
* `fullscreen` — кнопка перевода в полноэкранный режим.
* `live` — кнопка **Вернуться в эфир**.
* `mobileSeekButtons` — кнопки перемотки в мобильном интерфейсе.
* `nextAdInfo` — время до старта показа рекламы.
* `playbackRate` — скорость воспроизведения.
* `poster` — постер.
* `preloader` — спиннер загрузки.
* `settings` — кнопка настроек.
* `startScreen` — стартовый экран.
* `startScreenPlay` — кнопка воспроизведения на стартовом экране.
* `subtitlesToggle` — кнопка включения/выключения субтитров.
* `timeline` — шкала времени. Отключает перемотку с клавиатуры или при нажатии на сенсорный экран.
* `timelinePreview` — предварительный просмотр на шкале времени.
* `time` — текущее время воспроизведения.
* `title` — название видео.
* `sound` — кнопка отключения звука.
* `volumeSlider` — регулятор уровня громкости звука.

#### См. также {#see-also}

* [Interface: PlayerSdkInitConfig](../../api-ref/javascript/interfaces/PlayerSdkInitConfig.md) в справочнике API
* [Interface: PlayerSdkSourceParams](../../api-ref/javascript/interfaces/PlayerSdkSourceParams.md) в справочнике API
