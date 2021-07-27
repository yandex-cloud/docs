---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Availability zones

During the initial stage, the Yandex.Cloud platform is hosted in three Yandex data centers located in different areas of Russia (the Vladimir, Ryazan, and Moscow regions). The Yandex.Cloud infrastructure in each of the data centers is called an _availability zone_. Each zone is isolated from hardware and software failures that may occur in other availability zones. By deploying your apps in multiple zones, you will ensure fault tolerance and significantly reduce the risk of data loss.

You can place your resources in the following availability zones:

- `ru-central1-a`
- `ru-central1-b`
- `ru-central1-c`

{% note info %}

When new availability zones appear or existing ones change location, Yandex.Cloud notifies all customers.

{% endnote %}

Yandex.Cloud resources are either _zonal_ (meaning they are linked to an availability zone) or global (meaning they are independent of any zone).

Examples of zonal resources are [virtual machines](../../compute/concepts/vm.md) and [disks](../../compute/concepts/disk.md). Examples of global resources are [cloud networks](../../vpc/concepts/network.md) and [bucket](../../storage/concepts/bucket.md).

