# Availability zones


At its initial stage, the {{ yandex-cloud }} platform is hosted in three Yandex data centers located in different areas of Russia (the Vladimir, Ryazan, and Moscow regions). The {{ yandex-cloud }} infrastructure in each data center is called an _availability zone_. Each zone is isolated from hardware and software failures that may occur in other availability zones. By deploying your apps in multiple zones, you ensure fault tolerance and significantly reduce the risk of data loss.

You can host resources in the following availability zones:
* `{{ region-id }}-a`;
* `{{ region-id }}-b`;
* `{{ region-id }}-c` (with limitations — see the [details](ru-central1-c-deprecation.md)).

In the second half of 2023, a new data center will open in Kaluga resulting in a new availability zone. [For more information, see the blog](https://cloud.yandex.ru/blog/posts/2022/09/cloud-data-center-kaluga).

{% note info %}

When new availability zones appear or existing ones change location, {{ yandex-cloud }} notifies all its customers.

{% endnote %}

{{ yandex-cloud }} resources are either _zonal_ (linked to an availability zone) or _global_ (not linked to zones).

Zonal resources include [virtual machines](../../compute/concepts/vm.md) and [disks](../../compute/concepts/disk.md). Global resources include [cloud networks](../../vpc/concepts/network.md) and [buckets](../../storage/concepts/bucket.md).


