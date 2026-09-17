The `dspm.viewer` role enables viewing info on {{ dspm-name }} resources, as well as on scan jobs and the number of detected security threats. This role does not enable viewing masked and unprocessed data.

Users with this role can:
* View info on {{ dspm-name }} profiles.
* View info on {{ dspm-name }} [data sources](../../security-deck/concepts/dspm.md#data-source) and their scan areas.
* View info on {{ dspm-name }} data types and [categories](../../security-deck/concepts/dspm.md#data-categories).
* View info on sensitive data [scan](../../security-deck/concepts/dspm.md#scanning) jobs.
* View info on sensitive data scan jobs.
* View info on results of and errors relating to [continuous update scans](../../security-deck/concepts/dspm.md#change-scaning) and [regular sensitive data scans](../../security-deck/concepts/dspm.md#scanning) (unmasked data only).
* Download and export sensitive data scan results (unmasked data only).
* Estimate the cost of using {{ dspm-name }} (drawing on {{ objstorage-full-name }} bucket metadata in data sources).

This role includes the `dspm.auditor` permissions.

To export scan results, you also need the `storage.uploader` role for the bucket to save the results in and the `kms.keys.encrypter` role for the encryption key if the bucket is encrypted.
