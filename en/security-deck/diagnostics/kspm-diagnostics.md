---
title: Possible errors when using {{ k8s }} Security Posture Management (KSPM) in {{ sd-full-name }}
description: In this tutorial, you will learn about possible errors related to {{ k8s }} Security Posture Management (KSPM).
---

# Troubleshooting {{ k8s }} Security Posture Management (KSPM)

## Existing Kyverno installation detected and has to be removed manually {#existing-kyverno-installation}

A Kyverno admission controller was previously installed in the cluster. For the KSPM admission controller to work correctly, Kyverno must be removed during installation. When deleting Kyverno, you must also remove all [CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions) it created:

```bash
kubectl delete crd $(kubectl get crd -o name | grep kyverno.io)
```