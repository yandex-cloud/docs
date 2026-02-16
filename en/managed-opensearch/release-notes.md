---
title: '{{ mos-full-name }} release notes'
description: This section contains the {{ mos-name }} release notes.
---

# {{ mos-full-name }} release notes

## December 2025 {#dec-2025}

* Added [detailed metrics](operations/monitoring.md#hosts) for disk usage on cluster hosts.
* Added execution details for [operations on the cluster](operations/cluster-list.md#list-operations).
* The [updated](operations/cluster-version-update.md) {{ OS }} versions [3.3.2](https://github.com/opensearch-project/opensearch-build/blob/main/release-notes/opensearch-release-notes-3.3.2.md) and [3.4.0](https://github.com/opensearch-project/opensearch-build/blob/main/release-notes/opensearch-release-notes-3.4.0.md) improve the performance of queries with aggregation and fix a number of bugs, including the [NPE error when executing bulk queries](https://github.com/opensearch-project/k-NN/issues/2852).

## November 2025 {#nov-2025}

Added the `managed-opensearch.restorer` role for restoring clusters from backups. To learn more, see [Access management](security/index.md#managed-opensearch-restorer).

## October 2025 {#oct-2025}

Added new [host classes](concepts/instance-types.md) on AMD Zen 4 and AMD Zen 4 HighFreq platforms.


## July 2025 {#jul-2025}

Now you can [encrypt storage disks](concepts/storage.md#disk-encryption) with a custom KMS key when creating a cluster and restoring it from a backup.


## April 2025 {#apr-2025}

* Implemented a new shard balancing algorithm. In addition to the number of shards and primary shards, it takes the amount of free space into consideration and can balance primary shards better than the standard algorithm.
* Added the option to specify a host group for data reads/writes via the `X‑Yandex‑OpenSearch‑NodeGroup` parameter in the request header.

## October 2024 {#oct-2024}

* Added support for the `yandex-lemmer` [plugin](concepts/plugins.md#yandex-lemmer) for accurate search in Russian.
* A new {{ OS }} version is out: [2.17.0](https://github.com/opensearch-project/opensearch-build/blob/main/release-notes/opensearch-release-notes-2.17.0.md).
* Added the session timeout option (**{{ ui-key.yacloud.opensearch.auth.field_jwt-default-expiration-timeout }}**) to [external authentication sources settings](operations/saml-authentication.md#configuration-sso). Specify it if it is not set by the identity provider.

## September 2024 {#sep-2024}

Added automatic disk expansion. In the [cluster settings](operations/update.md), the user can set the disk storage usage threshold and maximum disk size. Upon reaching the threshold, the disk will automatically expand in fixed increments up to its maximum. You can choose to immediately expand the disk or to expand it during the next maintenance window.

## April 2024 {#apr-2024}

A new {{ OS }} version is out: [2.12.0](https://github.com/opensearch-project/opensearch-build/blob/main/release-notes/opensearch-release-notes-2.12.0.md).

## February 2024 {#feb-2024}

Now you can manage {{ OS }} clusters using the [CLI commands](../cli/cli-ref/managed-opensearch/cli-ref/index.md) and [{{ TF }}](./tf-ref.md).

## Q3 2023 {#q3-2023}

Added the option of [committing](../billing/concepts/cvos.md) a specific volume of services. All platform users can get a discount up to 22% starting August 1, 2023. The cost of services will not change while the discount is in effect.