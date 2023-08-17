# Uploading logs from {{ at-full-name }}

[{{ at-name }}](../../audit-trails/index.yaml) is a service for collecting and exporting audit logs that allows you to use analytical tools and rapidly respond to events occurring to {{ yandex-cloud }} resources. [{{ OS }}](../index.yaml) is used as a SIEM system for analyzing logs and responding to security events.

You will learn how to set up the export of logs from {{ at-name }} with just a few steps, while using [{{ yds-full-name }}](../../data-streams/index.yaml) and [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) and selecting {{ mos-full-name }} as a SIEM system to analyze logs and respond to security events.

{% include notitle [trails-logs-opensearch](../../_tutorials/trails-logs-opensearch.md) %}
