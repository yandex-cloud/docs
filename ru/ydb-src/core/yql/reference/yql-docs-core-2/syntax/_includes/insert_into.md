# INSERT INTO
{% if select_command != "SELECT STREAM" %}
Добавляет строки в таблицу. {% if feature_bulk_tables %} Если целевая таблица уже существует и не является сортированной, операция `INSERT INTO` дописывает строки в конец таблицы. В случае сортированной таблицы, YQL пытается сохранить сортированность путем запуска сортированного слияния. {% endif %}{% if feature_map_tables %} При попытке вставить в таблицу строку с уже существующим значением первичного ключа операция завершится ошибкой с кодом `PRECONDITION_FAILED` и текстом `Operation aborted due to constraint violation: insert_pk`.{% endif %}

{% if feature_mapreduce %}Таблица по имени ищется в базе данных, заданной оператором [USE](../use.md).{% endif %}

`INSERT INTO` позволяет выполнять следующие операции:

* Добавление константных значений с помощью [`VALUES`](../values.md).

  ```sql
  INSERT INTO my_table (Key1, Key2, Value1, Value2)
  VALUES (345987,'ydb', 'Яблочный край', 1414);
  COMMIT;
  ```

  ``` sql
  INSERT INTO my_table (key, value)
  VALUES ("foo", 1), ("bar", 2);
  ```

* Сохранение результата выборки `SELECT`.

  ```sql
  INSERT INTO my_table
  SELECT Key AS Key1, "Empty" AS Key2, Value AS Value1
  FROM my_table1;
  ```

{% if feature_insert_with_truncate %}
Чтобы перед записью очистить таблицу от имевшихся данных достаточно добавить модификатор: `INSERT INTO ... WITH TRUNCATE`.

**Примеры:**


``` yql
INSERT INTO my_table WITH TRUNCATE
SELECT key FROM my_table_source;
```

{% endif %}

{% else %}

Направить результат вычисления [SELECT STREAM](../select_stream.md) в указанный стрим на кластере, заданном оператором [USE](../use.md). Стрим должен существовать и иметь схему, подходящую результату запроса.

**Примеры:**
``` yql
INSERT INTO my_stream_dst
SELECT STREAM key FROM my_stream_src;
```

Существует возможность указать в качестве цели таблицу на кластере ydb. Таблица должна существовать на момент создания операции. Схема таблицы должна быть совместима с типом результата запроса.

**Примеры:**
``` yql
INSERT INTO ydb_cluster.`my_table_dst`
SELECT STREAM * FROM rtmr_cluster.`my_stream_source`;
```
{% endif %}
