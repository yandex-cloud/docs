---
title: '{{ mgl-full-name }} release notes'
description: This section contains the {{ mgl-name }} release notes.
---

# {{ mgl-full-name }} release notes

## Q1-Q3 2026 {#q1-q3-2026}

* The feature enabling you to [store {{ GL }} data in {{ objstorage-full-name }}](./concepts/s3-integration.md) has entered the [General Availability](../overview/concepts/launch-stages.md) stage. You can now select data types to offload to object storage, reducing instance disk usage and preventing its overflow. To enable the integration, follow [this guide](./operations/objstorage-integration.md). This feature is billed based on the [pricing policy](./pricing.md).
* Released [managed runners](./concepts/index.md#managed-runners) for [General Availability](../overview/concepts/launch-stages.md). You can now automatically deploy and scale VMs with {{ GL }} workers based on the load, customize their computing resources, disks, service accounts, and security groups. For more information on managed runners, see [this guide](./operations/runner.md) and [this tutorial](./tutorials/install-gitlab-runner.md#create-runner).

  {% include [note-payment](../_includes/managed-gitlab/note-payment.md) %}

* Introduced advanced features for [backup management](./operations/instance/instance-backups.md). You can now view the list and manually create backups, use them to restore your current instance or create a new one, download backups and secrets using signed links, as well as delete backups you no longer need.
* In the management console, added a notification about the instance’s total disk usage approaching the [allowed limit](./concepts/limits.md#limits).

  {% note tip %}

  To reduce the risk of disk overflow, enable [{{ GL }} data storage in {{ objstorage-name }}](./operations/objstorage-integration.md).

  {% endnote %}

* Upgraded {{ GL }} to version [18.11.11](https://docs.gitlab.com/releases/patches/patch-release-gitlab-19-2-4-released/).

## Q4 2025 {#q4-2025}

Added new parameters for {{ GL }} workers created by [managed {{ yandex-cloud }} runners](./tutorials/install-gitlab-runner.md#create-runner):
* [Security groups](../vpc/concepts/security-groups.md) for managing worker network access.
* [Service account](../iam/concepts/users/service-accounts.md) that will be used to authenticate the worker in {{ yandex-cloud }} from CI/CD pipelines.

## Q3 2025 {#q3-2025}

Supported the option to [store {{ GL }} data in {{ objstorage-full-name }}](./concepts/s3-integration.md).

## Q2 2025 {#q2-2025}

* Added support for {{ GL }} instance management using the [CLI](./cli-ref/index.md), [{{ TF }}](tf-ref.md), and [API](./api-ref/authentication.md).
* Implemented an option to select a [security group](../vpc/concepts/security-groups.md) when [creating](./operations/instance/instance-create.md) and [updating](./operations/instance/instance-update.md) a {{ GL }} instance. For more information, see [{#T}](./operations/configure-security-group.md).
* Added support for [getting information about service operations](./operations/instance/instance-list.md) using the CLI and API.

## Q1 2025 {#q1-2025}

### New features {#q1-2025-new-features}

* Added an option to issue Let's Encrypt TLS certificates via [{{ certificate-manager-full-name }}](../certificate-manager/). To start using {{ certificate-manager-name }} to issue certificates, contact [support]({{ link-console-support }}).
* Added support for the [{{ GL }} Pages](./concepts/index.md#pages) feature at the [Preview](../overview/concepts/launch-stages.md) stage. 

### Fixes and improvements {#q1-2025-problems-solved}

* Improved generation of the main {{ GL }} configuration file, which reduces the probability of mismatch between configurations.
* Improved automatic {{ GL }} instance updating.

## October 2024 {#oct-2024}

You can now monitor the state of your {{ GL }} instance from the {{ yandex-cloud }} management console. You can view the state charts in the **{{ ui-key.yacloud.common.monitoring }}** tab or in [{{ monitoring-full-name }}](../monitoring/concepts/index.md). This feature is currently at the [Preview](../overview/concepts/launch-stages.md) stage.

## September 2024 {#sep-2024}

You can now manage {{ GLR }} agents using the {{ yandex-cloud }} management console. This feature is currently at the [Preview](../overview/concepts/launch-stages.md) stage. To gain access, contact [support]({{ link-console-support }}) or your account manager.

## July 2024 {#jul-2024}

On July 1, 2024, the [approval rules](concepts/approval-rules.md) feature entered the [General Availability](../overview/concepts/launch-stages.md) stage and is now subject to the [pricing policy](pricing.md#prices-instance).


## March 2024 {#mar-2024}

Instances residing in the `ru-central1-c` availability zone can now be [migrated to a different zone](operations/instance/zone-migration.md).


## January 2024 {#jan-2024}

* Added the [Yandex ID](operations/omniauth.md#yandex-id) authentication provider.
* Added support for [migrating an instance](concepts/migration.md) from {{ GL }} to {{ mgl-name }}. This feature is currently at the [Preview](../overview/concepts/launch-stages.md) stage.
