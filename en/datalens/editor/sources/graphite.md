
# Graphite (Graphana)

**Interface**: [`https://grafana.yandex-team.ru`](https://grafana.yandex-team.ru)

**Prefixes**:
* `/_bs_graphite` -> `https://bs-mg.yandex-team.ru`
* `/_gr_graphite` -> `https://gr-mg.yandex-team.ru`
* `/_ps_graphite` -> `https://ps-mg.yandex-team.ru`

---

## Generating a data source {#forming-data-source}

To build a data source, the `buildSource` method from the `libs/graphite/v1` module is used.
The `buildSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---|
| prefix | `string` | Source prefix | Required |
| target | `string` | ??? | Required |
| from | `number` `string` | Start of the period (seconds or in the format `-30d`, `now`, ...) | Presently |
| until | `number` `string` | End of the period (seconds or in the format `-30d`, `now`, ...) | Presently |
| maxDataPoints | `number` | Limits on the number of points | `null` (without limitations) |

### Example {#forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const Graphite = require('libs/graphite/v1');

// Build the data source
const graphiteSource = Graphite.buildSource({
    prefix: 'bs',
    target: "alias(sumSeries(group(alias(sumSeries(one_min.analytics01e_crypta_yandex_net.CRYPTAUP.socdem_training_sample.yandexuids.{Russia}.{tv}.gender.{0,m}.count), 'Male'), alias(sumSeries(one_min.analytics01e_crypta_yandex_net.CRYPTAUP.socdem_training_sample.yandexuids.{Russia}.{tv}.gender.{1,f}.count), 'Female'), alias(sumSeries(one_min.analytics01e_crypta_yandex_net.CRYPTAUP.socdem_training_sample.yandexuids.{Russia}.{tv}.gender.unknown.count), 'Unknown'))), 'count')",            format: 'json',
    from: '1514764800',
    until: 'now',
    maxDataPoints: 180
});

// Export the data source
module.exports = {
    graphiteSource: graphiteSource
};
```

## The operations with data from source {#work-with-data-source}

The `prepareGraph` method of the `libs/graphite/v1` accepts, as an argument, the data received from the source and
converts it to the chart rendering data.

### Example {#work-with-data-source-example}

**JavaScript** tab
```js
// Include the data source module
const Graphite = require('libs/graphite/v1');

// Request the uploaded data
const loadedData = ChartEditor.getLoadedData();

// Build the data for rendering
const graph = Graphite.prepareGraph(loadedData.graphiteSource);

// Export the data for rendering
module.exports = graph;
```
