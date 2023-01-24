## Yandex Maps {#yandex-maps}

### Общая информация {#info}

В результате выполнения вкладки Yandex Maps должны быть экспортированы данные, отвечающие за дополнительную конфигурацию
отображения.
Описание [доступных параметров](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Map-docpage#Map__constructor-summary).

### Пример {#example}

Вкладка **Yandex Maps**
```js
module.exports = {
    state: {
        // центр карты
        center: [55.76, 37.64],
        // приближение
        zoom: 8,
        // элементы управления карты
        controls: ['zoomControl'],
        // поведения карты
        behaviors: ['drag', 'scrollZoom']
    },
    options: {}
};
```
