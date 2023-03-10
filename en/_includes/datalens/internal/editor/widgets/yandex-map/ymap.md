## Yandex Maps {#yandex-maps}

### General information {#info}

As a result of executing the Yandex Maps tab, the data providing additional display
configuration should be exported.
[Available parameters](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Map-docpage#Map__constructor-summary) descriptions.

### Example {#example}

**Yandex Maps** tab
```js
module.exports = {
    state: {
        // map center
        center: [55.76, 37.64],
        // soom
        zoom: 8,
        // map controls
        controls: ['zoomControl'],
        // map behaviors
        behaviors: ['drag', 'scrollZoom']
    },
    options: {}
};
```
