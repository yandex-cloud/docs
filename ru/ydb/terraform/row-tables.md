# Создание строковых таблиц в базе данных


{% note warning %}

На данный момент поддерживается создание только строковых таблиц. Функциональность Terraform провайдера по созданию колоночных таблиц находится в разработке.

{% endnote %}


Таблица в концепциях Terraform – это тоже ресурс, поэтому таблицы баз данных описываются отдельными блоками (`resource "yandex_ydb_table"`) с указанием внутренней ссылки на созданную ранее базу данных. Создадим тестовую строковую таблицу из 3 колонок в уже созданной базе данных:
```tf
resource "yandex_ydb_table" "test_table" {
  path = "test_dir/test_table_3_col"
  connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint 
  
column {
      name = "a"
      type = "Utf8"
      not_null = true
    }
    column {
      name = "b"
      type = "Uint32"
      not_null = true
    }
    column {
      name = "c"
      type = "Int32"
      not_null = false
    }
    column {
    name = "d"
    type = "Timestamp"
    }

  primary_key = ["a","b"]
  
}
```

Разберем значения параметров блока `"yandex_ydb_table"`:
1. `path` – путь в базе данных, где будет создана таблица. Название таблицы указывается без закрывающего слеша `/`. Если директория, где следует создать таблицу отсутствует – она будет создана;
1. `connection_string` – путь для подключения к базе данных. Используется совместно с параметром `ydb_full_endpoint`, который содержит полный путь до базы: `grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gv7kfcttio********/etn66ecf1qbt********`. Для краткости и простоты записи можно использовать ссылку на ресурс `"yandex_ydb_database_serverless"` с указанием идентификатора и параметра `ydb_full_endpoint`. Например, `yandex_ydb_database_serverless.database1.ydb_full_endpoint `; 
1. `primary_key` – первичный ключ таблицы. Может быть составным.

Полный перечень полей ресурса `yandex_ydb_table`:
| **Название поля** | **Тип** | **Значение** | **Описание** |
| --- | --- | --- | --- |
|path|`string`|`required`|Путь до таблицы|
|connection_string|`string`|`required`|Строка соединения|
|column|`array[column]`|`required`|Тип данных column|
|family|`array[family]`|`optional`|Группа колонок|
|primary_key|`array[string]`|`required`|[Первичный ключ таблицы](https://ydb.tech/ru/docs/yql/reference/syntax/create_table)|
|ttl|`ttl`|`optional`|Настройки TTL|
|attributes|`map[string]string`|`optional`|Атрибуты таблицы|
|partitioning_settings|`partitioning_settings`|`optional`|Настройки партиционирования|
|key_bloom_filter|`boolean`|`optional`|Использование [фильтра Блума для первичного ключа](https://ydb.tech/ru/docs/concepts/datamodel/table#bloom-filter)|
|read_replicas_settings|`string`|`optional`|[Настройки репликаций для чтения](https://ydb.tech/ru/docs/concepts/datamodel/table#read_only_replicas)|

Внутри блока `"yandex_ydb_table"` заключены вложенные блоки column, которые описывают индивидуальные свойства колонок, такие как:
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
|name|`string`<br>`required`|Имя колонки|
|type|`string`<br>`required`|Тип данных колонки. Используются [YQL типы данных](https://ydb.tech/ru/docs/yql/reference/types/)|
|family|`string`<br>`optional`|Группа колонки|
|not_null|`boolean`<br>`optional`<br>По умолчанию: `false`|Колонка не может быть NULL|

Пример полного описания колонки:
```tf
column {
  name     = "column_name"
  type     = "Utf8"
  family   = "some_family"
  not_null = true
}
```

{% note warning %}

На данный момент нельзя удалить колонку при помощи Terraform, её можно только добавить. Для удаления колонки необходимо сначала удалить колонку из базы напрямую (например, при помощи YQL запроса), после чего удалить колонку из конфигурационного файла.

{% endnote %}

Колонки могут быть объединены в [группы](https://ydb.tech/ru/docs/yql/reference/syntax/create_table#column-family) (семейства/family), для того чтобы задать им общие параметры, такие как: 
* `DATA` — тип устройства хранения для данных колонок этой группы (допустимые значения: `ssd`, `rot` (от rotation – вращение шпинделя HDD)); 
* `COMPRESSION` — кодек сжатия данных (допустимые значения: `off`, `lz4`). 
Для объеденения колонок в группу используется блок `family` на одном уровне с блоком `column`:
```tf
family {
  name        = "my_family"
  data        = "ssd"
  compression = "lz4"
}
```

Описание полей блока `family`:
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
|name|`string`<br>`required`|Имя группы колонок|
|data|`string`<br>`required`|Тип устройства хранения для данных колонок этой группы|
|compression|`string`<br>`required`|Кодек сжатия данных|

Пример группировки двух столбцов в одну группу может выглядить так:
```tf
resource "yandex_ydb_table" "test_table" {
    path = "test_dir/test_table_3_col"
    connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint 
    column {
        name = "a"
        type = "Uint16"
        family = "test_family_group"
        not_null = true
    }
    column {
        name = "b"
        type = "Uint32"
        family = "test_family_group"
        not_null = true
    }
    family {
      name  = "test_family_group"
      data  = "ssd"
      compression = "lz4"
    }    
}
```

YDB позволяет создавать специальный вид колонок – [TTL-колонки](https://ydb.tech/ru/docs/concepts/ttl), значения которой используются для определения времени жизни строк. TTL автоматически удаляет из таблицы строки, когда проходит указанное количество секунд от времени, записанного в TTL-колонку. Задать можно не более одной TTL-колонки. TTL-колонка может быть одного из следующих типов: `Date`, `Datetime`, `Timestamp`, `Uint32`, `Uint64`, `DyNumber`.

Задается TTL-колонка следующим блоком:
```tf
ttl {
  column_name     = "d"
  expire_interval = "PT1H" # 1 час
}
```

Описание значений полей ttl:
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
|column_name|`string`<br>`required`|Имя колонки для TTL|
|expire_interval|`string`<br>`required`|Интервал в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601)|
