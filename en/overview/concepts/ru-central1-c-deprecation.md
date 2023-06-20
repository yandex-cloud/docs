# Deprecation of the {{ region-id }}-c availability zone

{{ yandex-cloud }} plans to gradually deprecate the `{{ region-id }}-c` [availability zone](geo-scope.md) . Starting April 2022, its operation is limited:

* _Zonal quota_, a new type of [quota](quotas-limits.md), has been introduced for the number of zonal resources in `{{ region-id }}-c`. You can increase such quotas only by contacting [support]({{ link-console-support }}). Zonal quotas apply to the following services:

   * {{ compute-name }} (VMs and VM computing resources, instance groups, disks, file storage, dedicated hosts)
   * {{ managed-k8s-name }} (nodes)

   Zonal quota numbers will be published later in [{#T}](../../compute/concepts/limits.md) and [{#T}](../../managed-kubernetes/concepts/limits.md).

* In `{{ region-id }}-c`, new {{ yandex-cloud }} zonal features are unavailable. You cannot create:

   * {{ compute-name }} VMs with GPUs
   * {{ compute-name }} dedicated hosts based on Intel Ice Lake
   * {{ mgp-name }} database hosts

