---
title: "Методы плеера Cloud Video Player в SDK для JavaScript"
description: "На странице описаны методы, которые можно использовать для управления видеоплеером Cloud Video Player в SDK для JavaScript."
---

# Методы плеера

Вы можете управлять [видеоплеером](../../concepts/player.md) Cloud Video Player с использованием методов SDK для JavaScript:

#### setSource {#setsource}

Переключает контент.

Пример простого переключения контента:

```javascript
player.setSource('https://runtime.video.cloud.yandex.net/player/...');
```

{% include [video-content-id-desc](../../../_includes/video/video-content-id-desc.md) %}

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

#### getState {#getstate}

Возвращает состояние плеера в виде объекта, формат которого описан в разделе [{#T}](./player-state.md).

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

#### on/once {#subscribe-methods}

Позволяет подписаться на [события плеера](./player-events.md).

При вызове `once` подписка действует только на первое срабатывание события, при вызове `on` — на все срабатывания.

Методы имеют сигнатуру `on(eventName, handler)` и `once(eventName, handler)`. Первым параметром передается название события, вторым — обработчик.

В обработчик передается объект с соответствующим событию полем из [состояния плеера](./player-state.md).

Пример подписки на все срабатывания события изменения статуса воспроизведения [StatusChange](./player-state.md#StatusChange):

```javascript
player.on('StatusChange', ({ status }) => {
    console.log(status);
});
```

#### off {#off}

Позволяет отписаться от событий плеера, на которые с помощью [методов](./player-events.md#subscribe-methods) `on` или `once` была выполнена подписка.

Метод имеет сигнатуру `off(eventName, handler)`. Первым параметром передается название события, вторым — обработчик, который использовался ранее для подписки.

Пример отписки от функции-обработчика с названием `handler` для события изменения статуса воспроизведения [StatusChange](./player-events.md#StatusChange):

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

#### См. также {#see-also}

* [Interface: PlayerSdkApi](../../api-ref/javascript/interfaces/PlayerSdkApi.md) в справочнике API