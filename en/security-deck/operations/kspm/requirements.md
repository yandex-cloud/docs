 ---
title: "System and technical requirements when installing {{ kspm-name }}"
description: "This section includes system and technical requirements for {{ k8s }} clusters when installing {{ k8s }}® Security Posture Management ({{ kspm-name }}) in {{ sd-name }}."
---

# System and technical requirements

Before onboarding clusters to {{ kspm-name }}, make sure they meet the minimum requirements.

## Technical requirements {#technical-reqs}

To install the {{ kspm-name }} components, the resources available in the cluster must meet the following technical requirements:

* {{ k8s }} 1.30 or higher.
* There is no [Kyverno](https://yandex.cloud/en/marketplace/products/yc/kyverno)-based [admission control](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/) in the {{ k8s }} cluster. If Kyverno was previously deployed, remove it along with all [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) resources it has created.
* Networking must be set up between the {{ k8s }} cluster nodes and [{{ container-registry-full-name }}](../../../managed-kubernetes/tutorials/container-registry.md).
* Network access must be allowed on port `54321` from the pod running a runtime security monitoring sensor to the cluster pods.
* TCP access from the cluster to the {{ kspm-name }} API (`kspm.api.cloud.yandex.net`) must be allowed on port `443`.
* [Security groups](../../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes) must allow access from the cluster’s master node to {{ kspm-name }} components running on the cluster nodes.

## System requirements {#system-reqs}

To install the {{ kspm-name }} components, the resources available in the cluster must meet the minimum system requirements.

### Requirements for the cluster node group {#worker-node-requirements}

{% note info %}

Below is the minimum cluster node group configuration required to run the {{ kspm-name }} components. This configuration does not account for client load on the nodes.

{% endnote %}

#|
||
**Number of nodes**
|
**CPU,&nbsp;requests**</br>(`Admission` + `Runtime sensor`)
|
**Memory,&nbsp;requests**</br>(`Admission` + `Runtime sensor`)
||
||
2 | 2 vCPU | 4 GB
||
|#

### Resource usage by {{ kspm-name }} components {#component-consumption}

Installing {{ kspm-name }} in a {{ managed-k8s-name }} cluster deploys several components in the cluster. The tables below list these components and the minimum amount of cluster resources reserved for each of them. However, actual resource usage may be higher depending on the load.

**Admission components (Kyverno and admission reporter)**

These components run in a fixed number of replicas and do not depend on the number of nodes in the cluster.

#|
|| **Component** | **Replicas** | **CPU,&nbsp;requests**&nbsp;^1^ | **Memory,&nbsp;requests** ||
|| `kyverno-admission-controller` | 3 | — | 512 MB × 3 ||
|| `kyverno-background-controller` | 1 | 100m | 64 MB ||
|| `kyverno-cleanup-controller` | 1 | 100m | 64 MB ||
|| `kyverno-reports-controller` | 1 | 100m | 64 MB ||
|| `admission-reporter` | 1 | 100m | 64 MB ||
|| **Total** | > | **400m** | **1.75 GB** ||
|#

^1^ The values are specified in thousandths of a vCPU (millicores).

**Runtime sensor components (Tetragon)**

Some of these components run in a fixed number of replicas and do not depend on the number of nodes in the cluster, while others run on every cluster node as `DaemonSet`.

#|
|| **Component** | **Replicas** | **CPU,&nbsp;requests** | **Memory,&nbsp;requests** ||
|| `runtime-sensor-operator` | 1 | 10m | 64 MB ||
|| `runtime-sensor-agent` | 1 | 50m | 256 MB ||
|| `tetragon` (DaemonSet, per node) | ×N | 200m | 256 MB ||
|| `tetragon-server-proxy` (DaemonSet, per node) | ×N | — | — ||
|| **Total (fixed portion)** | > | **60m** | **320 MB** ||
|#

**Kube-bench component**

`kube-bench-reporter` runs on each cluster node as `DaemonSet`.

#|
|| **Component** | **Replicas** | **CPU,&nbsp;requests** | **Memory,&nbsp;requests** ||
|| `kube-bench-reporter` (DaemonSet, per node) | ×N | 50m | 128 MB ||
|#

**osquery components**

The `osquery-agent` and `osqueryd` components run within one `DaemonSet` on each cluster node.

#|
|| **Component** | **Replicas** | **CPU,&nbsp;requests** | **Memory,&nbsp;requests** ||
|| `osquery-agent` | xN | 20m | 64 MB ||
|| `osqueryd` | xN | 50m | 128 MB ||
|#

### Useful links {#see-also}

[{#T}](../../concepts/kspm.md)
