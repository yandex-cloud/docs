# Статистика

**Интерфейс**: [`https://stat.yandex-team.ru`](https://stat.yandex-team.ru)

**Префикс**: `/_stat` -> `https://api.stat.yandex-team.ru`

**Оглавление**:
* [Отчеты](#reports)
* [Геоданные](#geo-data)
* [Словари](#dictionaries)
* [Значения дименшенов](#dimension-values)

**Дополнительная информация**:
* [Доступные параметры](https://wiki.yandex-team.ru/statbox/statface/graphics/)
* [Описание дерева](https://wiki.yandex-team.ru/statbox/statface/reportdata/#podrobnoeopisanierabotysderevjami)
* [Документация по отчетам](https://doc.yandex-team.ru/stat/report-overview/concepts/about.html)

---

## Отчеты {#reports}

### Формирование источника данных {#reports-forming-data-source}

Для формирования источника данных используется метод `buildReportSource` модуля `libs/stat/v1`.
Метод `buildReportSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|beta|`boolean`|Источник stat-beta|false
|report|`string`|Имя отчета|Обязательное
|scale|`string`|Скейл|`d`
|period|`number`|Период|30
|region|`string`|Регион|`TOT`
|date_min|`string`|Начало периода в формате `YYYY-MM-DD hh:mm:ss`|`null`
|date_max|`string`|Конец периода в формате `YYYY-MM-DD hh:mm:ss`|`null`
|fields|`string` `string[]`|Поля из отчета|`null` (возвращается только поле с датой fielddate__ms)
|tree|`object` `object[]`|Описания деревьев|`null`
|where|`object`|Дополнительные условия|`null`

Описание дерева состоит из следующих свойств:

|Имя|Тип|Описание|По умолчанию
|:---|:---|:---|:---
|name|`string`|Имя древовидного поля|`null`
|path|`string[]` `number[]`|Путь|`null`
|level|`number`|Уровень|1

#### Пример {#reports-forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Stat = require('libs/stat/v1');

// формируем источник данных
const statReportSource = Stat.buildReportSource({
    report: 'Multiproject/Totals/Geography',
    scale: 'd',
    period: 30,
    fields: ['old_visitors_all', 'old_visitors_hits_all'],
    dict_fields: 'geoid',
    tree: {
        name: 'geoid',
        path: [10000, 225, 3, 1, 213],
        level: 1
    },
    // для случая нескольких деревьев
    /*
    tree:  [{
        name: 'geoid',
        path: [10000, 225, 3, 1, 213],
        level: 1
    }, {
        ...
    }]
    */
    where: {
        geoid__mode: 'leaf',
        projectid: 'Yandex'
    }
});

// экспортируем источник данных
module.exports = {
    statReportSource: statReportSource
};
```

### Примеры {#reports-examples}

[График по данным отчета Статистики](https://charts.yandex-team.ru/editor/Templates/simple-stat-report)

---

## Геоданные {#geo-data}

Для формирования источника данных используется метод `buildGeoSource` модуля `libs/stat/v1`.
Метод `buildGeoSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|beta|`boolean`|Источник stat-beta|false
|report|`string`|Имя отчета|Обязательное
|map|`object`|Данные карты (`libs/maps/*`)|Обязательное
|fields|`string` `string[]`|Поля из отчета|`null` (возвращаются все поля из отчета)
|scale|`string`|Скейл|`d`
|fielddate|`string`|Дата (`YYYY-MM-DD hh:mm:ss`)|Сегодня

#### Пример {#geo-data-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Stat = require('libs/stat/v1');

// подключаем модуль карты
const mapDataRu = require('libs/maps/ru/v1');

// формируем источник данных
const statGeoSource = Stat.buildGeoSource({
    report: '/Morda/Totals/Geography',
    map: mapDataRu,
    scale: 'd',
    fielddate: '2018-01-01',
    fields: 'old_visitors_all',
});

// экспортируем источник данных
module.exports = {
    statGeoSource: statGeoSource
};
```

### Примеры {#geo-data-examples}

[Всего уточненных посетителей морды за вчера по России](https://charts.yandex-team.ru/editor/Templates/simple-stat-geo)

---

## Словари {#dictionaries}

Для формирования источника данных используется метод `buildDictSource` модуля `libs/stat/v1`.
Метод `buildDictSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|beta|`boolean`|Источник stat-beta|false
|name|`string`|Имя словаря|Обязательное
|language|`string`|Язык|`null`
|keys|`string` `string[]`|Ключи из словаря|`null` (возвращаются все ключи и значения)

#### Пример {#dictionaries-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Stat = require('libs/stat/v1');

// формируем источник данных
const statDictSource = Stat.buildDictSource({
    name: 'edge_search_metrics',
    language: 'RU',
    keys: ['mode_switched', 'click_rate', 'abc']
});

// экспортируем источник данных
module.exports = {
    statDictSource: statDictSource
};
```

## Значения дименшенов {#dimension-values}

Для формирования источника данных для запроса значения конкретного
дименшена используется метод `buildDimensionValues` модуля `libs/stat/v1`.

Метод `buildDimensionValues` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|beta|`boolean`|Источник stat-beta|false
|report|`string`|Путь к отчёту|Обязательное
|dimension|`string`|id дименшена|Обязательное
|apply_dictionary|`bool`|Наложение словарей|Опциональное

#### Пример {#dimension-values-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Stat = require('libs/stat/v1');

// формируем источник данных
const statDimensionValuesSource = Stat.buildDimensionValues({
    report: 'Morda/Totals/Totals',
    dimension: 'project'
})
// ^ Примерный URL: https://stat.yandex-team.ru/_api/report/distincts/Morda/Totals/Totals?dim=project
// Структура данных: ["Value1", "Value2", ...]

// экспортируем источник данных
module.exports = {
    statDimensionValuesSource: statDimensionValuesSource
};
```

#### Наложение словарей {#dictionary-overlay}

Управляется флагом `apply_dictionary`.

Пример URL: https://stat-beta.yandex-team.ru/_api/report/distincts/Adhoc/hhell/tst/dimdicts?dim=case&_apply_dictionary=1

Структура данных: `[["value1", "title1"], ["value2"], ["value3", "title3"], ...]`.

Пример составления селектора (вкладка **Controls**):

```js
const items = ChartEditor.getLoadedData().statDimensionValuesSource;

module.exports = [
    {
        type: 'select', width: '100%', updateOnChange: true,
        param: 'case', label: 'Case',
        content: items.map(value => ({
            title: value[1] || value[0],
            value: value[0]
        }))
    }
];
```
