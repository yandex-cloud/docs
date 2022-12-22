## JavaScript {#javascript}

### General information {#common}

As a result of executing the JavaScript tab, data required for map rendering should be exported.

### Available methods {#available-methods}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getLoadedData()`**: Returns an object with data requested in the URLs tab.

* **`ChartEditor.updateConfig(config)`**: Extends the definition of the [Config](config.md) tab output with the `config` object.

* **`ChartEditor.updateHighchartsConfig(config)`**: Extends the definition of the [Highmaps](highmaps.md) tab output with the `config` object.

### Example {#example}

```js
// enabling the map geodata module
const mapDataRu = require('libs/maps/ru/v1');

module.exports = {
    // map info
    map: [{
        // series name (defaults to null)
        name: 'Updated visitors',
        // point data (defaults to null)
        data: [
            {
                // geodata ID
                // (links a point and a geodata entity (country, region, and so on))
                // (defaults to null)
                geo_id: '213',
                // title (defaults to null)
                name_local: 'Moscow',
                // value (defaults to NaN)
                value: 2799978
            },
            {
                geo_id: '2',
                name_local: 'Saint Petersburg',
                value: 1051140
            },
        ],
        // map geodata (required)
        mapData: mapDataRu
    }]
};
```

You can also specify point properties described in the [documentation](https://api.highcharts.com/highmaps/series.map.data).

You can find geodata modules for the maps of other countries in the `libs/maps/` directory.
