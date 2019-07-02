# Именованные выражения

Задача: вывести названия всех эпизодов 1-го сезона каждого сериала, сгруппировав их по заголовку с помощью именованных выражений.

Если в запросе много подзапросов или если подзапрос используется несколько раз — с запросом становится трудно работать. В таком случае рекомендуется использовать именованные выражения.
Синтаксис именованных выражений напоминает синтаксис переменных, однако именованные выражения больше напоминают макросы, которые перед выполнением принимают последнее указанное значение.

Следующий запрос делает то же самое, что и запрос в
[#T](07_Conditional_values.md).

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
$list_episode_titles = (       -- определить именованное выражение
    String::JoinFromList(AGGREGATE_LIST(title), ", ") AS episode_titles
);

$series_filter = (
    series_id IN (1,2) AND season_id = 1
);

$series_title = (
    CASE
        WHEN series_id = 1
        THEN "IT Crowd"
        ELSE "Silicon Valley"
    END
);

SELECT
    series_title,
    $list_episode_titles
FROM episodes
WHERE $series_filter
GROUP BY
$series_title AS series_title
;

COMMIT;
```

Синтаксис именованных выражений может показаться массивным для простых запросов, но в то же время такие запросы являются более наглядными.
