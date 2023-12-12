---
title: "Log groups in {{ cloud-logging-full-name }}"
description: "A log group is a way of grouping logs of services and custom messages."
---

# Log group in {{ cloud-logging-name }}

A _log group_ is a way of grouping logs of services and custom messages. There are two types of groups:
* Default. A default log group is created for each folder. Logs of {{ sf-name }}, {{ api-gw-name }}, and {{ serverless-containers-name }} are automatically put into this group. You can send logs to the default log group yourself.
* Custom. You can create a log group and enable logging to it yourself. [How to create a custom log group.](../operations/create-group.md)
