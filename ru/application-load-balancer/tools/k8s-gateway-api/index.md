---
title: "Gateway API для {{ managed-k8s-name }}"
description: "{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в кластерах {{ managed-k8s-full-name }} — Gateway API."
---

# Gateway API для {{ managed-k8s-name }}


{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Gateway API. Подробнее о проекте Gateway API см. на его [сайте](https://gateway-api.sigs.k8s.io/).

После установки Gateway API вы сможете создать с его помощью ресурс `Gateway` и связанные с ним ресурсы `HTTPRoute`:
* Ресурсом `Gateway` управляет оператор кластера. В этом ресурсе описывается прием входящего трафика и правила, по которым выбираются маршруты для этого трафика — ресурсы `HTTPRoute`. Для приема трафика по `Gateway` создается [L7-балансировщик](../../concepts/application-load-balancer.md), а для маршрутизации к балансировщику привязываются [HTTP-роутеры](../../concepts/http-router.md).
* Ресурсами `HTTPRoute` управляют разработчики приложений — сервисов {{ k8s }}. `HTTPRoute` — описание маршрута для принятого входящего трафика. В соответствии с этим описанием трафик может быть отправлен в сервис {{ k8s }}, выполняющий роль бэкенда, или перенаправлен на другой URI. По `HTTPRoute` создаются виртуальные хосты и маршруты в HTTP-роутерах и [группы бэкендов](../../concepts/backend-group.md).

## Пример конфигурации {#example}

Ниже приведен пример конфигурации ресурсов `Gateway` и `HTTPRoute`. По ней будет создан балансировщик, принимающий HTTPS-трафик и распределяющий его по двум сервисам в зависимости от пути в URI запроса.

{% cut "Пример" %}

```yaml
---
apiVersion: gateway.networking.k8s.io/v1alpha2
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
apiVersion: gateway.networking.k8s.io/v1alpha2
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
