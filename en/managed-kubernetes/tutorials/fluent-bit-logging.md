---
title: Configuring Fluent Bit for {{ cloud-logging-full-name }}
description: The Fluent Bit log processor allows you to transfer the {{ managed-k8s-name }} cluster logs to {{ cloud-logging-name }}. To transfer logs, you will use the Fluent Bit plugin for {{ cloud-logging-full-name }} module.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/k8s-fluent-bit-logging'
---

# Configuring Fluent Bit for {{ cloud-logging-full-name }}


{% note info %}

You can enable sending logs from the [{{ managed-k8s-name }} master host](../concepts/index.md#master) to [{{ cloud-logging-name }}](../../logging/) by specifying the `master logging` setting when [creating](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../operations/kubernetes-cluster/kubernetes-cluster-update.md) your [cluster](../concepts/index.md#kubernetes-cluster). The setting is only available in the API, CLI, and {{ TF }}. To learn more, see [Sending {{ managed-k8s-name }} cluster logs to {{ cloud-logging-name }}](../../logging/tutorials/k8s-fluent-bit-logging.md#master-logging).

{% endnote %}

The [Fluent Bit](https://fluentbit.io/) log processor allows you to transfer [pod](../concepts/index.md#pod) and [service](../concepts/index.md#service) logs and [system logs](../../managed-kubernetes/concepts/index.md#node-group) of {{ managed-k8s-name }} nodes to {{ cloud-logging-name }}. To transfer logs, you will use the [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) module.

{% include [Setup Managed K8S Fluent Bit](../../_tutorials/containers/k8s-fluent-bit-logging.md) %}
