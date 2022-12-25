
# Mobile metric

**Interface**: [`https://appmetrica.yandex.ru/`](https://appmetrica.yandex.ru/)

**Prefix**: `/_appmetrika` -> `https://beta.api-appmetrika.yandex.ru`

**Table of contents**:
* [Metric](#appmetrica-source)
* [Metadata](#meta-info)

---

## Mobile metric {#appmetrica-source}

### Generating a data source {#appmetrica-source-forming-data-source}

To build a data source, the `buildSourc`e method from the `libs/appmetrika/v1` module is used.
The `buildSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| ids | `number` `number[]` | Identifiers of metrics | Required |
| metrics | `string` `string[]` | Metric name (names) | Required |
| dimensions | `string` `string[]` | Grouping options name (names) | `null` |
| filters | `string` `string[]` | Segmentation filters | `null` |
| sort | `string` `string[]` | Names of dimensions and metrics to sort by | `null` |
| date1 | `string` | Period start: (`YYYY-MM-DD`) | A week ago |
| date2 | `string` | Period end (`YYYY-MM-DD`) | Presently |
| cache | `number` | The response caching time (in seconds) | 0 |
| accuracy | `number` `string` | Precision of the result calculation (from 0 to 1 or `low`, `medium`, `high`, `full`) | `medium` |
| limit | `number` | Limits on data amounts | 100 |
| where | `object` | Additional parameters | `null` |

#### Example {#appmetrica-source-forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const AppMetrika = require('libs/appmetrika/v1');

// Build data source
const appMetrikaSource = AppMetrika.buildSource({
    ids: 1111,
    date1: '2018-01-01',
    date2: '2018-02-01',
    metrics: 'ym:s:users',
    dimensions: 'ym:s:date',
    accuracy: 'full',
    filters: "ym:s:regionCityName=='Saint Petersburg",
    sort: 'ym:s:date',
    limit: 30,
    cache: 360
});

// Export sources
module.exports = {
    appMetrikaSource: appMetrikaSource
};
```

### Examples {#appmetrica-source-forming-data-source-examples}

[Chart based on the data from Yandex Metrica for mobile apps](https://charts.yandex-team.ru/editor/Templates/simple-appmetrika)

---

## Metadata {#meta-info}

### Generating a data source {#meta-info-forming-data-source}

To build a metadata source, the `buildMetaSource` method from the `libs/appmetrika/v1` module is used.
The `buildMetaSource` method accepts the tag ID as an argument.

#### Example {#meta-info-forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const AppMetrika = require('libs/appmetrika/v1');

// Build the source of metadata
const appMetrikaMetaSource = AppMetrika.buildMetaSource(1111);

// Export the sources
module.exports = {
    appMetrikaMetaSource: appMetrikaMetaSource
};
```
