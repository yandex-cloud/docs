# Deprecation of the {{ region-id }}-c availability zone

{{ yandex-cloud }} plans to gradually deprecate the `{{ region-id }}-c` [availability zone](geo-scope.md). Starting April 2022, its operation will be limited.

* _Zonal quotas_, a new type of [quota](quotas-limits.md), will be introduced for the number of zonal resources in `{{ region-id }}-c`. You can increase these quotas only by contacting [support]({{ link-console-support }}). Zonal quotas will apply to the following services:

   * {{ compute-name }} (VMs and VM computing resources, instance groups, disks, file storage, dedicated hosts).
   * {{ managed-k8s-name }} (nodes).

   Zonal quota numbers will be published later in [{#T}](../../compute/concepts/limits.md) and [{#T}](../../managed-kubernetes/concepts/limits.md).

* In `{{ region-id }}-c`, new {{ yandex-cloud }} zonal features are unavailable. You can't create:

   * {{ compute-name }} VMs with GPU.
   * {{ compute-name }} dedicated hosts on Intel Ice Lake.
   * {{ mgp-name }} database hosts.

For more information about development plans for availability zones and migration options, see this [post in the {{ yandex-cloud }} blog](https://cloud.yandex.ru/blog/posts/2022/03/az-deprecation-notice).