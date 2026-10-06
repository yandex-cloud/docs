---
title: Маршрутизация трафика {{ alb-full-name }} напрямую в поды кластера {{ managed-k8s-name }} с Gwin
description: Узнайте об особенностях маршрутизации трафика {{ alb-full-name }} напрямую в поды кластера {{ managed-k8s-name }} с Gwin и настройте ее.
canonical: '{{ link-docs }}/application-load-balancer/tools/gwin/routes-pod'
noIndex: true
---


# Маршрутизация трафика {{ alb-full-name }} напрямую в поды кластера {{ k8s }} с Gwin 

По умолчанию [{{ alb-full-name }}](../../application-load-balancer/) направляет трафик на NodePort сервиса, а {{ managed-k8s-name }} с помощью `kube-proxy` перенаправляет его в один из подов. Схема выглядит так:

{% include [routes-pod](../../_includes/application-load-balancer/routes-pod.md) %}