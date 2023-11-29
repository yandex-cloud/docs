* **{{ ui-key.yacloud.greenplum.label-start-time }}**: `VACUUM` start time. The default value is `19:00 UTC`. Once the `VACUUM` operation is completed, the `ANALYZE` operation starts.
* **{{ ui-key.yacloud.greenplum.label-vacuum-timeout }}**: Maximum `VACUUM` execution time, in seconds. The default value is `36,000`. As soon as this period expires, `VACUUM` will be forced to terminate.
* **{{ ui-key.yacloud.greenplum.label-analyze-timeout }}**: Maximum `ANALYZE` execution time, in seconds. The default value is `36,000`. As soon as this period expires, the operation will be forced to terminate.

The combined `VACUUM` and `ANALYZE` execution time may not exceed 24 hours.
