
# Solomon

**Interface**: [`https://solomon.yandex-team.ru`](https://solomon.yandex-team.ru)

**Prefix**: `/_solomon` -> `http://api.solomon.search.yandex.net`

---

## Integration {#integration}

A closer integration with the service is supported.
On the page with a chart, you have the **Share** button which opens the form to export the chart.
When you click **Export to Charts**, you are redirected to a chart in Yandex Charts.
If this button is missing, the `graph` parameter isn't `Auto`, and this is a preconfigured/configurable chart.
You can't display such a chart in Charts directly without conversions
because some settings are stored in Solomon and aren't available externally.

---

## Generating a data source {#forming-data-source}

To build a data source, the `buildSource` method from the `libs/solomon/v1` module is used.
The `buildSource` method accepts two arguments: an `object` with parameters and an `object` with labels.

* Parameters

   | Name | Type | Description | By default |
   |:---|:---|:---|:---
   | b | `string` | Start of the period (`YYYY-MM-DD HH:mm:ss` or `-30d`, ...) | 24 hours ago |
   | e | `string` | End of the period (`YYYY-MM-DD HH:mm:ss` or `-30d`, ...) | Now |

* Common labels

   | Name | Type | Description | Required |
   |:---|:---|:---|:---
   | project | `string` | Project name | Required (?) |
   | cluster | `string` | Cluster name | Required (?) |
   | service | `string` `string[]` | Service name | Required (?) |

### Example {#forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const Solomon = require('libs/solomon/v1');

// List all labels from the Solomon chart
// graph is not a label, so you don't need to write {graph: 'auto'}
const labels = {
    project: 'solomon',
    cluster: 'kikimr_solomon_stp_man',
    service: 'frontend',
    host: 'cluster',
    path: '/MemoryInfo/GCInfo/Count',
    garbadge_collector: '*'
};

// In the parameters, you can specify the period start and end
// With the current settings, the chart shows the last date
const params = {
    b: '1d',
    e: ''
};

// Build the data source
const solomonSource = Solomon.buildSource(params, labels);

// Export the data source
module.exports = {
    solomonSource: solomonSource
};
```

## The operations with data from source {#work-with-data-source}

The `prepareGraph` method from the `libs/solomon/v1` module is used to generate data for rendering.
As arguments, it accepts `sensors` obtained from the source and an `object` with the following properties:

| Name | Type | Description | By default |
|:---|:---|:---|:---
| titleLabel | `string|string[]` | Labels used to build categories | ??? |

### Example {#work-with-data-source-example}

**JavaScript** tab
```js
// Include the module for the data source
const Solomon = require('libs/solomon/v1');

// Request the loaded data
const loadedData = ChartEditor.getLoadedData();

// Retrieve the fields from the uploaded data
const sensors = loadedData.solomonSource.sensors;

// Generate the rendering data
const graph = Solomon.prepareGraph(
    sensors,
    // In the titleLabel variable, specify the label used to build categories
    // In this case, this is garbage_collector
    {titleLabel: 'garbadge_collector'}
    // {titleLabel: ['garbadge_collector', 'path']}
);

// Export the rendering data
module.exports = graph;
```

## Examples {#examples}

[Chart based on the data from Solomon](https://charts.yandex-team.ru/editor/Templates/simple-solomon)
