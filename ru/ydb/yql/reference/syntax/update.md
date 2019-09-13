# UPDATE

Изменяет данные в указанной таблице. 
Получает список строк таблицы по предикату из WHERE (на момент начала транзакции) и применяет к ним операцию [UPSERT](upsert_into.md) со значениями колонок посчитанным по выражениям из SET.
Не может менять значение первичного ключа.

**Примеры**

```sql
UPDATE my_table 
SET Value1 = YQL::ToString(Value2 + 1), Value2 = Value2 - 1
WHERE Key1 > 1;

COMMIT;
```

## UPDATE ON {#update-on}

При выполнении транзакции невозможно выполнить операции UPDATE, DELETE или INSERT над уже измененной таблицей, так как в рамках одной транзакции не отслеживается изменение состояния таблицы. Чтобы иметь возможность прочитать или изменить данные в ранее измененной таблице, используется конструкция UPDATE ON. Принцип работы конструкции проиллюстрирован в примере ниже.

**Примеры**

```sql
to_update = (
    SELECT Key, SubKey, "Updated" AS Value FROM my_table
    WHERE Key = 1
);

SELECT * FROM my_table;

UPDATE my_table ON
SELECT * FROM $to_update;

COMMIT;
```
