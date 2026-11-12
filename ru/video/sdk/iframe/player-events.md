---
title: События плеера {{ video-player-name }} в SDK для IFrame
description: На странице описаны возможные события видеоплеера {{ video-player-name }}, на которые можно подписаться в SDK для IFrame.
---

# События плеера

С помощью механизма `postMessage` SDK для IFrame вы можете подписаться на события [видеоплеера](../../concepts/player.md) {{ video-player-name }}. События отправляются из iframe в родительское окно.

## Формат подписки на события {#event-format}

Чтобы получать события от плеера, используйте обработчик `message`. Плеер передает данные события в поле `event.data` в виде строки JSON. Перед обращением к свойствам события преобразуйте эту строку в объект с помощью `JSON.parse`.

В примере используется iframe с `id="video-player"` из [начала работы](./index.md#add-player). Разместите скрипт после этого элемента. Если создаете iframe динамически, выполняйте код после добавления элемента в DOM. События, отправленные до регистрации обработчика, повторно не доставляются.

Обработчик проверяет окно и источник сообщения (`origin`), разбирает JSON и передает данные в функцию `handlePlayerEvent`:

```javascript
const iframe = document.getElementById('video-player');
const player = iframe.contentWindow;
const playerOrigin = new URL(iframe.src).origin;

function handlePlayerEvent(data) {
    console.log('Событие плеера:', data.event, data);
}

function onPlayerMessage(event) {
    if (event.source !== player || event.origin !== playerOrigin || typeof event.data !== 'string') {
        return;
    }

    let data;
    try {
        data = JSON.parse(event.data);
    } catch {
        return;
    }

    if (!data || typeof data !== 'object' || typeof data.event !== 'string') {
        return;
    }

    handlePlayerEvent(data);
}

window.addEventListener('message', onPlayerMessage);
```

Примеры ниже — варианты функции `handlePlayerEvent` для этого обработчика. Замените ее в общем примере или объедините в ней обработку нескольких событий. Повторно подписываться на `message` не нужно.

Если удаляете плеер со страницы, удалите и обработчик: `window.removeEventListener('message', onPlayerMessage)`.

## События инициализации {#initialization-events}

#### inited {#inited}

Плеер инициализирован и готов к работе.

Параметры события:
* `vsid` (string) — уникальный идентификатор сессии плеера.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'inited') {
        console.log('Плеер инициализирован, vsid:', data.vsid);
    }
}
```

#### resourcesIdle {#resourcesidle}

Все ресурсы плеера загружены, плеер находится в состоянии ожидания.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'resourcesIdle') {
        console.log('Ресурсы плеера загружены');
    }
}
```

#### contentImpression {#contentimpression}

Контент отображен пользователю (impression).

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'contentImpression') {
        console.log('Контент отображен');
    }
}
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
function handlePlayerEvent(data) {
    if (data.event === 'started') {
        console.log('Воспроизведение началось');
        console.log('Время:', data.time);
        console.log('Длительность:', data.duration);
        console.log('Название:', data.title);
    }
}
```

#### resumed {#resumed}

Воспроизведение возобновлено после паузы.

Параметры события:
* `time` (number) — текущее время воспроизведения в секундах.
* `duration` (number) — длительность видео в секундах.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'resumed') {
        console.log('Воспроизведение возобновлено на', data.time, 'секунде');
    }
}
```

#### paused {#paused}

Воспроизведение приостановлено.

Параметры события:
* `time` (number) — текущее время воспроизведения в секундах.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'paused') {
        console.log('Воспроизведение приостановлено на', data.time, 'секунде');
    }
}
```

#### ended {#ended}

Воспроизведение видео завершено.

Параметры события:
* `time` (number) — время окончания воспроизведения в секундах.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'ended') {
        console.log('Воспроизведение завершено');
    }
}
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
function handlePlayerEvent(data) {
    if (data.event === 'timeupdate') {
        console.log('Текущее время:', data.time);
        console.log('Длительность:', data.duration);
        console.log('Просмотрено:', data.watchedTime);
    }
}
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
function handlePlayerEvent(data) {
    if (data.event === 'durationchange') {
        console.log('Длительность изменилась:', data.duration);
    }
}
```

#### rewound {#rewound}

Пользователь перемотал видео.

Параметры события:
* `time` (number) — новое время воспроизведения в секундах.
* `previousTime` (number) — предыдущее время воспроизведения в секундах.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'rewound') {
        console.log('Перемотка с', data.previousTime, 'на', data.time);
    }
}
```

## События звука {#audio-events}

#### volumechange {#volumechange}

Изменение громкости или статуса muted (выключенного звука).

Параметры события:
* `volume` (number) — уровень громкости от 0 до 1.
* `muted` (boolean) — статус выключенного звука (`true` — звук выключен, `false` — включен).

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'volumechange') {
        console.log('Громкость:', data.volume);
        console.log('Звук выключен:', data.muted);
    }
}
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
function handlePlayerEvent(data) {
    if (data.event === 'error') {
        console.error('Ошибка воспроизведения');
        console.error('Код ошибки:', data.code);
        console.error('Время:', data.time);
    }
}
```

## События рекламы {#ad-events}

#### adShown {#adshown}

Начался показ рекламного ролика.

Параметры события:
* `time` (number) — время начала показа рекламы в секундах.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'adShown') {
        console.log('Начался показ рекламы');
    }
}
```

#### adEnd {#adend}

Показ рекламного ролика завершен.

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'adEnd') {
        console.log('Показ рекламы завершен');
    }
}
```

#### adPodStart {#adpodstart}

Начался показ рекламного блока (pod).

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'adPodStart') {
        console.log('Начался показ рекламного блока');
    }
}
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
function handlePlayerEvent(data) {
    if (data.event === 'sizeChange') {
        console.log('Размер видео:', data.videoWidth, 'x', data.videoHeight);
        console.log('Это реклама:', data.isAd);
    }
}
```

#### fullscreenchange {#fullscreenchange}

Изменение состояния полноэкранного режима.

Параметры события:
* `isFullscreen` (boolean) — статус полноэкранного режима (`true` — включен, `false` — выключен).

Пример обработки:

```javascript
function handlePlayerEvent(data) {
    if (data.event === 'fullscreenchange') {
        console.log('Полноэкранный режим:', data.isFullscreen ? 'включен' : 'выключен');
    }
}
```

#### Полезные ссылки {#see-also}

* [{#T}](./index.md)
* [{#T}](./initialization.md)
* [{#T}](./player-methods.md)
