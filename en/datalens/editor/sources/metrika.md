
# Metric

**Interface**: [`https://metrika.yandex.ru`](https://metrika.yandex.ru)

**Prefix**: `/_metrika` -> `https://metrika.yandex.ru`

**Table of contents**:
* [Metric](#metrica-source)
* [Metadata](#meta-info)

---

## Metric {#metrica-source}

### Generating a data source {#metrica-source-forming-data-source}

To build a data source, the `buildSource` method from the `libs/metrika/v1` module is used.
The `buildSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| ids | `number` `number[]` | Identifiers of metrics | Required |
| metrics | `string` `string[]` | Metric name (names) | Required |
| dimensions | `string` `string[]` | Grouping options name (names) | `null` |
| filters | `string` `string[]` | Segmentation filter | `null` |
| sort | `string` `string[]` | Names of dimensions and metrics to sort by | `null` |
| date1 | `string` | Period start: (`YYYY-MM-DD`) | A week ago |
| date2 | `string` | Period end (`YYYY-MM-DD`) | Presently |
| cache | `number` | The response caching time (in seconds) | 0 |
| accuracy | `number` `string` | Precision of the result calculation (from 0 to 1 or `low`, `medium`, `high`, `full`) | `medium` |
| limit | `number` | Limits on data amounts | 100 |
| where | `object` | Additional parameters | `null` |

#### Example {#metrica-source-forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const Metrika = require('libs/metrika/v1');

// Build the data source
const metrikaSource = Metrika.buildSource({
    ids: 44147844,
    date1: '2018-01-01',
    date2: '2018-02-01',
    metrics: 'ym:s:users',
    dimensions: 'ym:s:date',
    accuracy: 'full',
    filters: 'ym:s:pageViews>5',
    sort: 'ym:s:date',
    limit: 30,
    cache: 300
});

// Export the sources
module.exports = {
    metrikaSource: metrikaSource,
};
```

### Examples {#metrica-source-examples}

[Chart based on the data from Yandex Metrica](https://charts.yandex-team.ru/editor/Templates/simple-metrika)

---

## Metadata {#meta-info}

### Generating a data source {#meta-info-forming-data-source}

To build a metadata source, the `buildMetaSource` method from the `libs/metrika/v1` module is used.
The `buildMetaSource` method accepts the tag ID as an argument.

#### Example {#meta-info-forming-data-source-examples}

**Urls** tab
```js
// Include the data source module
const Metrika = require('libs/metrika/v1');

// Build the metadata source
const metrikaMetaSource = Metrika.buildMetaSource(44147844);

// Export the sources
module.exports = {
    metrikaMetaSource: metrikaMetaSource
};
```
