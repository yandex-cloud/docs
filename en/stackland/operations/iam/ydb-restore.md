---
title: Restoring a YDB from a backup
description: Restoring an IAM database in YDB from a local archive.
---

# Restoring a YDB from a backup

The `ydb-restore.sh` script restores an [{{ iam-name }}](../../concepts/components/iam.md) database in YDB from an archive created using the [backup script](ydb-backup.md).

The script is supported in {{ stackland-name }} version **26.3 and higher**.

{% note alert %}

Restoring a database irreversibly deletes the existing YDB and all its PVCs. {{ iam-name }} data changes introduced after restoring a database from the selected backup will be lost.

The cluster will become unavailable during recovery. Schedule a maintenance window. If the script terminates with an error, the cluster may remain unavailable until it is successfully restarted.

{% endnote %}

## Getting started {#prerequisites}

1. Make sure the workstation (Linux or macOS) has `bash`, `awk`, `du`, `kubectl`, `jq`, `tar`, and `mktemp` installed. Run the script from the interactive terminal, as you will need to confirm the action before changing the cluster.
1. Prepare a kubeconfig file with administrative access to the cluster to restore. This access should remain when {{ iam-name }} is not accessible. For example, you can use a kubeconfig with the `cluster-admin` role created [when installing the cluster](../../quickstart.md#installation-common).
1. Prepare the `tar.gz` archive created by the `ydb-backup.sh` script. If the current YDS is available and you need to save its data, [create a separate backup](ydb-backup.md) before restoring.
1. Make sure the workstation has space for the archive unpacking. In the cluster, the unpacked data copy is stored in a temporary PVC. The script reads its size automatically as the size of unpacked data + 10% rounded up to a GiB but not less than 10 GiB. After completion, the script deletes the temporary pod and PVC.
1. Specify the absolute paths to the kubeconfig and archive. Check the selected cluster, available storage classes, and archive readability:

   ```bash
   KUBECONFIG_PATH="<absolute_path_to_kubeconfig>"
   BACKUP_PATH="<absolute_path_to_tar.gz>"

   kubectl --kubeconfig "${KUBECONFIG_PATH}" config current-context
   kubectl --kubeconfig "${KUBECONFIG_PATH}" cluster-info
   kubectl --kubeconfig "${KUBECONFIG_PATH}" get storageclass
   tar -tzf "${BACKUP_PATH}" >/dev/null
   ```

1. Select a `StorageClass` supporting block (`volumeMode: Block`) and file (`volumeMode: Filesystem`) volumes. The script uses this storage class for new YDB disks and a temporary PVC with the backup.

   For a YDB, the script will create nine PVCs of `100Gi` each: three volumes for each of the three YDB storage nodes. Make sure the storage you selected has enough space for these PVCs and a temporary PVC with a backup, and the cluster has at least three nodes that disk preparation pods can run on.

   After restoring, the system uses one storage group with the selected `StorageClass` and three disks per node, even if the configuration was different prior to restoring.

## Recovering data {#restore}

1. Save the script below as `ydb-restore.sh` on your workstation.

   {% cut "ydb-restore.sh script" %}

   {% include notitle [ydb-restore.sh](../../_includes/scripts/operations/iam/ydb-restore.md) %}

   {% endcut %}

1. Make the file executable:

   ```bash
   chmod +x ydb-restore.sh
   ```

1. Specify the selected storage class and run the script:

   ```bash
   STORAGE_CLASS="<StorageClass_name>"

   ./ydb-restore.sh \
     --kubeconfig "${KUBECONFIG_PATH}" \
     --storage-class "${STORAGE_CLASS}" \
     --timeout 3600 \
     "${BACKUP_PATH}"
   ```

   Where:

   * `--kubeconfig`: Required path to the kubeconfig file of the cluster to restore.
   * `--storage-class`: Required name of the existing `StorageClass` for new YDB volumes and a temporary PVC with the backup.
   * `--timeout`: Timeout for individual operations and for restoring the YDB dump, in seconds. The default value is `3600`. This is not a limit on the total duration of the script execution.
   * `BACKUP_PATH`: Required path to the backup archive.

1. Check the Kubernetes API server's address and archive path the script will output. To confirm the current data deletion, enter `yes` in the terminal.

1. Wait for this message: `Restore completed successfully`. Do not run multiple script instances at once and do not create backups during restoring.

## Checking the result {#check-result}

1. Check the YDB and {{ iam-name }} state:

   ```bash
   kubectl --kubeconfig "${KUBECONFIG_PATH}" \
     --namespace stackland-iam \
     get storages.ydb.tech,databases.ydb.tech

   kubectl --kubeconfig "${KUBECONFIG_PATH}" \
     --namespace stackland-iam \
     get deployment iam-operator iam-uber

   kubectl --kubeconfig "${KUBECONFIG_PATH}" \
     --namespace stackland-iam \
     get pvc -l ydb.tech/statefulset-name=ydb-storage
   ```

   Expected result:

   * The `Storage/ydb-storage` and `Database/ydb-database` are in the `Ready` state.
   * `iam-operator` and `iam-uber` have one ready replica each.
   * The nine PVCs are in the `Bound` state and have the selected `StorageClass`.

1. Log in to the [management console]({{ link-console-main }}) and make sure that {{ iam-name }} users and settings are recovered from the selected backup.

## If recovery completes with an error {#retry}

Fix the issue specified in the script output and retry the same command with the same archive and parameters. If the timeout is exceeded, check the resource state and increase `--timeout` if needed.

If the `CiliumNetworkPolicy/ydb-restore-block-iam-uber` policy is still there in the `stackland-iam` namespace after the error, do not delete it manually. It blocks {{ iam-name }} queries against the database being restored. At the next run, the script will reuse the policy and delete it after data recovery.

Re-running the script also requires confirmation by entering `yes` and recreates the YDB. Wait for the `Restore completed successfully` message and [check the result](#check-result).
