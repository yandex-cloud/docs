Where:

* `--bucket`: Name of your bucket.
* `--key`: Object [key](../../storage/concepts/object.md#key).
* `--version-id`: Object version ID.
* `--retention`: Temporary lock settings (both parameters are required):

    * `Mode`: Lock [type](../../storage/concepts/object-lock.md#types):

        * `GOVERNANCE`: Temporary managed lock. You cannot set this type if an object version is already locked in compliance mode.
        * `COMPLIANCE`: Temporary strict lock.

    * `RetainUntilDate`: Lock end date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. For example, `2025-01-01T00:00:00Z`. The lock end time value is specified in the [UTC±00:00](https://en.wikipedia.org/wiki/UTC%2B00:00) time zone. To use a different time zone, add `+` or `-` and a UTC±00:00 offset to the end of the record. For more information, see [this example](#example-lock). If a version object is already locked in compliance mode, you can only extend it by setting new retain until date and time that are later than the current ones.

* `--bypass-governance-retention`: Flag that shows that a lock is bypassed. Select it if an object version is already locked in governance mode.