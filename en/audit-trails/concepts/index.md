# {{ at-full-name }} overview

{{ at-full-name }} lets you collect audit logs of {{ yandex-cloud }} resources and upload them to a {{ objstorage-name }} bucket or {{ cloud-logging-name }} log group:

* [Uploading audit logs to a bucket](../operations/index.md#bucket).

* [Uploading audit logs to Cloud Logging](../operations/index.md#logging).
* [Uploading audit logs to a data stream](../operations/index.md#data-streams).


Collecting audit logs lets you use analytical tools and rapidly respond to events that occur to {{ yandex-cloud }} services:

* [Searching audit logs in a bucket](../tutorials/search-bucket.md)

* [Searching audit logs in a log group](../tutorials/search-cloud-logging.md)

* [Exporting audit logs to SIEM systems](./export-siem.md)
* [Alert settings in {{ monitoring-full-name }}](../tutorials/alerts-monitoring.md)

{{ yandex-cloud }} services whose audit logs are collected by {{ at-name }}:

* {{ at-full-name }}
* {{ certificate-manager-full-name }}

* {{ cloud-logging-full-name }}

* {{ compute-full-name }}
* {{ iam-full-name }}
* {{ kms-full-name }}
* {{ lockbox-full-name }}
* {{ mch-full-name }}

* {{ mmg-full-name }}

* {{ mmy-full-name }}
* {{ mpg-full-name }}

* {{ mrd-full-name }}

* {{ network-load-balancer-full-name }}
* {{ objstorage-full-name }}
* {{ org-full-name }}
* {{ resmgr-full-name }}
* {{ vpc-full-name }}

* {{ ydb-full-name }}

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
