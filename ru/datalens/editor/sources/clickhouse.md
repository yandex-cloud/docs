# ClickHouse

{% note warning %}

Новые прямые подключения из Editor в {{ CH }} не создаются. Используйте стандартные [подключения](connections.md) для работы с источниками из Editor.

{% endnote %}

**Документация**: [`https://{{ ch.docs }}`](https://{{ ch.docs }})

**Префиксы**:
* `/_clickhouse_mtmega` -> `http://mtmega.yandex.ru:8123`
* `/_clickhouse_mtstat` -> `http://mtstat.yandex.ru:8123`
* `/_clickhouse_mtsmart` -> `http://mtsmart.yandex.ru:8123`
* `/_clickhouse_april` -> `http://april-storage01i.yandex.ru:8123`
* `/_clickhouse_zen` -> `http://zclick-f1.kaizen.yandex.net:8123`

---

## Ограничения {#limits}

* Для Charts выделены квоты на всех кластерах ClickHouse.
Они достаточно большие, но просим вас не забывать, что *with great power comes great responsibility*.
* ClickHouse быстрая база данных, но не забывайте контролировать время выполнения графика.
Тяжелый запрос может выполняться минуты и даже часы, что неприемлемо для виджетов.

---

## Формирование источника данных {#forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/clickhouse/v1`.
Метод `buildSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательный / По умолчанию|
|:---|:---|:---|:---|
|cluster|`string`|Имя кластера|Обязательный
|query|`string`|Запрос|Обязательный
|cache|`number`|Время кэширования ответа (в секундах)|0
|method|`string`|Метод HTTP-запроса|`get`

Предпочтительнее использовать `post` запрос, так как `query` может быть очень длинным и это может привести к ошибкам.

### Пример {#forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const ClickHouse = require('libs/clickhouse/v1');

// формируем запрос
const query = `
    SELECT *
    FROM charts.raif_rates
    WHERE currency IN ('USD')
    ORDER BY timestamp LIMIT 1000
`;

// формируем источник данных
const clickHouseSource = ClickHouse.buildSource({
    cluster: 'mtstat',
    query: query,
    cache: 360
});

// экспортируем источник данных
module.exports = {
    clickHouseSource: clickHouseSource
};
```

## Примеры {#examples}

[График по данным из ClickHouse](https://charts.yandex-team.ru/editor/Templates/simple-clickhouse)
