{% note info %}

To protect your backups from accidental file deletion, enable [S3 bucket versioning](../../../storage/operations/buckets/versioning.md). This way, deleted or overwritten files will be saved as previous versions you can [restore](../../../storage/operations/objects/restore-object-version.md) if needed. For more information about S3 bucket versioning, see [this guide](../../../storage/concepts/versioning.md).

Without versioning, you will not be able to restore files deleted from S3, even if previously copied.

{% endnote %}