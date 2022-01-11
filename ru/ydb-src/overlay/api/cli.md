## Общее описание
Командный интерфейс KiKiMR'а доступен через тот же бинарный файл, что используется для запуска сервера.
На текущий момент, формат команды такой:

```
kikimr <глобальные флаги> <команда> <аргументы/флаги команды>
```
### Глобальные флаги

```
-s|--server <host[:port]>
```
Указание адреса/хоста сервера и порта KiKiMR'а. По-умолчанию, значение этого параметра берется из переменной окружения KIKIMR_SERVER. Если переменной окружения нет, то используется localhost. Если порт не указан, используется порт 2134.

```
-d|--dump
```
Выводит на консоль подробный дамп содержимого запросов и ответов. Полезно для диагностики проблем.

```
-t|--time
```
Выводит на консоль время, потраченное на вызов сервера.

```
-o|--progress
```
Выводит прогресс выполнения долгих команд.

## Команды

В виду большого количества и разнообразия команд, они организованы в иерархическую структуру:
```
kikimr
├─ admin                    KiKiMR management and administration
│  ├─ blobstorage           Blob Storage management (aka bs)
│  │  ├─ disk               Disk management
│  │  │  ├─ create          Create a new disk
│  │  │  ├─ format          Format local disk
│  │  │  └─ info            Get info about disk
│  │  ├─ group              Group management
│  │  │  └─ create          Create a new group
│  │  └─ slot               Slot management
│  │     └─ create          Create a new slot
│  ├─ debug
│  └─ tablet                Tablet infrastructure administration
│     ├─ #                  <tablet id>
│     │  ├─ datashard
│     │  │  └─ config       Change datashard settings (aka conf)
│     │  ├─ execute
│     │  └─ keyvalue
│     │     └─ request      Request to KV tablet (aka req)
│     └─ compactionbroker   Compaction Broker (aka cb)
│        └─ config          Change cb settings
├─ db                       KiKiMR DB operations
│  ├─ execute               Execute minikql query (aka exec)
│  └─ schema                Schema operations
│     ├─ describe           Describe schema object (aka desc)
│     ├─ execute            Execute schema protobuf (aka exec)
│     ├─ init               Initialize schema root
│     ├─ ls                 List children schema objects
│     └─ mkdir              Create directory
└─ server                   Execute KiKiMR server
```
### db


### db execute

```
kikimr db execute <MiniKQL> [<Parameters>]
```
Команда выполнения транзакции над БД KiKiMR. Транзакция описывается на языке MiniKQL. В качестве первого аргумента указывается текст программы (или путь к файлу, содержащий программу в текстовом виде). Опционально можно указать параметры программы (также, в виде текста или в виде пути к тестовому файлу).

#### db schema

Описывает подраздел операций с схемой БД KiKiMR.

##### db schema describe

```
kikimr db schema describe [-t|--tree] [-d|--details] <path>
```
Команда получения описания объекта в схеме БД по указанному пути.
```
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$ ./kikimr db schema describe /Root/mds_data
72075186232623600/12    <table>   mds_data
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$
-t|-tree
```
Дополнительно выводит полный подробный путь к указанному объекту.
```
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$ ./kikimr db schema describe -t /Root/mds_data
72075186232623600/1     <dir>     Root
└─ 72075186232623600/12    <table>   mds_data
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$
```

```
-d|--details
```
Показывает более подробную информацию об объекте (к примеру, если это таблица, то показывает схему таблицы).
```
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$ ./kikimr db schema describe -d /Root/mds_data
72075186232623600/12    <table>   mds_data
─┬──────────────────────┬──────┬──────────
1│Uint32                │bucket│K0
2│LargeBoundedByteString│key   │K1
3│LargeBoundedByteString│value │
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$
```
#### db schema init
```
db schema init <root>
```
Инициализация схемы БД KiKiMR. `<root>` - имя корневого домена.
```
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$ ./kikimr db schema init Root
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$
```
#### db schema ls
```
db schema ls <path>
```
Отображает список объектов схемы БД KiKiMR по указанному пути.
```
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$ ./kikimr db schema ls /Root
72075186232623600/38	<dir>	Berkanavt
72075186232623600/13	<dir>	http_mds
72075186232623600/15	<dir>	Bobrs
72075186232623600/6	<dir>	sub_path5
72075186232623600/9	<dir>	sub_path8
72075186232623600/8	<dir>	sub_path7
72075186232623600/2	<dir>	sub_path1
72075186232623600/12	<table>	mds_data
72075186232623600/7	<dir>	sub_path6
72075186232623600/10	<dir>	sub_path9
72075186232623600/4	<dir>	sub_path3
72075186232623600/14	<table>	bobr_data
72075186232623600/5	<dir>	sub_path4
72075186232623600/3	<dir>	sub_path2
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$
```
#### db schema mkdir
```
db schema mkdir <path>
```
Создает каталог с указанным путем.
```
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$ ./kikimr db schema mkdir /Root/test1
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$
```
#### db schema execute

