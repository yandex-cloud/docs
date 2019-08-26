# Сортировка и фильтрация

Задача: выбрать первые три эпизода из всех сезонов *IT Crowd* за исключением первого.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
SELECT
   series_id,
   season_id,
   episode_id,
   CAST(air_date AS Date) AS air_date, 
   title

FROM episodes
WHERE
   series_id = 1      -- список условий для формирования результата
   AND season_id > 1  -- логическое И (AND) используется для написания сложных условий

ORDER BY              -- используется для сортировки результатов

   series_id,         -- с помощью ORDER BY можно
   season_id,         -- расположить результаты выборки в определенном порядке,
   episode_id         -- через запятую

LIMIT 3               -- LIMIT N после ORDER BY
                      -- означает "получить первые N" или "последние N" результатов
;                     -- в зависимости от порядка сортировки

COMMIT;
```