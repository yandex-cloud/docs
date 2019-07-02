# Применение вторичных индексов

{% if audience == "internal" %}

В разделе приведены рекомендации по созданию вторичных индексов и представлен пример их реализации на [Java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples/secondary_index) и [Python](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/secondary_index).

{% else if audience == "external" %}

В разделе приведены рекомендации по созданию вторичных индексов.

{% endif %}

### Описание задачи {#task}

В разделе [Основные понятия / Вторичные индексы](../concepts/secondary_indexes.md) кратко описан подход, позволяющий реализовать в {{ ydb-short-name }} вторичные индексы на уровне приложения. Рассмотрим, как данный подход позволит повысить эффективность вывода списка из N сериалов, отсортированных в обратном порядке по количеству просмотров.

### Схема данных {#schema}

В примере используется схема данных, описанная в документе [Начало работы / Чтение и запись данных](../getting_started/crud.md).
Чтобы хранить количество просмотров, в таблицу  ```series``` для каждого сериала добавлено поле ```views``` типа ```Uint64```.

Запрос на создание таблицы ```series```:

```
CREATE TABLE series
(
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    views Uint64,
    PRIMARY KEY (series_id)
);
```

Таблица ```series``` имеет ключевую колонку ```series_id```. Индекс по первичному ключу в {{ ydb-short-name }} создаётся автоматически и данные хранятся отсортированными по возрастанию значений первичного ключа, поэтому выборки по такому ключу будут эффективны. Пример такой выборки — поиск всех выпусков сериала по его ```series_id``` из таблицы ```series```.

Если выбирать с условиями по полям, которые не входят в состав первичного ключа, например по полю ```views```, такой запрос будет работать менее эффективно, потому что системе придется просканировать все строки таблицы для поиска. Чтобы сделать этот запрос более эффективным, следует построить индекс по полю ```views```.

Для хранения индекса по полю "количество просмотров" следует создать таблицу ```series_rev_views``` из двух полей ```rev_views``` и ```series_id```. Поле ```series_id``` таблицы ```series_rev_views``` ссылается на поле ```series_id``` таблицы ```series```.

Запрос на создание таблицы ```series_rev_views```:
```
CREATE TABLE series_rev_views
(
    rev_views Uint64,
    series_id Uint64,
    PRIMARY KEY (rev_views, series_id)
);
```

По первичному ключу данной таблицы автоматически будет построен индекс, который позволит эффективно искать по значению ключа ```rev_views, series_id```.

### Вставка данных {#insert-data}

Для сортировки в обратном порядке приходится рассчитывать значение поля ```rev_views``` в индексной таблице как разность между максимальным значением ```Uint64``` и количеством просмотров. Второй способ получить обратную сортировку — использовать знаковый тип данных ```Int64``` и умножить значение на -1.

Чтобы индекс и данные были консистентны, вставки в ```series``` осуществляются в транзакции, в которой выполняется ```INSERT``` строки в ```series``` и ```UPSERT``` строки в таблицу индекса ```series_rev_views```. Выбор в пользу ```UPSERT``` во втором случае был сделан потому, что эта операция не требует чтения, в отличии от ```INSERT```. Защиту от случайной перезаписи данных по существующему ключу обеспечивает предыдущий ```INSERT``` в ```series```, неуспех которого приведёт к откату всей транзакции.

{% note info %}

В примерах YQL-запросов используются prepared queries. Чтобы попробовать выполнить их в YQL-редакторе, нужно определить значения параметров, объявленных в верхней части запроса с помощью оператора ```DECLARE```.

{% endnote %}

Пример транзакции вставки в основную и индексную таблицы:

```
DECLARE $seriesId AS Uint64;
DECLARE $title AS Utf8;
DECLARE $seriesInfo AS Utf8;
DECLARE $releaseDate AS Uint32;
DECLARE $views AS Uint64;

-- Simulate a DESC index by inverting views using max(uint64)-views
$maxUint64 = 0xffffffffffffffff;
$revViews = $maxUint64 - $views;

INSERT INTO series (series_id, title, series_info, release_date, views)
VALUES ($seriesId, $title, $seriesInfo, $releaseDate, $views);

-- Insert above already verified series_id is unique, so it is safe to use upsert
UPSERT INTO series_rev_views (rev_views, series_id)
VALUES ($revViews, $seriesId);
```

