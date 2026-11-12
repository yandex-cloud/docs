---
title: Routing {{ alb-full-name }} traffic directly to {{ managed-k8s-name }} cluster pods with Gwin
description: Learn about the features of routing {{ alb-full-name }} traffic directly to {{ managed-k8s-name }} cluster pods with Gwin and set it up.
canonical: '{{ link-docs }}/application-load-balancer/tools/gwin/routes-pod'
noIndex: true
---


# Routing {{ alb-full-name }} traffic directly to {{ k8s }} cluster pods with Gwin 

By default, [{{ alb-full-name }}](../../application-load-balancer/) routes traffic to the service’s NodePort, while {{ managed-k8s-name }} redirects it to one of the pods using `kube-proxy`. The workflow is as follows:

{% include [routes-pod](../../_includes/application-load-balancer/routes-pod.md) %}