{% note warning %}

Starting from {{ k8s }} version 1.30, in the `RAPID` [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md), the basic node image is changed from Ubuntu 20.04 to Ubuntu 22.04. In the existing clusters and node groups, the OS version will be upgraded using the method you select. This upgrade will later become available in the `REGULAR` and `STABLE` release channels.

For OS upgrade details and recommendations, see [{#T}](../../managed-kubernetes/concepts/node-os-update.md).

{% endnote %}