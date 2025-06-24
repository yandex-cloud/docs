---
title: Step-by-step guides for {{ mch-full-name }}
description: This page provides a list of step-by-step guides for {{ mch-name }}.
---

# Step-by-step guides for {{ mch-name }}

## Clusters {#clusters}

* [Information about existing clusters](cluster-list.md)
* [Creating a cluster](cluster-create.md)
* [Updating cluster settings](update.md)
* [{#T}](change-server-level-settings.md)
* [{#T}](change-query-level-settings.md)
* [{#T}](cluster-version-update.md)
* [Stopping and starting a cluster](cluster-stop.md)
* [Managing {{ CH }} hosts](hosts.md)
* [Managing {{ ZK }} hosts](zk-hosts.md)
* [Migrating cluster hosts to a different availability zone](host-migration.md)
* [Managing backups](cluster-backups.md)
* [Deleting a cluster](cluster-delete.md)

## Connecting to a cluster {#connect}

* [Pre-configuration](connect/index.md)
* [FQDNs of {{ CH }} hosts](connect/fqdn.md)
* [Connecting to a cluster from applications](connect/clients.md)
* [Code examples for connecting to a cluster](connect/code-examples.md)

## Databases {#databases}

* [{#T}](web-sql-query.md)
* [Managing databases](databases.md)
* [User management](cluster-users.md)

## Storing and processing data {#data-storage-and-processing}

* [Managing a custom geobase](geobase.md)
* [Connecting external dictionaries](dictionaries.md)
* [Managing data format schemas](format-schemas.md)
* [Managing machine learning models](ml-models.md)


* [Setting up access to {{ objstorage-name }}](s3-access.md)


## Sharding {#sharding}

* [Managing shards](shards.md)
* [Managing shard groups](shard-groups.md)

## Logs and monitoring {#monitoring-and-logs}

* [Viewing cluster logs](cluster-logs.md)
* [Monitoring the state of clusters and hosts](monitoring.md)
* [Connecting to a cluster from {{ datalens-name }}](datalens-connect.md)


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
