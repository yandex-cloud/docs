# {{ at-full-name }} overview

{{ at-full-name }} lets you collect audit logs of {{ yandex-cloud }} resources and upload them to a {{ objstorage-name }} bucket or a {{ cloud-logging-name }} log group:

* [Uploading audit logs to the bucket](../operations/export-bucket.md)
* [Uploading audit logs to Cloud Logging](../operations/export-cloud-logging.md)

Collecting of audit logs lets you use analytical tools and rapidly respond to events occurring with {{ yandex-cloud }} services:

* [Searching in audit logs in the bucket](../solutions/search-bucket.md)
* [Searching in audit logs in the log group](../solutions/search-cloud-logging.md)
* [Uploading audit logs to SIEM](./export-siem.md)
* [Setting up alerts in {{ monitoring-full-name }}](../solutions/alerts-monitoring.md)

{{ yandex-cloud }} services whose audit logs are collected by {{ at-name }}:

* {{ at-full-name }}
* {{ cloud-logging-full-name }}
* {{ compute-full-name }}
* {{ ydb-full-name }}
* {{ iam-full-name }}
* {{ kms-full-name }}
* {{ lockbox-name }}
* {{ network-load-balancer-full-name }}
* {{ objstorage-full-name }}
* {{ vpc-full-name }}

The following events are logged:

* Inputs of federated users.
* Creating/deleting service accounts.
* Creating/deleting service account keys.
* Editing user roles and service accounts.
* Creating/deleting resources.
* Editing resource settings.
* Stopping/restarting a resource.
* Changing access policies.
* Creating/editing security groups.
* Actions with encryption keys and secrets.

## Current service limitations {#known-restrictions}

Read more about the service limits in [Quotas and limits](limits.md).
