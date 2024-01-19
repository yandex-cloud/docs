---
title: "Configuring Fluent Bit for {{ cloud-logging-full-name }}"
description: "The Fluent Bit log processor allows you to transfer the {{ managed-k8s-name }} cluster logs to {{ cloud-logging-name }}. The Fluent Bit plugin for {{ cloud-logging-full-name }} module is used to transfer logs."
---

# Configuring Fluent Bit for {{ cloud-logging-full-name }}

{% note info %}

You can enable sending logs from the [{{ managed-k8s-name }} master host](../concepts/index.md#master) to [{{ cloud-logging-name }}](../../logging/) by specifying the `master logging` setting when [creating](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../operations/kubernetes-cluster/kubernetes-cluster-update.md) your [cluster](../concepts/index.md#kubernetes-cluster). The setting is only available in the API, CLI, and {{ TF }}. To learn more, see [Sending {{ managed-k8s-name }} cluster logs to {{ cloud-logging-name }}](../../logging/tutorials/k8s-fluent-bit-logging.md#master-logging).

{% endnote %}

The [Fluent Bit](https://fluentbit.io/) log processor allows you to transfer the logs of {{ managed-k8s-name }} cluster [pods](../concepts/index.md#pod) and [services](../concepts/index.md#service) to {{ cloud-logging-name }}. The [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) module is used to transfer logs.

{% include [Setup Managed K8S Fluent Bit](../../_tutorials/containers/k8s-fluent-bit-logging.md) %}
