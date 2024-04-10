---
title: "Справочник инструментов {{ alb-full-name }} для {{ managed-k8s-full-name }}"
description: "На странице представлен справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}."
---

# Справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}



{{ alb-name }} предоставляет инструменты, которые позволяют разворачивать L7-балансировщики нагрузки в кластерах {{ managed-k8s-full-name }}: [Ingress-контроллер](../tools/k8s-ingress-controller/index.md) и [Gateway API](../tools/k8s-gateway-api/index.md). В справочнике описаны конфигурации ресурсов {{ k8s }}, по которым Ingress-контроллер и Gateway API разворачивают инфраструктуру.




## Ресурсы Ingress-контроллера {#ingress}

* [Ingress](ingress.md) — правила распределения трафика между бэкендами.
* [HttpBackendGroup](http-backend-group.md) — объединение бэкендов в группы.

## Ресурсы Gateway API {#gateway-api}

* [Gateway](gateway.md) — правила приема входящего трафика и выбора маршрутов (`HTTPRoute`) для этого трафика.
* [HTTPRoute](http-route.md) — правила маршрутизации трафика по бэкендам или его перенаправления.

## Общие ресурсы {#common}

* [Service](service.md) — описание [сервисов {{ k8s }}](../../managed-kubernetes/concepts/index.md#service), используемых в качестве бэкендов.


