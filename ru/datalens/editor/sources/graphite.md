
# Графит (графана)

**Интерфейс**: [`https://grafana.yandex-team.ru`](https://grafana.yandex-team.ru)

**Префиксы**:
* `/_bs_graphite` -> `https://bs-mg.yandex-team.ru`
* `/_gr_graphite` -> `https://gr-mg.yandex-team.ru`
* `/_ps_graphite` -> `https://ps-mg.yandex-team.ru`

---

## Формирование источника данных {#forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/graphite/v1`.
Метод `buildSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательный / По умолчанию|
|:---|:---|:---|:---|
|prefix|`string`|Префикс источника|Обязательный
|target|`string`|???|Обязательный
|from|`number` `string`|Начало периода (секунды или в виде `-30d`, `now`, ...)|Сегодня
|until|`number` `string`|Конец периода (секунды или в виде `-30d`, `now`, ...)|Сегодня
|maxDataPoints|`number`|Ограничение на количество точек|`null` (без ограничения)

### Пример {#forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Graphite = require('libs/graphite/v1');

// формируем источник данных
const graphiteSource = Graphite.buildSource({
    prefix: 'bs',
    target: "alias(sumSeries(group(alias(sumSeries(one_min.analytics01e_crypta_yandex_net.CRYPTAUP.socdem_training_sample.yandexuids.{Russia}.{tv}.gender.{0,m}.count), 'Male'), alias(sumSeries(one_min.analytics01e_crypta_yandex_net.CRYPTAUP.socdem_training_sample.yandexuids.{Russia}.{tv}.gender.{1,f}.count), 'Female'), alias(sumSeries(one_min.analytics01e_crypta_yandex_net.CRYPTAUP.socdem_training_sample.yandexuids.{Russia}.{tv}.gender.unknown.count), 'Unknown'))), 'count')",            format: 'json',
    from: '1514764800',
    until: 'now',
    maxDataPoints: 180
});

// экспортируем источник данных
module.exports = {
    graphiteSource: graphiteSource
};
```

## Работа с данными из источника {#work-with-data-source}

Метод `prepareGraph` модуля `libs/graphite/v1` принимает в качестве аргумента данные полученные от источника и
преобразовывает их в данные для отрисовки графика.

### Пример {#work-with-data-source-example}

Вкладка **JavaScript**
```js
// подключаем модуль источника данных
const Graphite = require('libs/graphite/v1');

// запрашиваем загруженные данные
const loadedData = ChartEditor.getLoadedData();

// формируем данные для отрисовки
const graph = Graphite.prepareGraph(loadedData.graphiteSource);

// экспортируем данные для отрисовки
module.exports = graph;
```

## Примеры {#examples}

[График по данным из Графана](https://charts.yandex-team.ru/editor/Templates/simple-graphite)
