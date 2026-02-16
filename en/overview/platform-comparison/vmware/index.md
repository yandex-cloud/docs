---
title: Comparison with VMware
description: This article establishes the equivalence between {{ yandex-cloud }} services and VMware services.
---

# Comparison with VMware

This section helps engineers having experience with [VMware](https://www.vmware.com/) to learn more about {{ yandex-cloud }} features. These two platforms are compared by the following key features:

* [{#T}](resource-role-model.md)
* [{#T}](computing-infrastructure.md)
* [{#T}](storage-subsystem.md)
* [{#T}](network-subsystem.md)
* [{#T}](management-tools.md)

## Key terms and definitions {#concepts}

#|
|| **VMware term** | **{{ yandex-cloud }} term** | **Description** ||
|| Virtual Datacenters (vDC) | Cloud | Isolated space provided to a user to place, store, and operate their information systems and applications ||
|| Organizations | Organizations | Root container for managing users, groups, identity federations, and computing resources ||
|| Organization Networks | VPC | Cloud networks providing resource connectivity ||
|| vApp | Instance Groups (in part) / Folder (in part) | Child container of a virtual datacenter (vDC) containing one or more VM instances ||
|#