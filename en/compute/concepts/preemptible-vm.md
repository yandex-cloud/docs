---
title: Preemptible VMs in {{ compute-full-name }}
description: In this article, you will learn what preemptible VMs are, how to use them, and learn about their limitations.
---

# Preemptible VMs

*Preemptible VMs* are VM instances that may be forcibly stopped at any time. This can happen in these two cases:
* If 24 hours elapsed since the VM was started.
* If there is a lack of resources to launch a regular VM in the same [availability zone](../../overview/concepts/geo-scope.md). Such an event is usually unlikely, but this may vary day to day.

Preemptible VMs are available at a [lower price](../pricing.md#prices-instance-resources) than regular ones. However, they do not provide fault-tolerance.

You can [create](../operations/vm-create/create-preemptible-vm.md#create-preemptible) a preemptible VM or [change the type](../operations/vm-create/create-preemptible-vm.md#preemptible-to-regular) of an existing one.

This will change pricing for the VM instance. For more information, see our [pricing policy](../pricing.md).

## Limits {#restrictions}

In addition to the fact that preemptible VMs can be forcibly stopped, they have the following limitations:

* If there are not enough resources in the specified availability zone to launch a preemptible VM, it will not get launched.
* Preemptible VMs are not subject to the [SLA](../../overview/sla.md).

## Working with preemptible VMs {#work-with-preemptible-vm}

When a preemptible VM is stopped, it is not deleted and all its data is saved. When you need the VM again, you can just [start it](../operations/vm-control/vm-stop-and-start.md#start).

With the [{{ sf-full-name }}](../../functions/) function, you can [configure](../tutorials/nodejs-cron-restart-vm.md) a stopped preemptible VM to run automatically.

{% note info %}

In [{{ ig-name }}](instance-groups/index.md), stopped VMs start automatically based on the [autohealing](instance-groups/autohealing.md) feature.

With {{ ig-name }}, preemptible VMs in the group get stopped after a random interval of 22 to 24 hours, rather than exactly after 24 hours. This helps avoid situations when all VMs in the group restart at the same time and stop handling the load of running applications.

{% endnote %}

## Preemptible VM features {#features}

### Stopping a VM {#vm-stop}

To stop a VM instance, {{ compute-name }} sends it the [ACPI shutdown](https://en.wikipedia.org/wiki/ACPI) signal to trigger a graceful power-off. The guest OS then has 30 seconds to terminate all processes before the VM shuts down.

In Linux, the `ACPI shutdown` signal is usually handled by [systemd](https://en.wikipedia.org/wiki/Systemd), an init subsystem and service manager. Upon receiving the signal, `systemd` sends the [SIGTERM](https://en.wikipedia.org/wiki/Signal_(IPC)#SIGTERM) signal to all running processes to initiate a graceful shutdown. If a process fails to terminate within the allocated timeout, `systemd` forcibly terminates it using the [SIGKILL](https://en.wikipedia.org/wiki/Signal_(IPC)#SIGKILL) signal.

{% note tip %}

The default process termination timeout in `systemd` is 90 seconds. Therefore, to ensure termination of all processes within the 30-second window allocated by {{ compute-name }}, we recommend setting `DefaultTimeoutStopSec=30s` in the [/etc/systemd/system.conf](https://www.freedesktop.org/software/systemd/man/systemd-system.conf.html) configuration file.

{% endnote %}

### VM lifetime {#term-life}

The lifetime of preemptible VMs is adjusted dynamically based on the current load of {{ yandex-cloud }} computing resources.

The maximum lifetime of preemptible VMs is 24 hours.

Preemptible VMs have no minimum lifetime. The system may even fail to create preemptible VMs, returning the `not enough resources` error, if an [availability zone](../../overview/concepts/geo-scope.md) runs out of available configurations. In this case, you can:
* Try deploying a preemptible VM in a different availability zone.
* Modify the preemptible VM configuration. For example, if a VM with eight GPUs is unavailable, try creating four VMs with two GPUs each, as this is a more likely configuration for preemptible VMs.
* Use a non-preemptible VM.

### Application fault tolerance {#resilience-to-failures}

If you use preemptible VMs for [batch processing](https://en.wikipedia.org/wiki/Batch_processing), your application must be designed to recover from failures on any of the computing nodes. For example, if a computing task takes an estimated ten hours to complete, the preemptible VM will probably shut down at some point during this period. Your application must be able to resume computations from the point of interruption.

{% note tip %}

To make sure your application recovers correctly after VM termination, save intermediate computation results to [{{ objstorage-full-name }}](../../storage/tools/geesefs.md) or [file storage](filesystem.md).

{% endnote %}

## When to use preemptible VMs {#scenarios-for-using}

Preemptible VMs are suitable for stateless, fault-tolerant workloads with flexible VM configuration requirements, for example:
* Big data processing.
* Building artifacts, software, or containers.
* CI/CD pipelines.
* Fault-tolerant [HPC](https://en.wikipedia.org/wiki/High-performance_computing).
* Graphics rendering.
* ML model training that takes less than 24 hours.

## Use cases {#examples}

* [{#T}](../tutorials/nodejs-cron-restart-vm.md)
* [{#T}](../tutorials/hpc-on-preemptible.md)
