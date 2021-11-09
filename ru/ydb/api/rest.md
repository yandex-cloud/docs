### Введение

В KiKiMR есть HTTP интерфейс, который позволяет выполнять различные команды.
В частности, через него можно работать с распределенной БД KiKiMR. Для этого выделено две команды: операция над схемой и операция над данными. Ниже идет описание каждой из них.
**URL:** `HOSTNAME:8765/CLI_MB/{CMD_NAME}`
**Метод:** `POST`
**Формат запроса:** JSON, `Content-Type: application/x-www-form-urlencoded`
**Коды ответа:** 200 (с данными) или 204 (без данных) при успешном запросе, другие (400, <span style="color:red;">какие ещё?</span>) при неуспешном
**Формат ответа:** Возвращается JSON с данными или информацией об ошибке, `Content-Type: application/json`

### Описание команд

#### DbSchema
**URL:** /CLI_MB/DbSchema
**Коды ошибок (поле SchemeStatus):** см. [enum EStatus](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/protos/flat_tx_scheme.proto)

Изменяет схему БД KiKiMR. В содержимом передается JSON следующего содержания:

Path - обязательный атрибут, указывающий местоположение в БД для выполнения операций над схемой. Должен начинаться с / и с корневого домена. Пример:
``` json
"Path": "/Root/Test1"
```
MkDir - опциональный атрибут, позволяющий создавать каталоги в БД. Состоит из строки, или массива строк. Пример:
``` json
"MkDir": "Test2"
```
DropTable - опциональный атрибут, позволяющий удалять таблицы из БД. Состоит из строки или масива строк. Пример:
``` json
"DropTable": ["KeyValueTest1", "KeyValueTest2"]
```
CreateTable - опциональный атрибут, позволяющий создавать новые таблицы в БД. Состоит из map'а {имя_таблицы => описание_таблицы}. Описание состоит из следующих атрибутов:
* Columns - обязательный атрибут, в котором, в виде map'а (строка:строка), перечисляются все имена колонок таблицы и соответствующие им типы.
* Key - обязательный атрибут, в котором перечисляются все колонки, которые составляют ключ таблицы, в том порядке (если их несколько), в котором они должны быть в ключе. Строка или массив строк.
* Partitions - опциональный атрибут, в котором задается количество шардов для партиционирования таблицы по ключу. Используются только первая колонка ключа и только если она числового типа.
Пример:
``` json
"CreateTable": {
    "MyTableName": {
        "Columns": {
            "Key": "Uint64",
            "Value": "Utf8String"
        },
        "Key": "Key",
        "Partitions": 10
    }
}
```
Для удобства указания нескольких операций в одной команде, атрибуты обрабатываются в следующем порядке: DropTable, MkDir, CreateTable.
В случае успешного выполнения операции, никакого контента не возвращается, возвращается HTTP код 204. В случае ошибки возвращается JSON с разными кодами ошибок (TBusResponse).

#### DbOperation
Method: POST
URL: /CLI_MB/DbOperation
Content-Type: application/x-www-form-urlencoded

Выполняет операцию над БД KiKiMR. В содержимом передается JSON следующего содержания:

Table - обязательный атрибут, в нем указывается имя таблицы над которой производится операция. Строка. Пример:
``` json
"Table": "/Root/Test1/MyTableName"
```
Select - опциональный атрибут, в нем указывается список колонок для чтения из таблицы. Список строк. Пример:
``` json
"Select": ["Key", "Value"]
```
Update - опциональный атрибут, в нем указываются колонки и новые значения для записи в таблицу. Map (строка:значение). Пример:
``` json
"Update": {
    "Value": "xyz"
}
```
Delete - оциональный атрибут, его наличие означает что нужно удалить строку из таблицы. Значение не играет роли. Пример:
``` json
"Delete": ""
```
Where - атрибут, указывающий значение ключа для поиска строки в таблице. Map (строка:значение). Должен быть указан для всех команд SELECT/UPDATE/DELETE. Пример:
``` json
"Where": {
    "Key": 1234
}
```
В случае успеха, если есть возвращаемое значение, возвращается оно в виде JSON map (строка:значение). В случае ошибки возвращается JSON с кодами ошибок (TBusResponse).
Если операция успешна, но не предполагает никакого возвращаемого значения, то будет просто HTTP 204.

Batch - опциональный атрибут, дающий возможность составить программу из нескольких операций. Все операции ограничены указанной таблицей. Атрибут состоит из массива операций, в каждой из которых может быть вышеописанные атрибуты Select/Update/Delete. Пример:
``` json
"Batch": [
        {
            "Update": { "value": "0123456789" },
            "Where": { "bucket": 3994319589, "key": "345" }
        },
        {
            "Update": { "value": "1234567890" },
            "Where": { "bucket": 3994319588, "key": "346" }
        }
    ]
```
#### SchemeDescribe

