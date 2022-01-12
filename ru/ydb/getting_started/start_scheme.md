---
sourcePath: overlay/getting_started/start_scheme.md
---
# Работа со схемой

В этом разделе описана работа со схемой YDB при помощи языка [YQL](https://yql.yandex-team.ru/docs/ydb/). Вы узнаете как создавать и модифицировать таблицы в базе данных, а также как работать с директориями. Так как этот раздел является введением в использование языка [YQL](https://yql.yandex-team.ru/docs/ydb/), в нем используются только базовые конструкции и малая часть параметров.

YQL запросы могут быть отправлены для выполнения в YDB следующими способами:

* из приложения, написанного с использованием YDB SDK для [C++](start_cpp.md), [Java](start_java.md), [Python](start_python.md);
* при помощи [YQL](https://yql.yandex-team.ru/) интерфейса;
* с помощью встроенного в [веб-интерфейс](https://ydb.yandex-team.ru) YQL Kit.

Для выполнения инструкций языка YQL в этом разделе будет использоваться встроенный в [веб-интерфейс](https://ydb.yandex-team.ru) YQL Kit.

![Open YQL Kit](../_assets/db_ui_open_yql_kit.png)

{% note info "Руководство" %}

Руководство по работе со схемой YDB при помощи [YQL](https://yql.yandex-team.ru/docs/ydb/) можно пройти в веб-интерфейсе [https://yql.yandex-team.ru/Tutorial/](https://yql.yandex-team.ru/Tutorial/ydb_01_Create_demo_tables).

{% endnote %}

## Предварительные требования
Для выполнения запросов из этого раздела понадобится база данных. Подробно о создании и управлении базой данных написано в разделе ["Базы данных — создание и управление"](create_manage_database.md).

## Создание таблицы

Чтобы создать таблицу, нужно указать имя таблицы, имена и типы данных для каждого столбца таблицы и перечислить столбцы, формирующие первичный ключ. Первичный ключ в таблицах YDB является обязательным. Каждый столбец в YDB может содержать значение NULL. При попытке создать таблицу с уже существующим именем, не будет произведено никакого действия.

{% note info "Модель данных, схема и типы данных" %}

Подробнее о модели данных и схему YDB написано в разделе [Модель данных и схема](../concepts/datamodel.md).<br>Список типов данных и ссылки на их описание см. в разделе [Типы данных](http://yql.yandex-team.ru/docs/ydb/types).

{% endnote %}

В окне редактора запросов введите и выполните следующий код, чтобы создать простую таблицу series. Столбцы таблицы имеют имена series_id, title, series_info и release_date.  Столбец series_id является первичным ключом таблицы. Таблицы seasons и episodes, представленные в примере ниже, описываются аналогичным образом.

<small>Листинг 1</small>

```sql
CREATE TABLE series (
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    PRIMARY KEY (series_id)
);

CREATE TABLE seasons (
    series_id Uint64,
    season_id Uint64,
    title Utf8,
    first_aired Uint64,
    last_aired Uint64,
    PRIMARY KEY (series_id, season_id)
);

CREATE TABLE episodes (
    series_id Uint64,
    season_id Uint64,
    episode_id Uint64,
    title Utf8,
    air_date Uint64,
    PRIMARY KEY (series_id, season_id, episode_id)
);
```

С помощью [web-интерфейса YDB](https://ydb.yandex-team.ru) можно убедиться, что таблицы были созданы.

![Create table](../_assets/ydb_example_create_table_full.png)


### Просмотр информации о таблице

Просмотр информации о таблице в текущей версии возможен только через SDK и [YDB CLI](../getting_started/ydb_cli.md).

Самым простым и быстрым способом является CLI (команда ```scheme describe```).  Но для автоматизации процессов лучше использовать SDK.

## YQL

Описание всех возможностей работы с таблицами приведены в разделах документаци по YQL:
- [`CREATE TABLE`](http://yql.yandex-team.ru/docs/ydb/syntax/create_table) - создание таблицы и определение начальных параметров
- [`ALTER TABLE`](http://yql.yandex-team.ru/docs/ydb/syntax/alter_table) - изменение параметров
- [`DROP TABLE`](http://yql.yandex-team.ru/docs/ydb/syntax/drop_table) - удаление таблицы

### Работа с директориями

Создание и удаление директорий в текущей версии возможно только через SDK и [YDB CLI](../getting_started/ydb_cli.md). SDK предоставляет методы создания, удаления, листинга и просмотра информации о директории. В таблице 2 приведены имена методов в SDK для [С++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/client/ydb_scheme.h), [Java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/table/src/SchemeClient.java) и [Python](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/client/scheme.py).

<small>Таблица 2 — имена методов для работы с директориями в SDK</small>

| Метод    | С++ | Java | Python |
| :--- |:---| :--- | :--- |
| Создание директории | ```TClient::MakeDirectory``` | ```SchemeClient.makeDirectory``` | ```scheme_client.make_directory``` |
| Удаление директории | ```TClient::RemoveDirectory``` | ```SchemeClient.removeDirectory``` | ```scheme_client.remove_directory``` |
| Просмотр информации о директории  | ```TClient::DescribePath``` | ```SchemeClient.describePath``` | ```scheme_client.describe_path``` |
| Листинг директории  | ```TClient::ListDirectory``` | ```SchemeClient.listDirectory``` | ```scheme_client.list_directory``` |
