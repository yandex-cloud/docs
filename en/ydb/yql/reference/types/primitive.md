# Primitive data types

{% note info %}

_Primitive_ data types are also sometimes referred to as _simple_ data types.

{% endnote %}

## Numeric types {#numeric}

{% include [datatypes](../../../_includes/datatypes_primitive_number.md) %}

## String types {#string}

{% include [datatypes](../../../_includes/datatypes_primitive_string.md) %}

## Date and time {#datetime}

{% include [datatypes](../../../_includes/datatypes_primitive_datetime.md) %}

## Casting between data types {#cast}

### Explicit casting {#explicit-cast}

Explicit type casting using [CAST](../syntax/expressions.md#cast):

Type | Bool | Int | Uint | Float | Double | Decimal | String | Utf8 | Json {% if audience != "external" %}| Yson {% endif %}| Uuid | Date | Datetime | Timestamp | Interval
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- {% if audience != "external" %}| --- {% endif %}| --- | --- | --- | --- | ---
**Bool** | — | Yes<sup>1</sup> | Yes<sup>1</sup> | Yes<sup>1</sup> | Yes<sup>1</sup> | No | Yes | No | No {% if audience != "external" %}| No {% endif %}| No | No | No | No | No
**Int** | Yes<sup>2</sup> | — | Yes | Yes<sup>3</sup> | Yes | Yes | Yes | No | No {% if audience != "external" %}| No {% endif %}| No | Yes | Yes | Yes | Yes
**Uint** | Yes<sup>2</sup> | Yes | — / Yes | Yes | Yes | Yes | No | No {% if audience != "external" %}| No {% endif %}| No | Yes | Yes | Yes | Yes
**Float** | Yes<sup>2</sup> | Yes | Yes | — / Yes | No | Yes | No | No {% if audience != "external" %}| No {% endif %}| No | No | No | No | No
**Double** | Yes<sup>2</sup> | Yes | Yes | Yes | — | No | Yes | No | No {% if audience != "external" %}| No {% endif %}| No | No | No | No | No
**Decimal** | No | Yes | Yes | Yes | Yes | — / Yes | No | No {% if audience != "external" %}| No {% endif %}| No | No | No | No | No
**String** | Yes | Yes | Yes | Yes | Yes | Yes | — / Yes | Yes {% if audience != "external" %}| Yes {% endif %}| Yes | Yes | Yes | Yes | Yes
**Utf8** | Yes | Yes | Yes | Yes | Yes | Yes | Yes | — / No {% if audience != "external" %}| No {% endif %}| No | Yes | Yes | Yes | Yes
**Json** | No | No | No | No | No | No | Yes | Yes | — {% if audience != "external" %}| No {% endif %}| No | No | No | No | No
**Uuid** | No | No | No | No | No | No / Yes | No {% if audience != "external" %}| No {% endif %}| No | — | No | No | No | No
**Date** | No | Yes | Yes | Yes | Yes | No | Yes | No | No {% if audience != "external" %}| No {% endif %}| No | — / Yes | Yes | No
**Datetime** | No | Yes | Yes | Yes | Yes | No | Yes | No {% if audience != "external" %}| No {% endif %}| No | No | Yes | — / Yes | No
**Timestamp** | No | Yes | Yes | Yes | Yes | No | Yes | No | No {% if audience != "external" %}| No {% endif %}| No | Yes | Yes | — / No
**Interval** | No | Yes | Yes | Yes | Yes | No / Yes | No | No | No {% if audience != "external" %}| No {% endif %}| No | No | No | — | —

<sup>1</sup> `True` casts to `1`, `False` casts to `0`.

<sup>2</sup> always casts to `True`. Exception: `0` casts to `False`.

<sup>3</sup>  It's possible only in the case of a non-negative value.

### Implicit casting {#implicit-cast}

Implicit casting occurs during basic operations (`+`, `-`, `×` and `/`) between different data types. The table shows the operation result type if the operation is possible:

Type | Bool | Int | Uint | Float | Double | Decimal | String | Utf8 | Json {% if audience != "external" %}| Yson {% endif %}| Uuid | Date | Datetime | Timestamp | Interval
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

