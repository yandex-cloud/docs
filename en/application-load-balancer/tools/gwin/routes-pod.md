---
title: Routing {{ alb-name }} traffic directly to {{ managed-k8s-full-name }} cluster pods with Gwin
description: Learn about the features of routing {{ alb-full-name }} traffic directly to {{ managed-k8s-name }} cluster pods with Gwin and set it up.
---


# Routing {{ alb-name }} traffic directly to {{ managed-k8s-full-name }} cluster pods with Gwin 

By default, {{ alb-name }} routes traffic to the service’s NodePort, while [{{ managed-k8s-full-name}}](../../../managed-kubernetes/) redirects it to one of the pods using `kube-proxy`. The workflow is as follows:

{% include [routes-pod](../../../_includes/application-load-balancer/routes-pod.md) %}