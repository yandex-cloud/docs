---
title: Starting a new {{ k8s }} project in {{ yandex-cloud }}
description: In this tutorial, you will learn how to create a new {{ k8s }} project in {{ yandex-cloud }}.
---

# Creating a new {{ k8s }} project in {{ managed-k8s-full-name }}


This tutorial describes how to run a new {{ k8s }} project in {{ yandex-cloud }}. You will deploy an application from [{{ container-registry-full-name }}](../../container-registry/) in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and publish it on the internet via the [{{ alb-full-name }}](../../application-load-balancer/) ingress controller.

{% include [Gwin](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}

If you need to create a {{ managed-k8s-name }} cluster with no internet access, see [{#T}](k8s-cluster-with-no-internet.md).

{% include notitle [new-kubernetes-project](../../_tutorials/k8s/new-kubernetes-project.md) %}