```
db schema execute <protobuf>
```
Команда изменения схемы БД KiKiMR, используя указанный protobuf. Допускается как указания protobuf в виде текста в командной строке, так и в виде пути к текстовому файлу. Подробнее формат protobuf модификации схемы описан [здесь](https://wiki.yandex-team.ru/users/davenger/flatdb/).
```
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$ ./kikimr db schema execute "ModifyScheme { WorkingDir: '/Root' OperationType: ESchemeOpMkDir MkDir { Name: 'Berkanavt' }}"
xenoxeno@xenoxeno-ub14:~/arcadia/kikimr/driver$
```
### admin

В данном описании команды раздела "admin" не рассматриваются.

### server

Команда server предназначена для запуска сервера KiKiMR.

### readTable
потоковая неблокирующая консистентная выгрузка таблицы

#### Цель

С помощью kikimr cli выгрузить таблицу любого размера целиком, не сталкиваясь с ограничениями на размер ответа, которые неизбежно возникают при попытке выгрузить таблицу через YQL.

#### Кратко о readTable
Выгрузка таблиц с помощью readTable позволяет получить консистентное состояние таблицы и при этом не блокировать другие запросы к таблице.

Можно указывать перечень столбцов, которые должны быть в ответе, накладывать ограничения на диапазон значений первичного ключа, ограничивать количество возвращаемых рядов.

[Описание операции](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/protos/tx_proxy.proto?rev=3635503&blame=true#L57) readTable в grpc-интерфейсе

Подсказка в kikimr cli
```
kovalad-osx:~ kovalad$ kikimr db readtable --help
Usage: readtable [OPTIONS] <PATH>

Options:
  {-V|--svnrevision} print svn version
  {-?|--help}        print usage
  --ordered          Result should be ordered by primary key (default: 0)
  --columns NAMES    Comma separated list of columns to read
  --from VALUE       Key value to start read from (comma is used as separator for compound keys
  --from-exclusive   Don't include the left border element into response (default: 0)
  --to VALUE         Key value to read until (comma is used as separator for compound keys
  --to-inclusive     Include the right border element into response (default: 0)
  --limit NUM        Limit result rows count
  --no-header        Don't print table header (default: 0)
  --no-data          Don't print table data (default: 0)
  --format csv       Specify output format (default: "csv")
  --delim SYMBOL     Specify delimiter for CSV format (default: ",")

Free args: min: 1, max: 1 (listed described args only)
  <PATH>  path to table
```
#### Ограничения

1. Любая ошибка во время вычитывания таблицы приведёт прерыванию операции. Повторение операции будет выгружать новое консистентное состояние
2. вероятность ошибки во время вычитывания растёт с размером таблицы и количеством шардов
3. если разбить вычитывание таблицы на несколько запросов readTable по диапазону ключей, то это не будет консистентным вычитыванием, каждый readTable будет консистентен, все вместе - нет.

#### Предусловия

Чтобы воспользоваться `readTable`, нужно:

1. Собрать kikimr cli из Аркадии по [инструкции](../getting_started/start_local_cluster.md), предварительно [выкачав Аркадию](/arcadia/starterguide/#2.spanclassb-page-codeb-page-codeinlineyesi-bemdata-bemb-page-codeyaclonesposobschekautitproektineobxodimyezavisimosti)
1. Включенный grpc на кластере
2. readTable работает только по grpc. При использовании версий [kikimr_configure](../internals/configuration.md), собранных после 04.04.2018, эта возможность включена на кластере по умолчанию.
3. Если grpc на кластере не включен, попытка выполнить readTable закончится ошибкой:
```
Stream are not supported for Message Bus
```
4. Если возможности воспользоваться актуальным [kikimr_configure](../internals/configuration.md) нет, grpc можно включить в grpc.txt:
```
StartGRpcProxy: true
   Host: "[::]"
   Port: 2135
   GRpcMemoryQuotaBytes: 1000000000
```
1. Включенный grpc streaming в настройках кластера. При использовании версий [kikimr_configure](../internals/configuration.md), собранных после 04.04.2018, эта возможность включена на кластере по умолчанию.
1. Если Streaming не включен, попытка выполнить `readTable` закончится с ошибкой
```
MP-0128 output streams are disabled for the server
```
2. Если возможности воспользоваться актуальным [kikimr_configure](../internals/configuration.md) нет, streaming можно включить в grpc.txt:
```
StreamingConfig {
    EnableOutputStreams: true
  }
```
#### Шаги
##### Запустить команду

Чтобы выгрузить столбцы token и type из таблицы `/Root/Captcha/CaptchaTest_Sessions` c кластера `3dc_dev`, начиная со значения ключа 00100A6ieOzDnkKRfoIHCc0M5vh0lCSP, нужно выполнить команду:
```kikimr -s grpc://3dc-ydb-dev-vla-003.search.yandex.net:2135 db readtable /Root/Captcha/CaptchaTest_Sessions --columns=token,type --limit=10000 --from=00100A6ieOzDnkKRfoIHCc0M5vh0lCSP
```
#### Возможные ошибки

##### Some keys not resolved, see UnresolvedKeys for details
1. В опциях `--from` и `--to` указаны значения ключей, для которых не нашлось строк
1. в списке --columns указаны несуществующие имена колонок
