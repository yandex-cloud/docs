# Drilldown

To enable drilldown, in the [config](architecture.md#config-and-highcharts) tab, define the breadcrumbs in the following format:

```js
module.exports = {
    drillDown: {
        breadcrumbs: ['City', 'Ship Mode', 'Customer Name']
    }
};
```

Examples with real data:

- [chart](https://datalens.yandex-team.ru/editor/9qahg4cnlu2y3).
- [table](https://datalens.yandex-team.ru/editor/s9u6umpgl2zsm).

In the [params](architecture.md#params) tab, you can set the drill level and the default filters.

```js
module.exports = {
    drillDownLevel: ['1'],
    drillDownFilters: ['Clinton'],
};
```

Examples with real data:

- [chart](https://datalens.yandex-team.ru/editor/n90lgbdq1hvmh).
- [table](https://datalens.yandex-team.ru/editor/2of13fiyiz6ww).

To enable drilldown, when clicking on the table row, in the cell object, specify the  `drillDownFilterValue` property. After this, when clicking on the row, you'll be navigated to the next drilldown level, and the value from `drillDownFilterValue` will be inserted into filters (see the [example](https://datalens.yandex-team.ru/editor/e0rfb29k8ip48-table-with-drill-click-new)).

In charts, drilldown on click is enabled immediately when you set up breadcrumbs. To use a filter value different from the chart value at this point, define the property `drillDownFilterValue` at the data level (see the [example](https://datalens.yandex-team.ru/editor/6sjbkxugou9g0)).
