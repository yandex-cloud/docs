---
title: '{{ resmgr-full-name }} release notes'
description: This section contains the {{ resmgr-name }} release notes.
---

# {{ resmgr-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}


## March 2026 {#march-2026}

* Added support for the `--parameters` parameter to the following commands: {{ tag-cli }}
  * `yc resource-manager folder bind-access-policy`
  * `yc resource-manager cloud bind-access-policy`

## December 2025 {#december-2025}

* Added commands for [access policy](../iam/concepts/access-control/access-policies.md) management in a [cloud](operations/cloud/manage-access-policies.md): {{ tag-cli }}
  * `yc resource-manager cloud list-access-policy-bindings`
  * `yc resource-manager cloud bind-access-policy`
  * `yc resource-manager cloud unbind-access-policy`
* Added commands for [access policy](../iam/concepts/access-control/access-policies.md) management in a [folder](operations/folder/manage-access-policies.md): {{ tag-cli }}
  * `yc resource-manager folder list-access-policy-bindings`
  * `yc resource-manager folder bind-access-policy`
  * `yc resource-manager folder unbind-access-policy`

## Q2 2025 {#q2-2025}

* Added the ability to [create](./operations/cloud/create.md#cli) and [rename](./operations/cloud/update.md#cli) a cloud using the {{ yandex-cloud }} CLI. {{ tag-cli }}

## Q1 2024 {#q1-2024}

* Added automatic deletion of folder limitations when [deleting](operations/cloud/delete.md) a cloud.
* Fixed the error of deleting [{{ cloud-apps-name }}](../cloud-apps/) resources when deleting cloud resources.
* Added support for deleting [{{ maf-name }}](../managed-airflow/) resources when deleting cloud resources.