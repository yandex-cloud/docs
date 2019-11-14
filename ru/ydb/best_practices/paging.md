# Постраничный вывод

В разделе приведены рекомендации по организации постраничного вывода данных и представлены примеры их реализации на языках Java и Python.

Для организации постраничного вывода рекомендуется последовательно выбирать данные, отсортированные по первичному ключу, ограничивая количество строк ключевым словом LIMIT.

Запрос ниже демонстрирует рекомендованный способ организации постраничного вывода.

{% note info %}

`$lastCity, $lastNumber` — значения первичного ключа, полученные в результате предыдущего запроса.

{% endnote %}

Запрос для организации постраничного вывода:

```sql
DECLARE $limit AS Uint64;
DECLARE $lastCity AS Utf8;
DECLARE $lastNumber AS Uint32;

$Data = (
    SELECT * FROM schools
    WHERE city = $lastCity AND number > $lastNumber
    ORDER BY city, number LIMIT $limit

    UNION ALL

    SELECT * FROM schools
    WHERE city > $lastCity
    ORDER BY city, number LIMIT $limit
);
SELECT * FROM $Data ORDER BY city, number LIMIT $limit;
```

{% note alert %}

В {{ ydb-short-name }} все колонки, включая ключевые, могут иметь значение NULL. Несмотря на это использование NULL в качестве значений в ключевых колонках крайне не рекомендуется, так как по SQL стандарту NULL нельзя сравнивать. Как следствие лаконичные SQL конструкции с простыми операторами сравнения будут работать некорректно. Вместо них придется использовать громоздкие конструкции с IS NULL/IS NOT NULL выражениями.

{% endnote %}
