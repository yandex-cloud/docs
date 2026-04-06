---
title: Possible errors when using {{ kspm-full-name }} ({{ kspm-name }}) in {{ sd-full-name }}
description: In this tutorial, you will learn about possible errors related to {{ kspm-full-name }} ({{ kspm-name }}).
---

# Troubleshooting {{ kspm-full-name }} ({{ kspm-name }})

## Existing Kyverno installation detected and has to be removed manually {#existing-kyverno-installation}

A Kyverno admission controller was previously installed in the cluster. For the {{ kspm-name }} admission controller to work correctly, Kyverno must be removed during installation. When deleting Kyverno, you must also remove all [CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions) it created:

```bash
kubectl delete crd $(kubectl get crd -o name | grep kyverno.io)
```

## Unable to check for existing Kyverno installation {#kyverno-check-error}

An unexpected error occurred while checking the cluster for the presence of Kyverno. Contact [support]({{ link-console-support }}).

## Cluster version too old {#outdated-cluster}

The specified cluster version is not supported. Upgrade the cluster to a [supported version](../concepts/kspm.md).

## Insufficient permissions in the cluster {#insufficient-permissions}

The service account specified when [activating the module](../operations/kspm/enable-kspm.md) does not have access to the cluster. Make sure the account has the [`security-deck.worker`](../security/index.md#security-deck-worker) role.

## Unable to check permissions in the cluster {#cluster-access-error}

 An unexpected error occurred while checking access permissions in the cluster. Either the cluster is unavailable or access is restricted by [network policies](../../managed-kubernetes/concepts/network-policy.md). 

 ## Component is unhealthy {#unhealthy-component}
 
 Component operation error. Contact [support]({{ link-console-support }}).

 ## Component sync failed {#failed-sync}
 
 An unexpected error occurred while modifying the component. Contact [support]({{ link-console-support }}).