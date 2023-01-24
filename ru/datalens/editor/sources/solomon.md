
# Соломон

**Интерфейс**: [`https://solomon.yandex-team.ru`](https://solomon.yandex-team.ru)

**Префикс**: `/_solomon` -> `http://api.solomon.search.yandex.net`

---

## Интеграция {#integration}

С сервисом есть более тесная интеграция.
На странице с графиком есть кнопка **Share**, которая открывает форму для экспорта графика.
По кнопке **Export to Charts** вас перенаправит на график в Yandex Charts.
Если этой кнопки нет, значит параметр `graph` не равен `Auto` и это преднастроенный/конфигурируемый график.
Такой график напрямую без дополнительных преобразований отобразить в Charts не получится,
т.к. часть настроек хранится в Соломон и они недоступны извне.

---

## Формирование источника данных {#forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/solomon/v1`.
Метод `buildSource` принимает два аргумент: `object` с параметрами и `object` с лейблами.

* Параметры

  |Имя|Тип|Описание|По умолчанию
  |:---|:---|:---|:---
  |b|`string`|Начало периода (`YYYY-MM-DD HH:mm:ss` или `-30d`, ...)|24 часа назад
  |e|`string`|Конец периода (`YYYY-MM-DD HH:mm:ss` или `-30d`, ...)|Сейчас

* Общие лейблы

  |Имя|Тип|Описание|Обязательное
  |:---|:---|:---|:---
  |project|`string`|Имя проекта|Обязательное (?)
  |cluster|`string`|Имя кластера|Обязательное (?)
  |service|`string` `string[]`|Имя сервиса|Обязательное (?)

### Пример {#forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Solomon = require('libs/solomon/v1');

// перечисляем все лейблы из графика в Соломоне
// graph не является лейблом, и писать {graph: 'auto'} не нужно
const labels = {
    project: 'solomon',
    cluster: 'kikimr_solomon_stp_man',
    service: 'frontend',
    host: 'cluster',
    path: '/MemoryInfo/GCInfo/Count',
    garbadge_collector: '*'
};

// в параметрах можно указать начало и конец периода
// при текущих настройках на графике показывается последний день
const params = {
    b: '1d',
    e: ''
};

// формируем источник данных
const solomonSource = Solomon.buildSource(params, labels);

// экспортируем источник данных
module.exports = {
    solomonSource: solomonSource
};
```

## Работа с данными из источника {#work-with-data-source}

Метод `prepareGraph` модуля `libs/solomon/v1` используется для формирования данных для отрисовки и в качестве
аргументов принимает сенсоры (`sensors`) полученные от источника и `object` со следующими свойствами:

|Имя|Тип|Описание|По умолчанию
|:---|:---|:---|:---
|titleLabel|`string|string[]`|Лейбл(ы), по которому строятся категории|???

### Пример {#work-with-data-source-example}

Вкладка **JavaScript**
```js
// подключаем модуль источника данных
const Solomon = require('libs/solomon/v1');

// запрашиваем загруженные данные
const loadedData = ChartEditor.getLoadedData();

// достаем поля из загруженных данных
const sensors = loadedData.solomonSource.sensors;

// формируем данные для отрисовки
const graph = Solomon.prepareGraph(
    sensors,
    // в переменной titleLabel нужно указать лейбл, по которым строятся категории
    // в данном случае это garbage_collector
    {titleLabel: 'garbadge_collector'}
    // {titleLabel: ['garbadge_collector', 'path']}
);

// экспортируем данные для отрисовки
module.exports = graph;
```

## Примеры {#examples}

[График по данным из Соломона](https://charts.yandex-team.ru/editor/Templates/simple-solomon)
