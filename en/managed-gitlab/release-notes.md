---
title: '{{ mgl-full-name }} release notes'
description: This section contains {{ mgl-name }} release notes.
---

# {{ mgl-full-name }} release notes

## Q1 2025 {#q1-2025}

### New features {#q1-2025-new-features}

* Added an option to issue Let's Encrypt TLS certificates via [{{ certificate-manager-full-name }}](../certificate-manager/). To start using {{ certificate-manager-name }} to issue certificates, contact [support]({{ link-console-support }}).
* Added support for the [{{ GL }} Pages](./concepts/index.md#pages) feature at the [Preview](../overview/concepts/launch-stages.md) stage. 

### Fixes and improvements {#q1-2025-problems-solved}

* Improved generation of the main {{ GL }} configuration file, which reduces the probability of mismatch between configurations.
* Improved the mechanism for automatic {{ GL }} instance updates.

## October 2024 {#oct-2024}

You can now monitor the state of your {{ GL }} instance from the {{ yandex-cloud }} management console. You can view the state charts in the **{{ ui-key.yacloud.common.monitoring }}** tab or in [{{ monitoring-full-name }}](../monitoring/concepts/index.md). This feature is currently in [Preview](../overview/concepts/launch-stages.md).

## September 2024 {#sep-2024}

Now you can manage {{ GLR }} agents from the {{ yandex-cloud }} management console. This feature is currently in [Preview](../overview/concepts/launch-stages.md). To get access, contact [support]({{ link-console-support }}) or your account manager.

## July 2024 {#jul-2024}

On July 1, 2024, the [approval rules](concepts/approval-rules.md) feature entered the [General Availability](../overview/concepts/launch-stages.md) stage and is now charged according to the [pricing policy](pricing.md#prices-instance).


## March 2024 {#mar-2024}

Instances residing in the `ru-central1-c` availability zone can now be [migrated to a different zone](operations/instance/zone-migration.md).


## January 2024 {#jan-2024}

* Added the [Yandex ID](operations/omniauth.md#yandex-id) authentication provider.
* Added the service of [migrating an instance](concepts/migration.md) from {{ GL }} to {{ mgl-name }}. This feature is currently in [Preview](../overview/concepts/launch-stages.md).