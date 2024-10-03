---
title: События плеера Cloud Video Player в SDK для JavaScript
description: На странице описаны возможные события видеоплеера Cloud Video Player, на которые можно подписаться в SDK для JavaScript.
---

# События плеера

С помощью методов [on и once](./player-methods.md#subscribe-methods) SDK для JavaScript вы можете подписаться на события [видеоплеера](../../concepts/player.md) Cloud Video Player:

#### SourceChange {#sourcechange}

Переключение контента.

В объекте `{ source }` в обработчик поступает новая [ссылка на контент](./player-state.md#state-source).

Пример:

```javascript
player.on('SourceChange', ({ source }) => {
    console.log(source);
});
```

#### StatusChange {#StatusChange}

Изменение [статуса воспроизведения](./player-state.md#state-status).

В объекте `{ status }` в обработчик поступает новое значение статуса воспроизведения.

Пример:

```javascript
player.on('StatusChange', ({ status }) => {
    console.log(status);
});
```

#### ErrorChange {#errorchange}

Появление или сброс ошибки.

В объекте `{ error }` в обработчик поступает [ошибка](./player-state.md#state-error).

Сброс ошибки происходит при переключении контента (если переключение возможно). В этом случае в обработчик поступает объект `error` со значением `undefined`.

Пример:

```javascript
player.on('ErrorChange', ({ error }) => {
    console.log(error);
});
```

#### CurrentTimeChange {#currenttimechange}

Изменение позиции на шкале времени.

В объекте `{ currentTime }` в обработчик поступает новое значение [текущего времени](./player-state.md#state-currentTime).

Пример:
```javascript
player.on('CurrentTimeChange', ({ currentTime }) => {
    console.log(currentTime);
});
```

#### DurationChange {#durationchange}

Изменение длительности видео.

В объекте `{ duration }` в обработчик поступает новое значение [длительности](./player-state.md#state-duration) видео.

Событие может возникать:
* при смене контента;
* периодически для видео [типа](./player-state.md#video-type-desc) `EVENT`, так как длительность непрерывно растет;
* при изменении типа видео с `LIVE` на `VOD`.

Пример:
```javascript
player.on('DurationChange', ({ duration }) => {
    console.log(duration);
});
```

#### VideoTypeChange {#videotypechange}

Изменение типа видео.

В объекте `{ videoType }` в обработчик поступает новое значение [типа видео](./player-state.md#state-videoType).

Событие может возникать:
* при смене контента;
* при изменении типа видео с `LIVE` и `EVENT` на `VOD`.

Пример:
```javascript
player.on('VideoTypeChange', ({ videoType }) => {
    console.log(videoType);
});
```

#### MutedChange {#mutedchange}

Изменение статуса `muted` (выключенного звука) видео.

В объекте `{ muted }` в обработчик поступает новое значение статуса [muted](./player-state.md#state-muted).

Пример:

```javascript
player.on('MutedChange', ({ muted }) => {
    console.log(muted);
});
```

#### VolumeChange {#volumechange}

Изменение уровня громкости звука в видео.

В объекте `{ volume }` в обработчик поступает новое значение [уровня громкости](./player-state.md#state-volume).

Пример:
```javascript
player.on('VolumeChange', ({ volume }) => {
    console.log(volume);
});
```

#### UtcStartTimeChange {#utcstarttimechange}

Изменение UTC-времени старта видео.

В объекте `{ utcStartTime }` в обработчик поступает новое значение [UTC-времени](./player-state.md#state-utcStartTime).

Событие может возникать:
* при смене контента;
* при изменении типа видео с `LIVE` на `VOD`.

Пример:

```javascript
player.on('UtcStartTimeChange', ({ utcStartTime }) => {
    console.log(utcStartTime);
});
```

#### SeekableRangeChange {#seekablerangechange}

Изменение области перемотки.

В объекте `{ seekableRange }` в обработчик поступает новое описание [области перемотки](./player-state.md#state-seekableRange).

Событие может возникать:
* при смене контента;
* периодически для видео типов `LIVE` и `EVENT`, так как область перемотки в них непрерывно увеличивается.

Пример:

```javascript
player.on('SeekableRangeChange', ({ seekableRange }) => {
    console.log(seekableRange.start, seekableRange.end);
});
```

#### BufferedRangesChange {#bufferedrangeschange}

Изменение областей буферизации.

В объекте `{ bufferedRanges }` в обработчик поступает массив с новым описанием [областей буферизации](./player-state.md#state-bufferedRanges).

Пример:

```javascript
player.on('BufferedRangesChange', ({ bufferedRanges }) => {
    console.log(bufferedRanges);
});
```


#### См. также {#see-also}

* [Interface: PlayerSdkEventHandlers](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) в справочнике API