| Type | Description | Used<br/>in queries<br/>and <br/>YQL calculations | Used<br/>as the<br/>column data type | Used in<br/>primary<br/>keys | Supports the<br/>comparison<br/>option |
| ----- | ----- | ----- | ----- | ----- | ----- |
| `string` | Any binary data. | Yes | Yes | Yes | Yes |
| `Utf8` | Text in UTF-8 encoding. | Yes | Yes | Yes | Yes |
| `Json` | JSON in textual representation. | Yes | Yes | No | No |
| `JsonDocument` | JSON in an indexed binary representation. | Yes | Yes | No | No |
{% if audience != "external" %}
| `Yson` | [YSON](https://yt.yandex-team.ru/docs/description/common/yson.html) in textual or binary representation. | Yes | Yes | No | No |
{% endif %}
|`Uuid` | The [UUID](https://tools.ietf.org/html/rfc4122). | Yes | No | No | Yes |

{% note info "Size limits" %}

The maximum value size for a non-key column cell with any string data type is 8 MB.

{% endnote %}

