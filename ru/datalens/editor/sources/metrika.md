
# Метрика

**Интерфейс**: [`https://metrika.yandex.ru`](https://metrika.yandex.ru)

**Префикс**: `/_metrika` -> `https://metrika.yandex.ru`

**Оглавление**:
* [Метрика](#metrica-source)
* [Мета-информация](#meta-info)

---

## Метрика {#metrica-source}

### Формирование источника данных {#metrica-source-forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/metrika/v1`.
Метод `buildSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|ids|`number` `number[]`|Идентификатор(ы) метрик|Обязательное
|metrics|`string` `string[]`|Имя (имена) метрик|Обязательное
|dimensions|`string` `string[]`|Имя (имена) группировок|`null`
|filters|`string` `string[]`|Фильтр сегментации|`null`
|sort|`string` `string[]`|Имена группировок и метрик, по которым будет сортировка|`null`
|date1|`string`|Начало периода (`YYYY-MM-DD`)|Неделю назад
|date2|`string`|Конец периода (`YYYY-MM-DD`)|Сегодня
|cache|`number`|Время кэширования ответа (в секундах)|0
|accuracy|`number` `string`|Точность вычисления результата (от 0 до 1 или `low`, `medium`, `high`, `full`)|`medium`
|limit|`number`|Ограничения количества данных|100
|where|`object`|Дополнительные параметры|`null`

#### Пример {#metrica-source-forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Metrika = require('libs/metrika/v1');

// формируем источник данных
const metrikaSource = Metrika.buildSource({
    ids: 44147844,
    date1: '2018-01-01',
    date2: '2018-02-01',
    metrics: 'ym:s:users',
    dimensions: 'ym:s:date',
    accuracy: 'full',
    filters: 'ym:s:pageViews>5',
    sort: 'ym:s:date',
    limit: 30,
    cache: 300
});

// экспортируем источники
module.exports = {
    metrikaSource: metrikaSource,
};
```

### Примеры {#metrica-source-examples}

[График по данным из Метрики](https://charts.yandex-team.ru/editor/Templates/simple-metrika)

---

## Мета-информация {#meta-info}

### Формирование источника данных {#meta-info-forming-data-source}

Для формирования источника мета-информации используется метод `buildMetaSource` модуля `libs/metrika/v1`.
Метод `buildMetaSource` принимает идентификатор счетчика в качестве аргумента.

#### Пример {#meta-info-forming-data-source-examples}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Metrika = require('libs/metrika/v1');

// формируем источник мета-информации
const metrikaMetaSource = Metrika.buildMetaSource(44147844);

// экспортируем источники
module.exports = {
    metrikaMetaSource: metrikaMetaSource
};
```
