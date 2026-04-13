---
title: Upgrading the major {{ PG }} version in {{ mpg-name }}
description: To upgrade the major {{ PG }} version in {{ mpg-name }}, select a suitable time and version and start the update. The major version update is performed automatically.
---

# Upgrading the major {{ PG }} version in {{ mpg-full-name }}

To upgrade the major {{ PG }} version in {{ mpg-name }}, select a suitable time and version and [start the update](../operations/cluster-version-update.md#start-update).

To upgrade a major version, the following must be free:

* For [disks](storage.md) with a capacity of 100 GB or less: At least 10% of the storage volume.
* For disks with a capacity of over 100 GB: At least 10 GB.

Before upgrading, we recommend [creating a backup](../operations/cluster-backups.md#create-backup) of the cluster and then testing the update on a test cluster to ensure it runs correctly. You can deploy the test cluster from the backup.

You can only upgrade a major version step by step, one version at a time.

> For example, if you need to update a cluster from version `14` to `16`, first update it from `14` to `15`, and then from `15` to `16`.

{% note info %}

Upgrade from a standard version to a _1С:Enterprise_ version (e.g., `14` to `14-1c`) is not supported.

{% endnote %}

The update process runs automatically and includes the following steps:

1. Checking that the upgrade is possible.
1. Upgrading extensions.
1. Preparing the master:
    
    1. Disabling `autovacuum`.
    1. Updating the statistics collection settings.
    1. Stopping the master.

1. Configuring the master settings.
1. Performing a binary update of the master.
1. Checking the master after the binary update and updating the configuration.
1. Starting the master in restricted mode.
1. Collecting reduced statistics using the `vacuumdb` command with the `--analyze-in-stages` and `--all` options. The command runs with a timeout of 300 seconds.

    Statistics collection is performed in three stages. In the first stage, preliminary statistics are collected with `default_statistics_target=100`. In the second and third stages, full statistics are collected.

1. Sequential replica update. The order of replica updates is determined randomly.
1. Switching the master to normal mode.

The master is unavailable for reads and writes during the major version update. No [role switching](../concepts/replication.md#replication-auto) occurs. Each replica is only unavailable for reads during its own update. As a result, the cluster is unavailable for writes during the update. Read availability depends on the number of hosts in the cluster:

* A cluster with a single host is unavailable for reads.
* A cluster with two hosts is available for reads during the master update but unavailable during the replica update.
* A cluster with three or more hosts is always available for reads.

How long an upgrade takes depends on the number of affected databases and the number of objects in each of them. The more databases and objects there are, the longer your upgrade will take.

To learn about updates within the same version and host maintenance, see [Maintenance](../concepts/maintenance.md).