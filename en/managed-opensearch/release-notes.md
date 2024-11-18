---
title: '{{ mos-full-name }} release notes'
description: This section contains {{ mos-name }} release notes.
---

# {{ mos-full-name }} release notes

## September 2024 {#sep-2024}

Added automatic increase of disk size. In the [cluster settings](operations/update.md), the user can set the disk storage usage threshold and maximum disk size. Upon reaching the threshold, the disk size will automatically increase in fixed increments up to its maximum. You can choose to immediately increase the disk size or to increase it during the next maintenance window.

## April 2024 {#apr-2024}

* A new {{ OS }} version is available: [2.12.0](https://github.com/opensearch-project/opensearch-build/blob/main/release-notes/opensearch-release-notes-2.12.0.md).

## February 2024 {#feb-2024}

* Now you can manage {{ OS }} clusters using the [CLI commands](../cli/cli-ref/managed-services/managed-opensearch/index.md) and [{{ TF }}](./tf-ref.md).

## Q3 2023 {#q3-2023}

* Added the option of [committing](../billing/concepts/cvos.md) a specific volume of services. All users of the platform can get a discount up to 22% starting from August 1, 2023. The cost of services will not change during the whole period of the offer.