---
title: Инструменты для {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, какие инструменты сервис {{ alb-name }} предоставляет для {{ managed-k8s-name }}.
---

# Инструменты для {{ managed-k8s-name }}

Чтобы создавать балансировщики нагрузки и управлять ими в кластерах {{ managed-k8s-name }}, сервис {{ alb-name }} предоставляет следующие инструменты:

* [ALB Ingress-контроллер](k8s-ingress-controller/index.md) — для спецификации {{ k8s }} [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/);
* [Gateway API](k8s-gateway-api/index.md) — для спецификации {{ k8s }} [Gateway API](https://gateway-api.sigs.k8s.io/);
* [{{ yandex-cloud }} Gwin](gwin/index.md) — для спецификаций {{ k8s }} [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) и [Gateway API](https://gateway-api.sigs.k8s.io/).

{% include [ingress-to-gwin-tip](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}