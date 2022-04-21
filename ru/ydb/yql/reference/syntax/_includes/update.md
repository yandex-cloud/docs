---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-core/syntax/_includes/update.md
sourcePath: ru/ydb/yql/reference/yql-core/syntax/_includes/update.md
---
# UPDATE

Изменяет данные в таблице. После ключевого слова `SET` указываются столбцы, значение которых необходимо заменить, и сами новые значения. Список строк задается с помощью условия `WHERE`. Если `WHERE` отсутствует, изменения будут применены ко всем строкам таблицы.

`UPDATE` не может менять значение `PRIMARY_KEY`.

{% note info %}

В рамках одной транзакции операторы UPDATE или UPDATE ON для одной таблицы можно использовать только один раз.

{% endnote %}

**Пример**

```sql
UPDATE my_table
SET Value1 = YQL::ToString(Value2 + 1), Value2 = Value2 - 1
WHERE Key1 > 1;
```

## UPDATE ON {#update-on}

Это другая форма записи оператора UPDATE.

Синтаксис:

```
UPDATE table_name ON
SELECT ....
```

SELECT должен возвращать выборку в которой имена всех колонок результирующего набора совпадают с соответствующими именами в table_name. Если имя какой-либо из колонок результирующего набора имеет имя, отсутствующее в table_name, то вернется ошибка.

SELECT должен возвращать выборку в которой присутствуют все столбцы, формирующие primary key таблицы table_name.

UPDATE ON проходится по всем записям результирующего набора, возвращаемого SELECT, ищет по primary key соответствующие записи в table_name и проводит обновление столбцов, не состоящих в primary key согласно значениям, указанным в соответствующих столбцах результирующего набора.

Столбцы таблицы table_name, не задействованные в SELECT не меняют своего значения.

**Примеры**

```sql
$to_update = (
    SELECT Key, SubKey, "Updated" AS Value FROM my_table
    WHERE Key = 1
);

SELECT * FROM my_table;

UPDATE my_table ON
SELECT * FROM $to_update;
```


В примере ниже primary key таблицы season состоит только из одного столбца season_id.
```yql
$updated_fld=AsList(
    AsStruct(
        3ul as season_id,
        'update_on title 3'u as title,
        301ul as series_id
    )
);
update season on select * from As_Table( $updated_fld);
```


{% note info %}

Если В рамках одной транзакции Вы хотите многократно обновлять одну и ту же таблицу - то используйте оператор UPSERT

{% endnote %}

**Пример:**

```уql
$updated_fld=AsList(
    AsStruct(
        1ul as season_id,
        'update_on title 30'u as title,
        301ul as series_id
    )
);
update season on select * from As_Table( $updated_fld);

UPSERT INTO season (season_id, title)
values (30ul,'30'u),
        (31ul,'31'u);
       
UPSERT INTO season (season_id, title)
values (33ul,'33'u);        
```