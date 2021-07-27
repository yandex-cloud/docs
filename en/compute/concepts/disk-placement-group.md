---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Non-replicated disk placement groups

When creating [non-replicated disks](disk.md#disks_types), resources are automatically distributed across the {{ yandex-cloud }} physical infrastructure. Your disks might get hosted on the same physical media. To make multiple disk failures less likely, you can combine your disks into placement groups.

_Non-replicated disk placement group_ is a group of non-replicated disks where disks are hosted on different racks within the same availability zone. If one server rack that hosts disks from your group fails, this affects only one disk.

Grouping of non-replicated disks reduces the risk of their parallel failure. However, the placement requirements are more demanding, so a physical resource shortage is more likely for non-replicated disks in a placement group rather than for the same number of ungrouped disks. You might fail to create a non-replicated disk in a placement group, but succeed to create it outside the group without any problem.

For more information about the organizational and technical limits of placement groups, see [{#T}](../concepts/limits.md).

