---
title: График (Gravity UI Charts) в Editor
description: Из статьи вы узнаете, что такое график (Gravity UI Charts) в Editor.
---

# График (Gravity UI Charts)

{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Этот тип чарта служит для отрисовки различных типов графиков с помощью библиотеки [@gravity-ui/charts](https://github.com/gravity-ui/charts).

Доступные типы визуализаций перечислены в [документации](https://gravity-ui.github.io/charts/pages/overview.html).

В данный момент библиотека находится в альфа-версии.


## Структура на вкладке Prepare {#prepare}

На этой вкладке описывается конфиг чарта, который описывает параметры компонента библиотеки.

Пример конфига для простой круговой диаграммы:

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

Все доступные поля конфига смотрите в [документации](https://gravity-ui.github.io/charts/pages/api/Configuration/interfaces/ChartData.html).

## Структура на вкладке Config {#config}

Вкладка **Config** описывает структуру данных для дополнительных возможностей чарта — например таких, как кросс-фильтрация. Общий формат:

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

## Примеры {#gravity-charts-examples}

* [Столбчатая диаграмма](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Столбчатая%20диаграмма)
* [Линейчатая диаграмма](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Линейчатая%20диаграмма)
* [Линейная диаграмма](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Линейная%20диаграмма)
* [Диаграмма с областями](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Диаграмма%20с%20областями)
* [Круговая диаграмма](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Круговая%20диаграмма)
* [Кольцевая диаграмма](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Кольцевая%20диаграмма)
* [Точечная диаграмма](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Точечная%20диаграмма)
* [Древовидная диаграмма](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Древовидная%20диаграмма)
* [Каскадная диаграмма (Waterfall)](https://datalens.yandex/nvkfwnekf9xy9?tab=Gy9#Каскадная%20диаграмма%20(Waterfall))