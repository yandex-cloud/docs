# ROUND with precision parameter is not supported for double precision data type in {{ PG }}

`ERR.DS_API.DB.INVALID_FUNCTION.PG_DOUBLE_PRECISION_ROUND`

Функция [ROUND](../../../datalens/function-ref/ROUND.md) с параметром `precision` не поддерживается для типа `double precision` источника данных {{ PG }}.

{{ datalens-short-name }} распознает типы `double precision` и `numeric` от {{ PG }} как `Дробное число`. Из этих двух типов функция ROUND с параметром `precision` поддерживает только `numeric`.  Чтобы снова привести `double precision` на уровень БД, воспользуйтесь другой функцией — [DB_CAST](../../../datalens/function-ref/DB_CAST.md).

Пример:

```
ROUND(DB_CAST([ваше поле]/1000000, 'numeric', 16, 8) [, precision ]), где 16 — общее число знаков в дробном числе, 8 — число знаков после запятой в этом числе.
```
