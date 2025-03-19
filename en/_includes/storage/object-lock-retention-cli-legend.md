Where:

* `--bucket`: Name of your bucket.
* `--key`: Object [key](../../storage/concepts/object.md#key).
* `--version-id`: Object version ID.
* `--retention`: Retention settings (both parameters are required):

    * `Mode`: Retention [type](../../storage/concepts/object-lock.md#types):

        * `GOVERNANCE`: Governance-mode retention. You cannot set this type if an object version is already locked in compliance mode.
        * `COMPLIANCE`: Compliance-mode retention.

    * `RetainUntilDate`: Retention expiration date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2025-01-01T00:00:00Z`. The expiration time value is specified in [UTC±00:00](https://en.wikipedia.org/wiki/UTC%2B00:00). To use a different time zone, add `+` or `-` and a UTC±00:00 offset to the end of the record. For more information, see [this example](#example-lock). If an object version is already locked in compliance mode, you can only extend it by setting new expiration date and time that are later than the current ones.

* `--bypass-governance-retention`: Flag to enable bypassing the lock. Select it if an object version is already locked in governance mode.