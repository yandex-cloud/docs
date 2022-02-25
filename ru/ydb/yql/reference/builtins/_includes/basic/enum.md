---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/enum.md
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/enum.md
---

## Enum, AsEnum {#enum}

`Enum()` cоздает значение перечисления.

Аргументы:

* Строка с именем поля
* Тип перечисления

**Пример**
``` yql
$enum_type = Enum<Foo, Bar>;
SELECT
   Enum("Foo", $enum_type) as Enum1Value,
   Enum("Bar", $enum_type) as Enum2Value;
```

`AsEnum()` создает значение [перечисления](../../../types/containers.md) с одним элементом. Это значение может быть неявно преобразовано к любому перечислению, содержащему такое имя.

Аргументы:

* Строка с именем элемента перечисления

**Пример**
``` yql
SELECT
   AsEnum("Foo");
```
