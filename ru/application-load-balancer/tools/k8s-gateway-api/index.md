---
title: Gateway API для {{ managed-k8s-full-name }}
description: '{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в кластерах {{ managed-k8s-full-name }} — Gateway API.'
---

# Gateway API для {{ managed-k8s-name }}

{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Gateway API. Подробнее о проекте Gateway API см. на его [сайте](https://gateway-api.sigs.k8s.io/).

После установки Gateway API вы сможете создать с его помощью ресурс `Gateway`, а также связанные с ним ресурсы `HTTPRoute` и `GRPCRoute`:
* Ресурсом `Gateway` управляет оператор кластера. В этом ресурсе описывается прием входящего трафика и правила, по которым выбираются маршруты для этого трафика — ресурсы `HTTPRoute` и `GRPCRoute`. Для приема трафика по `Gateway` создается [L7-балансировщик](../../concepts/application-load-balancer.md), а для маршрутизации к балансировщику привязываются [HTTP-роутеры](../../concepts/http-router.md).
* Ресурсами `HTTPRoute` и `GRPCRoute` управляют разработчики приложений — сервисов {{ k8s }}. `HTTPRoute` и `GRPCRoute` — описание маршрута для принятого входящего трафика. В соответствии с этим описанием трафик может быть отправлен в сервис {{ k8s }}, выполняющий роль бэкенда, или перенаправлен на другой URI. По `HTTPRoute` и `GRPCRoute` создаются виртуальные хосты и маршруты в HTTP-роутерах, а также [группы бэкендов](../../concepts/backend-group.md).

Полную конфигурацию ресурсов для Gateway API см. в следующих разделах:

* [Gateway](../../k8s-ref/gateway.md) — правила приема входящего трафика и выбора маршрутов (`HTTPRoute`) для этого трафика.
* [GatewayPolicy](../../k8s-ref/gateway-policy.md) — политика применения правил ресурса `Gateway`, конфигурация обработки входящего трафика.
* [YCCertificate](../../k8s-ref/yc-certificate.md) — параметры сертификата {{ certificate-manager-name }} для настройки TLS-соединений в ресурсе `Gateway`.
* [HTTPRoute](../../k8s-ref/http-route.md) и [GRPCRoute](../../k8s-ref/grpc-route.md) — правила маршрутизации трафика по бэкендам или его перенаправления.
* [RoutePolicy](../../k8s-ref/route-policy.md) — политика применения правил ресурса `HTTPRoute` и настройка правил доступа к бэкендам.
* [YCStorageBucket](../../k8s-ref/yc-storage-bucket.md) — параметры бакета {{ objstorage-name }} для настройки бэкенда в ресурсе `HTTPRoute`.
* [Service](../../k8s-ref/service-for-gateway.md) — описание сервисов {{ k8s }}, используемых в качестве бэкендов.

## Порядок маршрутов в виртуальных хостах {#route-order}

Порядок маршрутов в виртуальных хостах определяется алгоритмами, описанными в спецификации Gateway API. Эти алгоритмы отличаются для HTTP-запросов и gRPC-вызовов.

{% list tabs %}

- HTTP-запросы

  [Алгоритм](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io%2Fv1.HTTPRouteRule) сортирует маршруты по условиям совпадения параметров маршрута и входящего HTTP-запроса.

  Условия совпадения в порядке уменьшения приоритета:

  1. Точное совпадение пути.
  1. Совпадение по префиксу пути с наибольшим числом символов.
  1. Соответствие метода.
  1. Наибольшее число совпадений по заголовкам.
  1. Наибольшее число совпадений по параметрам запроса.

  Если запрос не соответствует ни одному из правил, привязанных к текущему родительскому элементу, возвращается код `404`.

- gRPC-вызовы

  [Алгоритм](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io%2Fv1.GRPCRouteRule) сортирует маршруты по количеству символов в параметрах маршрута и входящего gRPC-вызова. Совпадения учитываются только по заголовкам.

  Условия сравнения в порядке уменьшения приоритета:

  1. Наибольшее число символов в доменном имени без звездочек `*`.
  1. Наибольшее число символов в доменном имени.
  1. Наибольшее число символов в имени сервиса.
  1. Наибольшее число символов в имени метода.
  1. Наибольшее число совпадений по заголовкам.

{% endlist %}

Если после применения этих условий среди маршрутов из разных ресурсов остаются маршруты с равным приоритетом, то сначала больший приоритет получают старые маршруты, а затем — маршруты в алфавитном порядке по формату `{namespace}/{name}`.

В случае, если в пределах одного HTTPRoute/GRPCRoute все еще остаются маршруты с равным приоритетом, предпочтение отдается первому подходящему правилу в порядке их перечисления с учетом предыдущих критериев.

Порядок маршрутов может влиять на логику обработки запросов/вызовов.

## Пример конфигурации {#example}

Ниже приведен пример конфигурации ресурсов `Gateway` и `HTTPRoute`. По ней будет создан балансировщик, принимающий HTTPS-трафик и распределяющий его по двум сервисам в зависимости от пути в URI запроса.

{% cut "Пример" %}

```yaml
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: alb-gwapi-gw
spec:
  gatewayClassName: yc-df-class
  listeners:
    - name: alb-gwapi-listener
      protocol: HTTPS
      port: 443
      hostname: <доменное_имя>
      allowedRoutes:
        namespaces:
          from: Selector
          selector:
            matchLabels:
              gatewayName: alb-gwapi-gw
      tls:
        certificateRefs:
          - kind: Secret
            group: ""
            name: alb-gwapi-cert
            namespace: alb-gwapi-ns
```

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: alb-gwapi-apps-ns
  labels:
    gatewayName: alb-gwapi-gw

---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: alb-gwapi-route
  namespace: alb-gwapi-apps-ns
spec:
  hostnames:
    - "<доменное_имя>"
  parentRefs:
    - name: alb-gwapi-gw
      namespace: default
  rules:
    - matches:
        - path: 
            type: PathPrefix
            value: /app1
      backendRefs:
        - name: alb-demo-1
          port: 80
    - matches:
        - path:
            type: PathPrefix
            value: /app2
      backendRefs:
        - name: alb-demo-2
          port: 80
    - backendRefs: # Default match (implicit "/" path prefix)
        - name: alb-demo-2
          port: 80
```

{% endcut %}

## Установка и требования {#install}

Для установки Gateway API требуются:

* Кластер {{ managed-k8s-name }}.
* Группа узлов в кластере.
* Пространство имен в кластере для хранения ключа [сервисного аккаунта](../k8s-ingress-controller/service-account.md).

Установить Gateway API можно по [инструкции](../../operations/k8s-gateway-api-install.md).

#### См. также {#see-also}

* [Настройка групп безопасности](../k8s-ingress-controller/security-groups.md) для кластера {{ k8s }} и балансировщика.
* [Сервисный аккаунт](../k8s-ingress-controller/service-account.md) для работы контроллера.
* [Gateway API в {{ marketplace-full-name }}]({{ link-cloud-marketplace }}/products/yc/gateway-api).
