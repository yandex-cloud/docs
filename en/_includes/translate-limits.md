#### Quotas {#translate-quotas}

| Type of limit | Value |
----- | -----
| Calls of one API method per second | 20 |
| Characters sent for translation or language detection, per hour | 1 million |

#### Limits {#translate-limits}

For limitations on the field values in the request body, see the [API reference](../translate/api-ref/Translation/index.md).

The limits for using glossaries are as follows:

- The number of pairs sent to glossaries must be **no more than 50**.

- The total number of Unicode characters in this structure must be **no more than 20,000**: 10,000 characters per source text and 10,000 characters per target text.

{% note warning %}

This only refers to texts without CGI parameters.

{% endnote %}