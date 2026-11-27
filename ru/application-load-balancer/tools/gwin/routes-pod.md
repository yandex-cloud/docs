---
title: Маршрутизация трафика {{ alb-name }} напрямую в поды кластера {{ managed-k8s-full-name }} с Gwin
description: Узнайте об особенностях маршрутизации трафика {{ alb-full-name }} напрямую в поды кластера {{ managed-k8s-name }} с Gwin и настройте ее.
alternate:
  - href: ru/application-load-balancer/tools/gwin/routes-pod.md
    type: text/markdown
    title: Markdown version
---


# Маршрутизация трафика {{ alb-name }} напрямую в поды кластера {{ managed-k8s-full-name }} с Gwin 

По умолчанию {{ alb-name }} направляет трафик на NodePort сервиса, а [{{ managed-k8s-full-name}}](../../../managed-kubernetes/) с помощью `kube-proxy` перенаправляет его в один из подов. Схема выглядит так:

{% include [routes-pod](../../../_includes/application-load-balancer/routes-pod.md) %}