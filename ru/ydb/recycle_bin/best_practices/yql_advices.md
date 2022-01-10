<!-- added to YQL FAQ -->

## План запросов вида (key1, key2) IN ((v1, v2), (v3, v4), ...) {#query-plan}

Сейчас это лучше записывать через JOIN с константной таблицей:
```sql
$keys = AsList(
    AsStruct(1 AS Key1, "One" AS Key2),
    AsStruct(2 AS Key1, "Three" AS Key2),
    AsStruct(4 AS Key1, "One" AS Key2)
);

SELECT t.* FROM AS_TABLE($keys) AS k
INNER JOIN [Root/Home/spuchin/TwoKey] AS t
ON t.Key1 = k.Key1 AND t.Key2 = k.Key2;
```