# {{ mkf-full-name }} revision history

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.06.2022 {#01.06.2022}

* {{ KF }} version 3.1 is available in the `PRESTABLE` environment. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Added the ability to use an SSL certificate to connect to a cluster via the MirrorMaker connector. {{ tag-con }}
* Added support for offline maintenance.

## 01.05.2022 {#01.05.2022}

* Added the ability to configure public access to the CLI. {{ tag-cli }}.
* Prohibited the use of the `preallocate` flag, which causes `CorruptRecordException` (see the [KAFKA-13664](https://issues.apache.org/jira/browse/KAFKA-13664) ticket).
* Added support for standard compression (zstd) for a schema registry.

## 01.04.2022 {#01.04.2022}

* A new version is available: {{ KF }} 3.0.
