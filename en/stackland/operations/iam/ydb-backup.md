---
title: Creating a YDB backup
description: Creating a local backup of an IAM database in YDB.
---

# Creating a YDB backup

Using the `ydb-backup.sh` script, a cluster administrator can create an [{{ iam-name }}](../../concepts/components/iam.md) database backup in YDB and save it on a workstation as a `tar.gz` archive.

The script is supported in {{ stackland-name }} version **26.3 and higher**.

## Getting started {#prerequisites}

1. Make sure the workstation (Linux or macOS) has `bash`, `awk`, `du`, `kubectl`, `tar`, and `mktemp` installed.
1. Prepare a kubeconfig file with admin cluster access. You can use a kubeconfig with the `cluster-admin` role created [when installing the cluster](../../quickstart.md#installation-common).
1. Make sure your YDB is accessible and the workstation has enough free space to store both the unpacked data and the archive simultaneously.
1. Make sure a default `StorageClass` with file volume support (`volumeMode: Filesystem`) is configured in the cluster. The script uses this storage class for a temporary PVC with a full data copy. The storage must have enough free space for the PVC.
1. Specify the absolute path to your kubeconfig file, then check the selected cluster and storage classes:

   ```bash
   KUBECONFIG_PATH="<absolute_path_to_kubeconfig>"

   kubectl --kubeconfig "${KUBECONFIG_PATH}" config current-context
   kubectl --kubeconfig "${KUBECONFIG_PATH}" cluster-info
   kubectl --kubeconfig "${KUBECONFIG_PATH}" get storageclass
   ```

## Creating a backup {#create-backup}

1. Save the script below as `ydb-backup.sh` on your workstation.

   {% cut "ydb-backup.sh script" %}

   {% include notitle [ydb-backup.sh](../../_includes/scripts/operations/iam/ydb-backup.md) %}

   {% endcut %}

1. Make the file executable:

   ```bash
   chmod +x ydb-backup.sh
   ```

1. Specify the path to the new archive and run the script:

   ```bash
   BACKUP_PATH="$(pwd)/ydb-backup-$(date -u +%Y%m%dT%H%M%SZ).tar.gz"

   ./ydb-backup.sh \
     --kubeconfig "${KUBECONFIG_PATH}" \
     --pvc-size 20Gi \
     --timeout 3600 \
     "${BACKUP_PATH}"
   ```

   Where:

   * `--kubeconfig`: Kubeconfig file path. If not set, the script uses the path from the `KUBECONFIG` variable, then falls back to `$HOME/.kube/config`. Specify the path to a single file.
   * `--pvc-size`: Size of the temporary PVC for the full data copy in the cluster. The default value is `20Gi`. If the copy does not fit in the PVC, rerun the script with a larger value for this setting.
   * `--timeout`: Timeout for individual operations and creating the YDB dump, in seconds. The default value is `3600`. This is not a limit on the total duration of the script execution.
   * `BACKUP_PATH`: Path to the archive. An existing file will not be overwritten. If the path is not specified, the script generates a `ydb-backup-<UTC_date_and_time>.tar.gz` file in the script’s directory.

   Do not run multiple instances of the script at once in the same cluster: they use the same temporary pod and PVC. After completion, the script deletes the temporary pod and PVC.

1. Wait for the `Backup completed` message with the path to the archive and its size.

## Checking the result {#check-result}

1. Make sure the archive is created and readable:

   ```bash
   ls -lh "${BACKUP_PATH}"
   tar -tzf "${BACKUP_PATH}" >/dev/null
   ```

1. Save the archive in a secure location separate from the cluster. The archive contains confidential {{ iam-name }} data: restrict access to it during storage and transmission.

For information on how to restore the database, see [Restoring a YDB from backup](ydb-restore.md).
