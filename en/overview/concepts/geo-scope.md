# Availability zones

At its initial stage, the {{ yandex-cloud }} platform is hosted in three Yandex data centers located in different areas of Russia (the Vladimir, Ryazan, and Moscow regions). The {{ yandex-cloud }} infrastructure in each data center is called an _availability zone_. Each zone is isolated from hardware and software failures that may occur in other availability zones. By deploying your apps in multiple zones, you ensure fault tolerance and significantly reduce the risk of data loss.

You can host resources in the following availability zones:
* `ru-central1-a`;
* `ru-central1-b`;
* `ru-central1-c` (with limitations — see the [details](ru-central1-c-deprecation.md)).

{% note info %}

When new availability zones appear or existing ones change location, {{ yandex-cloud }} notifies all its customers.

{% endnote %}

{{ yandex-cloud }} resources are either _zonal_ (linked to an availability zone) or _global_ (not linked to zones).

Zonal resources include [virtual machines](../../compute/concepts/vm.md) and [disks](../../compute/concepts/disk.md). Global resources include [cloud networks](../../vpc/concepts/network.md) and [buckets](../../storage/concepts/bucket.md).