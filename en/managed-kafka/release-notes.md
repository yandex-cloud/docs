---
title: '{{ mkf-full-name }} release notes'
description: This section contains {{ mkf-name }} release notes.
---

# {{ mkf-full-name }} release notes

## November 2025 {#november-2025}

[Kafbat UI](https://ui.docs.kafbat.io/) is now used for Kafka UI.

## October 2025 {#october-2025}

* Added new [metrics](metrics.md): `can_read`, `can_write`, `kafka_topic_partition_low_water_mark`, and `kafka_topic_partition_high_water_mark`.
* Added new [host classes](concepts/instance-types.md): AMD Zen 4 and AMD Zen 4 HighFreq.

## September 2025 {#september-2025}

* Added a new [service role](security/index.md#managed-kafka-interface-user), `managed-kafka.interfaceUser`, that enables you to use the {{ kafka-ui }}.
* Added the option to select a coordination service when creating a cluster:
   * {{ ZK }} (on separate hosts)
   * {{ kraft-short-name }} (combined mode)
   * {{ kraft-short-name }} (on separate hosts)
* {{ ZK }} is supported by clusters with {{ KF }} 3.6 to 3.9 (inclusive).

## August 2025 {#august-2025}

* [Built-in support for the {{ kafka-ui }} web interface](concepts/kafka-ui.md) is now available in the Kazakhstan [region](../overview/concepts/region.md).
* Added new [user roles](concepts/account-roles.md) for managing {{ KF }} cluster resources: `ACCESS_ROLE_TOPIC_PRODUCER`, `ACCESS_ROLE_TOPIC_CONSUMER`, `ACCESS_ROLE_SCHEMA_READER`, and `ACCESS_ROLE_SCHEMA_WRITER`.
* Added the [ability to migrate](tutorials/zk-kraft-kafka-migration.md) from {{ ZK }} to {{ kraft-short-name }} hosts.
* Added the ability to sync data from {{ KF }} topics to an {{ objstorage-name }} bucket without using the internet.
* Changed the limit for the amount of broker data when using SSD network storage. The new limit is 32,768 GB.

## July 2025 {#july-2025}

* Added [built-in support for {{ kafka-ui }}](concepts/kafka-ui.md) in clusters.
* Now you can [get a discount for commited volumes of services in KRaft](pricing.md#prices-kraft).
* Added the [version update policy](concepts/update-policy.md).
* Added a new [user role](concepts/account-roles.md), `ACCESS_ROLE_TOPIC_ADMIN`, for managing topics.

## May 2025 {#may-2025}

Added the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** section to the management console.

## March 2025 {#mar-2025}

* Added support for the new {{ KF }} 3.7, 3.8, and 3.9. These versions are available in the `PRODUCTION` environment. For more information about the updates, see [this {{ KF }} guide](https://kafka.apache.org/documentation.html).
* Starting March 1, 2025, support for {{ KF }} versions 2.8, 3.0, 3.1, 3.2, and 3.3 is discontinued. You cannot create a cluster with these versions.

## July 2024 {#jul-2024}

Added automatic increase of disk size. In the [cluster settings](./operations/cluster-update.md), the user can set the disk storage usage threshold and maximum disk size. Upon reaching the threshold, the disk size will automatically increase in fixed increments up to its maximum. You can choose to immediately increase the disk size or to increase it during the next maintenance window.

## March 2024 {#mar-2024}

Now you can [replace the availability zone](./operations/host-migration.md) for {{ mkf-name }} clusters.

## Q4 2023 {#q4-2023}

New {{ KF }} version 3.5.1 is available in the `PRODUCTION` environment. For more information about revisions, see [this {{ KF }} 3.5.0 guide](https://archive.apache.org/dist/kafka/3.5.0/RELEASE_NOTES.html) and this [{{ KF }} 3.5.1 guide](https://archive.apache.org/dist/kafka/3.5.1/RELEASE_NOTES.html).

## Q2 2023 {#q2-2023}

New {{ KF }} version 3.4 is available in the `PRODUCTION` environment. For more information about the updates, see [this {{ KF }} guide](https://archive.apache.org/dist/kafka/3.4.0/RELEASE_NOTES.html).

## Q1 2023 {#q1-2023}

New {{ KF }} version 3.3 is available in the `PRODUCTION` environment.

## Q4 2022 {#q4-2022}

* Added support for the [Sasl enabled mechanisms](concepts/settings-list.md#settings-sasl-enabled-mechanisms) setting that allows specifying encryption mechanisms available when connecting to a cluster.
* Users with the `admin` role can now delete consumer groups.
* The [S3 Sink](concepts/connectors.md#s3-sink) connector is now available in the CLI.

## Q3 2022 {#q3-2022}

* Added support for managing connectors in the CLI with the `{{ yc-mdb-kf }} connector` command and MirrorMaker connectors with the `{{ yc-mdb-kf }} connector-mirrormaker` command.
* Improved the performance of transactions to modify user privileges for a large number of topics.
* The `Message max bytes`, `Offsets retention minutes`, `Replica fetch max bytes`, and `Ssl cipher suites` [settings](concepts/settings-list.md#cluster-settings) are now supported.
* Added the ability to create a cluster on local disks on Intel Ice Lake.
* Fixed the `kafka_group_topic_partition_lag` metric calculation. For more information, see the [{{ monitoring-full-name }} metric reference](metrics.md).
* New {{ KF }} version 3.2 is available in the `PRODUCTION` environment.

## Q2 2022 {#q2-2022}

* A new connector is now available: [S3 Sink](concepts/connectors.md#s3-sink).
* New {{ KF }} version 3.1 is available in the `PRESTABLE` and `PRODUCTION` environments.
* Added the ability to use an SSL certificate to connect to a cluster via the MirrorMaker connector.
* Added support for offline maintenance.
* Added the ability to configure public access to the CLI.
* Prohibited the use of the `preallocate` flag causing `CorruptRecordException` (see the [KAFKA-13664](https://issues.apache.org/jira/browse/KAFKA-13664) ticket).
* Added support for standard compression (zstd) for a schema registry.

## Q1 2022 {#q1-2022}

A new version is available: {{ KF }} 3.0.
