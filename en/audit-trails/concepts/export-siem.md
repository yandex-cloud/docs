# Exporting audit logs to SIEM systems

You can export audit log files to SIEM systems.

The {{ yandex-cloud }} team has prepared a set of solutions for exporting audit logs into several SIEM systems. The files of the solutions are listed in the relevant sections of the [yc-solution-library-for-security](https://github.com/yandex-cloud/yc-solution-library-for-security/) repository.

[Yc-solution-library-for-security](https://github.com/yandex-cloud/yc-solution-library-for-security/) is a public repo on GitHub with a set of examples and recommendations on how to build a secure infrastructure in {{ yandex-cloud }}.

As of today, solutions have been prepared for the following SIEM systems:

* [Yandex Managed Service for Elasticsearch](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)
* [ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)
* [Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)

All the solutions provide continuous delivery of audit log files from buckets to the SIEM system and also contain correlation rules, dashboards, and preset queries to search for important security events. The {{ yandex-cloud }} team supports and regularly updates all the solutions.

