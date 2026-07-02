[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > Справочник > Apache Airflow™

# Apache Airflow™

Для работы под управлением [Apache Airflow™](https://airflow.apache.org) Yandex Query предоставляет пакет [apache-airflow-providers-yandex](https://pypi.org/project/apache-airflow-providers-yandex/). [Задания Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/index.html) представляют собой приложения на языке Python, состоящие из набора [операторов Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html) и их [зависимостей](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html), определяющих порядок выполнения. Для выполнения запросов к Yandex Query в составе пакета содержится оператор Apache Airflow™ [`YQExecuteQueryOperator`](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/_api/airflow/providers/yandex/operators/yq/index.html).

Для выполнения запросов к Yandex Query необходимо инициализировать `YQExecuteQueryOperator` оператор с помощью аргументов, указанных ниже.

Обязательные аргументы:
* `name` — название задания Apache Airflow™.
* `sql` — текст [SQL-запроса](../concepts/glossary.md#query), который необходимо выполнить в Yandex Query.

Опциональные аргументы:
* `folder_id` — каталог, где будет исполняться запрос. Если не указан, то совпадает с каталогом Managed Service for Apache Airflow™.
* `yandex_conn_id` — идентификатор подключения с типом `yandexcloud`, содержащий параметры соединения с Yandex Cloud. Если не указан, то используется соединение с именем `yandexcloud_default`. Соединение `yandexcloud_default` предустанавливается в составе Managed Service for Apache Airflow™, отдельно его заводить не нужно.

Пример:

```python
yq_operator = YQExecuteQueryOperator(task_id="yq_operator", sql="SELECT 'Hello, world!'")
```

В данном примере создается задание Apache Airflow™ с идентификатором `yq_operator`, которое выполняет запрос `SELECT 'Hello, world!'`. Полный пример запуска запроса в Yandex Query из Managed Service for Apache Airflow™ находится в разделе [Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™](../tutorials/airflow-auto-tasks.md).

## Возвращаемые значения {#ret_values}

Результатом успешного исполнения оператора `YQExecuteQueryOperator` являются данные в виде словаря (`dict`), содержащего массив описаний столбцов и массив строк с результатами.

Запрос:
```python
yq_operator = YQExecuteQueryOperator(task_id="yq_operator", sql="SELECT 'Hello, World!'")
```

Результат:
```json
{
  'rows': [['Hello, world!']],
  'columns': [{'name': 'column0', 'type': 'String'}]
}
```

| Поле | Описание |
| ----- | ----- |
| `columns` | Массив колонок возвращаемого значения |
| `columns[].name` | Имя колонки |
| `columns[].type` | Тип данных колонки |
| `rows` | Массив строк результатов возвращаемого значения. Количество элементов массива каждой строки совпадает с числом колонок из параметра `columns` |

## Соответствие YQL и Python-типов

Ниже приведены правила преобразования YQL-типов в Python-результаты.

### Скалярные типы {#scalars-types}

| YQL-тип | Python-тип | Пример в Python |
| --- | --- | --- |
| `Int8`, `Int16`, `Int32`, `Uint8`, `Uint16`, `Uint32`, `Int64`, `Uint64` | `int` | `647713` |
| `Bool` | `bool` | True |
| `Float`, `Double` | `double`<br/>NaN и Inf представляются в виде `None` | `7.88731023`<br/>`None` |
| `Decimal` | `Decimal` | `45.23410083` |
| `Utf8` | `str` | `Текст строки` |
| `String` | `str` <br/> `bytes`  | `Текст строки` |

### Сложные типы {#complex-types}

| YQL-тип | Python-тип | Пример в Python |
| --- | --- | --- |
| `Json`, `JsonDocument` | `str` (весь узел вставляется как строка) | `{"a":[1,2,3]}` |
| `Date`, `Datetime`, `Timestamp` | `datetime` | `2022-02-09` |

### Опциональные типы {#optional-types}

| YQL-тип | Python-тип | Пример в Python |
| --- | --- | --- |
| `Optional` | Оригинальный тип или None | ```1``` |

### Контейнеры {#containers}

| YQL-тип | Python-тип | Пример в Python |
| --- | --- | --- |
| `List<Type>` | `list` | `[1,2,3,4]` |
| `Dict<KeyType, ValueType>` | `dict` | ```{key1: value1, key2: value2}``` |
| `Set<KeyType>` | `set` | ```set(key_value1, key_value2)``` |
| `Tuple<Type1, Type2>` | `tuple` | ```(element1, element2, ..)``` |
| `Struct<Name:Utf8,Age:Int32>`| `dict` | `{ "Name": "John", "Age": 128 }` |
| `Variant<Type1, Type2>` с tuple | `list` | ```list[64563, 1]``` |
| `Variant<value:Int32,error:String>` со структурой | `dict` | ```{key1: value1, key2: value2}``` |

### Специальные типы {#special-types}

| YQL-тип | Python-тип |
| --- | --- |
| `Void`, `Null` | `None` |
| `EmptyList` | `[]` |
| `EmptyDict` | `{}` |


#### Полезные ссылки {#see-also}

* [Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™](../tutorials/airflow-auto-tasks.md).