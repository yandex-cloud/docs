---
title: '{{ dataproc-full-name }} component interfaces and ports'
description: In this tutorial, you will learn what component interfaces and ports are supported in {{ dataproc-name }} and how you can use them.
---

# {{ dataproc-name }} component interfaces and ports

For some {{ dataproc-name }} components, such as Hadoop, Spark, Yarn, and Zeppelin, there are custom web interfaces available on a cluster's master host. These interfaces can be used:

* YARN Resource Manager and HDFS Name Node: To manage and monitor cluster resources.
* Spark History and JobHistory: To view job statuses and debug jobs.
* Apache Zeppelin: For collaboration, experiments, or ad-hoc operations.

{{ dataproc-name }} enables you to create clusters accessible from the internet or only from a cloud network. However, we recommend making service component interfaces inaccessible from outside {{ yandex-cloud }} in any configuration. You can connect to {{ dataproc-name }} component interfaces either using [UI Proxy](../operations/connect-interfaces.md#ui-proxy) or an [intermediate virtual machine](../operations/connect-interfaces.md#routing).

UI Proxy is a tool that allows you to proxy the cluster component interface with HTTP traffic encryption and authentication via the {{ yandex-cloud }} IAM. To access the interfaces, the user must be logged in to {{ yandex-cloud }}, have cluster view permissions and the `dataproc.user` role.

UI Proxy is disabled by default. To use it, enable it when [creating](../operations/cluster-create.md#create) or [configuring](../operations/connect-interfaces.md#ui-proxy-enable) a cluster and [view](../operations/connect-interfaces.md#ui-proxy-list) a list of web interfaces available for connection.

{% note warning %}

You may need to additionally [set up security groups](../operations/connect.md#configuring-security-groups) to use UI Proxy.

{% endnote %}

## Components and ports {#port-numbers}

{% include [ports-table](../../_includes/data-proc/ports-table.md) %}
