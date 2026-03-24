**Retention limits**

Type of limit | Value
--------------- | --------
Data retention period for all spans | 4 days

**Write limits**

Type of limit | Value
--------------- | --------
Maximum size of a span batch | 4 MB
Maximum span start time in the past (`startTimeUnixNano`) | 24 hours ago
Maximum span end time in the future (`endTimeUnixNano`) | 1 hour from now
Maximum span `name` length | 2,048 characters
Maximum number of span `attributes` | 512
Maximum attribute name length | 256 characters
Maximum attribute value length | 2,097,152 characters
Maximum `events` per span | 256

**Read limits**

Type of limit | Value
--------------- | --------
Maximum number of spans displayed in the trace viewing interface | 100,000

For larger traces, split them into multiple traces and link them using [span links](https://opentelemetry.io/docs/concepts/signals/traces/#span-links).