
# Razladki

**Interface**: [`https://razladki.yandex-team.ru`](https://razladki.yandex-team.ru)

**Prefix**: `/_razladki` -> `https://razladki.yandex-team.ru`

---

## Specifics {#features}

The service sends time in the UTC format.

---

## Generating a data source {#forming-data-source}

To build a data source, the `buildSource` method from the `libs/razladki/v1` module is used.
The `buildSource` method accepts one argument: an `object` with the following **required** properties:

| Name | Type | Description |
|:---|:---|:---
| project | `string` | Project name |
| metric | `string` `string[]` | Metric/Metrics |
| date_min | `string` | Period start: (`YYYY-MM-DD hh:mm`) |
| date_max | `string` | Period end (`YYYY-MM-DD hh:mm`) |

### Example {#forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const Razladki = require('libs/razladki/v1');

// Build the data source
const razladkiSource = Razladki.buildSource({
    project: 'freshness_sbs',
    metric: [
        'production_vs_october_2017_winrate',
        'production_vs_october_2017_winrate_fast'
    ],
    date_min: '2018-01-01',
    date_max: '2018-02-01'
});

// Export the data source
module.exports = {
    razladkiSource: razladkiSource
};
```

## The operations with data from source {#work-with-data-source}

The `prepareGraph` method from the `libs/razladki/v1` module is used to generate data for rendering.
As arguments, it accepts the data obtained from the source and the `object` with the following properties:

| Name | Type | Description | By default |
|:---|:---|:---|:---
| useTimeShift | `boolean` | Use local time (adds 3 hours to the time series) | `false` |

### Example {#work-with-data-source-example}

**JavaScript** tab
```js
// Include the data source module
const Razladki = require('libs/razladki/v1');

// Request the loaded data 
const loadedData = ChartEditor.getLoadedData();

// Build the data for rendering
const result = Razladki.prepareGraph(
    loadedData.razladkiSource,
    {useTimeShift: true}
);

// Export the data for rendering
module.exports = result;
```

## Examples {#examples}

[Chart based on the data from Razladki](https://charts.yandex-team.ru/editor/Templates/simple-razladki)
