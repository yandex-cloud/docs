---
title: Restoring databases from a backups in case the availability zone fails
description: The process of restoring managed database clusters from backups if the availability zone fails.
noIndex: true
alternate:
  - href: en/architecture/mdb-outbound-backup-recovery.md
    type: text/markdown
    title: Markdown version
---

# Restoring DB clusters from backups to an external S3 storage

For managed database clusters, backups are created using special utilities, such as WAL-G, and are stored in S3-compatible storage. When transferring a cluster to the client, the following are also transferred along with the cluster: the base backups from the `basebackups_005/` folder and the transaction log archive: WAL files, binary logs, or oplog, depending on the DBMS.

Data is restored on a custom infrastructure without access to {{ yandex-cloud }} or managed database services. Doing this requires deploying a DBMS of the same major version as in the original cluster, installing WAL-G, getting access to reading the bucket with backups, and obtaining a private encryption key. First, a base backup is downloaded that was created before the required time point, and the transaction logs are then reproduced on top of it.

To restore data, use the guide for your respective DBMS:

#|
|| **Service** | **Guide** ||
|| {{ mpg-name }} | [{#T}](../managed-postgresql/operations/cluster-outbound-backups.md) ||
|| {{ mmy-name }} | [{#T}](../managed-mysql/operations/cluster-outbound-backups.md) ||
|| {{ mrd-name }} | [{#T}](../managed-valkey/operations/cluster-outbound-backups.md) ||
|| {{ mmg-name }} | [{#T}](../storedoc/operations/cluster-outbound-backups.md) ||
|| {{ mgp-name }} | [{#T}](../managed-greenplum/operations/cluster-outbound-backups.md) ||
|| {{ mch-name }} | [{#T}](../managed-clickhouse/operations/cluster-outbound-backups.md) ||
|#
