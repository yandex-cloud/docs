---
title: Справочник инструментов {{ alb-full-name }} для {{ managed-k8s-full-name }}
description: На странице представлен справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}.
noIndex: true
---

# Справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}


{{ alb-name }} предоставляет инструменты, которые позволяют разворачивать L7-балансировщики нагрузки в кластерах {{ managed-k8s-full-name }}: [Ingress-контроллер](../../application-load-balancer/tools/k8s-ingress-controller/index.md) и [Gateway API](../../application-load-balancer/tools/k8s-gateway-api/index.md). В справочнике описаны конфигурации ресурсов {{ k8s }}, по которым Ingress-контроллер и Gateway API разворачивают инфраструктуру.

## Ресурсы Ingress-контроллера {#ingress}

* [Ingress](ingress.md) — правила распределения трафика между бэкендами.
* [HttpBackendGroup](http-backend-group.md), [GrpcBackendGroup](grpc-backend-group.md) — объединение бэкендов в группы.
* [IngressClass](ingress-class.md) — управление несколькими Ingress-контроллерами в кластере {{ k8s }}.
* [Service](service-for-ingress.md) — описание [сервисов {{ k8s }}](../concepts/index.md#service), используемых в качестве бэкендов. Отличается от ресурса `Service` для Gateway API тем, что для сервисов Ingress-контроллера поддержаны аннотации.

## Ресурсы Gateway API {#gateway-api}

* [Gateway](gateway.md) — правила приема входящего трафика и выбора маршрутов (`HTTPRoute` и `TLSRoute`) для этого трафика.
* [GatewayPolicy](gateway-policy.md) — политика применения правил ресурса `Gateway`, конфигурация обработки входящего трафика.
* [YCCertificate](./yc-certificate.md) — параметры сертификата {{ certificate-manager-name }} для настройки TLS-соединений в ресурсе `Gateway`.
* [HTTPRoute](http-route.md) — правила для перенаправления или маршрутизации HTTP- и HTTPS-трафика по бэкендам.
* [RoutePolicy](route-policy.md) — политика применения правил ресурса `HTTPRoute` и настройка правил доступа к бэкендам.
* [GRPCRoute](grpc-route.md) — правила для перенаправления или маршрутизации gRPC-трафика по бэкендам.
* [YCStorageBucket](./yc-storage-bucket.md) — параметры бакета {{ objstorage-name }} для настроек бэкенда в ресурсе `HTTPRoute`.
* [TLSRoute](./tls-route.md) — правила для маршрутизации TLS-трафика по бэкендам.
* [Service](service-for-gateway.md) — описание сервисов {{ k8s }}, используемых в качестве бэкендов.