Сохранить в базе увеличение количества просмотров для определённого сериала можно одной операцией ```UPSERT``` в таблицу  ```series```. Для поддержания вторичного индекса  в консистентном состоянии в той же самой транзакции выполняется удаление и ```UPSERT``` для индексной таблицы ```series_rev_views```. В данной ситуации нет возможности обойтись только ```UPSERT``` или ```UPDATE```, потому что в состав первичного ключа входит количество просмотров, которое требуется увеличить. Изменить значение первичного ключа для строки в таблице {{ ydb-short-name }} невозможно.

Пример транзакции увеличения количества просмотров и обновления индекса:

```
DECLARE $seriesId AS Uint64;
DECLARE $newViews AS Uint64;

$maxUint64 = 0xffffffffffffffff;
$newRevViews = $maxUint64 - $newViews;

$data = (
    SELECT series_id, ($maxUint64 - views) AS old_rev_views
    FROM series
    WHERE series_id = $seriesId
);

UPSERT INTO series
SELECT series_id, $newViews AS views FROM $data;

DELETE FROM series_rev_views
ON SELECT old_rev_views AS rev_views, series_id FROM $data;

UPSERT INTO series_rev_views
SELECT $newRevViews AS rev_views, series_id FROM $data;

SELECT COUNT(*) AS cnt FROM $data;
```

При удалении записи из таблицы ```series``` в рамках одной транзакции выполняется удаление соответствующей записи из индексной таблицы ```series_rev_views```.

Пример транзакции удаления записи о сериалах и актуализации индекса:

```
DECLARE $seriesId AS Uint64;

$maxUint64 = 0xffffffffffffffff;

$data = (
    SELECT series_id, ($maxUint64 - views) AS rev_views
    FROM [series]
    WHERE series_id = $seriesId
);

DELETE FROM series
ON SELECT series_id FROM $data;

DELETE FROM series_rev_views
ON SELECT rev_views, series_id FROM $data;

SELECT COUNT(*) AS cnt FROM $data;
```

### Выборка данных {#select-data}

Без использования вторичных индексов на уровне приложения запрос на выборку ```$limit``` записей, отсортированных по убыванию количества просмотров, будет работать неэффективно, так как для его выполнения {{ ydb-short-name }} просканирует все строки таблицы ```series```.

Запрос на выборку ```$limit``` строк из таблицы ```series``` с сортировкой по убыванию количества просмотров:

```
DECLARE $limit AS Uint64;

SELECT series_id, title, series_info, release_date, views
FROM series
ORDER BY views DESC
LIMIT $limit;

```

Построить список из ```$limit``` самых просматривыемых сериалов с использованием индексной таблицы можно, соединив с помощью ```JOIN``` по ```series_id``` результаты выборки из ```series``` по ```series_id``` с результатом выборки ```$limit``` первых записей из индексной таблицы ```series_rev_views```, отсортированных по значениям первичного ключа.

Запрос на выборку данных из таблицы ```series``` с сортировкой по убыванию количества просмотров:

```
DECLARE $limit AS Uint64;

$filter = (
    SELECT rev_views, series_id
    FROM series_rev_views
    ORDER BY rev_views, series_id
    LIMIT $limit
);

SELECT t2.series_id AS series_id, title, series_info, release_date, views
FROM $filter AS t1
INNER JOIN series AS t2 USING (series_id)
ORDER BY views DESC, series_id ASC;
```

В отличие от транзакций с одним шардом, использование распределённых транзакций требует больше ресурсов и занимает больше времени. Вторичные индексы на уровне приложения основаны на изменении и чтении данных с использованием распределённых транзакций. Данные, необходимые для ответа на запрос, нужно искать минимум в двух разных шардах. При обработке запросов на изменение — сохранить в два шарда. В то время как точечные чтения и записи могут выполняться за времена до 10 мс в 99-ом персентиле, распределённые транзакции как правило занимают от 20 до 500 мс.

{% note alert %}

Полный просмотр таблицы может быть невозможен из-за внутренних ограничений: размер ответа клиенту не может превышать 50 МБ, размер данных, извлекаемых из одного шарда таблицы в одном YQL-запросе не может превышать 5 ГБ. Для больших таблиц и запросов эти ограничения могут сделать невозможным полный просмотр всех строк таблицы.

{% endnote %}
