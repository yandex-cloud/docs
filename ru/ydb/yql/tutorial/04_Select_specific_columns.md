# Выборка данных из определенных колонок

Задача:

1. Выбрать данные из колонок *series_id*, *release_date* и *title*;
2. Переименовать *title* в *series_title*;
3. Преобразовать тип *release_date* из Uint32 в Date.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
$format = DateTime::Format("%Y-%m-%d");

SELECT
    series_id, release_date, title -- имена колонок перечислены
                                   -- с запятой в качестве разделителя

    title AS series_title,         -- используя AS в качестве ключевого слова можно
                                   -- переименовать столбцы или дать имя произвольному
                                   -- выражению

    $format(DateTime::FromSeconds(CAST(DateTime::ToSeconds(DateTime::IntervalFromDays(CAST(release_date AS Int16))) AS Uint32))) AS release_date

FROM series;

COMMIT;
```

