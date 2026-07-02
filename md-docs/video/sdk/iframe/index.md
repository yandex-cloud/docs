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

Для управления плеером через JavaScript необходимо получить ссылку на iframe и использовать метод `postMessage` для отправки команд:

```javascript
// Получаем ссылку на iframe
var iframe = document.getElementById('video-player');
var player = iframe.contentWindow;

// Функция для отправки команд плееру
function sendCommand(method, params) {
    player.postMessage({
        method: method,
        ...params
    }, '*');
}

// Функция для подписки на события плеера
window.addEventListener('message', function(event) {
    if (event.data && event.data.event) {
        console.log('Событие плеера:', event.data.event, event.data);
    }
});
```

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

Пример использования методов:

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

Пример подписки на события:

```javascript
window.addEventListener('message', function(event) {
    if (!event.data || !event.data.event) return;
    
    switch(event.data.event) {
        case 'inited':
            console.log('Плеер инициализирован, vsid:', event.data.vsid);
            break;
        case 'started':
            console.log('Воспроизведение началось');
            break;
        case 'paused':
            console.log('Воспроизведение приостановлено');
            break;
        case 'timeupdate':
            console.log('Текущее время:', event.data.time);
            break;
    }
});
```

#### Полезные ссылки {#see-also}

* [Параметры инициализации плеера](initialization.md)
* [Методы плеера](player-methods.md)
* [События плеера](player-events.md)