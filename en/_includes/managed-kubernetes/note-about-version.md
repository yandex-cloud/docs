{% note warning %}

* If you need to upgrade both the master node and the node group, upgrade the master first.
* If the master is running on {{ k8s }} 1.14 and node groups are on {{ k8s }} 1.13, compatibility issues will affect CSI operation. For correct operation, upgrade the node groups to {{ k8s }} 1.14.

{% endnote %}

