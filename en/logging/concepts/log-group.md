---
title: "Log group in {{ cloud-logging-full-name }}"
description: "A log group is a way of grouping logs of services and custom messages."
---

# Log group in {{ cloud-logging-name }}

A _log group_ is a way of grouping logs of services and custom messages. There are two types of groups:
* Default. A default log group is created for each folder. {{ sf-name }}, {{ api-gw-name }}, and {{ serverless-containers-name }} logs automatically get into this group. You can [add records](../operations/write-logs.md) to the default log group yourself.
* Custom. You can create a log group and add records to it yourself. [How to create a custom log group](../operations/create-group.md).

When adding a record to a log group, you can specify its creation `timestamp`. The record creation timestamp may differ from the time it was added to the log group. It must satisfy the following conditions:
```
Current date – 30 days < Record creation timestamp < Current date + 1 day
```
