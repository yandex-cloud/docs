---
title: События плеера Cloud Video Player в SDK для IFrame
description: На странице описаны возможные события видеоплеера Cloud Video Player, на которые можно подписаться в SDK для IFrame.
---

# События плеера

С помощью механизма `postMessage` SDK для IFrame вы можете подписаться на события [видеоплеера](../../concepts/player.md) Cloud Video Player. События отправляются из iframe в родительское окно.

## Формат подписки на события {#event-format}

Для получения событий от плеера используется обработчик `message`:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event) {
        // Обработка события
        console.log('Событие плеера:', event.data.event, event.data);
    }
});
```

## События инициализации {#initialization-events}

#### inited {#inited}

Плеер инициализирован и готов к работе.

Параметры события:
* `vsid` (string) — уникальный идентификатор сессии плеера.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'inited') {
        console.log('Плеер инициализирован, vsid:', event.data.vsid);
    }
});
```

#### resourcesIdle {#resourcesidle}

Все ресурсы плеера загружены, плеер находится в состоянии ожидания.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'resourcesIdle') {
        console.log('Ресурсы плеера загружены');
    }
});
```

#### contentImpression {#contentimpression}

Контент отображен пользователю (impression).

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'contentImpression') {
        console.log('Контент отображен');
    }
});
```

## События воспроизведения {#playback-events}

#### started {#started}

Воспроизведение видео началось (первый запуск после загрузки контента).

Параметры события:
* `time` (number) — текущее время воспроизведения в секундах.
* `duration` (number) — длительность видео в секундах.
* `title` (string, необязательный) — название видео.
* `description` (string, необязательный) — описание видео.
* `contentId` (string, необязательный) — идентификатор контента.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'started') {
        console.log('Воспроизведение началось');
        console.log('Время:', event.data.time);
        console.log('Длительность:', event.data.duration);
        console.log('Название:', event.data.title);
    }
});
```

#### resumed {#resumed}

Воспроизведение возобновлено после паузы.

Параметры события:
* `time` (number) — текущее время воспроизведения в секундах.
* `duration` (number) — длительность видео в секундах.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'resumed') {
        console.log('Воспроизведение возобновлено на', event.data.time, 'секунде');
    }
});
```

#### paused {#paused}

Воспроизведение приостановлено.

Параметры события:
* `time` (number) — текущее время воспроизведения в секундах.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'paused') {
        console.log('Воспроизведение приостановлено на', event.data.time, 'секунде');
    }
});
```

#### ended {#ended}

Воспроизведение видео завершено.

Параметры события:
* `time` (number) — время окончания воспроизведения в секундах.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'ended') {
        console.log('Воспроизведение завершено');
    }
});
```

## События времени и позиции {#time-events}

#### timeupdate {#timeupdate}

Изменение текущего времени воспроизведения. Событие генерируется периодически во время воспроизведения.

Параметры события:
* `time` (number) — текущее время воспроизведения в секундах.
* `duration` (number) — длительность видео в секундах.
* `watchedTime` (number) — общее время просмотра в секундах.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'timeupdate') {
        console.log('Текущее время:', event.data.time);
        console.log('Длительность:', event.data.duration);
        console.log('Просмотрено:', event.data.watchedTime);
    }
});
```

#### durationchange {#durationchange}

Изменение длительности видео.

Параметры события:
* `duration` (number) — новая длительность видео в секундах.

Событие может возникать:
* при смене контента;
* периодически для прямых трансляций, так как длительность непрерывно растет.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'durationchange') {
        console.log('Длительность изменилась:', event.data.duration);
    }
});
```

#### rewound {#rewound}

Пользователь перемотал видео.

Параметры события:
* `time` (number) — новое время воспроизведения в секундах.
* `previousTime` (number) — предыдущее время воспроизведения в секундах.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'rewound') {
        console.log('Перемотка с', event.data.previousTime, 'на', event.data.time);
    }
});
```

## События звука {#audio-events}

#### volumechange {#volumechange}

Изменение громкости или статуса muted (выключенного звука).

Параметры события:
* `volume` (number) — уровень громкости от 0 до 1.
* `muted` (boolean) — статус выключенного звука (`true` — звук выключен, `false` — включен).

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'volumechange') {
        console.log('Громкость:', event.data.volume);
        console.log('Звук выключен:', event.data.muted);
    }
});
```

## События ошибок {#error-events}

#### error {#error}

Произошла ошибка воспроизведения.

Параметры события:
* `time` (number) — время, когда произошла ошибка, в секундах.
* `code` (string) — код ошибки.

Возможные коды ошибок:
* `'0'` — неизвестная ошибка.
* `'1'` — ошибка загрузки видео.
* `'2'` — ошибка сети.
* `'3'` — ошибка декодирования.
* `'4'` — видео не поддерживается.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'error') {
        console.error('Ошибка воспроизведения');
        console.error('Код ошибки:', event.data.code);
        console.error('Время:', event.data.time);
    }
});
```

## События рекламы {#ad-events}

#### adShown {#adshown}

Начался показ рекламного ролика.

Параметры события:
* `time` (number) — время начала показа рекламы в секундах.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'adShown') {
        console.log('Начался показ рекламы');
    }
});
```

#### adEnd {#adend}

Показ рекламного ролика завершен.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'adEnd') {
        console.log('Показ рекламы завершен');
    }
});
```

#### adPodStart {#adpodstart}

Начался показ рекламного блока (pod).

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'adPodStart') {
        console.log('Начался показ рекламного блока');
    }
});
```

## События отображения {#display-events}

#### sizeChange {#sizechange}

Изменение размера видео.

Параметры события:
* `videoWidth` (number) — ширина видео в пикселях.
* `videoHeight` (number) — высота видео в пикселях.
* `isAd` (boolean) — является ли текущее видео рекламой.

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'sizeChange') {
        console.log('Размер видео:', event.data.videoWidth, 'x', event.data.videoHeight);
        console.log('Это реклама:', event.data.isAd);
    }
});
```

#### fullscreenchange {#fullscreenchange}

Изменение состояния полноэкранного режима.

Параметры события:
* `isFullscreen` (boolean) — статус полноэкранного режима (`true` — включен, `false` — выключен).

Пример обработки:

```javascript
window.addEventListener('message', function(event) {
    if (event.data && event.data.event === 'fullscreenchange') {
        console.log('Полноэкранный режим:', event.data.isFullscreen ? 'включен' : 'выключен');
    }
});
```

#### См. также {#see-also}

* [{#T}](./index.md)
* [{#T}](./initialization.md)
* [{#T}](./player-methods.md)