Method: POST
URL: /CLI_MB/SchemeDescribe
Content-Type: application/x-www-form-urlencoded

Возвращает информацию об указанном элементе в пути (директория, таблица)

Атрибут Path - указывает элемент дерева, описание которого запрашивается

``` json
{
  "Path": "/Root/tmp"
}
```
#### DbQuery

С помощью метода DbQuery можно выполнять YQL-запросы через HTTP-интерфейс

например, отправив файл select-with-dbquery.json с содержимым
``` json
{
  "Query": "select * from [/Root/Tmp/kovalad/organizations] limit 100;"
}
```
с помощью команды
```
curl -v --data @select-with-dbquery.json -w'\n' "http://3dc-ydb-dev.yandex.net:8765/CLI_MB/DbQuery"
```
Можно получить все строки из таблицы /Root/Tmp/kovalad/organizations на кластере 3dc_dev.
Главное не забывать про то, что автокомита нет.

### Аутентификация

Для аутентификации поддерживается возможность передачи токенов в заголовках, как в [инструкции](https://wiki.yandex-team.ru/oauth/newservice/#kakpodderzhatoauthvsvojomservise)

Про аутентификацию и авторизацию есть более подробный [раздел](../concepts/internal/iam.md)

### Примеры

В качестве примера мы создадим таблицу с тривиальной схемой, запишем туда значение и прочтем его. Все с использованием консольной команды curl.

#### Создание схемы
Создадим файл с именем "schema.json" со следующим содержимым:
``` json
{
    "Path": "/Root",
    "CreateTable": {
        "KeyValueTable": {
            "Columns": {
                "Key": "Uint64",
                "Value": "Utf8String"
            },
            "Key": "Key",
            "Partitions": 10
        }
    }
}
```
Выполним команду:
```
xenoxeno@xenoxeno-ub14:~$ curl -v --data @schema.json -w'\n' "http://localhost:8765/CLI_MB/DbSchema"
*   Trying ::1...
* Connected to localhost (::1) port 8765 (#0)
> POST /CLI_MB/DbSchema HTTP/1.1
> Host: localhost:8765
> User-Agent: curl/7.47.0
> Accept: */*
> Content-Length: 244
> Content-Type: application/x-www-form-urlencoded
>
* upload completely sent off: 244 out of 244 bytes
< HTTP/1.1 204 No content
< Connection: Keep-Alive
< Transfer-Encoding: chunked
<
* Connection #0 to host localhost left intact
```
Команда выполнена успешно (HTTP/1.1 204 No content), теперь у нас есть таблица, расшардированная по 10 партишенам.
Запишем данные.
#### Запись данных
Для этого создадим файлик "update.json" со следующим содержимым:
``` json
{
    "Table": "/Root/KeyValueTable",
    "Update": {
        "Value": "xyz"
    },
    "Where": {
        "Key": 1234
    }
}
```
Выполним команду (обратите внимание - URL другой):
```
xenoxeno@xenoxeno-ub14:~$ curl -v --data @update.json -w'\n' "http://localhost:8765/CLI_MB/DbOperation"
*   Trying ::1...
* Connected to localhost (::1) port 8765 (#0)
> POST /CLI_MB/DbOperation HTTP/1.1
> Host: localhost:8765
> User-Agent: curl/7.47.0
> Accept: */*
> Content-Length: 118
> Content-Type: application/x-www-form-urlencoded
>
* upload completely sent off: 118 out of 118 bytes
< HTTP/1.1 204 No content
< Connection: Keep-Alive
< Transfer-Encoding: chunked
<

* Connection #0 to host localhost left intact
```
Команда выполнена успешно (HTTP/1.1 204 No content), мы записали значение "xyz" в строку с ключом 1234.
Теперь прочтем это.
#### Чтение данных
Создадим файлик "select.json" со следующим содержимым:
``` json
{
    "Table": "/Root/KeyValueTable",
    "Select": ["Key", "Value"],
    "Where": {
        "Key": 1234
    }
}
```
Выполним команду:
```
xenoxeno@xenoxeno-ub14:~$ curl -v --data @select.json -w'\n' "http://localhost:8765/CLI_MB/DbOperation"
*   Trying ::1...
* Connected to localhost (::1) port 8765 (#0)
> POST /CLI_MB/DbOperation HTTP/1.1
> Host: localhost:8765
> User-Agent: curl/7.47.0
> Accept: */*
> Content-Length: 106
> Content-Type: application/x-www-form-urlencoded
>
* upload completely sent off: 106 out of 106 bytes
< HTTP/1.1 200 Ok
< Content-Type: application/json
< Connection: Keep-Alive
< Transfer-Encoding: chunked
<
* Connection #0 to host localhost left intact
{"Key": 1234, "Value": "xyz"}
```
Мы прочли содержимое колонок "Key" и "Value" из строки с ключом "Key" равным 1234.
