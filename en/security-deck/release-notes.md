---
title: '{{ sd-full-name }} release notes'
description: This section contains the {{ sd-name }} release notes.
---

# {{ sd-full-name }} release notes

## February 2026 {#february-2026}

* The modules [{{ dspm-name }}](./concepts/dspm.md), [{{ cspm-name }}](./concepts/cspm.md), [{{ kspm-name }}](./concepts/kspm.md), and the [AI assistant](concepts/ai-assistant.md)are now available at the [Preview](../overview/concepts/launch-stages.md) stage.
* Starting February 2, 2025, [{{ kspm-name }}](./concepts/kspm.md) is subject to the [pricing policy](pricing.md#kspm-rules).
* [{{ cspm-name }}](./concepts/cspm.md) now supports new [security standards](./concepts/cspm.md#standards), namely, PCI DSS (Payment Card Industry Data Security Standard) and FSTEC requirements for protection of personal data (Order No. 21).
* New rules for compliance with all supported security standards were implemented in [{{ cspm-name }}](./concepts/cspm.md).

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
