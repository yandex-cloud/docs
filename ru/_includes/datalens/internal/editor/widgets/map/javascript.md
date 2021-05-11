## JavaScript {#javascript}

### Общая информация {#common}

В результате выполнения вкладки JavaScript должны быть экпортированы данные для отрисовки карты.

### Доступные методы {#available-methods}

* **`ChartEditor.getParams()`** - возвращает объект с нормализованными параметрами.

* **`ChartEditor.getLoadedData()`** - возвращает объект с данными, запрошенными на вкладке Urls.

* **`ChartEditor.updateConfig(config)`** - доопределяет результат вкладки [Config](config.md) объектом `config`.

* **`ChartEditor.updateHighchartsConfig(config)`** - доопределяет результат вкладки [Highmaps](highmaps.md) объектом `config`.

### Пример {#example}

```js
// подключаем модуль геоданных карты
const mapDataRu = require('libs/maps/ru/v1');

module.exports = {
    // информация о карте
    map: [{
        // имя ряда (по умолчанию: null)
        name: 'Уточненные посетители',
        // данные точек (по умолчанию: null)
        data: [
            {
                // идентификатор геоданных
                // (связывает точку и сущность (страна, регион и т.д.) геоданных)
                // (по умолчанию: null)
                geo_id: '213',
                // заголовок (по умолчанию: null)
                name_local: 'Москва',
                // значение (по умолчанию: NaN)
                value: 2799978
            },
            {
                geo_id: '2',
                name_local: 'Санкт-Петербург',
                value: 1051140
            },
        ],
        // геоданные карты (обязательно)
        mapData: mapDataRu
    }]
};
```

Также для точек можно указать свойства описанные в [документации](https://api.highcharts.com/highmaps/series.map.data).

Модули геоданных для карт других стран можно найти в папке `libs/maps/`.
