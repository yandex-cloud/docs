---
sourcePath: en/ydb/overlay/maintenance/backup_and_recovery.md
---
{% include [intro.md](_includes/backup_and_recovery/01_intro.md) %}

{% include [prerequisites.md](_includes/backup_and_recovery/02_prerequisites.md) %}

{% include [fs_backup_header.md](_includes/backup_and_recovery/04_fs_backup_1_header.md) %}

{% include [fs_backup_body.md](_includes/backup_and_recovery/04_fs_backup_2_body.md) %}

{% include [fs_restore.md](_includes/backup_and_recovery/05_fs_restore.md) %}

{% include [s3_header.md](_includes/backup_and_recovery/06_s3_1_header.md) %}

In this section, the target system is [{{ objstorage-full-name }}](../../storage/).

{% include [s3_prerequisites.md](_includes/backup_and_recovery/06_s3_2_prerequisites.md) %}

When working with [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage), the [{{ yandex-cloud }} Object Storage bucket](https://cloud.yandex.ru/docs/storage/concepts/bucket) is used.

{% include [s3_access_keys.md](_includes/backup_and_recovery/06_s3_3_access_keys.md) %}

{% include [s3_export.md](_includes/backup_and_recovery/06_s3_4_export.md) %}

{% include [s3_restore.md](_includes/backup_and_recovery/06_s3_5_restore.md) %}

{% include [s3_forget.md](_includes/backup_and_recovery/06_s3_6_forget.md) %}

