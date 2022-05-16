---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/types/_includes/datatypes_primitive_number.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/types/_includes/datatypes_primitive_number.md
---
| Type | Description | Notes |
| ----- | ----- | ----- |
| `Bool ` | Boolean value. |
| `Int8` | A signed integer.<br/>Acceptable values: from -2<sup>7</sup> to 2<sup>7</sup>–1. | Not supported for table columns |
| `Int16` | A signed integer.<br/>Acceptable values: from –2<sup>15</sup> to 2<sup>15</sup>–1. | Not supported for table columns |
| `Int32` | A signed integer.<br/>Acceptable values: from –2<sup>31</sup> to 2<sup>31</sup>–1. |
| `Int64` | A signed integer.<br/>Acceptable values: from –2<sup>63</sup> to 2<sup>63</sup>–1. |
| `Uint8` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>8</sup>–1. |
| `Uint16` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>16</sup>–1. | Not supported for table columns |
| `Uint32` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>32</sup>–1. |
| `Uint64` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>64</sup>–1. |
| `Float` | A real number with variable precision, 4 bytes in size. | Can't be used in the primary key |
| `Double` | A real number with variable precision, 8 bytes in size. | Can't be used in the primary key |
| `Decimal` | A real number with the specified precision, up to 35 decimal digits | When used in table columns, precision is fixed: Decimal (22,9).</br>Can't be used in the primary key |

`DyNumber` | A binary representation of a real number with an accuracy of up to 38 digits.<br/>Acceptable values: positive numbers from 1×10<sup>-130</sup> up to 1×10<sup>126</sup>–1, negative numbers from -1×10<sup>126</sup>–1 to -1×10<sup>-130</sup>, and 0.<br/>Compatible with the `Number` type in AWS DynamoDB. It's not recommended for {{ backend_name_lower }}-native applications. |

