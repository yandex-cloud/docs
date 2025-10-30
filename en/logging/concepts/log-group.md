---
title: Log group in {{ cloud-logging-full-name }}
description: A log group is a way of grouping logs of services and custom messages.
sourcePath: en/logging_includes/concepts/log-group.md
---

# Log group in {{ cloud-logging-name }}

A _log group_ is a way of grouping logs of services and custom messages. There are two types of groups:

* Default.

    The name of the default log group is `default`. The group is created automatically when a [service](#services) or application writes logs with the folder ID specified for destination. A user can [add records](../operations/write-logs.md) to it manually. If you [create a log group](../operations/create-group.md) named `default`, it will be the default log group for the folder it was created in.

* Custom.

  A user can create a log group and add records to it manually.

When adding a record to a log group, you can specify its creation `timestamp`. The record creation timestamp may differ from the time it was added to the log group. It must satisfy the following conditions:
```text
Current date – 30 days < Record creation timestamp < Current date + 1 day
```

## Services capable of logging in {{ cloud-logging-name }} {#services}


* [{{ api-gw-name }}](../../api-gateway/)
* [{{ alb-name }}](../../application-load-balancer/)
* [{{ at-name }}](../../audit-trails/)
* [{{ sf-name }}](../../functions/)
* [{{ compute-name }}](../../compute/) (collecting logs from VMs and user applications via [{{ unified-agent-full-name }}](../../monitoring/concepts/data-collection/unified-agent/))
* [{{ container-registry-name }}](../../container-registry/)
* [{{ ml-platform-name }}](../../datasphere/)
* [{{ maf-name }}](../../managed-airflow/)
* [{{ mgp-name }}](../../managed-greenplum/)
* [{{ managed-k8s-name }}®](../../managed-kubernetes/)
* [{{ serverless-containers-name }}](../../serverless-containers/)
* [{{ si-name }}](../../serverless-integrations/)
* [{{ postbox-name }}](../../postbox/)
* [{{ cns-full-name }}](../../notifications/)
* [{{ dataproc-name }}](../../data-proc/)
* [{{ yds-full-name }}](../../data-streams/)
* [{{ iot-name }}](../../iot-core/)
* [{{ mpg-full-name }}](../../managed-postgresql/)