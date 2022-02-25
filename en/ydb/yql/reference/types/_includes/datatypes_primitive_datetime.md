---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/types/_includes/datatypes_primitive_datetime.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/types/_includes/datatypes_primitive_datetime.md
---

| Type | Description | Notes |
| ----- | ----- | ----- |
| `Date` | Date, precision to the day |
| `Datetime` | Date/time, precision to the second |
| `Timestamp` | Date/time, precision to the microsecond |
| `Interval` | Time interval, precision to the microsecond, <br/>Valid values: must not exceed 24 hours. | Can't be used in the primary key |
| `TzDate` | Date with time zone label, precision to the day | Not supported in table columns |
| `TzDateTime` | Date/time with time zone label, precision to the second | Not supported in table columns |
| `TzTimestamp` | Date/time with time zone label, precision to the microsecond | Not supported in table columns |

