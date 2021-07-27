---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# MessageAttributeValue

Custom message attribute value. The same restrictions apply to string values as to the message body.

The message name, type, value, and body cannot be empty. The total size of all parts of a message put together cannot exceed 256 KB.

| Parameter | Type | Required parameter | Description |
| ----- | ----- | ----- | ----- |
| `BinaryListValue.N` | **array** | No | Not implemented. |
| `BinaryValue` | **base64** | No | Any binary data. |
| `DataType` | **string** | Yes | Data type: String, Number, or Binary.  For the Number type, use StringValue. |
| `StringListValue.N` | **string** | No | Not implemented. |
| `StringValue` | **string** | No | UTF-8 encoded string. |

