---
title: '{{ mos-full-name }} release notes'
description: This section contains {{ mos-name }} release notes.
---

# {{ mos-full-name }} release notes


## July 2025 {#jul-2025}

Now you can [encrypt storage disks](concepts/storage.md#disk-encryption) with a custom KMS key when creating a cluster and restoring it from a backup.


## April 2025 {#apr-2025}

* Implemented a new shard balancing algorithm. In addition to the number of shards and primary shards, it takes the amount of free space into consideration and can balance primary shards better than the standard algorithm.
* Added the ability to specify a host group when reading or writing via the `X‑Yandex‑OpenSearch‑NodeGroup` parameter in the request header.

## October 2024 {#oct-2024}

* Added support of the `yandex-lemmer` [plugin](concepts/plugins.md#yandex-lemmer) for accurate search in Russian.
* A new version is out: {{ OS }} [2.17.0](https://github.com/opensearch-project/opensearch-build/blob/main/release-notes/opensearch-release-notes-2.17.0.md).
* Added the session timeout option (**{{ ui-key.yacloud.opensearch.auth.field_jwt-default-expiration-timeout }}**) to [external authentication sources settings](operations/saml-authentication.md#configuration-sso). Specify if not set by the identity provider.

## September 2024 {#sep-2024}

Added automatic increase of disk size. In the [cluster settings](operations/update.md), the user can set the disk storage usage threshold and maximum disk size. Upon reaching the threshold, the disk size will automatically increase in fixed increments up to its maximum. You can choose to immediately increase the disk size or to increase it during the next maintenance window.

## April 2024 {#apr-2024}

A new version is out: {{ OS }} [2.12.0](https://github.com/opensearch-project/opensearch-build/blob/main/release-notes/opensearch-release-notes-2.12.0.md).

## February 2024 {#feb-2024}

Now you can manage {{ OS }} clusters using the [CLI commands](../cli/cli-ref/managed-opensearch/cli-ref/index.md) and [{{ TF }}](./tf-ref.md).

## Q3 2023 {#q3-2023}

Added the option of [committing](../billing/concepts/cvos.md) a specific volume of services. All users of the platform can get a discount up to 22% starting from August 1, 2023. The cost of services will not change during the whole period of the offer.