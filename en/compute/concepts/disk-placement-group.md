# Non-replicated disk placement groups

When creating [non-replicated disks](disk.md#disks_types), resources are automatically distributed across the {{ yandex-cloud }} physical infrastructure. Your disks might get hosted on the same physical media. To make multiple disk failures less likely, you can combine your disks into placement groups.

{% note info %}

Disks are not replicated on the {{ yandex-cloud }} side; however, you can make a disk replicated using placement groups.

{% endnote %}

_Non-replicated disk placement group_ is a group of non-replicated disks where disks are hosted on different racks within the same availability zone. If one server rack that hosts disks from your group fails, this would affect only one disk.

Grouping non-replicated disks reduces the risk of their simultaneous failure. However, the placement requirements are more demanding, so a physical resource shortage is more likely for non-replicated disks in a placement group rather than for the same number of ungrouped disks. You might fail to create a non-replicated disk in a placement group, but succeed to create one outside the group without any issue.

For more information about the organizational and technical limits of placement groups, see [{#T}](../concepts/limits.md).
