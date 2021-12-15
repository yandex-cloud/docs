# Простые типы данных

{% note info %}

Термин _простые_ используются как синоним _примитивные_ для типов данных.

{% endnote %}

## Числовые типы {#numeric}

{% include [datatypes](../../../_includes/datatypes_primitive_number.md) %}

## Строковые типы {#string}

{% include [datatypes](../../../_includes/datatypes_primitive_string.md) %}

## Дата и время {#datetime}

{% include [datatypes](../../../_includes/datatypes_primitive_datetime.md) %}

## Приведение простых типов данных {#cast}

### Явное приведение {#explicit-cast}

Явное приведение типов с помощью [CAST](../syntax/expressions.md#cast):

Тип | Bool | Int | Uint | Float | Double | Decimal | String | Utf8 | Json {% if audience != "external" %}| Yson {% endif %}| Uuid | Date | Datetime | Timestamp | Interval
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- {% if audience != "external" %}| --- {% endif %}| --- | --- | --- | --- | ---
**Bool** | — | Да<sup>1</sup> | Да<sup>1</sup> | Да<sup>1</sup> | Да<sup>1</sup> | Нет | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Нет | Нет | Нет | Нет
**Int** | Да<sup>2</sup> | — | Да | Да<sup>3</sup> | Да | Да | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Да | Да | Да | Да
**Uint** | Да<sup>2</sup> | Да | — | Да | Да | Да | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Да | Да | Да | Да
**Float** | Да<sup>2</sup> | Да | Да | — | Да | Нет | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Нет | Нет | Нет | Нет
**Double** | Да<sup>2</sup> | Да | Да | Да | — | Нет | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Нет | Нет | Нет | Нет
**Decimal** | Нет | Да | Да | Да | Да | — | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Нет | Нет | Нет | Нет
**String** | Да | Да | Да | Да | Да | Да | — | Да | Да {% if audience != "external" %}| Да {% endif %}| Да | Да | Да | Да | Да
**Utf8** | Да | Да | Да | Да | Да | Да | Да | — | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Да | Да | Да | Да
**Json** | Нет | Нет | Нет | Нет | Нет | Нет | Да | Да | — {% if audience != "external" %}| Нет {% endif %}| Нет | Нет | Нет | Нет | Нет
**Uuid** | Нет | Нет | Нет | Нет | Нет | Нет | Да | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | — | Нет | Нет | Нет | Нет
**Date** | Нет | Да | Да | Да | Да | Нет | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | — | Да | Да | Нет
**Datetime** | Нет | Да | Да | Да | Да | Нет | Да | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Нет | Да | — | Да | Нет
**Timestamp** | Нет | Да | Да | Да | Да | Нет | Да | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Да | Да | — | Нет
**Interval** | Нет | Да | Да | Да | Да | Нет | Да | Нет | Нет | Нет {% if audience != "external" %}| Нет {% endif %}| Нет | Нет | Нет | — | —

<sup>1</sup> `True` соответствует `1`, `False` соответствует `0`.
<sup>2</sup> Всегда `True`. Исключение: `0` соответствует `False`.
<sup>3</sup> Возможно только в случае неотрицательного значения.

### Неявное приведение {#implicit-cast}

Неявное приведение типов возникает при выполнении базовых операций (`+`, `-`, `×` и `/`) между разными типами данных. В таблице указан тип результата операции, если она возможна:

Тип | Bool | Int | Uint | Float | Double | Decimal | String | Utf8 | Json {% if audience != "external" %}| Yson {% endif %}| Uuid | Date | Datetime | Timestamp | Interval
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- {% if audience != "external" %}| --- {% endif %}| --- | --- | --- | --- | ---
**Bool** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Int** | — | `Int` | `Int` | `Float` | `Double` | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Uint** | — | `Int` | `Uint` | `Float` | `Double` | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Float** | — | `Float` | `Float` | `Float` | `Double` | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Double** | — | `Double` | `Double` | `Double` | `Double` | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Decimal** | — | — | — | — | — | `Decimal` | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**String** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Utf8** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Json** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Uuid** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | —
**Date** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | `Date`
**Datetime** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | `Datetime`
**Timestamp** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | — | — | — | `Timestamp`
**Interval** | — | — | — | — | — | — | — | — | — {% if audience != "external" %}| — {% endif %}| — | `Date` | `Datetime` | `Timestamp` | `Interval`
