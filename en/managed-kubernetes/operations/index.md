---
title: How to work with {{ managed-k8s-full-name }}. Instructions
description: "In this article you will learn how to work with managed {{ k8s }} service in {{ yandex-cloud }}. We will tell about persistent volumes, manage a group of nodes, {{ k8s }} cluster."
---

# All instructions

* [{#T}](connect/security-groups.md)
* [{#T}](node-connect-ssh.md)
* [{#T}](update-kubernetes.md)

{% if product == "yandex-cloud" %}

## Installing applications {#marketplace}

* [{#T}](applications/marketplace.md)
* [{#T}](applications/jaeger.md)
* [{#T}](applications/metrics-provider.md)

{% endif %}

## Network scenarios {#network-scenarios}

* [{#T}](create-load-balancer.md)
* [{#T}](calico.md)
* [{#T}](cilium.md)
* [{#T}](cilium-node-local-dns.md)

## Encryption {#encrypting}

* [{#T}](autoscale.md)

## Working with persistent volumes {#persistent-volumes}

* [{#T}](volumes/dynamic-create-pv.md)
* [{#T}](volumes/static-create-pv.md)
* [{#T}](volumes/manage-storage-class.md)
* [{#T}](volumes/volume-expansion.md)
* [{#T}](volumes/statefulset-pvc-expansion.md)
* [{#T}](volumes/mode-block.md)

## Managing a {{ k8s }} cluster {#kubernetes-cluster}

* [{#T}](kubernetes-cluster/kubernetes-cluster-list.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-create.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-update.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-namespace-create.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-delete.md)

## Managing a node group {#node-group}

* [{#T}](node-group/node-group-list.md)
* [{#T}](node-group/node-group-create.md)
* [{#T}](node-group/node-group-update.md)
* [{#T}](node-group/node-label-management.md)
* [{#T}](node-group/node-group-delete.md)

{% if product == "yandex-cloud" %}

## Working with external nodes {#external-nodes}

* [{#T}](external-nodes-connect.md)

{% endif %}