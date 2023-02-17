
# Migrating old charts

Originally, ChartEditor could only run code in the browser.
This approach substantially simplified development of the service, but had multiple drawbacks:
- Too small amounts of data available for upload and pre-processing. When dozens of charts are loaded in the dashboard, even a megabyte in one of them could create problems.
- Nuances related to browsers and their JS engines
- Lack of security
- Overall limited options of control available to us: we couldn't return results over the API, we had limited options to collect statistics and add new features

In about 2016, we started making our first approaches to pre-processing on the server side (calculated fields in wizards, a separate tab for server-side code in ChartEditor).
We graduated our first server-only version to [beta](https://clubs.at.yandex-team.ru/statistics/1206) on March 31, 2017.
By-and-by, we collected feedback, added missing features to the new engine, and supported all the chart types, checking all this functionality on numerous production dashboards.
[We launched the engine](https://clubs.at.yandex-team.ru/statistics/1403) on February 16, 2018, making this engine a default execution environment for all the new charts.


## Basics {#basic}

*
   ### We no longer have any magical variables, such as ChartEditor.setDataSource, ChartEditor.draw {#no-more-magic-variables}

```js
̶v̶̶a̶̶r̶̶ ̶̶p̶̶a̶̶r̶̶a̶̶m̶̶s̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶̶
```
```js
̶̶v̶̶a̶̶r̶̶ ̶̶g̶̶r̶̶a̶̶p̶̶h̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶̶
̶̶v̶̶a̶̶r̶̶ ̶̶t̶̶a̶̶b̶̶l̶̶e̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶̶
̶̶v̶̶a̶̶r̶̶ ̶̶m̶̶a̶̶p̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶̶
```
```js
̶̶v̶̶a̶̶r̶̶ ̶̶s̶̶t̶̶a̶̶t̶̶f̶̶a̶̶c̶̶e̶̶_̶̶g̶̶r̶̶a̶̶p̶̶h̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶̶
̶̶v̶̶a̶̶r̶̶ ̶̶s̶̶t̶̶a̶̶t̶̶f̶̶a̶̶c̶̶e̶̶_̶̶m̶̶e̶̶t̶̶r̶̶i̶̶c̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶̶
̶̶v̶̶a̶̶r̶̶ ̶̶s̶̶t̶̶a̶̶t̶̶f̶̶a̶̶c̶̶e̶̶_̶̶t̶̶e̶̶x̶̶t̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶̶
̶̶v̶̶a̶̶r̶̶ ̶̶s̶̶t̶̶a̶̶t̶̶f̶̶a̶̶c̶̶e̶̶_̶̶m̶̶a̶̶p̶̶ ̶̶=̶̶ ̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶;̶
```
```js
̶̶C̶̶h̶̶a̶̶r̶̶t̶̶E̶̶d̶̶i̶̶t̶̶o̶̶r̶̶.̶̶s̶̶e̶̶t̶̶D̶̶a̶̶t̶̶a̶̶S̶̶o̶̶u̶̶r̶̶c̶̶e̶̶(̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶)̶̶
̶̶C̶̶h̶̶a̶̶r̶̶t̶̶E̶̶d̶̶i̶̶t̶̶o̶̶r̶̶.̶̶d̶̶r̶̶a̶̶w̶̶(̶̶{̶̶ ̶̶.̶̶.̶̶.̶̶ ̶̶}̶̶)̶
```
...

A **single export interface** is implemented on all tabs:

```js
module.exports = { ... };
```

All the other logic on the tab is intact (except for other points described here).

**Previously**

Params tab:

```js
var params = {
    region: 'RU',
    scale: 'd'
}
```

JavaScript tab:

```js
ChartEditor.draw({
    graphs: [{data: [1]}],
    categories_ms: [1577836800000]
});
```

**Now**

Params tab:

```js
module.exports = {
    region: 'RU',
    scale: 'd'
};
```

JavaScript tab:

```js
module.exports = {
    graphs: [{data: [1]}],
    categories_ms: [1577836800000]
};
```

*
   ### We no longer support the "global" params variable {#no-more-global-params}

Now, you need to get the script parameters explicitly

```js
const params = ChartEditor.getParams();
```

`params` will have the following format:

```js
{
  region: ['RU'],
  scale: ['d']
}
```

To get the value of one parameter:

```js
const scale = ChartEditor.getParam('scale');
```

**Note**: All the resulting parameter values, including single ones, will be wrapped into an array, regardless of how you describe them in the Params tab.

*
   ### Instead of the Includes tab, modules are included on tabs {#instead-of-includes}

Learn more about modules in the [relevant section](modules.md).

**Previously**

Includes tab:

```js
var includes = [
    'Statbox.Lambda',
    'aHelpers',
    'moment.js'
];
```

**Now**

On each tab where the module is used:

```js
const _ = require('Statbox/Lambda');
const Helpers = require('modules/aHelpers');
const moment = require('vendor/moment/v2.24');
```

**Note**: Abandon the use of `Statbox` modules because they aren't supported anymore.

*
   ### Separate modules for sources instead of ChartEditor.buildUrl {#instead-of-buildurl}

For a list of available sources and examples of how to use them, see the [section](sources/index.md#list-data-sources).

## Examples {#examples}

[Examples/deprecated/parametrized-stat-graph](https://charts.yandex-team.ru/editor/Examples/deprecated/parametrized-stat-graph) -> [Examples/parametrized-stat-graph](https://charts.yandex-team.ru/editor/Examples/parametrized-stat-graph)
[Examples/deprecated/parametrized-stat-metric](https://charts.yandex-team.ru/editor/Examples/deprecated/parametrized-stat-metric) -> [Examples/parametrized-stat-metric](https://charts.yandex-team.ru/editor/Examples/parametrized-stat-metric)

## Legacy {#legacy}

The old execution environment will continue running in the existing charts (some of them were written seven (!) years ago).
However, we'll only fix critical errors in them and won't support them in our chats and newsletters.

Apart from that, you will not be able to use the charts with a browser-based execution environment in our newly developed tools and services,
such as, our [new ChartEditor interface](https://clubs.at.yandex-team.ru/statistics/1796) and [Yandex Dash](../dash/migration.md).
