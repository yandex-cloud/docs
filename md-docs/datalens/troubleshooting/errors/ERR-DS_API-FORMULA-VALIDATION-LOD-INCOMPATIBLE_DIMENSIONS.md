[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Incompatible dimensions

# [Yandex DataLens] Incompatible dimensions

`ERR.DS_API.FORMULA.VALIDATION.LOD.INCOMPATIBLE_DIMENSIONS`

Ошибка возникает из-за того, что агрегации, находящиеся на одном уровне вложенности, имеют разные наборы измерений.

Например, в чарте с группировкой по измерениям `[Region]` и `[Category]` нельзя создать такой показатель:

```
ARG_MAX(
     ANY([City] INCLUDE [City]),
     AVG([Sales] INCLUDE [Order Date])
)
```

Агрегации `ANY([City] INCLUDE [City])` и `AVG([Sales] INCLUDE [Order Date])` находятся на одном уровне вложенности (внутри `ARG_MAX`). У первой агрегации измерение `[City]`, у второй — `[Order Date]`. Ошибка в этом случае возникает из-за того, что нет другой агрегации, которая содержит оба этих измерения.

Для исправления ошибки измените выражение так, чтобы одна из вложенных агрегаций содержала все измерения, которые используются в других вложенных агрегациях. Например, так:

```
ARG_MAX(
     ANY([City] INCLUDE [City]),
     AVG([Sales] INCLUDE [City],[Order Date])
)
```

Подробнее об использовании LOD-выражений читайте в разделе [LOD-выражения и управление фильтрацией в агрегатных функциях в Yandex DataLens](../../concepts/lod-aggregation.md).