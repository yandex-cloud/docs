---
noIndex: true
canonical: '{{ link-docs }}/tutorials/security/trails-logs-opensearch'
---

# Uploading logs from {{ at-full-name }} to {{ OS }}

[{{ at-name }}](../../audit-trails) is a service for collecting and exporting audit logs that allows you to use analytical tools and rapidly respond to events occurring to {{ yandex-cloud }} resources. [OpenSearch](../../managed-opensearch/) is used as a SIEM system for analyzing logs and responding to security events.

You will learn how to set up the export of logs from {{ at-name }} in just a few steps using [{{ yds-full-name }}](../../data-streams/) and [{{ data-transfer-full-name }}](../../data-transfer/), with {{ mos-full-name }} as a SIEM system to analyze logs and respond to security events.

{% include notitle [trails-logs-opensearch](../../_tutorials/security/trails-logs-opensearch.md) %}
