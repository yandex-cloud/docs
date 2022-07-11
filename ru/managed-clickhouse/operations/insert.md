# Добавление данных в {{ CH }}

## Обычная вставка данных {#general-insert}

Для рутинного добавления данных в базу данных используйте запрос `INSERT`, описанный в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/insert-into/). `INSERT`-запросы рекомендуется отправлять не чаще одного раза в секунду.

Чтобы загружать большое количество информации, используйте сжатие данных при передаче: например, его можно включить для HTTP или `clickhouse-client`. Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/interfaces/).

## Вставка данных с указанием схемы формата данных {#insert-with-format-schema}

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

## Пример работы со схемой формата при вставке данных {#example}

**Пример проверялся в следующем окружении:**
- Виртуальная машина в Облаке c Ubuntu 20.04 LTS.
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


## Перед началом работы {#before-you-begin}

1. Изучите формат данных, который будет использоваться при вставке, чтобы [подготовить](#prepare-format-schemas) корректные схемы формата.

   В этом сценарии использования для иллюстрации принимается, что:
   - идентификатор пользователя `id` представлен в виде целого беззнакового 64-битного числа (`Uint64` в Cap'n Proto и {{ CH }}, `uint64` в Protobuf);
   - имя пользователя `name` представлено в виде строки (`Text` в Cap'n Proto, `string` в Protobuf, `String` в {{ CH }}).
   
   Подробнее о поддерживаемых типах данных см. в документации [Cap'n Proto](https://capnproto.org/language.html), [Protobuf](https://developers.google.com/protocol-buffers/docs/proto3) и [{{ CH }}]({{ ch.docs }}/sql-reference/data-types/).

1. [Подключитесь к кластеру](connect.md) и создайте таблицу `db1.users` нужного вида, если ее еще не существует:

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

   {% list tabs %}
   
   - Cap'n Proto
   
     `user.capnp`
     ```
     @0xbec0f3f99cec4fbf;
     
     struct User {
       id @0 :UInt64;
       name @1 :Text;
     }
     ``` 
   
     Подробнее о формате файла см. в [документации Cap'n Proto](https://capnproto.org/language.html).
   
   - Protobuf
   
     `user.proto`
     ```
     syntax = "proto3";

     message User {
       uint64 id = 1;
       string name = 2;
     };
     ```
     
     Подробнее о формате файла см. в [документации Protobuf](https://developers.google.com/protocol-buffers/docs/overview).
   
   {% endlist %}

{% if audience != "internal" %}

1. [Загрузите файл](../../storage/operations/objects/upload.md) в {{ objstorage-name }} и [получите ссылку](../../storage/operations/objects/link-for-download.md) на него.

{% else %}

1. Загрузите файл в {{ objstorage-name }} и получите ссылку на него.

{% endif %}

1. [Подключите схему формата данных](format-schemas.md#add-format-schema) к кластеру `chcluster`:
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

   {% list tabs %}
   
   - Cap'n Proto
   
     `capnproto-example.py`
     ```python
     import requests
     import io
     import capnp
     from user_capnp import User

     DB_HOST="<FQDN хоста {{ CH }}>"
     DB_NAME="db1"
     DB_USER="<имя пользователя БД>"
     DB_PASS="<пароль пользователя БД>"
     CA_CERT="{{ crt-local-dir }}{{ crt-local-file }}"

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
         INSERT INTO {database}.users FORMAT {type} SETTINGS format_schema='{name}:{cls}'
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
   
   - Protobuf
   
     `protobuf-example.py`
     ```python
     import requests
     import io
     import varint
     from user_pb2 import User

     DB_HOST="<FQDN хоста {{ CH }}>"
     DB_NAME="db1"
     DB_USER="<имя пользователя БД>"
     DB_PASS="<пароль пользователя БД>"
     CA_CERT="{{ crt-local-dir }}{{ crt-local-file }}"

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
         '''INSERT INTO {database}.users FORMAT {type} SETTINGS format_schema='{name}:{cls}'
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


### Вставка данных {#insert-data}

1. Запустите подготовленные на [предыдущем этапе](#prepare-scripts) скрипты:
   
   {% list tabs %}
   
   - Cap'n Proto
     
     ```bash
     python3 capnproto-example.py
     ```
     
   - Protobuf
     
     ```bash
     python3 protobuf-example.py
     ```
   
   {% endlist %}
   
1. [Подключитесь к кластеру](connect.md) и проверьте, что данные были успешно вставлены, выполнив запрос `SELECT`: 

   {% list tabs %}

   - Cap'n Proto

     ```sql
     SELECT * FROM db1.users;
     
     ┌─id─┬─name─┐
     │ 11 │ John │
     │ 12 │ Bob  │
     │ 13 │ Jane │
     └────┴──────┘
     ```
     
   - Protobuf
   
     ```sql
     SELECT * FROM db1.users;
     
     ┌─id─┬─name────┐
     │ 21 │ Stephen │
     │ 22 │ Olivia  │
     │ 23 │ Tim     │
     └────┴─────────┘
     ```
     
   {% endlist %}
