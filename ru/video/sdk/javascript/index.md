---
title: Начало работы с JavaScript SDK для Cloud Video Player
description: На странице приведены основные элементы управления видеоплеером Cloud Video Player с помощью SDK для JavaScript.
---

# Начало работы с SDK видеоплеера для JavaScript

Вы можете интегрировать [видеоплеер](../../concepts/player.md) с контентом из Cloud Video в ваш проект на языке [JavaScript](https://ru.wikipedia.org/wiki/JavaScript) с помощью Cloud Video Player SDK для JavaScript.

## Подключение плеера на странице {#add-player}

Чтобы подключить плеер на страницу, добавьте на нее код:

```html
<script src="https://runtime.video.cloud.yandex.net/player/js/player-sdk.js"></script>
```

## Инициализация плеера {#initialize-player}

Чтобы инициализировать плеер, добавьте на страницу код:

```javascript
var player = Ya.playerSdk.init({
    /** @type {(string|HTMLElement)} где будет создан плеер плеер */
    element: 'video-player',
    /** @type {string} ссылка на воспроизводимый контент */
    source: 'https://runtime.video.cloud.yandex.net/player/...',
    /** @type {boolean} автовоспроизведение при загрузке контента */
    autoplay: false
});
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

Подробнее об инициализации плеера см. в разделах:

* [Параметры инициализации плеера](./initialization.md)
* [Interface: PlayerSdkInitConfig](../../api-ref/javascript/interfaces/PlayerSdkInitConfig.md) в справочнике API
* [Interface: PlayerSdkSourceParams](../../api-ref/javascript/interfaces/PlayerSdkSourceParams.md) в справочнике API

## Управление плеером {#player-controls}

Информацию о методах управления плеером см. в разделах:

* [Методы плеера](./player-methods.md)
* [Interface: PlayerSdkApi](../../api-ref/javascript/interfaces/PlayerSdkApi.md) в справочнике API

## Состояние плеера {#player-state}
    
Информацию об объекте, содержащем параметры состояния плеера см. в разделах:

* [Состояние плеера](./player-state.md)
* [Interface: PlayerSdkState](../../api-ref/javascript/interfaces/PlayerSdkState.md) в справочнике API

## События плеера {#player-events}

Информацию о событиях плеера см. в разделах:

* [События плеера](./player-events.md)
* [Interface: PlayerSdkEventHandlers](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) в справочнике API
