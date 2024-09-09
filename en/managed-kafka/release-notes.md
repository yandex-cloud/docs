# {{ mkf-full-name }} release notes

This section contains {{ mkf-name }} release notes.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## July 2024 {#jule-2024}

* Added automatic increase of disk size. In the [cluster settings](./operations/cluster-update.md), the user can set the disk storage usage threshold and maximum disk size. Upon reaching the threshold, the disk size will automatically increase in fixed increments up to its maximum. You can choose to immediately increase the disk size or to increase it during the next maintenance window.

## March 2024 {#mar-2024}

* Now you can [replace the availability zone](./operations/host-migration.md) for {{ mkf-name }} clusters.

## Q4 2023 {#q4-2023}

* New {{ KF }} version 3.5.1 available in the `PRODUCTION` environment. For more information about revisions, see the [documentation for {{ KF }} 3.5.0](https://archive.apache.org/dist/kafka/3.5.0/RELEASE_NOTES.html) and the [documentation for {{ KF }} 3.5.1](https://archive.apache.org/dist/kafka/3.5.1/RELEASE_NOTES.html). {{ tag-con }}

## Q2 2023 {#q2-2023}

* New {{ KF }} version 3.4 available in the `PRODUCTION` environment. For more information about revisions, see the [{{ KF }} documentation](https://archive.apache.org/dist/kafka/3.4.0/RELEASE_NOTES.html). {{ tag-con }}

## Q1 2023 {#q1-2023}

* New {{ KF }} version 3.3 available in the `PRODUCTION` environment. {{ tag-con }}

## Q4 2022 {#q4-2022}

* Added support for the [Sasl enabled mechanisms](concepts/settings-list.md#settings-sasl-enabled-mechanisms) setting that allows specifying encryption mechanisms available when connecting to a cluster.
* Users with the `admin` role can now delete consumer groups.
* The [S3 Sink](concepts/connectors.md#s3-sink) connector is now available in the CLI. {{ tag-cli }}

## Q3 2022 {#q3-2022}

* Added support for managing connectors in the CLI with the `{{ yc-mdb-kf }} connector` command and MirrorMaker connectors with the `{{ yc-mdb-kf }} connector-mirrormaker` command. {{ tag-cli }}
* Improved the performance of transactions to modify user privileges for a large number of topics.
* Added support for the `Message max bytes`, `Offsets retention minutes`, `Replica fetch max bytes`, and `Ssl cipher suites` [settings](concepts/settings-list.md#cluster-settings).
* Added the ability to create a cluster on local disks on Intel Ice Lake.
* Corrected the way to compute the `kafka_group_topic_partition_lag` metric. For more information, see the [{{ monitoring-full-name }} metric reference](../_includes/monitoring/metrics-ref/managed-kafka.md).
* New {{ KF }} version 3.2 available in the `PRODUCTION` environment. {{ tag-con }}

## Q2 2022 {#q2-2022}

* New connector available: [S3 Sink](concepts/connectors.md#s3-sink). {{ tag-con }}
* New {{ KF }} version 3.1 available in the `PRESTABLE` and `PRODUCTION` environments. {{ tag-con }}
* Added the ability to use an SSL certificate to connect to a cluster via the MirrorMaker connector. {{ tag-con }}
* Added support for offline maintenance.
* Added the ability to configure public access to the CLI. {{ tag-cli }}.
* Prohibited the use of the `preallocate` flag, which causes `CorruptRecordException` (see the [KAFKA-13664](https://issues.apache.org/jira/browse/KAFKA-13664) ticket).
* Added support for standard compression (zstd) for a schema registry.

## Q1 2022 {#q1-2022}

* A new version is available: {{ KF }} 3.0.
