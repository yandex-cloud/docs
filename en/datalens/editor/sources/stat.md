# Statistics

**Interface**: [`https://stat.yandex-team.ru`](https://stat.yandex-team.ru)

**Prefix**: `/_stat` -> `https://api.stat.yandex-team.ru`

**Table of contents**:
* [Reports](#reports)
* [Geodata](#geo-data)
* [Dictionaries](#dictionaries)
* [Dimension values](#dimension-values)

**Additional information**:
* [Available parameters](https://wiki.yandex-team.ru/statbox/statface/graphics/)
* [Tree description](https://wiki.yandex-team.ru/statbox/statface/reportdata/#podrobnoeopisanierabotysderevjami)
* [Reports documentation](https://doc.yandex-team.ru/stat/report-overview/concepts/about.html)

---

## Reports {#reports}

### Generating a data source {#reports-forming-data-source}

To create a data source, the `buildReportSource` method from the `libs/stat/v1` module is used.
The `buildReportSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| beta | `boolean` | stat-beta source | false |
| report | `string` | Report name | Required |
| scale | `string` | Scale | `d` |
| period | `number` | Period | 30 |
| region | `string` | Region | `TOT` |
| date_min | `string` | The start of the period, in the format `YYYY-MM-DD hh:mm:ss` | `null` |
| date_max | `string` | The start of the period, in the format `YYYY-MM-DD hh:mm:ss` | `null` |
| fields | `string` `string[]` | Fields from the report | `null` (only the date field fielddate__ms is returned) |
| tree | `object` `object[]` | Tree description | `null` |
| where | `object` | Additional terms | `null` |

The tree description includes the following properties:

| Name | Type | Description | By default |
|:---|:---|:---|:---
| name | `string` | Tree field name | `null` |
| path | `string[]` `number[]` | Path | `null` |
| level | `number` | Level | 1 |

#### Example {#reports-forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const Stat = require('libs/stat/v1');

// Build the data source
const statReportSource = Stat.buildReportSource({
    report: 'Multiproject/Totals/Geography',
    scale: 'd',
    period: 30,
    fields: ['old_visitors_all', 'old_visitors_hits_all'],
    dict_fields: 'geoid',
    tree: {
        name: 'geoid',
        path: [10000, 225, 3, 1, 213],
        level: 1
    },
    // For the multi-tree case
    /*
    tree:  [{
        name: 'geoid',
        path: [10000, 225, 3, 1, 213],
        level: 1
    }, {
        ...
    }]
    */
    where: {
        geoid__mode: 'leaf',
        projectid: 'Yandex'
    }
});

// Export the data source
module.exports = {
    statReportSource: statReportSource
};
```

### Examples {#reports-examples}

[Chart based on the Statistics report data](https://charts.yandex-team.ru/editor/Templates/simple-stat-report)

---

## Geodata {#geo-data}

To create a data source, the `buildGeoSource` method from the `libs/stat/v1` module is used.
The `buildGeoSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| beta | `boolean` | stat-beta source | false |
| report | `string` | Report name | Required |
| map | `object` | Map data (`libs/maps/*`) | Required |
| fields | `string` `string[]` | Fields from the report | `null` (all the fields from the report are returned) |
| scale | `string` | Scale | `d` |
| fielddate | `string` | Date (`YYYY-MM-DD hh:mm:ss`) | Presently |

#### Example {#geo-data-example}

**Urls** tab
```js
// Include the data source module
const Stat = require('libs/stat/v1');

// Include the map module
const mapDataRu = require('libs/maps/ru/v1');

// Build the data source
const statGeoSource = Stat.buildGeoSource({
    report: '/Morda/Totals/Geography',
    map: mapDataRu,
    scale: 'd',
    fielddate: '2018-01-01',
    fields: 'old_visitors_all',
});

// Export the data source
module.exports = {
    statGeoSource: statGeoSource
};
```

### Examples {#geo-data-examples}

[The total refined number of the home page users yesterday in Russia](https://charts.yandex-team.ru/editor/Templates/simple-stat-geo)

---

## Dictionaries {#dictionaries}

To build a data source, the `buildDictSource` method from the `libs/stat/v1` module is used.
The `buildDictSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| beta | `boolean` | stat-beta source | false |
| name | `string` | Dictionary name | Required |
| language | `string` | Language  | `null` |
| keys | `string` `string[]` | Keys from the dictionary | `null` (all keys and values are returned) |

#### Example {#dictionaries-example}

**Urls** tab
```js
// Include the data source module
const Stat = require('libs/stat/v1');

// Build the data source
const statDictSource = Stat.buildDictSource({
    name: 'edge_search_metrics',
    language: 'RU',
    keys: ['mode_switched', 'click_rate', 'abc']
});

// Export the data source
module.exports = {
    statDictSource: statDictSource
};
```

## Dimension values {#dimension-values}

To build a data source for querying the value of a single
dimension, use the `buildDimensionValues` method from the `libs/stat/v1` module.

The `buildDimensionValues` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| beta | `boolean` | stat-beta source | false |
| report | `string` | The path to the report | Required |
| dimension | `string` | Dimension ID | Required |
| apply_dictionary | `bool` | Dictionaries overlay | Optional |

#### Example {#dimension-values-example}

**Urls** tab
```js
// Include the data source module
const Stat = require('libs/stat/v1');

// Build the data source
const statDimensionValuesSource = Stat.buildDimensionValues({
    report: 'Morda/Totals/Totals',
    dimension: 'project'
})
// ^ What the URL will look like: https://stat.yandex-team.ru/_api/report/distincts/Morda/Totals/Totals?dim=project
// Data structure: ["Value1", "Value2", ...]

// Export the data source
module.exports = {
    statDimensionValuesSource: statDimensionValuesSource
};
```

#### Dictionaries overlay {#dictionary-overlay}

Governed by the `apply_dictionary` flag.

URL example: https://stat-beta.yandex-team.ru/_api/report/distincts/Adhoc/hhell/tst/dimdicts?dim=case&_apply_dictionary=1

Data structure: `[["value1", "title1"], ["value2"], ["value3", "title3"], ...]`.

Example of building a selector (**Controls** tab):

```js
const items = ChartEditor.getLoadedData().statDimensionValuesSource;

module.exports = [
    {
        type: 'select', width: '100%', updateOnChange: true,
        param: 'case', label: 'Case',
        content: items.map(value => ({
            title: value[1] || value[0],
            value: value[0]
        }))
    }
];
```
