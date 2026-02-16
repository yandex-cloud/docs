---
title: '{{ resmgr-full-name }} release notes'
description: This section contains {{ resmgr-name }} release notes.
---

# {{ resmgr-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}


## Q2 2025 {#q2-2025}

* Added the ability to [create](./operations/cloud/create.md#cli) and [rename](./operations/cloud/update.md#cli) a cloud using the {{ yandex-cloud }} CLI. {{ tag-cli }}

## Q1 2024 {#q1-2024}

* Added automatic deletion of folder limitations when [deleting](operations/cloud/delete.md) a cloud.
* Fixed the error of deleting [{{ cloud-apps-name }}](../cloud-apps/) resources when deleting cloud resources.
* Added support for deleting [{{ maf-name }}](../managed-airflow/) resources when deleting cloud resources.