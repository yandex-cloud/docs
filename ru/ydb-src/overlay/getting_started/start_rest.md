_Тут приведены простейшие примеры использования HTTP API KiKiMR. Вот ссылка на [подробное описание HTTP-интерфейса](../api/rest.md)._

Предполагаем, что инстанс KiKiMR развёрнут на localhost (это может быть инсталляция из одного хоста или мы находимся на одном хосте из кластера, неважно). При дефолтных настройках HTTP API доступен по адресу `localhost:8765/CLI_MB/`. Команды к нему передаются в формате JSON, ответы приходят в нём же. Если поместить команду в файл `cmd.js`, то запрос выполняется так:

```
curl -d @cmd.js -i localhost:8765/CLI_MB/{CMD_NAME}
```
, где `{CMD_NAME}` имеет значение `DbSchema` или `DbOperation` в зависимости от типа команды. В примерах будет указываться только `CMD_NAME` и содержимое JSON.

### Создадим папки и таблицы {#create-folders-and-tables}
**Создадим папку**, в которой будем проводить свои тесты:
```
URL: /CLI_MB/DbSchema

{
  "Path": "/Root",
  "MkDir": "MyTestFolder"
}
```

* `Path` – обязательный атрибут всех команд `DbSchema`, он указывает, в какой папке выполняется операция,
* `MkDir` – строка с именем создаваемой папки или список таких строк (например, `["MyFolder1", "MyFolder2"]`). Создать сразу иерархию папок (скажем, папку "MyFolder/MySubFolder") нельзя, надо создать их последовательными командами с удлиняющимся `Path`.

**Создадим таблицу в папке:**
```
URL: /CLI_MB/DbSchema

{
    "Path": "/Root/MyTestFolder",
    "CreateTable": {
        "MyTable": {
            "Columns": {
                "IdColumn": "Uint64",
                "AnotherColumn": "Utf8String"
            },
            "Key": "IdColumn",
            "Partitions": 10
        }
    }
}
```

* `MyTable` – имя таблицы; в одной команде `CreateTable` можно описать сразу несколько таблиц,
* `Columns` – список колонок; перечень возможных типов можно посмотреть <span style="color:red;">где?</span>
* `Key` – обязательное поле, может содержать одно имя колонки или список.


### Поработаем с данными {#lets-work-with-the-data}
**Запишем строку в таблицу:**

Новые записи добавляются так же, как изменяются существующие – через команду Update:

```
URL: /CLI_MB/DbOperation

{
    "Table": "/Root/MyTestFolder/MyTable",
    "Update": {
        "AnotherColumn": "xyz"
    },
    "Where": {"IdColumn": 1234}
}
```

* `Table` – обязательное поле для всех команд `DbOperation`. Сейчас один запрос HTTP API может производить операции только над одной таблицей. 
Чтобы одной командой добавить несколько записей, воспользуйтесь командой `Batch` (она может объединять и разнотипные команды тоже):

```
URL: /CLI_MB/DbOperation

{
    "Table": "/Root/MyTestFolder/MyTable",
    "Batch": [{
        "Update": {"AnotherColumn": "value1"},
        "Where": {"IdColumn": 1}
    }, {
        "Update": {"AnotherColumn": "value2"},
        "Where": {"IdColumn": 2}
    }, {
        "Update": {"AnotherColumn": "value3"},
        "Where": {"IdColumn": 3}
    }    
}
```

Получить данные через HTTP API сейчас можно только точечно:
```
URL: /CLI_MB/DbOperation

{
    "Table": "/Root/MyTestFolder/MyTable",
    "Select": ["IdColumn", "AnotherColumn"],
    "Where": {"IdColumn": 1234}
}
```
Аналогично – удалить:
```
URL: /CLI_MB/DbOperation

{
    "Table": "/Root/MyTestFolder/MyTable",
    "Delete": "",
    "Where": {"IdColumn": 1234}
}
```