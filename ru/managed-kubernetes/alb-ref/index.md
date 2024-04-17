---
title: "Справочник инструментов {{ alb-full-name }} для {{ managed-k8s-full-name }}"
description: "На странице представлен справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}."
noIndex: true
---

# Справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}


{{ alb-name }} предоставляет инструменты, которые позволяют разворачивать L7-балансировщики нагрузки в кластерах {{ managed-k8s-full-name }}: [Ingress-контроллер](../../application-load-balancer/tools/k8s-ingress-controller/index.md) и [Gateway API](../../application-load-balancer/tools/k8s-gateway-api/index.md). В справочнике описаны конфигурации ресурсов {{ k8s }}, по которым Ingress-контроллер и Gateway API разворачивают инфраструктуру.

## Ресурсы Ingress-контроллера {#ingress}

* [Ingress](ingress.md) — правила распределения трафика между бэкендами.
* [HttpBackendGroup](http-backend-group.md) — объединение бэкендов в группы.
* [IngressClass](ingress-class.md) — управление несколькими Ingress-контроллерами в кластере {{ k8s }}.
* [Service](service-for-ingress.md) — описание [сервисов {{ k8s }}](../concepts/index.md#service), используемых в качестве бэкендов. Отличается от ресурса `Service` для Gateway API тем, что для сервисов Ingress-контроллера поддержаны аннотации.

## Ресурсы Gateway API {#gateway-api}

* [Gateway](gateway.md) — правила приема входящего трафика и выбора маршрутов (`HTTPRoute`) для этого трафика.
* [HTTPRoute](http-route.md) — правила маршрутизации трафика по бэкендам или его перенаправления.
* [Service](service-for-gateway.md) — описание сервисов {{ k8s }}, используемых в качестве бэкендов.
