# Exporting audit logs to SIEM systems

{% if product == "yandex-cloud" %}
You can export audit log files to SIEM systems.

The {{ yandex-cloud }} team has prepared a set of solutions for exporting audit logs into several SIEM systems. You can find solution files in the respective sections of the [{{ yandex-cloud }} Security Solution Library repository](https://github.com/yandex-cloud/yc-solution-library-for-security/).

[{{ yandex-cloud }} Security Solution Library](https://cloud.yandex.ru/solutions/security-solution-library) is a public repo on GitHub with a set of examples and recommendations on how to build a secure infrastructure in {{ yandex-cloud }}.

As of today, solutions have been prepared for the following SIEM systems:
* [Yandex Managed Service for Elasticsearch](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)
* [ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)
* [Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)

All the solutions provide continuous delivery of audit log files from buckets to the SIEM system and also contain correlation rules, dashboards, and preset queries to search for important security events. The {{ yandex-cloud }} team supports and regularly updates all the solutions.
{% endif %}
{% if product == "cloud-il" %}
To set up export to any SIEM, use utilities such as [GeeseFS](../../storage/tools/geesefs.md) or [s3fs](../../storage/tools/s3fs.md). They let you mount an {{ objstorage-name }} bucket as a VM's local disk. Next, you need to install a SIEM connector on the VM and configure reading JSON files from the bucket.
{% endif %}