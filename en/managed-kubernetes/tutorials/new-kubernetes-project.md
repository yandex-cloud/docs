---
title: Creating a new {{ k8s }} project in {{ yandex-cloud }}
description: Follow this guide to create a new {{ k8s }} project in {{ yandex-cloud }}.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/new-kubernetes-project'
---

# Creating a new {{ k8s }} project in {{ yandex-cloud }}


This article describes how to run a new {{ k8s }} project in {{ yandex-cloud }}. An application from [{{ container-registry-full-name }}](../../container-registry/) is deployed in a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) and published on the internet via the [{{ alb-full-name }}](../../application-load-balancer/) Ingress controller.

If you need to create a {{ managed-k8s-name }} cluster with no internet access, see [{#T}](k8s-cluster-with-no-internet.md).

{% include [new-kubernetes-project](../../_tutorials/k8s/new-kubernetes-project.md) %}