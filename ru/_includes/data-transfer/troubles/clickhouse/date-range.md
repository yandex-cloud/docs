### Неподдерживаемый диапазон дат {#date-range}

Если в переносимых данных есть даты вне поддерживаемых диапазонов, {{ CH }} возвращает ошибку:

```text
TYPE_ERROR [target]: failed to run (abstract1 source): failed to push items from 0 to 1 in batch:
Push failed: failed to push 1 rows to ClickHouse shard 0:
ClickHouse Push failed: Unable to exec changeItem: clickhouse:
dateTime <имя_поля> must be between 1900-01-01 00:00:00 and 2262-04-11 23:47:16
```

Поддерживаемые диапазоны дат в {{ CH }}:

* Для полей с типом `DateTime64` — с 1900-01-01 по 2299-12-31. Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/data-types/datetime64).
* Для полей с типом `DateTime` — с 1970-01-01 по 2106-02-07. Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/data-types/datetime).

**Решение:** используйте один из вариантов:

* Приведите все даты в базе-источнике к поддерживаемому в {{ CH }} диапазону.
* В [параметрах эндпоинта-источника](../../../../data-transfer/operations/endpoint/index.md#update) исключите таблицу с некорректными датами из трансфера.
* В [параметрах трансфера](../../../../data-transfer/operations/transfer.md#update) укажите трансформер [{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.convert_to_string.title}}](../../../../data-transfer/concepts/data-transformation.md#convert-to-string). В этом случае при трансфере изменится тип поля.
