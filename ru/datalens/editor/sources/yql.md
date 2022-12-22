
# YQL

**Интерфейс**: [`https://yql.yandex-team.ru`](https://yql.yandex-team.ru)

**Префикс**: `/_yql` -> `https://yql.yandex.net`

**Оглавление**:
* [Таблицы](#sheets)
* [Операции](#operations)

## Ограничения {#limits}

* За один запрос не более 1000 записей и 100 кб данных (если нужно больше - делайте несколько запросов или рассмотрите вариант складывать данные в YT и получать их через [{{ CH }} over YT](../../tutorials/data-from-ch-over-yt.md)).
* Все запросы выполняются от имени текущего пользователя, просматривающего чарт

## Таблицы {#sheets}

### Формирование источника данных {#sheets-forming-data-source}

Для формирования источника данных используется метод `buildTableSource` модуля `libs/yql/v1`.
Метод `buildTableSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|cluster|`string`|Имя кластера|Обязательное
|path|`string`|Путь|Обязательное
|offset|`number`|Смещение начала|0
|limit|`number`|Количества записей, которые будут загружены. Если лимит не задан, то сервис (YQL) определяет его сам.|`null`
|infer_scheme|`bool`|Использовать схему по первой строчке таблицы|`false`|
|cache|`number`|Время кэширования ответа (в секундах)|0

Если ваша таблица не имеет схемы, выставьте опцию `infer_scheme = true` и
тогда схема будет автоматически определятся по первой строчке таблицы.

#### Пример {#sheets-forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const YQL = require('libs/yql/v1');

// формируем источник данных
const yqlTableSource = YQL.buildTableSource({
    cluster: 'hahn',
    path: 'home/charts/USNationalDebt',
    offset: 0,
    limit: 10,
    cache: 100000
});

// экспортируем источник данных
module.exports = {
    yqlTableSource: yqlTableSource
};
```

### Работа с данными из источника {#sheets-work-with-data-source}

Метод `prepareTableData` модуля `libs/yql/v1` принимает в качестве аргумента данные полученные от источника и выполняет
предварительную обработку данных.

### Примеры {#sheets-work-with-data-source-examples}

[График по данным из YQL таблицы](https://charts.yandex-team.ru/editor/Templates/simple-yql-table)

---

## Операции {#operations}

### Ограничения {#operations-limits}

Выполненный YQL-запрос - read-only сущность, поэтому данные обновляться не будут никогда.
Если хочется регулярно обновляемых данных, данные надо куда-нибудь выгружать (например, в YT-таблицу),
и указывать источником уже эту выгрузку.

### Формирование источника данных {#operations-forming-data-source}

Для формирования источника данных используется метод `buildOperationSource` модуля `libs/yql/v1`.
Метод `buildOperationSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|operationId|`string`|Идентификатор операции|Обязательное
|cache|`number`|Время кэширования ответа (в секундах)|0

#### Пример {#operations-forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const YQL = require('libs/yql/v1');

// формируем источник данных
const yqlOperationSource = YQL.buildOperationSource({
    operationId: 'Wlc7fSK7Yg2vMq6rar_DrBOjQXg8RZch5sTu-9oU1ZU=',
    cache: 10000
});

// экспортируем источник данных
module.exports = {
    yqlOperationSource: yqlOperationSource
};
```

### Работа с данными из источника {#operations-work-with-data-source}

Метод `prepareOperationData` модуля `libs/yql/v1` принимает в качестве аргумента данные полученные от источника и
выполняет предварительную обработку данных.

## Примеры {#examples}

[График по данным из YQL операции](https://charts.yandex-team.ru/editor/Templates/simple-yql-operation)
