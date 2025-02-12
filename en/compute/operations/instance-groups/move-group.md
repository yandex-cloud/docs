---
title: Moving an instance group to a different availability zone
description: In this article, you will learn how to move a {{ compute-name }} instance group across availability zones.
---

# Moving an instance group to a different availability zone


If your instance group is connected to a load balancer, follow these guides as appropriate:
* [{#T}](move-group-with-nlb.md)
* [{#T}](move-group-with-alb.md)

To move an instance group to a different availability zone:
1. [Create](../../../vpc/operations/subnet-create.md) a subnet in the availability zone you want to move your instance group to.
1. Add the group instances to the new availability zone:

    {% include [ig-create-in-another-zone](../../../_includes/compute/ig-create-in-another-zone.md) %}

1. Delete the group instances from the previous availability zone:

    {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}

### See also {#see-also}

* [{#T}](move-group-with-nlb.md)
* [{#T}](move-group-with-alb.md)