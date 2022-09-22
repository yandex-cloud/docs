# Gateway API для {{ managed-k8s-name }}

{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Gateway API. Подробнее о проекте Gateway API см. на его [сайте](https://gateway-api.sigs.k8s.io/).

После установки Gateway API вы сможете создать с его помощью ресурс `Gateway` и связанные с ним ресурсы `HTTPRoute`: 

* Ресурсом `Gateway` управляет оператор кластера. В этом ресурсе описывается прием входящего трафика и правила, по которым выбираются маршруты для этого трафика — ресурсы `HTTPRoute`. Для приема трафика по `Gateway` создается [L7-балансировщик](../../concepts/application-load-balancer.md), а для маршрутизации к балансировщику привязываются [HTTP-роутеры](../../concepts/http-router.md).
* Ресурсами `HTTPRoute` управляют разработчики приложений — сервисов {{ k8s }}. `HTTPRoute` — описание маршрута для принятого входящего трафика. В соответствии с этим описанием трафик может быть отправлен в сервис {{ k8s }}, выполняющий роль бэкенда, или перенаправлен на другой URI. По `HTTPRoute` создаются виртуальные хосты и маршруты в HTTP-роутерах и [группы бэкендов](../../concepts/backend-group.md).

## Пример конфигурации {#example}

Ниже приведен сокращенный пример конфигурации ресурса `Ingress`. По ней будет создан балансировщик, принимающий HTTPS-трафик и распределяющий его по двум сервисам в зависимости от пути в URI запроса.

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

* Кластер {{ managed-k8s-name }} с версией {{ k8s }} не ниже {{ alb-ingress-k8s-version }}.
* Группа узлов в кластере с версией {{ k8s }} не ниже {{ alb-ingress-k8s-version }}.
* Пространство имен в кластере для хранения ключа [сервисного аккаунта](../k8s-ingress-controller/service-account.md).

Установить Gateway API можно:

* Как продукт {{ marketplace-full-name }} через консоль управления.
* Как чарт через менеджер пакетов [Helm]{% if lang == "ru" %}(https://helm.sh/ru/){% else %}(https://helm.sh/){% endif %} версии не ниже {{ alb-ingress-helm-version }} с [включенной поддержкой OCI](https://helm.sh/docs/topics/registries/). Чарт скачивается и устанавливается с помощью следующих команд:

  ```bash
  export HELM_EXPERIMENTAL_OCI=1 && \
  helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
    --version {{ alb-gateway-api-version }} \
    --untar && \
  helm install \
    --namespace <пространство_имен> \
    --set folderId=<идентификатор_каталога> \
    --set networkId=<идентификатор_сети> \
    --set subnetId=<идентификатор_подсети> \
    --set-file saKeySecretKey=<путь_к_файлу_с_ключом_сервисного_аккаунта> \
    yc-alb-gateway-api ./yc-alb-gateway-api-chart/
   ```

Подробнее о каждом способе см. в [полной инструкции по установке](../../operations/k8s-gateway-api-install.md).

#### См. также {#see-also}

* [Настройка групп безопасности](../k8s-ingress-controller/security-groups.md) для кластера {{ k8s }} и балансировщика.
* [Сервисный аккаунт](../k8s-ingress-controller/service-account.md) для работы контроллера.
