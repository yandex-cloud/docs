---
title: Creating a new {{ k8s }} project in {{ yandex-cloud }}
description: Follow this tutorial to create a new {{ k8s }} project in {{ yandex-cloud }}.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/new-kubernetes-project'
---

# Creating a new {{ k8s }} project in {{ yandex-cloud }}


This tutorial describes how to run a new {{ k8s }} project in {{ yandex-cloud }}. You will deploy an application from [{{ container-registry-full-name }}](../../container-registry/) in a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) and publish it on the internet via the [{{ alb-full-name }}](../../application-load-balancer/) ingress controller.

If you need to create a {{ managed-k8s-name }} cluster with no internet access, see [{#T}](k8s-cluster-with-no-internet.md).

{% include [new-kubernetes-project](../../_tutorials/k8s/new-kubernetes-project.md) %}