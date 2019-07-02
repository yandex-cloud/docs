# Создание схемы

## Предварительные требования {#prerequisite}

Для создания схемы вам понадобится база данных. Подробнее о том, как создать базу данных, читайте в разделе [Управление базами данных](create_manage_database.md).

## Как создать таблицу {#create-table}

Чтобы создать таблицу, нужно указать имя таблицы, имена и типы данных для каждой колонки и перечислить колонки, формирующие первичный ключ. Первичный ключ в таблицах YDB является обязательным. Каждая колонка в YDB может содержать значение NULL. При попытке создать таблицу с уже существующим именем, не будет произведено никакого действия.

{% note info %}

Подробнее про модель данных и схему YDB читайте в разделе [Модель данных и схема](../concepts/datamodel.md).<br>Про поддерживаемые типы данных читайте в разделе [Типы данных](../concepts/datatypes.md).

{% endnote %}

CREATE TABLE создает таблицу с указанными параметрами.

```yql
CREATE TABLE series
(
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    PRIMARY KEY (series_id)
);

CREATE TABLE seasons
(
    series_id Uint64,
    season_id Uint64,
    title Utf8,
    first_aired Uint64,
    last_aired Uint64,
    PRIMARY KEY (series_id, season_id)
);

CREATE TABLE episodes
(
    series_id Uint64,
    season_id Uint64,
    episode_id Uint64,
    title Utf8,
    air_date Uint64,
    PRIMARY KEY (series_id, season_id, episode_id)
);
```

В результате будет создана простая таблица *series* с колонками *series_id*, *title*, *series_info* и *release_date*. Колонка *series_id* является первичным ключом таблицы. Таблицы *seasons* и *episodes* описываются аналогичным образом.

{% if audience == "internal" %}

В [консоли управления](https://ydb.yandex-team.ru) можно убедиться, что таблицы были созданы.

![Create table](../_assets/ydb_example_create_table_full.png)

{% endif %}

## Как изменить структуру таблицы {#alter-table}

{{ ydb-short-name }} позволяет добавлять и удалять неключевые колонки в таблицу.

ADD COLUMN добавляет колонку с указанными именем и типом. Приведенный ниже код добавит к таблице *episodes* колонку ```is_deleted``` с типом данных ```Bool```.

```yql
ALTER TABLE episodes ADD COLUMN is_deleted Bool;
```

DROP COLUMN удаляет колонку с указанными именем. Приведенный ниже код удалит колонку ```is_deleted``` из таблицы *episodes*.

```yql
ALTER TABLE episodes DROP column is_deleted;
```

## Как удалить таблицу {#drop-table}

DROP TABLE удаляет указанную таблицу. Если таблицы с таким именем не существует, возвращается ошибка. Приведенный ниже код вернет ошибку ```Table not found```, так как мы не создавали таблицу *actors*.

```yql
DROP TABLE actors;
```

## Работа с директориями {#directories}

Создание и удаление директорий в текущей версии возможно только через SDK. SDK предоставляет методы создания, удаления, листинга и просмотра информации о директории.

{% if audience == "internal" %}

В таблице ниже приведены имена методов в SDK для [С++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/client/ydb_scheme.h), [Java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/table/src/SchemeClient.java), [Python](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/client/scheme.py) и [Go](https://godoc.yandex-team.ru/pkg/a.yandex-team.ru/kikimr/public/sdk/go/ydb/scheme/).

{% else if audience == external %}

В таблице ниже приведены имена методов в SDK для Java, [Python](https://github.com/yandex-cloud/ydb-python-sdk) и [Go](https://github.com/yandex-cloud/ydb-go-sdk).

{% endif %}

{% if audience == "internal" %}

| Метод    | С++ | Java | Python | Go |
| ---- | ---- | ---- | ---- | ---- |
| Создание директории | ```TClient::MakeDirectory``` | ```SchemeClient.makeDirectory``` | ```scheme_client.make_directory``` | ```Client.MakeDirectory``` |
| Удаление директории | ```TClient::RemoveDirectory``` | ```SchemeClient.removeDirectory``` | ```scheme_client.remove_directory``` | ```Client.RemoveDirectory``` |
| Просмотр информации о директории  | ```TClient::DescribePath``` | ```SchemeClient.describePath``` | ```SchemeClient.describeDirectory``` |  ```Client.DescribePath``` |
| Листинг директории  | ```TClient::ListDirectory``` | ```scheme_client.describe_path``` | ```SchemeClient.list_directory``` | ```Client.ListDirectory``` |

 {% else if audience == "external" %}

 | Метод    | Java | Python |  Go |
 | ---- | ---- | ---- | ---- | ---- |
 | Создание директории | ```SchemeClient.makeDirectory``` | ```scheme_client.make_directory``` | ```Client.MakeDirectory``` |
 | Удаление директории | ```SchemeClient.removeDirectory``` | ```scheme_client.remove_directory``` | ```Client.RemoveDirectory``` |
 | Просмотр информации о директории  | ```SchemeClient.describePath``` | ```SchemeClient.describeDirectory``` | ```Client.DescribePath``` |
 | Листинг директории  | ```scheme_client.describe_path``` | ```SchemeClient.list_directory``` | ```Client.ListDirectory``` |

 {% endif %}