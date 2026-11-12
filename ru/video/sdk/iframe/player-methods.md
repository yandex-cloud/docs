---
title: Методы плеера {{ video-player-name }} в SDK для IFrame
description: На странице описаны методы, которые можно использовать для управления видеоплеером {{ video-player-name }} в SDK для IFrame.
---

# Методы плеера

Вы можете управлять [видеоплеером](../../concepts/player.md) {{ video-player-name }} с использованием методов SDK для IFrame. Методы вызываются через механизм `postMessage` для взаимодействия с iframe.

## Формат вызова методов {#method-format}

Для вызова методов плеера используйте `postMessage`. Разместите скрипт после iframe с `id="video-player"` из [начала работы](./index.md#add-player). Если создаете iframe динамически, выполняйте код после добавления элемента в DOM:

```javascript
const iframe = document.getElementById('video-player');
const player = iframe.contentWindow;
const playerOrigin = new URL(iframe.src).origin;

player.postMessage({
    method: 'methodName',
    // параметры метода
}, playerOrigin);
```

В примерах ниже используются переменные `player` и `playerOrigin` из этого кода. Значение `playerOrigin` ограничивает отправку команд источником из URL плеера: протоколом, именем хоста и портом. Вызывайте методы после события [`inited`](./player-events.md#inited).

## Методы управления воспроизведением {#playback-methods}

#### play {#play}

Запускает воспроизведение видео.

Пример использования:

```javascript
player.postMessage({
    method: 'play'
}, playerOrigin);
```

#### pause {#pause}

Ставит воспроизведение на паузу.

Пример использования:

```javascript
player.postMessage({
    method: 'pause'
}, playerOrigin);
```

#### seek {#seek}

Перематывает видео в заданную позицию.

Параметры:
* `time` (number) — позиция в секундах, на которую нужно перемотать видео.

Пример перемотки видео на 30-ю секунду:

```javascript
player.postMessage({
    method: 'seek',
    time: 30
}, playerOrigin);
```

#### updateSource {#updatesource}

Переключает контент на другое видео.

Параметры:
* `id` (string) — идентификатор нового контента.
* `params` (object, необязательный) — дополнительные параметры для загрузки контента.

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

Пример переключения на другое видео:

```javascript
player.postMessage({
    method: 'updateSource',
    id: 'vplayer/new-video-id',
    params: {
        autoplay: true
    }
}, playerOrigin);
```

После успешного переключения контента плеер отправит событие [`inited`](./player-events.md#inited) с новым `vsid`.

## Методы управления звуком {#audio-methods}

#### setVolume {#setvolume}

Устанавливает уровень громкости звука видео.

Параметры:
* `volume` (number) — уровень громкости в диапазоне от `0` (звук не слышен) до `1` (максимальная громкость).

Пример установки громкости на 70%:

```javascript
player.postMessage({
    method: 'setVolume',
    volume: 0.7
}, playerOrigin);
```

#### mute {#mute}

Выключает звук видео.

Пример использования:

```javascript
player.postMessage({
    method: 'mute'
}, playerOrigin);
```

#### unmute {#unmute}

Включает звук видео.

Пример использования:

```javascript
player.postMessage({
    method: 'unmute'
}, playerOrigin);
```

## Методы управления качеством и дорожками {#quality-methods}

#### setQuality {#setquality}

Устанавливает качество видео.

Параметры:
* `quality` (string) — качество видео. Возможные значения:
  * `small` — 240p
  * `medium` — 360p
  * `large` — 480p
  * `hd720` — 720p
  * `hd1080` — 1080p
  * или прямое указание качества, например `'720p'`, `'1080p'`

Пример установки качества HD 720p:

```javascript
player.postMessage({
    method: 'setQuality',
    quality: 'hd720'
}, playerOrigin);
```

Или:

```javascript
player.postMessage({
    method: 'setQuality',
    quality: '720p'
}, playerOrigin);
```

#### setAudioTrack {#setaudiotrack}

Переключает аудиодорожку.

Параметры:
* `value` (string) — идентификатор аудиодорожки.

Пример использования:

```javascript
player.postMessage({
    method: 'setAudioTrack',
    value: 'audio-track-id'
}, playerOrigin);
```

## Методы управления отображением {#display-methods}

#### setFullscreen {#setfullscreen}

Переключает полноэкранный режим.

Параметры:
* `fullscreen` (boolean) — `true` для включения полноэкранного режима, `false` для выхода из него.

Пример включения полноэкранного режима:

```javascript
player.postMessage({
    method: 'setFullscreen',
    fullscreen: true
}, playerOrigin);
```

Пример выхода из полноэкранного режима:

```javascript
player.postMessage({
    method: 'setFullscreen',
    fullscreen: false
}, playerOrigin);
```

#### configureSkin {#configureskin}

Настраивает отображение элементов интерфейса плеера.

Параметры:
* `skinConfig` (object) — объект с настройками интерфейса:
  * `hiddenControls` (array | string) — массив строк или строка с названиями элементов интерфейса для скрытия, разделенными запятыми.

Доступные элементы интерфейса для `hiddenControls`:
* `*` — все элементы интерфейса
* `play` — кнопки воспроизведения, паузы, повтора
* `startScreenPlay` — кнопка воспроизведения на стартовом экране
* `sound` — кнопка отключения звука
* `volumeSlider` — ползунок громкости
* `settings` — кнопка настроек
* `fullscreen` — кнопка полноэкранного режима
* `timeline` — таймлайн (также отключает перемотку с клавиатуры)
* `timelinePreview` — превью на таймлайне
* `live` — кнопка **Вернуться в эфир**
* `poster` — постер
* `time` — текущее время воспроизведения
* `forward` — кнопка перемотки вперед (мобильный интерфейс)
* `backward` — кнопка перемотки назад (мобильный интерфейс)
* `preloader` — спиннер загрузки
* `contextMenu` — контекстное меню
* `startScreen` — стартовый экран
* `playbackRate` — скорость воспроизведения
* `nextAdInfo` — время до старта показа рекламы
* `subtitlesToggle` — кнопка включения/выключения субтитров
* `mobileSeekButtons` — кнопки перемотки в мобильном интерфейсе
* `title` — название видео

Пример скрытия нескольких элементов с помощью массива:

```javascript
player.postMessage({
    method: 'configureSkin',
    skinConfig: {
        hiddenControls: ['play', 'timeline', 'sound']
    }
}, playerOrigin);
```

Пример скрытия элементов с помощью строки:

```javascript
player.postMessage({
    method: 'configureSkin',
    skinConfig: {
        hiddenControls: 'play,timeline,sound'
    }
}, playerOrigin);
```

Пример отображения ранее скрытого элемента (используя `!` перед названием):

```javascript
player.postMessage({
    method: 'configureSkin',
    skinConfig: {
        hiddenControls: ['*', '!play'] // play будет показан, остальное скрыто
    }
}, playerOrigin);
```

## Обработка результатов выполнения методов {#method-results}

Ответ на команду приходит в событии `<methodName>:return`, где `<methodName>` — имя метода. Ответ может содержать результат в поле `result` или ошибку в поле `error`.

Чтобы сопоставить ответ с вызовом, передайте идентификатор запроса в поле `id` и проверьте его в ответе. Зарегистрируйте обработчик перед отправкой команды и удалите его после получения ответа:

```javascript
const requestId = 'unique-request-id-' + Date.now();

function onPlayResult(event) {
    if (event.source !== player || event.origin !== playerOrigin || typeof event.data !== 'string') {
        return;
    }

    let data;
    try {
        data = JSON.parse(event.data);
    } catch {
        return;
    }

    if (!data || data.event !== 'play:return' || data.id !== requestId) {
        return;
    }

    window.removeEventListener('message', onPlayResult);

    if (data.error) {
        console.error('Ошибка выполнения метода:', data.error);
    } else {
        console.log('Метод выполнен успешно:', data.result);
    }
}

window.addEventListener('message', onPlayResult);

player.postMessage({
    method: 'play',
    id: requestId
}, playerOrigin);
```

#### Полезные ссылки {#see-also}

* [{#T}](./index.md)
* [{#T}](./initialization.md)
* [{#T}](./player-events.md)
