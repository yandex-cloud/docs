---
title: '{{ sd-full-name }} release notes'
description: This section contains the {{ sd-name }} release notes.
---

# {{ sd-full-name }} release notes

## July 2026 {#july-2026}

* In the [{{ cspm-name }}](./concepts/cspm.md), [{{ kspm-name }}](./concepts/kspm.md), and [{{ td-full-name }}](./concepts/threat-detector.md) modules, you can now [configure the display and sorting of security control rules](./operations/cspm/view-rules.md#general-info).
* Added the [option](./operations/alerts/view.md) to filter alerts by an extended set of attributes.
* [{{ vuln-man-name }}](./concepts/vulnerability-management.md) was migrated to a paid plan. For more information, see the [pricing policy](pricing.md#modules-rules).
* Implemented the [blocking mode](./operations/kspm/manage-rule-modes.md) for `admission`-type rules in [{{ kspm-name }}](./concepts/kspm.md), which allows you to prohibit deployment of loads that violate the security policy.
* [{{ cspm-name }}](./concepts/cspm.md) got a new [rule set](./concepts/standard-compliance/ransomware-prevention.md) to minimize the risks of ransomware attacks and an extended list of rules for infrastructure security compliance verification. The new rules govern the password policy and outbound internet access control.
* In [{{ dspm-name }}](./concepts/dspm.md):
  * You can now hook up [custom dictionaries](./concepts/dspm.md#custom-dictionaries) to search for field-specific sensitive data.
  * Added fixed-price [subscriptions](pricing.md#starter-rules) you may prefer over your pay-as-you-go plan.
  * Implemented [continuous change scanning](./concepts/dspm.md#change-scaning) to track the emergence and updates of sensitive data.

## June 2026 {#june-2026}

* {{ sd-full-name }} has entered the [General Availability](../overview/concepts/launch-stages.md) stage. The [Threat Detection](./concepts/threat-detector.md) and Vulnerability Manager modules, along with the AI assistant, remain in [Preview](../overview/concepts/launch-stages.md).
* Added new rules for infrastructure security compliance verification in [{{ cspm-name }}](./concepts/cspm.md). The new rules govern the use of [MFA](./rules-reference/cspm.md#userpool-mfa), [key rotation](./rules-reference/cspm.md#sa-key-rotation), use of [Yandex ID accounts](./rules-reference/cspm.md#yid-organization), tracking of the [last-authenticated date of service accounts](./rules-reference/cspm.md#unused-service-account), and last use of [access keys](./rules-reference/cspm.md#unused-key).
* In [{{ kspm-name }}](./concepts/kspm.md): 
  * [Exceptions](./operations/kspm/manage-exceptions.md) now support excluding resources from checks based on their type, workload name, and labels.
  * Implemented rule modes of the _admission_ type.
  * Supported a new {{ k8s }}® version.
* Added [support](./operations/alerts/work.md#update-batch) for changing the status, assigning owners, and adjusting severity for multiple alerts at once.
* When you create a workspace, the system automatically creates a default alert sink unless the user creates a custom one. 
* Added support for [activating and deactivating workspaces](./operations/workspaces/index.md) in {{ sd-name }}.

## May 2026 {#may-2026}

* [{{ cspm-name }}](./concepts/cspm.md) now includes a new [rule set](./concepts/standard-compliance/yc-gost-57580.md) aligned with GOST R 57580, the national security standard for banking and financial operations. 
* [{{ dspm-name }}](./concepts/dspm.md) now supports creating [scan scopes](./operations/dspm/create-data-source.md#change-scaning) from preliminary analysis results and continuous [monitoring](./concepts/dspm.md#change-scaning) of those scopes for new or modified sensitive data.  
* The pricing model has been expanded: you can now purchase monthly [subscriptions](pricing.md#starter-pricing) for the [{{ cspm-name }}](./concepts/cspm.md) and [Threat Detection](./concepts/threat-detector.md) modules.
* All module [errors](./diagnostics/index.md) are now displayed in a single dedicated interface.
* Scanning {{ yandex-360 }} disks for sensitive data using [{{ dspm-name }}](./concepts/dspm.md) is now available to all users. Previously, this feature was only available upon request.

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
