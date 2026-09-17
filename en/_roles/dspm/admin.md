The `dspm.admin` role enables using {{ dspm-name }} profiles and managing data sources and sensitive data scans, which includes viewing masked and unprocessed data in scan results.

Users with this role can:
* View info on {{ dspm-name }} profiles and use them.
* View info on {{ dspm-name }} [data sources](../../security-deck/concepts/dspm.md#data-source) and their scan areas, as well as create, modify, use, and delete such sources.
* Use {{ yandex-cloud }} resources in {{ dspm-name }} data sources.
* View info on {{ dspm-name }} data types and [categories](../../security-deck/concepts/dspm.md#data-categories).
* View info on sensitive data [scan](../../security-deck/concepts/dspm.md#scanning) jobs, as well as create, run, suspend, resume, modify, and delete such jobs.
* View info on sensitive data scans, as well as create, suspend, resume, modify, and delete them.
* View info on results of and errors relating to [continuous update scans](../../security-deck/concepts/dspm.md#change-scaning) and [regular sensitive data scans](../../security-deck/concepts/dspm.md#scanning), including masked and unprocessed data.
* Download and export sensitive data scan results, including masked and unprocessed data.
* Estimate the cost of using {{ dspm-name }} (drawing on {{ objstorage-full-name }} bucket metadata in data sources).

This role includes the `dspm.editor` permissions.

To export scan results, you also need the `storage.uploader` role for the bucket to save the results in and the `kms.keys.encrypter` role for the encryption key if the bucket is encrypted.
