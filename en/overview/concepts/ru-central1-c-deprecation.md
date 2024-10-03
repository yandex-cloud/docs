---
title: Discontinuation of the {{ region-id }}-c availability zone in {{ yandex-cloud }}
description: '{{ yandex-cloud }} plans to gradually discontinue the {{ region-id }}-c availability zone. Starting April 2022, quotas apply on the number of zonal resources, and new zonal features are no longer available for this zone.'
---

# Discontinuation of the {{ region-id }}-c availability zone

{{ yandex-cloud }} plans to gradually discontinue the `{{ region-id }}-c` [availability zone](geo-scope.md). Starting April 2022, its operation is limited:

* _Zonal quota_, a new type of [quota](quotas-limits.md), has been introduced for the number of zonal resources in `{{ region-id }}-c`. You can increase such quotas only by contacting [support]({{ link-console-support }}). Zonal quotas apply to the following services:

   * {{ compute-name }} (VMs and VM computing resources, instance groups, disks, file storages, dedicated hosts)
   * {{ managed-k8s-name }} (nodes)

   Zonal quota numbers will be published later in [{#T}](../../compute/concepts/limits.md) and [{#T}](../../managed-kubernetes/concepts/limits.md).

* In `{{ region-id }}-c`, new {{ yandex-cloud }} zonal features are unavailable. You cannot create:

   * {{ compute-name }} VMs with GPUs
   * {{ compute-name }} VMs based on {{ highfreq-ice-lake }}
   * {{ compute-name }} dedicated hosts based on Intel Ice Lake
   * {{ mgp-name }} database hosts

As part of discontinuation, starting May 28, 2024, all our `{{ region-id }}-c` users will no longer be able to:

* Create new {{ managed-k8s-name }} master hosts and node groups.
* Create or update MDB cluster hosts.
* Enable `{{ region-id }}-c` in {{ alb-name }} to accept traffic.
* Enable `{{ region-id }}-c` in {{ ig-name }} to accept traffic.
* Create new {{ mgl-name }} instances.
* Create new {{ cloud-desktop-name }} instances.

