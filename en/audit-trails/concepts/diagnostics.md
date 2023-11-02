# Diagnostic logs

Trail diagnostic logs contain records of changes to the status of the [trail](./trail.md) itself.
Diagnostic logs have nothing to do with events occurring to the resources the trail collects [audit logs](./format.md) for.

The trail statuses are as follows:

* `Active`: Trail is running and collecting audit logs from the available resources.
* `Error`: Possible issues with the trail's destination objects or the trail itself. See [our recommendations](../operations/error.md) on how to recover the trail.

A running trail may switch to the `Error` status as a result of incorrect actions performed by the administrator, such as:

* Changing the configuration of the [destination object](./trail.md#target) that {{ at-short-name }} audit logs are uploaded to (deleting a bucket in {{ objstorage-short-name }} or a {{ cloud-logging-short-name }} log group).
* Modifying the permissions of the service account the configured trail is running under (revoking the [`audit-trails.viewer`](../security/index.md#roles-list), [`storage.uploader`](../../storage/security/index.md#storage-uploader), or other permissions).

If the trail is recovered within three days after the `Error` status occurred, all audit records generated while the trail was down will be uploaded to the appropriate destination object.

If the trail is recovered more than three days after the `Error` status occurred, audit events generated for the trail over the previous 72 hours since the trail recovery will be uploaded to the destination object.
