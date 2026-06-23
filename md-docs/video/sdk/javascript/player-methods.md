# Методы плеера

Вы можете управлять [видеоплеером](../../concepts/player.md) Cloud Video Player с использованием методов SDK для JavaScript:

#### setSource {#setsource}

Переключает контент.

Пример простого переключения контента:

```javascript
player.setSource('https://runtime.video.cloud.yandex.net/player/...');
```

Где `https://runtime.video.cloud.yandex.net/player/...` — ссылка на [видео](../../operations/video/get-link.md), [трансляцию](../../operations/streams/get-link.md) или [плейлист](../../operations/playlists/get-link.md).

Пример переключения контента с установкой стартовой позиции и выключенным автовоспроизведением:

```javascript
player.setSource({
    source: 'https://runtime.video.cloud.yandex.net/player/...',
    startPosition: 10,
    autoplay: false
});
```

В примере в качестве параметра передается объект формата:

```javascript
{
    /** @type {string} ссылка на воспроизводимый контент */
    source,
    /**
     * @type {boolean} (необязательный параметр) автовоспроизведение при переключении на контент.
     * по умолчанию сохраняется состояние воспроизведения на момент вызова метода.
     * Автоплей может не сработать. См. https://developer.chrome.com/blog/autoplay/
     * autoplay
     */
    autoplay,
    /** @type {number} (необязательный параметр, по умолчанию 0) стартовая позиция в секундах */
    startPosition,
}
```

Метод возвращает промис (promise), который:

* переводится в состояние `fulfilled`, если переключение прошло успешно;
* переводится в состояние `rejected`, если переключение завершилось ошибкой. Например, в случае если контент с заданным `id` не найден.

#### preloadSource {#preloadsource}

Предзагружает контент для дальнейшего воспроизведения.

Пример базовой предзагрузки контента:

```javascript
player.preloadSource('https://runtime.video.cloud.yandex.net/player/...');
```

Пример предзагрузки с дополнительными параметрами:

```javascript
const controller = new AbortController();

player.preloadSource(
    {
        source: 'https://runtime.video.cloud.yandex.net/player/...',
        startPosition: 0,
    },
    {
        signal: controller.signal,
        bufferGoal: 30
    }
);

// Для отмены предзагрузки:
// controller.abort();
```

В примере в качестве первого параметра передается объект формата:

```javascript
{
    /** @type {string} ссылка на воспроизводимый контент */
    source,
    /** @type {number} (необязательный параметр, по умолчанию 0) стартовая позиция в секундах */
    startPosition,
}
```

В качестве второго необязательного параметра можно передать объект с настройками предзагрузки:

```javascript
{
    /** @type {AbortSignal} (необязательный параметр) сигнал для отмены предзагрузки */
    signal,
    /** @type {number} (необязательный параметр) целевой размер буфера в секундах */
    bufferGoal,
}
```

Метод возвращает промис (promise), который:

* переводится в состояние `fulfilled`, если предзагрузка завершена успешно;
* переводится в состояние `rejected`, если предзагрузка завершилась ошибкой или была отменена.

#### getState {#getstate}

Возвращает состояние плеера в виде объекта, формат которого описан в разделе [Состояние плеера](player-state.md).

Пример использования:

```javascript
var state = player.getState();
```

#### play {#play}

Запускает воспроизведение.

Метод возвращает промис (promise), который:

* переводится в состояние `fulfilled`, если воспроизведение началось;
* переводится в состояние `rejected`, если запустить воспроизведение [не удалось](https://developer.chrome.com/blog/autoplay).

#### pause {#pause}

Ставит воспроизведение на паузу.

#### seek {#seek}

Перематывает видео в заданную позицию, которая передается в качестве параметра.

Пример перемотки видео на 10-ю секунду:

```javascript
player.seek(10);
```

#### setMuted {#setmuted}

Выключает/включает звук.

В качестве параметра передается значение типа `boolean`.

Пример включения звука:

```javascript
player.setMuted(false);
```

#### setVolume {#setvolume}

Устанавливает уровень громкости звука видео в диапазоне от `0` (звук не слышен) до `1` (максимальная громкость).

Пример:

```javascript
player.setVolume(0.7);
```

#### setTextTrack {#settexttrack}

Переключает текстовую дорожку (субтитры).

В качестве параметра передается значение `value` из объекта дорожки, полученного из [textTracks](player-state.md#state-textTracks). 

Для отключения субтитров передайте `null`.

Пример включения субтитров:

```javascript
var tracks = player.getState().textTracks;
if (tracks.length > 0) {
    player.setTextTrack(tracks[0].value);
}
```

Пример включения субтитров с начала воспроизведения:

```javascript
player.once('TextTracksChange', ({ textTracks }) => {
    if (textTracks.length > 0) {
        player.setTextTrack(textTracks[0].value);
    }
});
```

Пример отключения субтитров:

```javascript
player.setTextTrack(null);
```

#### setVideoTrack {#setvideotrack}

Переключает видеодорожку.

В качестве параметра передается значение `value` из объекта дорожки, полученного из [videoTracks](player-state.md#state-videoTracks).

Пример переключения дорожки:

```javascript
var tracks = player.getState().videoTracks;
if (tracks.length > 0) {
    player.setVideoTrack(tracks[0].value);
}
```

Пример переключения дорожки с начала воспроизведения:

```javascript
player.once('VideoTracksChange', ({ videoTracks }) => {
    if (videoTracks.length > 0) {
        player.setVideoTrack(videoTracks[0].value);
    }
});
```

#### setPlaybackSpeed {#setplaybackspeed}

Устанавливает скорость воспроизведения видео.

В качестве параметра передается число, определяющее скорость воспроизведения, например:
* `1` — нормальная скорость (по умолчанию);
* `0.5` — половинная скорость;
* `2` — двойная скорость.

{% note warning %}

Отрицательные значения скорости могут работать некорректно.

{% endnote %}

Пример установки двойной скорости воспроизведения:

```javascript
player.setPlaybackSpeed(2);
```

Пример установки половинной скорости:

```javascript
player.setPlaybackSpeed(0.5);
```

#### on/once {#subscribe-methods}

Позволяет подписаться на [события плеера](player-events.md).

При вызове `once` подписка действует только на первое срабатывание события, при вызове `on` — на все срабатывания.

Методы имеют сигнатуру `on(eventName, handler)` и `once(eventName, handler)`. Первым параметром передается название события, вторым — обработчик.

В обработчик передается объект с соответствующим событию полем из [состояния плеера](player-state.md).

Пример подписки на все срабатывания события изменения статуса воспроизведения [StatusChange](player-state.md#StatusChange):

```javascript
player.on('StatusChange', ({ status }) => {
    console.log(status);
});
```

#### off {#off}

Позволяет отписаться от событий плеера, на которые с помощью [методов](player-events.md#subscribe-methods) `on` или `once` была выполнена подписка.

Метод имеет сигнатуру `off(eventName, handler)`. Первым параметром передается название события, вторым — обработчик, который использовался ранее для подписки.

Пример отписки от функции-обработчика с названием `handler` для события изменения статуса воспроизведения [StatusChange](player-events.md#statuschange):

```javascript
player.off('StatusChange', handler);
```

#### destroy {#destroy}

Уничтожает (destroy) плеер и освобождает ресурсы.

Возвращает промис (promise), который переводится в состояние `fulfilled` после завершения выполнения операции.

Пример использования:
```javascript
player.destroy();
```

#### Полезные ссылки {#see-also}

[Interface: PlayerSdkApi](../../api-ref/javascript/interfaces/PlayerSdkApi.md) — описание методов управления плеером в справочнике API.