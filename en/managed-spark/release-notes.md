---
title: '{{ msp-full-name }} release notes'
description: This section contains {{ msp-name }} release notes.
---

# {{ msp-full-name }} release notes

## August 2026 {#august-2026}

Added the ability to use [basic and custom environments](operations/environment-create.md) with specified {{ SPRK }} and Python versions and additional pip and deb packages.

## March 2026 {#march-2026}

Added separate roles to view and edit maintenance tasks: [managed-spark.maintenanceTask.viewer](security.md#managed-spark-maintenanceTask-viewer), [managed-spark.maintenanceTask.editor](security.md#managed-spark-maintenanceTask-editor).

## February 2026 {#february-2026}

* Added the [**{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**](operations/cluster-maintenance.md) section to the management console.
* Added the ability to [configure cluster access permissions](operations/cluster-access.md).

## December 2025 {#december-2025}

* Added the ability to [select and update](operations/cluster-version-update.md) a cluster’s {{ SPRK }} version.

## September 2025 {#september-2025}

* On September 22, 2025, {{ msp-full-name }} entered the [General Availability](../overview/concepts/launch-stages.md) stage and is now subject to the [pricing policy](pricing.md).
* Added support for [SparkConnect jobs](operations/jobs-sparkconnect.md).

## August 2025 {#august-2025}

* {{ msp-full-name }} is now available in the Kazakhstan [region](../overview/concepts/region.md).
* You can now [change your {{ SPRK }} cluster's settings](operations/cluster-update.md) after you create one.

## May 2025 {#may-2025}

* {{ msp-full-name }} is now in [Public Preview](../overview/concepts/launch-stages.md).
* Added the ability to perform operations on an {{ SPRK }} cluster via [Terraform](tf-ref.md) and [API](api-ref/authentication.md).
