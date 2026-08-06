---
title: '{{ sd-full-name }} release notes'
description: This section contains the {{ sd-name }} release notes.
---

# {{ sd-full-name }} release notes

## June 2026 {#june-2026}

* {{ sd-full-name }} has entered the [General Availability](../overview/concepts/launch-stages.md) stage. The [Threat Detection](./concepts/threat-detector.md) and Vulnerability Manager modules, along with the AI assistant, remain in [Preview](../overview/concepts/launch-stages.md).
* Added new rules for infrastructure security compliance verification in [{{ cspm-name }}](./concepts/cspm.md). New rules now govern using MFA, rotating keys, tracking service account last authentication dates, and using Yandex ID accounts.
* In [{{ kspm-name }}](./concepts/kspm.md): 
  * [Exceptions](./operations/kspm/manage-exceptions.md) now allow excluding resources from checks by resource type, workload name, and labels.
  * Implemented rule modes of the _admission_ type.
  * Added support for new {{ k8s }}® version.
* Added [support](./operations/alerts/work.md#update-batch) for changing status, assigning owners, and adjusting severity for multiple alerts at once.
* Creating a workspace automatically creates a default alert sink unless the user creates a custom one. 
* Added support for [activating and deactivating workspaces](./operations/workspaces/index.md) in {{ sd-name }}.

## May 2026 {#may-2026}

* [{{ cspm-name }}](./concepts/cspm.md) now includes a new [ruleset](./concepts/standard-compliance/yc-gost-57580.md) aligned with GOST R 57580, the national security standard for banking and financial operations. 
* [{{ dspm-name }}](./concepts/dspm.md) now supports creating [scan scopes](./operations/dspm/create-data-source.md#change-scaning) from preliminary analysis results and continuously [monitoring](./concepts/dspm.md#change-scaning) those scopes for new or modified sensitive data.  
* The pricing model has been expanded: you can now purchase monthly [subscriptions](pricing.md#starter-pricing) for the [{{ cspm-name }}](./concepts/cspm.md) and [Threat Detection](./concepts/threat-detector.md) modules.
* All module [errors](./diagnostics/index.md) are now displayed in a unified error interface.
* Now all users can enjoy [{{ dspm-name }}](./concepts/dspm.md)'s capability to scan {{ yandex-360 }} disks for sensitive data; previously, this feature was only available upon request.

## April 2026 {#april-2026}

* [{{ td-full-name }}](./concepts/threat-detector.md) (TD) kicked off. This module is in [Preview](../overview/concepts/launch-stages.md) and available only upon request.
* Added new rules for infrastructure security compliance verification in [{{ cspm-name }}](./concepts/cspm.md). The new rules regulate {{ mgl-name }} instance [security event monitoring](./rules-reference/cspm.md#gitlab-audited) and user credential management.
* You can now manually [initiate](./operations/cspm/check-environment.md) an infrastructure security compliance verification procedure in [{{ cspm-name }}](./concepts/cspm.md).
* You can also [view and download](./operations/dspm/discovery-mode.md) the results of preliminary analysis in [{{ dspm-name }}](./concepts/dspm.md).
* On the [{{ cspm-name }}](./concepts/cspm.md) and [{{ kspm-name }}](./concepts/kspm.md) alerts page, you can now [exclude a resource](./operations/alerts/work.md#create-exception) from the compliance check.

## March 2026 {#march-2026}
* Released the [{{ vuln-man-name }} (VM)](./concepts/vulnerability-management.md) module. This module is in [Preview](../overview/concepts/launch-stages.md) and available only upon request.
* [{{ dspm-name }}](./concepts/dspm.md) now supports preliminary [analysis of data](./concepts/dspm.md#discovery-mode) stored in {{ objstorage-name }} buckets within a workspace.
* You can now [group](./operations/alerts/view.md#search) alerts by type and filter them by new attributes.
* In [{{ kspm-name }}](./concepts/kspm.md), you can now specify objects in [exceptions](./operations/kspm/manage-exceptions.md) using search by namespace.
* Added new rules for infrastructure security compliance verification in [{{ cspm-name }}](./concepts/cspm.md). The new rules control the [assignment](./rules-reference/cspm.md#check-privileged-roles) of privileged roles, DDoS [protection](./rules-reference/cspm.md#appsec-ddos-protection-l3) at the network level, service account [access](./rules-reference/cspm.md#access) to {{ k8s }}® clusters, and redundant service account roles at the [organization](./rules-reference/cspm.md#sa-privileges-org-roles) and [service](./rules-reference/cspm.md#sa-privileges-service-roles) levels. 

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
