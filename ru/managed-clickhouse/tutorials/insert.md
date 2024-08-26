---
title: "Как добавить данные в кластер {{ CH }} в {{ mch-full-name }}"
description: "Следуя данной инструкции, вы сможете добавить данные в кластер {{ CH }}."
---

# Добавление данных в {{ CH }}

Для обычной вставки данных в таблицы используйте запрос `INSERT INTO`:

```sql
INSERT INTO db_name.table_name VALUES (v11, v12, v13), (v21, v22, v23), ...
```

Запросы на вставку рекомендуется отправлять не чаще одного раза в секунду. Чтобы объединить мелкие запросы в один большой, используйте [буферизацию](#buffer-insert).

Подробнее о запросе `INSERT INTO` см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/insert-into#insert).

## Вставка данных из файла {#file-insert}

Для вставки данных в таблицу из локального файла используйте запрос `INSERT INTO` вида:

```sql
INSERT INTO db_name.table_name FROM INFILE '<полный_путь_к_файлу>'
[COMPRESSION '<формат_сжатия>'] FORMAT <формат_данных>;
```

Опция `COMPRESSION` позволяет передавать сжатые файлы. Используйте ее, чтобы загружать большие объемы информации. Опция поддерживается при работе через [clickhouse-client]({{ ch.docs }}/interfaces/cli) или [HTTP-интерфейс]({{ ch.docs }}/interfaces/http). Если формат сжатия не указан, то он определяется по расширению файла. Возможные значения формата сжатия: `none`, `gzip`, `deflate`, `br`, `xz`, `zstd`, `lz4`, `bz2`.

Список поддерживаемых форматов данных приведен в [документации {{ CH }}]({{ ch.docs }}/interfaces/formats). О настройке схем форматов данных Cap'n Proto и Protobuf см. в разделе [Управление схемами формата данных](../operations/format-schemas.md).

## Вставка данных с использованием буферизации {#buffer-insert}

При вставке данных в {{ CH }} часть вычислительных ресурсов расходуется на выполнение служебных операций. При выполнении каждого `INSERT`-запроса {{ CH }} создает в хранилище отдельный кусок данных. Помимо строк таблицы такой кусок содержит ряд вспомогательных файлов с метаданными. Затем {{ CH }} объединяет куски данных в фоновом режиме. Чем больше потребуется операций объединения, тем больше будет задействовано ресурсов.

В результате тысяча запросов на вставку одной строки создаст большую нагрузку на кластер, чем один запрос на вставку тысячи строк. Поэтому рекомендуется вставлять данные в таблицу большими порциями — от 1000 до 100 000 строк.

Если данные поступают малыми порциями от разных источников, используйте один из механизмов буферизации:

* (рекомендуется) [асинхронная вставка](#async-insert);
* [буферные таблицы](#buffer-table).

### Асинхронная вставка данных {#async-insert}

Если для пользователя установлена настройка [Async insert](../concepts/settings-list.md#setting-async-insert), то все запросы на вставку от этого пользователя сначала попадают в буфер в оперативной памяти. Данные из буфера сбрасываются в таблицу при выполнении одного из условий:

* Размер буфера достиг значения настройки [Async insert max data size](../concepts/settings-list.md#setting-async-insert-max-data-size).
* С момента первого после сброса данных `INSERT`-запроса прошло время, указанное в настройке [Async insert busy timeout](../concepts/settings-list.md#setting-async-insert-busy-timeout).

Чтобы включить асинхронную вставку данных, [установите значение настройки](../operations/change-query-level-settings.md#yandex-cloud-interfaces) **Async insert** на `1`.

При использовании асинхронных вставок недоступна [дедупликация строк](https://clickhouse.com/docs/en/guides/developer/deduplication).

Подробную информацию об асинхронной вставке данных см. в [документации {{ CH }}](https://clickhouse.com/docs/en/cloud/bestpractices/asynchronous-inserts).

### Вставка данных через буферную таблицу {#buffer-table}

Буферная таблица создается в оперативной памяти, накапливает поступающие в нее данные и сбрасывает их в основную таблицу при выполнении заданных условий.

Для создания буферной таблицы используется табличный движок `Buffer`, который принимает на вход следующие основные параметры:

```text
Buffer(database, table, num_layers, min_time, max_time, min_rows, max_rows, min_bytes, max_bytes)
```

Где:

* `database` — имя БД.
* `table` — имя таблицы, в которую будут сброшены данные.
* `num_layers` — количество буферов. Физически таблица хранится в памяти в виде нескольких независимых буферов.
* `min_time`, `max_time`, `min_rows`, `max_rows`, `min_bytes` и `max_bytes` — параметры, определяющие условия сброса данных в основную таблицу. Время измеряется в секундах.

Сброс данных в основную таблицу происходит при достижении всех минимальных значений, либо хотя бы одного максимального. Если объем поступающей порции данных превышает `max_rows` или `max_bytes`, то данные не попадают в буфер, а записываются напрямую в основную таблицу.

Информацию о дополнительных параметрах движка и ограничениях таблиц на движке `Buffer` см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/special/buffer).

#### Пример {#buffer-table-example}

1. Создайте обычную таблицу `users` в базе данных `db1`:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.users (id UInt64, name String)
    ENGINE = MergeTree() ORDER BY id;
    ```

1. Создайте буферную таблицу `users_buffer`, привязанную к основной таблице `users`:

    ```sql
    CREATE TABLE db1.users_buffer AS db1.users ENGINE = Buffer(db1, users, 1, 10, 100, 10000, 1000000, 10000000, 100000000);
    ```

1. Передайте данные в буферную таблицу:

    ```sql
    INSERT INTO db1.users_buffer VALUES (1, 'Vlad'), (2, 'John'), (3, 'Zara');
    ```

1. Проверьте данные в основной таблице, они появятся через 100 секунд (`max_time`):

    ```sql
    SELECT * FROM db1.users;
    ```

Результат:

```text
┌─id─┬─name─┐
│  1 │ Vlad │
│  2 │ John │
│  3 │ Zara │
└────┴──────┘
```

## Вставка данных с указанием схемы формата данных {#insert-with-format-schema}

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

## Пример работы со схемой формата при вставке данных {#example}

**Пример проверялся в следующем окружении:**
- Виртуальная машина в Облаке с Ubuntu 20.04 LTS.
- Bash: `5.0.16`.
- clickhouse-client: `20.10.2.20`.
- capnproto: `0.7.0`.
- protobuf-compiler: `3.6.1`.
- Python: `3.8.5`; pip3: `20.0.2`.

Допустим, что создан однохостовый кластер {{ mch-name }} `chcluster`с базой данных `db1` и нужно вставить данные о пользователях в таблицу `db1.users`. Пусть каждая запись о пользователе содержит следующую информацию:
- идентификатор пользователя `id`;
- имя пользователя `name`.

Чтобы вставить данные о пользователях в форматах Cap'n Proto и Protobuf в таблицу `db1.users`:
1. [Установите зависимости](#satisfy-dependencies).
1. [Подготовьте схемы формата данных](#prepare-format-schemas).
1. [Подготовьте скрипты](#prepare-scripts).
1. [Вставьте данные](#insert-data).


### Перед началом работы {#before-you-begin}

1. Изучите формат данных, который будет использоваться при вставке, чтобы [подготовить](#prepare-format-schemas) корректные схемы формата.

   В этом сценарии использования для иллюстрации принимается, что:
   - идентификатор пользователя `id` представлен в виде целого беззнакового 64-битного числа (`Uint64` в Cap'n Proto и {{ CH }}, `uint64` в Protobuf);
   - имя пользователя `name` представлено в виде строки (`Text` в Cap'n Proto, `string` в Protobuf, `String` в {{ CH }}).

   Подробнее о поддерживаемых типах данных см. в документации [Cap'n Proto](https://capnproto.org/language.html), [Protobuf](https://developers.google.com/protocol-buffers/docs/proto3) и [{{ CH }}]({{ ch.docs }}/sql-reference/data-types/).

1. [Подключитесь к кластеру](../operations/connect/clients.md) и создайте таблицу `db1.users` нужного вида, если ее еще не существует:

   ```sql
   CREATE TABLE IF NOT EXISTS db1.users (id UInt64, name String)
   ENGINE = MergeTree() ORDER BY id;
   ```


### Установка зависимостей {#satisfy-dependencies}

```bash
sudo apt update && sudo apt install -y python3 python3-pip capnproto protobuf-compiler && \
pip3 install protobuf varint pycapnp
```


### Подготовка схем формата данных {#prepare-format-schemas}

1. Создайте файл с описанием схемы:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     `user.capnp`
     ```capnproto
     @0xbec0f3f99cec4fbf;

     struct User {
       id @0 :UInt64;
       name @1 :Text;
     }
     ```

     Подробнее о формате файла см. в [документации Cap'n Proto](https://capnproto.org/language.html).

   - Protobuf {#protobuf}

     `user.proto`
     ```capnproto
     syntax = "proto3";

     message User {
       uint64 id = 1;
       string name = 2;
     };
     ```

     Подробнее о формате файла см. в [документации Protobuf](https://developers.google.com/protocol-buffers/docs/overview).

   {% endlist %}


1. [Загрузите файл](../../storage/operations/objects/upload.md) в {{ objstorage-name }} и [получите ссылку](../../storage/operations/objects/link-for-download.md) на него.


1. [Подключите схему формата данных](../operations/format-schemas.md#add-format-schema) к кластеру `chcluster`:
   - Для схемы формата данных Cap'n Proto (файл `user.capnp`) задайте имя `schema-capnproto`.
   - Для схемы формата данных Protobuf (файл `user.protobuf`) задайте имя `schema-protobuf`.


### Подготовка скриптов {#prepare-scripts}

Эти Python-скрипты подготавливают тестовые данные о пользователях в нужных форматах и вставляют их в таблицу кластера.

{% note info %}

Скрипты на Python приведены в демонстрационных целях. Вы можете подготовить и вставить бинарные данные в требуемом формате, создав аналогичный скрипт на другом языке программирования.

{% endnote %}

Чтобы подготовить скрипты:
1. Скомпилируйте файл схемы Protobuf `user.proto` для Python:

   ```bash
   protoc user.proto --python_out .
   ```

   Будет сгенерирован файл `user_pb2.py`.

1. Создайте файлы с кодом Python:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     `capnproto-example.py`
     ```python
     import requests
     import io
     import capnp
     from user_capnp import User

     DB_HOST="<FQDN_хоста_{{ CH }}>"
     DB_NAME="db1"
     DB_USER="<имя_пользователя_БД>"
     DB_PASS="<пароль_пользователя_БД>"
     CA_CERT="{{ crt-local-dir }}{{ crt-local-file-root }}"

     SCHEMA_NAME = 'schema-capnproto'
     SCHEMA_TYPE = "CapnProto"
     SCHEMA_CLASS = "User"

     def execute_query(query, data=None):
         url = 'https://{host}:8443/'.format(host=DB_HOST)
         params = {
             'database': DB_NAME,
             'query': query.strip()
         }
         auth = {
             'X-ClickHouse-User': DB_USER,
             'X-ClickHouse-Key': DB_PASS
         }

         rs = requests.post(url,
                            params=params,
                            headers=auth,
                            data=data,
                            verify=CA_CERT)

         rs.raise_for_status()

     def add_user(fileobj, user_id, user_name):
         user = User.new_message()
         user.id = user_id
         user.name = user_name

         fileobj.write(user.to_bytes())

     message = io.BytesIO()

     add_user(message, 11, 'John')
     add_user(message, 12, 'Bob')
     add_user(message, 13, 'Jane')

     execute_query(
         '''
         INSERT INTO {database}.users SETTINGS format_schema='{name}:{cls}' FORMAT {type}
         '''.format(database=DB_NAME,
                    type=SCHEMA_TYPE,
                    name=SCHEMA_NAME,
                    cls=SCHEMA_CLASS), data=message.getvalue())
     ```

     Этот скрипт:
     1. Получает класс `User` из подключенного файла `user.capnp` (`from user_capnp import User`).
     1. Выполняет запросы к кластеру по HTTPS, использует SSL.
     1. Записывает тестовый набор данных в объект класса User (`def add_user ...`) и добавляет этот объект к битовому потоку ввода-вывода `message`.
     1. Вставляет данные из битового потока `message` в таблицу `db1.users`, опираясь на данные класса `User` схемы формата данных `schema-capnproto` в кластере.

   - Protobuf {#protobuf}

     `protobuf-example.py`
     ```python
     import requests
     import io
     import varint
     from user_pb2 import User

     DB_HOST="<FQDN_хоста_{{ CH }}>"
     DB_NAME="db1"
     DB_USER="<имя_пользователя_БД>"
     DB_PASS="<пароль_пользователя_БД>"
     CA_CERT="{{ crt-local-dir }}{{ crt-local-file-root }}"

     SCHEMA_NAME = 'schema-protobuf'
     SCHEMA_TYPE = "Protobuf"
     SCHEMA_CLASS = "User"

     def execute_query(query, data=None):
         url = 'https://{host}:8443/'.format(host=DB_HOST)
         params = {
             'database': DB_NAME,
             'query': query.strip()
         }
         auth = {
             'X-ClickHouse-User': DB_USER,
             'X-ClickHouse-Key': DB_PASS
         }

         rs = requests.post(url,
                            params=params,
                            headers=auth,
                            data=data,
                            verify=CA_CERT)

         rs.raise_for_status()

     def add_user(fileobj, user_id, user_name):
         user = User()
         user.id = user_id
         user.name = user_name

         fileobj.write(varint.encode(user.ByteSize()))
         fileobj.write(user.SerializeToString())

     message = io.BytesIO()
     add_user(message, 21, 'Stephen')
     add_user(message, 22, 'Olivia')
     add_user(message, 23, 'Tim')

     execute_query(
         '''INSERT INTO {database}.users SETTINGS format_schema='{name}:{cls}' FORMAT {type}
         '''.format(database=DB_NAME,
                    type=SCHEMA_TYPE,
                    name=SCHEMA_NAME,
                    cls=SCHEMA_CLASS), data=message.getvalue())
     ```

     Этот скрипт:
     1. Получает класс `User` из подключенного файла `user_pb2.py`, который был получен после компиляции proto-файла (`from user_pb2 import User`).
     1. Записывает тестовый набор данных в объект класса User (`def add_user ...`) и добавляет этот объект к битовому потоку ввода-вывода `message`.
     1. Вставляет данные из битового потока `message` в таблицу `db1.users`, опираясь на данные класса `User` схемы формата данных `schema-protobuf` в кластере.

   {% endlist %}

   О том, как получить FQDN хоста, см. [инструкцию](../operations/connect/fqdn.md).

### Вставка данных {#insert-data}

1. Запустите подготовленные на [предыдущем этапе](#prepare-scripts) скрипты:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     ```bash
     python3 capnproto-example.py
     ```

   - Protobuf {#protobuf}

     ```bash
     python3 protobuf-example.py
     ```

   {% endlist %}

1. [Подключитесь к кластеру](../operations/connect/clients.md) и проверьте, что данные были успешно вставлены, выполнив запрос `SELECT`:

   {% list tabs group=data_format %}

   - Cap'n Proto {#capn}

     ```sql
     SELECT * FROM db1.users;

     ┌─id─┬─name─┐
     │ 11 │ John │
     │ 12 │ Bob  │
     │ 13 │ Jane │
     └────┴──────┘
     ```

   - Protobuf {#protobuf}

     ```sql
     SELECT * FROM db1.users;

     ┌─id─┬─name────┐
     │ 21 │ Stephen │
     │ 22 │ Olivia  │
     │ 23 │ Tim     │
     └────┴─────────┘
     ```

   {% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
