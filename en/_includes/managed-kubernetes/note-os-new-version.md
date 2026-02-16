{% note warning %}

Starting with {{ k8s }} 1.30, the {{ managed-k8s-name }} cluster node base image changed from Ubuntu 20.04 to Ubuntu 22.04 in all [release channels](../../managed-kubernetes/concepts/release-channels-and-updates.md). In the existing clusters and node groups, the OS version will be upgraded using the method you select.

For OS upgrade details and recommendations, see [{#T}](../../managed-kubernetes/concepts/node-os-update.md).

{% endnote %}