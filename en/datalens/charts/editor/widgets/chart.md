---
title: Chart (Gravity UI Charts) in Editor
description: In this article, you will learn about charts (Gravity UI Charts) in Editor.
---

# Chart (Gravity UI Charts)


{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}


You can use this chart type to render various charts with the [@gravity-ui/charts](https://github.com/gravity-ui/charts) library.

For available types of visualizations, see the [library overview](https://gravity-ui.github.io/charts/pages/overview.html).

The library is currently in alpha.


## Structure on the Prepare tab {#prepare}

This tab describes chart configuration with library component properties.

Configuration example for a simple pie chart:

```js
// an example of a simple pie chart
module.exports = {
    series: {
        data: [{
		    type: 'pie', 
            data: [{
        	    name: 'Apple',
        	    value: 70,
    		}, {
        	    name: 'Cherry',
        	    value: 30,
    	    }],
        }],
    },
    legend: {enabled: true},
    title: {
        text: 'SeriesName',
        style: {fontSize: '12px', fontWeight: 'normal'},
    },
}
```

For available configuration fields, see the [developer documentation](https://gravity-ui.github.io/charts/pages/api/Configuration/interfaces/ChartData.html).

## Structure on the Config tab {#config}

The **Config** tab describes the data structure for additional chart features, e.g., cross-filtering. Common format:

```js
module.exports = {
    drilldown: {
        breadcrumbs: [],
    },
    events: {
        click: [{handler: {type: 'setActionParams'}, scope: 'point'}],
    },
}
```

## Examples {#gravity-charts-examples}

* [Column chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Столбчатая%20диаграмма)
* [Bar chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Линейчатая%20диаграмма)
* [Line chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Линейная%20диаграмма)
* [Area chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Диаграмма%20с%20областями)
* [Pie chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Круговая%20диаграмма)
* [Donut chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Кольцевая%20диаграмма)
* [Scatter chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Точечная%20диаграмма)
* [Tree chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Древовидная%20диаграмма)
* [Cascade (waterfall) chart](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Каскадная%20диаграмма%20(Waterfall))