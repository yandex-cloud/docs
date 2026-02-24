### One of the three latest Kubernetes versions is used, updates are monitored {#version-update}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | k8s.version-update ||
|#

#### Description

{% note warning "**Manual check**" %}

This rule requires manual verification of Kubernetes version and update monitoring.

{% endnote %}

For Kubernetes, both automatic and manual updates are available for [clusters](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#kubernetes-cluster) and [node groups](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#node-group). You can request a manual update of the Kubernetes cluster or its nodes to the [latest supported version](https://yandex.cloud/en/docs/managed-kubernetes/concepts/release-channels-and-updates) at any time. Manual updates bypass any configured maintenance windows and maintenance exceptions. Kubernetes issues updates in a regular manner. To meet the Information Security standards:

* Select a relevant update channel and enable either automatic installation of updates, or manual installation immediately after publication in the selected channel.

* Check that the update settings meet the Information Security standards.

* Use one of the three latest Kubernetes versions, because updates (including security updates) are only released for these versions.

#### Guides and solutions

* [Guide on how to update a cluster automatically](https://yandex.cloud/en/docs/managed-kubernetes/operations/update-kubernetes#cluster-upgrade)
* [Guide on how to update a cluster manually](https://yandex.cloud/en/docs/managed-kubernetes/operations/update-kubernetes#cluster-manual-upgrade)
