| Type | Description | Used<br/>in queries<br/>and <br/>YQL calculations | Used<br/>as the<br/>column data type | Used in<br/>primary<br/>keys | Supports the<br/>comparison<br/>option |
| ----- | ----- | ----- | ----- | ----- | ----- |
| `Bool ` | Boolean value. | Yes | Yes | Yes | Yes |
| `Int8` | A signed integer.<br/>Acceptable values: from -2<sup>7</sup> to 2<sup>7</sup>–1. | Yes | No | No | Yes |
| `Int16` | A signed integer.<br/>Acceptable values: from –2<sup>15</sup> to 2<sup>15</sup>–1. | Yes | No | No | Yes |
| `Int32` | A signed integer.<br/>Acceptable values: from –2<sup>31</sup> to 2<sup>31</sup>–1. | Yes | Yes | Yes | Yes |
| `Int64` | A signed integer.<br/>Acceptable values: from –2<sup>63</sup> to 2<sup>63</sup>–1. | Yes | Yes | Yes | Yes |
| `Uint8` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>8</sup>–1. | Yes | Yes | Yes | Yes |
| `Uint16` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>16</sup>–1. | Yes | No | No | Yes |
| `Uint32` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>32</sup>–1. | Yes | Yes | Yes | Yes |
| `Uint64` | An unsigned integer.<br/>Acceptable values: from 0 to 2<sup>64</sup>–1. | Yes | Yes | Yes | Yes |
| `Float` | A real number 4 bytes in size. | Yes | Yes | No | Yes |
| `Double` | A real number 8 bytes in size. | Yes | Yes | No | Yes |
| `Decimal` | A fixed-precision number.<br/>Acceptable values: Decimal(22,9): 13 integer digits, 9 fractional digits. | Yes | Yes | No | Yes |
| `DyNumber` | A binary representation of a real number with an accuracy of up to 38 digits.<br/>Acceptable values: positive numbers from 1×10<sup>-130</sup> up to 1×10<sup>126</sup>–1, negative numbers from -1×10<sup>126</sup>–1 to -1×10<sup>-130</sup> and 0.<br/>Compatible with the  `Number` type in AWS DynamoDB. It's not recommended for {{ ydb-short-name }}-native applications. | Yes | Yes | Yes | Yes |

