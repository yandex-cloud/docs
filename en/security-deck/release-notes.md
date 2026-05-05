---
title: '{{ sd-full-name }} release notes'
description: This section contains the {{ sd-name }} release notes.
---

# {{ sd-full-name }} release notes

## March 2026 {#march-2026}
* Released [Vulnerability Management (VM)](./concepts/vulnerability-management.md). This module is in [Preview](../overview/concepts/launch-stages.md) and available only upon request.
* [DSPM](./concepts/dspm.md) now supports preliminary [analysis of data](./concepts/dspm.md#discovery-mode) stored in {{ objstorage-name }} buckets within a workspace.
* You can now [group](./operations/alerts/view.md#search) alerts by type and filter them by new attributes.
* In [KSPM](./concepts/kspm.md), you can now specify objects in [exceptions](./operations/kspm/manage-exceptions.md) using search by namespace.
* In [CSPM](./concepts/cspm.md), added new rules for checking infrastructure for compliance with security standards. The new rules control the [assignment](./rules-reference/cspm.md#check-privileged-roles) of privileged roles, DDoS [protection](./rules-reference/cspm.md#appsec-ddos-protection-l3) at the network level, service account [access](./rules-reference/cspm.md#access) to {{ k8s }}® clusters, and redundant service account roles at the [organization](./rules-reference/cspm.md#sa-privileges-org-roles) and [service](./rules-reference/cspm.md#sa-privileges-service-roles) levels. 

## February 2026 {#february-2026}

* [{{ dspm-name }}](./concepts/dspm.md), [{{ cspm-name }}](./concepts/cspm.md), [{{ kspm-name }}](./concepts/kspm.md), and the [AI assistant](concepts/ai-assistant.md) are now in [Preview](../overview/concepts/launch-stages.md).
* As of February 2, 2025, [{{ kspm-name }}](./concepts/kspm.md) is charged according to the [pricing policy](pricing.md#kspm-rules).
* Supported new [security standards](./concepts/cspm.md#standards) in [{{ cspm-name }}](./concepts/cspm.md): PCI DSS (Payment Card Industry Data Security Standard) and requirements of the FSTEC of Russia (Order No. 21) aimed at protection of personal data. 
* In [{{ cspm-name }}](./concepts/cspm.md), implemented new compliance rules for all supported security standards.

## January 2026 {#january-2026}

* Introduced fixed-price subscriptions for [{{ dspm-name }}](./concepts/dspm.md). You can purchase a subscription instead of paying for the actual resource consumption. The subscription pricing will soon be available in the [Pricing policy](pricing.md) section.
* Implemented an [API](./api-ref/Alert/index.md) to work with alerts.

## Q4 2025 {#q4-2025}

* Added support for [{{ yandex-360 }}](https://360.yandex.ru/) disks as [scan sources](./operations/dspm/create-scan.md#yandex-360) in {{ dspm-name }}.
* Image scanning in [{{ dspm-name }}](./concepts/dspm.md) is now subject to the [pricing policy](pricing.md#dspm-rules).
* Added the [compliance check interface](./concepts/standard-compliance/index.md).

## Q3 2025 {#q3-2025}

* Launched [{{ kspm-name }}](./concepts/kspm.md) and [{{ cspm-name }}](./concepts/cspm.md).
* You can now use {{ kspm-name }} and {{ cspm-name }} as data sources for [alerts](./concepts/alerts.md).
* You can now [create a {{ sd-name }} workspace](./operations/workspaces/index.md), which is a container for module settings and resources, list of controlled resources, control parameters, and other settings.
* Added an [AI assistant](concepts/ai-assistant.md).
* [{{ dspm-name }}](./concepts/dspm.md) now supports [partial scanning](./operations/dspm/create-scan.md) and [image scanning](./operations/dspm/create-scan.md).
