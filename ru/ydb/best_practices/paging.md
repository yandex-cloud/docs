# Постраничный вывод

{% if audience == "internal" %}

В разделе приведены рекомендации по организации постраничного вывода данных и представлены примеры их реализации на языках [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/examples/pagination), [Java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples/src/pagination) и [Python](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/pagination).

{% else if audience == "external" %}

В разделе приведены рекомендации по организации постраничного вывода данных и представлены примеры их реализации на языках Java и Python.

{% endif %}

Для организации постраничного вывода рекомендуется последовательно выбирать данные, отсортированные по первичному ключу, ограничивая количество строк ключевым словом LIMIT.

Запрос ниже демонстрирует рекомендованный способ организации постраничного вывода.

{% note info %}

`$lastCity, $lastNumber` — значения первичного ключа, полученные в результате предыдущего запроса.

{% endnote %}

Запрос для организации постраничного вывода:

```yql
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
