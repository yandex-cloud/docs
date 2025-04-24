---
title: Starting a new {{ k8s }} project in {{ yandex-cloud }}
description: In this tutorial, you will learn how to create a new {{ k8s }} project in {{ yandex-cloud }}.
---

# Creating a new {{ k8s }} project in {{ managed-k8s-full-name }}


This article describes how to run a new {{ k8s }} project in {{ yandex-cloud }}. An application from [{{ container-registry-full-name }}](../../container-registry/) is deployed in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and published on the internet via the [{{ alb-full-name }}](../../application-load-balancer/) Ingress controller.

If you need to create a {{ managed-k8s-name }} cluster with no internet access, see [{#T}](k8s-cluster-with-no-internet.md).

{% include notitle [new-kubernetes-project](../../_tutorials/k8s/new-kubernetes-project.md) %}