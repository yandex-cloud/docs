---
sourcePath: en/ydb/ydb-docs-core/en/core/maintenance/_includes/backup_and_recovery/06_s3_5_restore.md
---
### Restoring data from S3-compatible storage {#s3_restore}

First, connect the bucket with the YDB database backup files in S3-compatible storage to make the database available through operations on the file system.

When done, upload the data from the backup in YDB following the instructions described in [Restoring data from backups in the file system](#filesystem_restore).