---
title: '{{ mtr-full-name }} release notes'
description: This section contains {{ mtr-name }} release notes.
---

# {{ mtr-full-name }} release notes

## September 2025 {#september-2025}

Now you can select a {{ TR }} version when [creating](operations/cluster-create.md) or [updating](operations/cluster-update.md#change-version) a cluster.

## August 2025 {#august-2025}

Now you can use the [REST](api-ref/Catalog/index.md) methods and the [gRPC](api-ref/grpc/Catalog/index.md) call to work with [catalogs in a {{ TR }} cluster](operations/index.md#catalogs).
 
## July 2025 {#july-2025}

* On July 21, 2025, {{ mtr-name }} entered the [General Availability](../overview/concepts/launch-stages.md) stage and is now subject to the [pricing policy](pricing.md).
* Now you can [get detailed operation info for a cluster](operations/cluster-list.md).
* You can also [get a list of the cluster's {{ TR }} catalogs](operations/cluster-list.md).

## June 2025 {#june-2025}

* Added support for [fault-tolerant execution of queries in cluster](concepts/retry-policy.md).
* Enabled operations on a {{ TR }} cluster and catalogs via the [{{ yandex-cloud }} CLI](../cli/cli-ref/managed-trino/cli-ref/index.md), [{{ TF }}](tf-ref.md).

## May 2025 {#may-2025}

* [A new connector is now available](concepts/index.md#connector): MS SQL Server.
* Added the [**{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**](operations/cluster-maintenance.md) section to the management console.

## April 2025 {#april-2025}

* {{ mtr-full-name }} is now in [Public Preview](../overview/concepts/launch-stages.md).
* [A new connector is now available](concepts/index.md#connector): Oracle.
* Added integration with {{ connection-manager-full-name }}.
* Enabled operations on a {{ TR }} cluster via [API](api-ref/authentication.md).
