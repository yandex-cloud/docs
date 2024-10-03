---
title: Log group in {{ cloud-logging-full-name }}
description: A log group is a way of grouping logs of services and custom messages.
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


* [{{ alb-name }}](../../application-load-balancer/)
* [{{ api-gw-name }}](../../api-gateway/)
* [{{ at-name }}](../../audit-trails/)
* [{{ sf-name }}](../../functions/)
* [{{ container-registry-name }}](../../container-registry/)
* [{{ dataproc-name }}](../../data-proc/)
* [{{ ml-platform-name }}](../../datasphere/)
* [{{ managed-k8s-name }}®](../../managed-kubernetes/)
* [{{ serverless-containers-name }}](../../serverless-containers/)
* [{{ iot-name }}](../../iot-core/)
