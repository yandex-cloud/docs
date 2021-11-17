---
title: Yandex Audit Trails. Обзор сервиса
description: 'Yandex Audit Trails позволяет собирать аудитные логи о происходящих с ресурсами Yandex.Cloud событиях и загружать эти логи в бакет или лог-группу для дальнейшего анализа или экспорта.'
---

# {{ at-full-name }} overview

{{ at-full-name }} lets you collect audit logs of {{ yandex-cloud }} resources and upload them to a {{ objstorage-name }} bucket or {{ cloud-logging-name }} log group:

* [Uploading audit logs to a bucket](../operations/export-bucket.md).
* [Uploading audit logs to Cloud Logging](../operations/export-cloud-logging.md).

Collecting audit logs lets you use analytical tools and rapidly respond to events that occur to {{ yandex-cloud }} services:

* [Searching audit logs in a bucket](../solutions/search-bucket.md).
* [Searching audit logs in a log group](../solutions/search-cloud-logging.md).
* [Exporting audit logs to SIEM systems](./export-siem.md).
* Setting up alerts in Cloud Logging.

{{ yandex-cloud }} services whose audit logs {{ at-name }} collects:

* {{ at-full-name }}
* {{ cloud-logging-name }}
* {{ compute-name }}
* {{ iam-name }}
* {{ kms-name }}
* {{ lockbox-name }}
* {{ objstorage-name }}
* {{ resmgr-name }}
* {{ vpc-name }}
* {{ ydb-name }}

The following events are logged:

* Logins by federated users.
* Creating/deleting service accounts.
* Creating/deleting keys of service accounts.
* Editing user roles and service accounts.
* Creating/deleting resources.
* Editing resource settings.
* Stopping/restarting a resource.
* Changing access policies.
* Creating/editing security groups.
* Actions with encryption keys and secrets.

## Current service limits {#known-restrictions}

For more information about service limits, see [Quotas and limits](limits.md).

