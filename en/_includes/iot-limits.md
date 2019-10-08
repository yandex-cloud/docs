#### Limits {#limits}

| Type of limit | Value |
| ----- | ----- |
| Maximum size per message | 256 KB |
| Frequency of sending messages per device | No more than once per second |
| Maximum length of the subtopic name | 1024 symbols
| Maximum number of aliases per device | 5

{% note info %}

Message delivery is not guaranteed if the limits are exceeded.

{% endnote %}

#### Other restrictions {#other-restrictions}

- The `Retain` flag is not supported.
- Persistent Session is not supported.

