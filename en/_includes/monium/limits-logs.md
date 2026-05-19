### Limits {#loggs-limits}

Type of limit | Value
--------------- | --------
Maximum size of one log batch | 8 MB
Maximum log start time in the past (`time_unix_nano`) | 24 hours ago
Maximum log time in the future (`time_unix_nano`) | 5 minutes ahead
Maximum [label](../../monium/concepts/data-model.md#label) name length | 64 bytes
Maximum label value length | 256 bytes
Maximum [metadata](../../monium/concepts/data-model.md#meta) name length | 400 bytes
Maximum metadata value length | 1 MB

{% note info %}

Allowed log batch size is up to 16 MB, but receipt this big is not guaranteed.

{% endnote %}