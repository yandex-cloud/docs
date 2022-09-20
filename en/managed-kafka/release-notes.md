# {{ mkf-full-name }} releases

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.08.2022 {#01.08.2022}

* Improved the performance of transactions to modify user privileges for a large number of topics.
* Added support for the `message.max.bytes`, `offsets.retention.minutes`, `replica.fetch.max.bytes`, and `ssl.cipher.suites` settings. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Added the ability to create a cluster on local disks on Intel Ice Lake.
* Corrected the way to compute the `kafka_group_topic_partition_lag` metric. {% if audience != "internal" %} For more information, see the [{{ monitoring-full-name }} metric reference](https://cloud.yandex.ru/docs/monitoring/metrics-ref/#managed-kafka). {% endif %}
* New {{ KF }} version 3.2 available in `PRODUCTION` environment. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

## 01.07.2022 {#01.07.2022}

* New connector available: [S3 Sink](concepts/connectors.md#s3-sink). {{ tag-con }}
* New {{ KF }} version 3.1 available in `PRODUCTION` environment. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

## 01.06.2022 {#01.06.2022}

* New {{ KF }} version 3.1 available in `PRESTABLE` environment. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Added the ability to use an SSL certificate to connect to a cluster via the MirrorMaker connector. {{ tag-con }}
* Added support for offline maintenance.

## 01.05.2022 {#01.05.2022}

* Added the ability to configure public access to the CLI. {{ tag-cli }}.
* Prohibited the use of the `preallocate` flag, which causes `CorruptRecordException` (see the [KAFKA-13664](https://issues.apache.org/jira/browse/KAFKA-13664) ticket).
* Added support for standard compression (zstd) for a schema registry.

## 01.04.2022 {#01.04.2022}

* A new version is available: {{ KF }} 3.0.
