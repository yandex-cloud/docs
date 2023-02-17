
# Metrics

**Interface**: [`https://metrics.yandex-team.ru`](https://metrics.yandex-team.ru)

**Prefix**: `/_metrics` -> `https://metrics.yandex-team.ru`

---

## Integration {#integration}

A closer integration with the service is supported.
There is the **Stat export** button on the chart page.
As a result, you will be redirected to a Yandex Charts chart.

## Generating a data source {#forming-data-source}

To build a data source, the `buildSource` method from the `libs/metrics/v1` module is used.
The `buildSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---|
| graphName | `string` | Chart name in Metrics | Required |
| startDate | `string` | ISO period start date | Required |
| endDate | `string` | ISO period end date | Required |
| confidentOnly | `boolean` | Only verified points | `false` |
| config | `object[]` | Configurations array | Required |

The configuration description includes the following **required** property:

| Name | Type | Description |
|:---|:---|:---
| filter | `object` | Filter description |

The filter description includes the following **required** properties:

| Name | Type | Description |
|:---|:---|:---
| system | `string` | System name |
| metric | `string` | Metric name |

### Example {#forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const Metrics = require('libs/metrics/v1');

// Build the data source
const metricsSource = Metrics.buildSource({
    graphName: 'history',
    startDate: '2018-01-01',
    endDate: '2018-02-01',
    confidentOnly: false,
    config: [
        {
            filter: {
                system: '142',
                metric: 'proxima-5'
            }
        },
        {
            filter: {
                system: '140',
                metric: 'proxima-5'
            }
        }
    ]
});

// Export the data source
module.exports = {
    metricsSource: metricsSource
};
```

## Examples {#examples}

[The metric is `proxima-5`, the systems are `140` and `142`](https://charts.yandex-team.ru/editor/Templates/simple-metrics)
