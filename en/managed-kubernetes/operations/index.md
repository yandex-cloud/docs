---
title: "Instructions for operations with {{ managed-k8s-full-name }}"
description: "In this article, you'll learn how to work with the managed service for {{ k8s }} in {{ yandex-cloud }}. Find out how to use persistent volumes and manage {{ k8s }} clusters and node groups."
---

# Step-by-step instructions for {{ managed-k8s-name }}

* [{#T}](node-connect-ssh.md)
* [{#T}](update-kubernetes.md)
* [{#T}](autoscale.md)

## Connecting to a cluster {#cluster-connect}

* [{#T}](connect/index.md)
* [{#T}](connect/security-groups.md)
* [{#T}](connect/create-static-conf.md)

{% if product == "yandex-cloud" %}

## Installing applications from {{ marketplace-full-name }} {#marketplace}

* [{#T}](applications/marketplace.md)
* [{#T}](applications/argo-cd.md)
* [{#T}](applications/csi-s3.md)
* [{#T}](applications/crossplane.md)
* [{#T}](applications/external-secrets-operator.md)
* [{#T}](applications/filebeat.md)
* [{#T}](applications/fluentbit.md)
* [{#T}](applications/gateway-api.md)
* [{#T}](applications/gitlab-agent.md)
* [{#T}](applications/gitlab-runner.md)
* [{#T}](applications/hashicorp-vault.md)
* [{#T}](applications/alb-ingress-controller.md)
* [{#T}](applications/jaeger.md)
* [{#T}](applications/kyverno.md)
* [{#T}](applications/metrics-provider.md)
* [{#T}](applications/node-local-dns.md)
* [{#T}](applications/policy-reporter.md)
* [{#T}](applications/thumbor.md)

{% endif %}

## Network scenarios {#network-scenarios}

* [{#T}](create-load-balancer.md)
* [{#T}](calico.md)
* [{#T}](cilium.md)
* [{#T}](cilium-node-local-dns.md)

## Working with persistent volumes {#persistent-volumes}

* [{#T}](volumes/dynamic-create-pv.md)
* [{#T}](volumes/static-create-pv.md)
* [{#T}](volumes/manage-storage-class.md)
* [{#T}](volumes/volume-expansion.md)
* [{#T}](volumes/statefulset-pvc-expansion.md)
* [{#T}](volumes/mode-block.md)
* [{#T}](volumes/s3-csi-integration.md)

## Managing a {{ k8s }} cluster {#kubernetes-cluster}

* [{#T}](kubernetes-cluster/kubernetes-cluster-list.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-create.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-update.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-namespace-create.md)
* [{#T}](kubernetes-cluster/kubernetes-cluster-delete.md)

## Managing a node group {#node-group}

* [{#T}](node-group/node-group-list.md)
* [{#T}](node-group/node-group-create.md)
* [{#T}](node-connect-ssh.md)
* [{#T}](autoscale.md)
* [{#T}](node-group/node-group-update.md)
* [{#T}](node-group/node-label-management.md)
* [{#T}](node-group/node-group-delete.md)

{% if product == "yandex-cloud" %}

## Working with external nodes {#external-nodes}

* [{#T}](external-nodes-connect.md)

{% endif %}