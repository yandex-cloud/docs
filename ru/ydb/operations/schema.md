# Управление таблицами

Узнайте как создать, отредактировать или удалить таблицу. Для создания таблицы вам понадобится [база данных](create_manage_database#create-db.md).

## Создайте таблицу {#create-table}

Чтобы создать таблицу, укажите:
1. Имя таблицы.
1. Имена и типы данных для каждой колонки.
1. Колонки, формирующие первичный ключ. Первичный ключ в таблицах YDB является обязательным.

Таблицы в {{ ydb-short-name }} имеют следующие характеристики:
* Каждая колонка может содержать значение NULL.
* При попытке создать таблицу с уже существующим именем, не будет произведено никакого действия.
* Первичные индексы строятся по первичному ключу, являются уникальными и создаются автоматически.

Подробнее про модель данных и схему {{ ydb-short-name }} читайте в разделе [Модель данных и схема](../concepts/datamodel.md). Про поддерживаемые типы данных читайте в разделе [Типы данных](../concepts/datatypes.md).

Оператор [CREATE TABLE](../../ydb/yql/reference/syntax/create_table.md) создает таблицу с указанными параметрами:

{% include [create-new-table-3-columns](../../_includes/ydb/queries/create-new-table-3-columns.md) %}

В результате будет создана простая таблица ```series``` с колонками ```series_id```, ```title```, ```series_info``` и ```release_date```. Колонка ```series_id``` является первичным ключом таблицы. Таблицы ```seasons``` и ```episodes``` описываются аналогичным образом.


{% note info %}

Подробнее о том, как добавить вторичные индексы при создании таблицы, читайте в разделе [{#T}](../yql/reference/syntax/create_table.md#si-add).

{% endnote %}

## Измените структуру таблицы {#alter-table}

В {{ ydb-short-name }} можно добавлять неключевые колонки в таблицу.

ADD COLUMN добавляет колонку с указанными именем и типом. Приведенный ниже код добавит к таблице ```episodes``` колонку ```is_deleted``` с типом данных ```Bool```.

```sql
ALTER TABLE episodes ADD COLUMN is_deleted Bool;
```

DROP COLUMN удаляет колонку с указанными именем. Приведенный ниже код удалит колонку ```is_deleted``` из таблицы ```episodes```.

```sql
ALTER TABLE episodes DROP column is_deleted;
```

## Удалите таблицу {#drop-table}

DROP TABLE удаляет указанную таблицу. Если таблицы с таким именем не существует, возвращается ошибка. Приведенный ниже код вернет ошибку ```Table not found```, так как мы не создавали таблицу *actors*.

```sql
DROP TABLE actors;
```

## Создайте и удалите директории {#directories}

Создание и удаление директорий в текущей версии возможно только через SDK. SDK предоставляет методы создания, удаления, листинга и просмотра информации о директории.


В таблице ниже приведены имена методов в SDK для [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk) и [Go](https://github.com/yandex-cloud/ydb-go-sdk).



 | Метод    | Java | Python |  Go |
 | ---- | ---- | ---- | ---- | ---- |
 | Создание директории | ```SchemeClient.makeDirectory``` | ```scheme_client.make_directory``` | ```Client.MakeDirectory``` |
 | Удаление директории | ```SchemeClient.removeDirectory``` | ```scheme_client.remove_directory``` | ```Client.RemoveDirectory``` |
 | Просмотр информации о директории  | ```SchemeClient.describePath``` | ```SchemeClient.describeDirectory``` | ```Client.DescribePath``` |
 | Листинг директории  | ```scheme_client.describe_path``` | ```SchemeClient.list_directory``` | ```Client.ListDirectory``` |

