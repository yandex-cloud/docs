---
title: "{{ at-full-name }}. Overview"
description: "{{ at-full-name }} lets you collect audit logs about {{ yandex-cloud }} resource events and upload them for further analysis and export."
---

# {{ at-full-name }} overview

{{ at-full-name }} allows you to collect [management event audit logs](./events.md) and [data event audit logs](./events-data-plane.md) for {{ yandex-cloud }} resources and upload them to a {{ objstorage-name }} bucket, {{ yds-name }} stream, or {{ cloud-logging-name }} log group:

* [Uploading audit logs to a bucket](../operations/index.md#bucket).
* [Uploading audit logs to Cloud Logging](../operations/index.md#logging).
* [Uploading audit logs to a data stream](../operations/index.md#data-streams).

Collecting audit logs enables you to use analytical tools and promptly respond to {{ yandex-cloud }} events:

* [Searching audit logs in a bucket](../tutorials/search-bucket.md).
* [Searching audit logs in a log group](../tutorials/search-cloud-logging.md).
* [Exporting audit logs to SIEM systems](./export-siem.md).
* [Alert settings in {{ monitoring-full-name }}](../tutorials/alerts-monitoring.md).

The following [management events](./events.md) are logged:

* Logins by federated users
* Creating/deleting service accounts
* Creating/deleting keys of service accounts
* Editing user roles and service accounts
* Creating/deleting resources
* Editing resource settings
* Stopping/restarting a resource
* Changing access policies
* Creating/editing security groups
* Actions with encryption keys and secrets

## Current service limits {#known-restrictions}

The audit log does not capture authentication errors. For example, if a user makes an API call without an IAM token, this information will not be included in the audit logs.

The log captures authorization errors. For example, if a user attempts to create a resource without sufficient privileges, the log will include an error message.

The service has [quotas and limits](limits.md).

If you upload audit logs to a log group or a data stream, make sure their size is both within the {{ at-name }} limits and the [{{ cloud-logging-full-name }}](../../logging/concepts/limits.md) and [{{ yds-full-name }}](../../data-streams/concepts/limits.md) limits. If the limits are exceeded, information in event audit logs that are large in size will be incomplete.

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}

We also recommend uploading audit logs to the {{ objstorage-name }} bucket.

{% note info %}

{% include [error-note](../../_includes/audit-trails/error-note.md) %}

{% endnote %}
