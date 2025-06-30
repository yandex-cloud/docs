# Поля ресурса RoutePolicy

Ресурс `RoutePolicy` позволяет задавать облако-специфичные политики для ресурсов `HTTPRoute` и других маршрутов в {{ alb-name }}. Политики применяются к маршрутам на основе селектора или явных ссылок.

{% note info %}

Вы также можете задать параметры политик с помощью аннотаций ресурса `HTTPRoute`. Набор параметров ресурса `RoutePolicy` и аннотации `HTTPRoute` равнозначны.

{% endnote %}

Пример определения ресурса `RoutePolicy` (предназначен только для демонстрации всех параметров):

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: RoutePolicy
metadata:
  name: my-route-policy
spec:
  targetRefs:
    - name: some-http-route
      kind: HTTPRoute
      group: gateway.networking.k8s.io
  selector:
    matchLabels:
      app: my-app

  policy:
    rules:
      timeout: "60s"                           
      idleTimeout: "300s"                      
      securityProfileId: "security-profile-1"
    
      http:
        upgradeTypes: ["websocket"]

      backends:
        balancing:
          mode: "ROUND_ROBIN"
          panicThreshold: 50
          localityAwareRouting: 90
          strictLocality: false

        sessionAffinity:
          header:
            name: "X-Session-ID"
          cookie: 
            name: "session"
            ttl: "1h"
          connection:
            sourceIP: true

        hc:
          timeout: "2s"
          interval: "5s"
          healthyThreshold: 3
          unhealthyThreshold: 5
          port: 30030 

          http:
            path: "/health"
            host: "example.com"
            useHTTP2: true

          grpc:
            serviceName: "health"

          stream:
            send: "PING"
            receive: "PONG"

        tls:
          sni: "example.com"
          trustedCA:
            id: "certificate-id"
            bytes: | 
              -----BEGIN CERTIFICATE-----
              ...
              -----END CERTIFICATE-----

      rbac:
        action: "ALLOW"
        principals:
          admin:
            token-check:
              header:
                name: "X-Auth-Token"
                exact: "admin-token"
            ip-check:
              ip:
                remoteIp: "10.0.0.0/8"
            any: true

  hosts:
    securityProfileId: "security-profile-1"
    rbac:
      ...

  rule:
    api-route: 
      timeout: "30s"
      ...

  host:
    api.example.com: 
      securityProfileId: "api-profile"
      ...
```

## RoutePolicy {#routepolicy}

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: RoutePolicy
metadata:
  name: <string>
  namespace: <string>
spec:
  targetRefs:
    - name: <string>
      kind: <string>
      group: <string>
  selector:
    matchLabels:
      <ключ>: <значение>
  policy:
    rules: <RouteRule>
    rule:
      <имя_правила>: <RouteRule>
    hosts: <VirtualHost>
    host:
      <имя_хоста>: <VirtualHost>
```

Где:

