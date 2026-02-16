# How to find out the physical address of a {{ yandex-cloud }} data center



## Case description {#case-description}

You need to know the exact addresses of the servers located in the {{ yandex-cloud }} data centers, to include them in the notification documents prepared as required by the regulatory authorities.

## Solution {#case-resolution}

The {{ yandex-cloud }} platform is hosted in four Yandex data centers located in Russia (Vladimir, Ryazan, Moscow, and Kaluga regions).

All {{ yandex-cloud }} resources are either zonal (linked to an availability zone) or global (not linked to any zone).
For instance, VMs and disks are zonal resources.

Here are the addresses of our data centers:

* Vladimir region: Ul. Poiskovaya 1, Mrk. Energetik, Vladimir 2
* Ryazan region: Ul. Pushkina, 21, Sasovo
* Kaluga region: 1-y Automobilniy proezd, 8, Kaluga
* Moscow region: Ul. Silikatnaya, 19, Mytishchi

We recommend specifying all four addresses. This approach has been proven by other clients to be acceptable by the regulatory authorities.

## If nothing helped {#if-nothing-worked}

To get more details on the legal aspects, please check our [security standards](https://yandex.cloud/en/security/standards/152-fz) and the [data processing agreement](https://yandex.com/legal/cloud_dpa/en/).

