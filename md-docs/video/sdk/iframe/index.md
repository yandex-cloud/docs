[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > [SDK](../index.md) > IFrame > Начало работы

# Начало работы с SDK видеоплеера для IFrame

Вы можете интегрировать [видеоплеер](../../concepts/player.md) с контентом из Cloud Video в ваш проект с помощью Cloud Video Player SDK для IFrame. SDK позволяет управлять плеером через JavaScript API, используя механизм `postMessage` для взаимодействия с iframe.

## Подключение плеера на странице {#add-player}

Чтобы подключить плеер на страницу, добавьте на нее код вставки iframe:

```html
<iframe
    id="video-player"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/..."
></iframe>
```

Где `https://runtime.video.cloud.yandex.net/player/...` — ссылка на [видео](../../operations/video/get-link.md), [трансляцию](../../operations/streams/get-link.md) или [плейлист](../../operations/playlists/get-link.md).

## Инициализация SDK {#initialize-sdk}

Для управления плеером через JavaScript получите ссылку на iframe и используйте метод `postMessage` для отправки команд. Разместите скрипт после iframe из предыдущего примера. Если создаете iframe динамически, выполняйте код после добавления элемента в DOM:

```javascript
// Получаем ссылку на iframe
const iframe = document.getElementById('video-player');
const player = iframe.contentWindow;
const playerOrigin = new URL(iframe.src).origin;

// Функция для отправки команд плееру
function sendCommand(method, params = {}) {
    player.postMessage({
        method: method,
        ...params
    }, playerOrigin);
}
```

Значение `playerOrigin` ограничивает отправку команд источником из URL плеера: протоколом, именем хоста и портом. Команды можно передавать объектами, а события от плеера приходят в виде строк JSON.

## Настройка параметров плеера {#player-parameters}

Вы можете настроить параметры плеера при создании iframe, добавив их в URL в виде query-параметров:

```html
<iframe
    id="video-player"
    src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=1"
></iframe>
```

Подробнее в разделе [Параметры инициализации плеера](initialization.md).

## Управление плеером {#player-controls}

Информация о методах управления плеером представлена в разделе [Методы плеера](player-methods.md).

Примеры отдельных команд приведены ниже. Вызывайте их после события [`inited`](player-events.md#inited), например из обработчиков кнопок:

```javascript
// Запустить воспроизведение
sendCommand('play', {});

// Поставить на паузу
sendCommand('pause', {});

// Перемотать на 30-ю секунду
sendCommand('seek', { time: 30 });

// Установить громкость на 50%
sendCommand('setVolume', { volume: 0.5 });
```

## События плеера {#player-events}

Информация о событиях плеера представлена в разделе [События плеера](player-events.md).

Добавьте обработчик в тот же скрипт после объявления `player` и `playerOrigin`. Он проверяет отправителя сообщения и разбирает JSON. События, отправленные до регистрации обработчика, повторно не доставляются:

```javascript
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

    switch (data.event) {
        case 'inited':
            console.log('Плеер инициализирован, vsid:', data.vsid);
            break;
        case 'started':
            console.log('Воспроизведение началось');
            break;
        case 'paused':
            console.log('Воспроизведение приостановлено');
            break;
        case 'timeupdate':
            console.log('Текущее время:', data.time);
            break;
    }
}

window.addEventListener('message', onPlayerMessage);
```

Если удаляете плеер со страницы, удалите и обработчик: `window.removeEventListener('message', onPlayerMessage)`.

#### Полезные ссылки {#see-also}

* [Параметры инициализации плеера](initialization.md)
* [Методы плеера](player-methods.md)
* [События плеера](player-events.md)