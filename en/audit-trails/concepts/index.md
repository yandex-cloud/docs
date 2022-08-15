# {{ at-full-name }} overview

{{ at-full-name }} lets you collect audit logs of {{ yandex-cloud }} resources and upload them to a {{ objstorage-name }}{% if product == "yandex-cloud" %} bucket or {{ cloud-logging-name }}{% endif %} log group:

* [Uploading audit logs to a bucket](../operations/index.md#bucket).
{% if product == "yandex-cloud" %}

* [Uploading audit logs to Cloud Logging](../operations/index.md#logging).
* [Uploading audit logs to a data stream](../operations/index.md#data-streams).

{% endif %}

Collecting audit logs lets you use analytical tools and rapidly respond to events that occur to {{ yandex-cloud }} services:

* [Searching audit logs in a bucket](../tutorials/search-bucket.md)
{% if product == "yandex-cloud" %}

* [Searching audit logs in a log group](../tutorials/search-cloud-logging.md)
{% endif %}

* [Exporting audit logs to SIEM systems](./export-siem.md)
* [Alert settings in {{ monitoring-full-name }}](../tutorials/alerts-monitoring.md)

{{ yandex-cloud }} services whose audit logs are collected by {{ at-name }}:

* {{ at-full-name }}
* {{ certificate-manager-full-name }}
{% if product == "yandex-cloud" %}

* {{ cloud-logging-full-name }}
{% endif %}

* {{ compute-full-name }}
* {{ iam-full-name }}
* {{ kms-full-name }}
* {{ lockbox-full-name }}
* {{ mch-full-name }}
{% if product == "yandex-cloud" %}

* {{ mmg-full-name }}
{% endif %}

* {{ mmy-full-name }}
* {{ mpg-full-name }}
{% if product == "yandex-cloud" %}

* {{ mrd-full-name }}
{% endif %}

* {{ network-load-balancer-full-name }}
* {{ objstorage-full-name }}
* {{ org-full-name }}
* {{ resmgr-full-name }}
* {{ vpc-full-name }}
{% if product == "yandex-cloud" %}

* {{ ydb-full-name }}
{% endif %}

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
