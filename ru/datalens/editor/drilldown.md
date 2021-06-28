# Дриллдаун

Чтобы включить дриллдаун, на вкладке [config](architecture.md#config-and-highcharts) определите хлебные крошки в следующем формате.

```js
module.exports = {
    drillDown: {
        breadcrumbs: ['City', 'Ship Mode', 'Customer Name']
    }
};
```

Примеры на реальных данных:

- [график](https://datalens.yandex-team.ru/editor/9qahg4cnlu2y3);
- [таблица](https://datalens.yandex-team.ru/editor/s9u6umpgl2zsm).

На вкладке [params](architecture.md#params) можно задать уровень дрилла и фильтры по умолчанию.

```js
module.exports = {
    drillDownLevel: ['1'],
    drillDownFilters: ['Clinton'],
};
```

Примеры на реальных данных:

- [график](https://datalens.yandex-team.ru/editor/n90lgbdq1hvmh);
- [таблица](https://datalens.yandex-team.ru/editor/2of13fiyiz6ww).

Чтобы включить дриллдаун при нажатии на строку таблицы, в объекте ячейки задайте свойство `drillDownFilterValue`. После этого при нажатии на строку будет выполнен переход на следующий уровень дрилла, а в фильтры подставится значение из `drillDownFilterValue` (см. [пример](https://datalens.yandex-team.ru/editor/e0rfb29k8ip48-table-with-drill-click-new)).

В графиках дриллдаун при нажатии работает сразу после определения хлебных крошек. Чтобы в фильтр подставлялось значение, не совпадающее со значением графика в данной точке, определите свойство `drillDownFilterValue` на уровне данных (см. [пример](https://datalens.yandex-team.ru/editor/6sjbkxugou9g0)).
