---
title: Начало работы с JavaScript SDK для {{ video-player-name }}
description: На странице приведены основные элементы управления видеоплеером {{ video-player-name }} с помощью SDK для JavaScript.
alternate:
  - href: ru/video/sdk/javascript/index.md
    type: text/markdown
    title: Markdown version
---

# Начало работы с SDK видеоплеера для JavaScript

Вы можете интегрировать [видеоплеер](../../concepts/player.md) с контентом из {{ video-name }} в ваш проект на языке [JavaScript](https://ru.wikipedia.org/wiki/JavaScript) с помощью {{ video-player-name }} SDK для JavaScript.

## Подключение плеера на странице {#add-player}

Чтобы подключить плеер на страницу, добавьте на нее код:

```html
<script src="https://runtime.video.cloud.yandex.net/player/js/player-sdk.js"></script>
```

## Инициализация плеера {#initialize-player}

Чтобы инициализировать плеер, добавьте на страницу код:

```javascript
var player = Ya.playerSdk.init({
    /** @type {(string|HTMLElement)} где будет создан плеер */
    element: 'video-player',
    /** @type {string} ссылка на воспроизводимый контент */
    source: 'https://runtime.video.cloud.yandex.net/player/...',
    /** @type {boolean} автовоспроизведение при загрузке контента */
    autoplay: false
});
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

Инициализация плеера описана в разделах:

* [Параметры инициализации плеера](./initialization.md)
* [Interface: PlayerSdkInitConfig](../../api-ref/javascript/interfaces/PlayerSdkInitConfig.md) в справочнике API
* [Interface: PlayerSdkSourceParams](../../api-ref/javascript/interfaces/PlayerSdkSourceParams.md) в справочнике API

### Использование TypeScript {#typescript}

Если вы используете TypeScript, установите [пакет типов SDK](https://www.npmjs.com/package/@yandex-cloud/stream-player-public-types) в качестве зависимости для разработки:

```bash
npm install --save-dev @yandex-cloud/stream-player-public-types
```

Перед выполнением примера [подключите скрипт плеера](#add-player) и дождитесь его загрузки. На странице должен быть элемент с идентификатором `video-player`, например `<div id="video-player"></div>`.

Используйте тип `PlayerSdkGlobalObject` для доступа к SDK. Тогда TypeScript проверит параметры инициализации и определит тип `player` как `PlayerSdkApi`:

```typescript
import type { PlayerSdkGlobalObject } from '@yandex-cloud/stream-player-public-types';

const { playerSdk } = (window as PlayerSdkGlobalObject).Ya;
const player = playerSdk.init({
    element: 'video-player',
    source: 'https://runtime.video.cloud.yandex.net/player/...',
});
```

В параметре `source` укажите ссылку на видео, трансляцию или плейлист.

## Управление плеером {#player-controls}

Информация о методах управления плеером представлена в разделах:

* [Методы плеера](./player-methods.md)
* [Interface: PlayerSdkApi](../../api-ref/javascript/interfaces/PlayerSdkApi.md) в справочнике API

## Состояние плеера {#player-state}
    
Информация об объекте, содержащем параметры состояния плеера, представлена в разделах:

* [Состояние плеера](./player-state.md)
* [Interface: PlayerSdkState](../../api-ref/javascript/interfaces/PlayerSdkState.md) в справочнике API

## События плеера {#player-events}

Информация о событиях плеера представлена в разделах:

* [События плеера](./player-events.md)
* [Interface: PlayerSdkEventHandlers](../../api-ref/javascript/interfaces/PlayerSdkEventHandlers.md) в справочнике API