* `apiVersion`: `gateway.alb.yc.io/v1`
* `kind`: `RoutePolicy`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Не является именем балансировщика в {{ alb-name }}.
  
  * `namespace` (`string`)
  
    [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

* `spec` (`RoutePolicySpec`, обязательное):

  * `targetRefs` (`[]LocalObjectReference`) — список ссылок на ресурсы, к которым применяется политика.

  * `selector` (`LabelSelector`) — селектор по меткам для выбора ресурсов.

  * `policy` (`Route`, обязательное) — облако-специфичная конфигурация маршрутов. Подробнее см. [ниже](#route).

## Route {#route}

```yaml
rules: <RouteRule>
rule:
  <имя_правила>: <RouteRule>
hosts:
  securityProfileId: <string>
  rbac: <RBAC>
host:
  <имя_хоста>:
    securityProfileId: <string>
    rbac: <RBAC>
```

Где:

* `rules` (`RouteRule`)

  Общие настройки для всех правил маршрута. Подробнее см. [RouteRule](#routerule).

* `rule` (`map[string]RouteRule`)

  Настройки для конкретных правил (по имени).

* `hosts` (`VirtualHost`)

  Общие настройки для всех виртуальных хостов.

  * `securityProfileId` (`string`)
  
    Идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) {{ sws-name }} для хоста.

  * `rbac` (`RBAC`)
  
    [Настройки RBAC](#rbac) для доступа к хосту.

* `host` (`map[string]VirtualHost`)

  Настройки для конкретных хостов (по имени).

## RouteRule {#routerule}

```yaml
backends: <Backend>
sessionAffinity: <SessionAffinity>
securityProfileId: <string>
rbac: <RBAC>
timeout: <string>
idleTimeout: <string>
http:
  upgradeTypes: [<string>, ...]
```

* `backends` (`Backend`)

  Настройки группы бэкендов. Подробнее см. [Backend](#backend).

* `sessionAffinity` (`SessionAffinity`)

  Параметры сессий. Подробнее см. [SessionAffinity](#sessionaffinity).

* `securityProfileId` (`string`)

  Идентификатор профиля безопасности {{ sws-name }}.

* `rbac` (`RBAC`)

  Настройки RBAC. Подробнее см. [RBAC](#rbac).

* `timeout` (`string`)

  Общий таймаут соединения (например, `"60s"`).

* `idleTimeout` (`string`)

  Таймаут неактивного соединения.

* `http` (`RouteALBHTTP`)

  HTTP-специфичные опции.

  * `upgradeTypes` (`[]string`)
  
    Поддерживаемые значения HTTP Upgrade (например, `websocket`).

## Backend {#backend}

```yaml
http:
  useHTTP2: <bool>
stream:
  enableProxy: <bool>
balancing:
  mode: <string>
  panicThreshold: <int>
  localityAwareRouting: <int>
  strictLocality: <bool>
hc: <HealthCheck>
tls: <BackendTLS>
```

Где:

* `http` (`HTTPBackend`)

  HTTP-настройки бэкенда.

  * `useHTTP2` (`bool`) — использовать протокол HTTP/2 для соединения с бэкендом. По умолчанию используется HTTP/1.1.

* `stream` (`StreamBackend`)

  TCP-настройки бэкенда.

  * `enableProxy` (`bool`)
  
    Включить proxy protocol для TCP-бэкенда.

* `balancing` (`LoadBalancingConfig`)

  Параметры балансировки нагрузки.

  * `mode` (`string`)
  
    Режим балансировки. Возможные значения: `RANDOM`, `ROUND_ROBIN`, `LEAST_REQUEST`.

  * `panicThreshold` (`int`)
  
    Порог для panic mode (%).

  * `localityAwareRouting` (`int`)
  
    Процент трафика в свою зону.

  * `strictLocality` (`bool`)
  
    Признак строгой локальности маршрутов: трафик направляется только в зону доступности узла балансировщика.

* `hc` (`HealthCheck`)

  Параметры health check. Подробнее см. [HealthCheck](#healthcheck).

* `tls` (`BackendTLS`)

  TLS-настройки для соединения с бэкендом. Подробнее см. [BackendTLS](#backendtls).

## HealthCheck {#healthcheck}

```yaml
timeout: <string>
interval: <string>
healthyThreshold: <int>
unhealthyThreshold: <int>
port: <int>
http:
  host: <string>
  path: <string>
  useHTTP2: <bool>
grpc:
  serviceName: <string>
stream:
  send: <string>
  receive: <string>
```

Где:

* `timeout` (`string`)

  Таймаут ответа на проверку состояния.

* `interval` (`string`)

  Интервал между проверками состояния.

* `healthyThreshold` (`int`)

  Количество успешных проверок состояния для присвоения статуса healthy.

* `unhealthyThreshold` (`int`)

  Количество неуспешных проверок состояния для присвоения статуса unhealthy.

* `port` (`int`)
  
  Порт для health check.

* `http` (`HealthcheckHTTP`)

  HTTP-проверка.

  * `host` (`string`) — Host header для проверки.
  * `path` (`string`) — путь для HTTP-проверки.
  * `useHTTP2` (`bool`) — использовать HTTP/2 для проверки.

* `grpc` (`HealthcheckGRPC`)

  gRPC-проверка.

  * `serviceName` (`string`) — имя gRPC-сервиса для проверки.

* `stream` (`HealthcheckStream`)

  TCP-проверка.

  * `send` (`string`) — данные для отправки при TCP-проверке.
  * `receive` (`string`) — ожидаемый ответ.

## BackendTLS {#backendtls}

```yaml
sni: <string>
trustedCA:
  id: <string>
  bytes: <string>
```

Где:

* `sni` (`string`)

  SNI для TLS.

* `trustedCA`

  Доверенный CA:

  * `id` (`string`) — идентификатор сертификата.
  * `bytes` (`string`) — содержимое сертификата в PEM-encoded формате.

## SessionAffinity {#sessionaffinity}

```yaml
connection:
  sourceIP: <bool>
cookie:
  name: <string>
  ttl: <string>
header:
  name: <string>
```

Где:

* `connection.sourceIP` (`bool`)

  Признак использования IP-адреса клиента для session affinity.

* `cookie.name` (`string`)

  Имя cookie для session affinity.

* `cookie.ttl` (`string`)

  TTL для cookie.

* `header.name` (`string`)

  Имя HTTP-заголовка для session affinity.

## RBAC {#rbac}

RBAC управляет доступом к маршрутам и хостам с помощью проверки атрибутов запроса.

Правила RBAC распределяются по _группам_ и _принципалам_:

* Группа — логическая группа проверок, например `admin`.
* Принципал — название для проверки набора условий (например, `check-token`).

Каждое правило задается набором типов проверяемых условий (например, `header`, `ip`).

Все проверки в рамках одной группы объединяются по условию `AND`. Действие проверок в разных группах происходит по условию `OR`.

```yaml
action: <string>
principals:
  <имя_группы>:
    <имя_принципала>:
      header:
        name: <string>
        regex: <string>
        exact: <string>
        prefix: <string>
      ip:
        remoteIp: <string>
      any: <bool>
```

Где:

* `action` (`string`)

  Действие при срабатывании правил (`ALLOW`/`DENY`).

* `principals`

  Группы условий:

  * `header` — условие для сравнения значения заголовка с заданным значением.
  * `ip.remoteIp` — условие для сравнения IP-адреса или CIDR-блока клиентского запроса с заданным значением.
  * `any` — проверка срабатывает для любого запроса.
