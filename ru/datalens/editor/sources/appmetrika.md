
# Мобильная метрика

**Интерфейс**: [`https://appmetrica.yandex.ru/`](https://appmetrica.yandex.ru/)

**Префикс**: `/_appmetrika` -> `https://beta.api-appmetrika.yandex.ru`

**Оглавление**:
* [Метрика](#appmetrica-source)
* [Мета-информация](#meta-info)

---

## Мобильная метрика {#appmetrica-source}

### Формирование источника данных {#appmetrica-source-forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/appmetrika/v1`.
Метод `buildSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|ids|`number` `number[]`|Идентификатор(ы) метрик|Обязательное
|metrics|`string` `string[]`|Имя (имена) метрик|Обязательное
|dimensions|`string` `string[]`|Имя (имена) группировок|`null`
|filters|`string` `string[]`|Фильтр(ы) сегментации|`null`
|sort|`string` `string[]`|Имена группировок и метрик, по которым будет сортировка|`null`
|date1|`string`|Начало периода (`YYYY-MM-DD`)|Неделю назад
|date2|`string`|Конец периода (`YYYY-MM-DD`)|Сегодня
|cache|`number`|Время кэширования ответа (в секундах)|0
|accuracy|`number` `string`|Точность вычисления результата (от 0 до 1 или `low`, `medium`, `high`, `full`)|`medium`
|limit|`number`|Ограничения количества данных|100
|where|`object`|Дополнительные параметры|`null`

#### Пример {#appmetrica-source-forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const AppMetrika = require('libs/appmetrika/v1');

// формируем источник данных
const appMetrikaSource = AppMetrika.buildSource({
    ids: 1111,
    date1: '2018-01-01',
    date2: '2018-02-01',
    metrics: 'ym:s:users',
    dimensions: 'ym:s:date',
    accuracy: 'full',
    filters: "ym:s:regionCityName=='Санкт-Петербург'",
    sort: 'ym:s:date',
    limit: 30,
    cache: 360
});

// экспортируем источники
module.exports = {
    appMetrikaSource: appMetrikaSource
};
```

### Примеры {#appmetrica-source-forming-data-source-examples}

[График по данным из Мобильной метрики](https://charts.yandex-team.ru/editor/Templates/simple-appmetrika)

---

## Мета-информация {#meta-info}

### Формирование источника данных {#meta-info-forming-data-source}

Для формирования источника мета-информации используется метод `buildMetaSource` модуля `libs/appmetrika/v1`.
Метод `buildMetaSource` принимает идентификатор счетчика в качестве аргумента.

#### Пример {#meta-info-forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const AppMetrika = require('libs/appmetrika/v1');

// формируем источник мета-информации
const appMetrikaMetaSource = AppMetrika.buildMetaSource(1111);

// экспортируем источники
module.exports = {
    appMetrikaMetaSource: appMetrikaMetaSource
};
```
