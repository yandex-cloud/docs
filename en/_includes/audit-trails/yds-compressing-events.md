If the event flow write speed in {{ yds-name }} is over 1 MB/s, enable compression. This will cut the volume of transmitted data, reduce the risk of [throttling](https://en.wikipedia.org/wiki/Dynamic_frequency_scaling) for individual {{ DS }} segments, and improve your flow bandwidth performance.

The compression setting is available when [creating](../../audit-trails/operations/create-trail.md) or [modifying](../../audit-trails/operations/manage-trail.md) a trail via the CLI, API, or {{ TF }} UI. Available compression methods: `GZIP` ([GNU Zip](https://wikipedia.org/wiki/Gzip)) or `ZSTD` ([Zstandard](https://wikipedia.org/wiki/Zstandard)). There is no compression default (`RAW`).

To read data via the native {{ DS }} protocol, additionally enable compression on the {{ DS }} reader. The HTTP Kinesis and {{ KF }} protocols are not supported yet.
