---
title: '{{ baremetal-extend-managed-k8s-name }}'
description: In this article, you will learn about {{ baremetal-extend-managed-k8s-name }}.
---

# {{ baremetal-extend-managed-k8s-name }}

*{{ baremetal-extend-managed-k8s-name }}* enables you to create [{{ managed-k8s-name }} worker node groups](../../../managed-kubernetes/concepts/index.md#node-group) on dedicated [{{ baremetal-name }} servers](../servers.md). Worker nodes run containerized applications, while the [{{ k8s }} master](../../../managed-kubernetes/concepts/index.md#master) is managed by {{ managed-k8s-name }}.

{{ baremetal-extend-managed-k8s-name }} allows you to use dedicated server CPUs, memory, and disks for container workloads while keeping [{{ k8s }} cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) management tools in {{ yandex-cloud }}. This option is a good fit when workloads require physical isolation and predictable performance from dedicated hardware.

When you create a group, {{ baremetal-extend-managed-k8s-name }} rents servers of the selected [configuration](../server-configurations.md), sets them up, and connects them to the cluster. You can manage your [node group in {{ managed-k8s-name }}](../../../managed-kubernetes/operations/index.md#node-group), while the servers it contains are displayed in {{ baremetal-name }}.

[Creating a {{ baremetal-name }} node group for {{ baremetal-extend-managed-k8s-name }}](../../operations/extend/managed-kubernetes.md).

#### See also {#see-also}

* [{#T}](../extend.md)
* [{#T}](../private-network.md)
* [{#T}](../dhcp.md)
