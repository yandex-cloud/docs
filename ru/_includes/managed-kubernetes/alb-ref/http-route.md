# Поля ресурса HTTPRoute

В ресурсе `HTTPRoute` определяются правила маршрутизации трафика по бэкендам — сервисам {{ k8s }} (ресурсам [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md)) или перенаправления трафика. `HTTPRoute` получает входящий трафик от тех [ресурсов Gateway](../../../application-load-balancer/k8s-ref/gateway.md), требованиям которых он соответствует.

`HTTPRoute` предназначен для разработчиков приложений. Оператор кластера должен использовать `Gateway`.

`HTTPRoute` — ресурс {{ k8s }}, определенный [проектом {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/). Ниже описаны поля и аннотации ресурса, с которыми работает Gateway API {{ alb-name }}. Полное описание конфигурации ресурса см. в [документации {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRoute).

## HTTPRoute {#httproute}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: <string>
  namespace: <string>
  annotations:
    gateway.alb.yc.io/rules.backends.http.useHTTP2: <bool>
    gateway.alb.yc.io/rules.backends.balancing.mode: <string>
    gateway.alb.yc.io/rules.backends.balancing.localityAwareRouting: <string>
    gateway.alb.yc.io/rules.backends.balancing.strictLocality: <bool>
    gateway.alb.yc.io/rules.backends.balancing.panicThreshold: <string>
    gateway.alb.yc.io/rule.<имя_правила>.backends.balancing.mode: <string>
    gateway.alb.yc.io/rules.backends.hc.timeout: <string>
    gateway.alb.yc.io/rules.backends.hc.interval: <string>
    gateway.alb.yc.io/rules.backends.hc.healthyThreshold: <string>
    gateway.alb.yc.io/rules.backends.hc.unhealthyThreshold: <string>
    gateway.alb.yc.io/rules.backends.hc.port: <string>
    gateway.alb.yc.io/rules.backends.hc.http.path: <string>
    gateway.alb.yc.io/rules.backends.hc.http.useHTTP2: <bool>
    gateway.alb.yc.io/rules.backends.hc.http.host: <string>
    gateway.alb.yc.io/rules.backends.hc.grpc.serviceName: "Check"
    gateway.alb.yc.io/rules.backends.hc.stream.send: <string>
    gateway.alb.yc.io/rules.backends.hc.stream.receive: <string>
    gateway.alb.yc.io/rules.sessionAffinity.header.name: <string>
    gateway.alb.yc.io/rules.sessionAffinity.cookie.name: <string>
    gateway.alb.yc.io/rules.sessionAffinity.cookie.ttl: <string>
    gateway.alb.yc.io/rules.sessionAffinity.sourceIP: <bool>
    gateway.alb.yc.io/rules.timeout: <string>
    gateway.alb.yc.io/rules.idleTimeout: <string>
    gateway.alb.yc.io/rule.<имя_правила>.timeout: <string>
    gateway.alb.yc.io/rule.<имя_правила>.idleTimeout: <string>
    gateway.alb.yc.io/rules.httpUpgradeTypes: <string>
    gateway.alb.yc.io/rules.securityProfileId: <string>
    gateway.alb.yc.io/rules.rbac.action: <string>
    gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.name: <string>
    gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.regex: <string>
    gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.exact: <string>
    gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.prefix: <string>
    gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.ip.remoteIp: <string>
    gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.any: <bool>
    gateway.alb.yc.io/hosts.securityProfileId: <string>
    gateway.alb.yc.io/hosts.rbac.action: <string>
spec: <HTTPRouteSpec>
```

Где:

* `apiVersion`: `gateway.networking.k8s.io/v1`
* `kind`: `HTTPRoute`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Не является именем маршрута в {{ alb-name }}.

  * `namespace` (`string`)

    [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

  * `annotations` (`map[string]string`)

    Аннотации ресурса.

    {% note info %}

    Вы можете определить ресурс [RoutePolicy](../../../application-load-balancer/k8s-ref/route-policy.md) вместо аннотаций. Набор параметров ресурса `RoutePolicy` и аннотации `HTTPRoute` равнозначны.

    {% endnote %}

    * `gateway.alb.yc.io/rules.timeout` (`string`)

      Таймаут для HTTP-соединения балансировщика и бэкенда. Соединение поддерживается до истечения указанного времени, независимо от того, происходит ли передача данных. При достижении таймаута ресурс возвращает статус `UNAVAILABLE`.

    * `gateway.alb.yc.io/rules.idleTimeout` (`string`)

      Таймаут неактивного HTTP-соединения, в течение которого отсутствует передача данных. По истечении таймаута возвращает статус `504 Gateway Timeout`.
    
    * `gateway.alb.yc.io/rules.securityProfileId` (`string`)
    
      Идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) {{ sws-name }} для маршрута.

    * `gateway.alb.yc.io/hosts.securityProfileId` (`string`)
    
      Идентификатор профиля безопасности для хоста.

    * `gateway.alb.yc.io/rules.backends.http.useHTTP2`

      Использовать HTTP/2 для соединения между балансировщиком и бэкендом.

    * `gateway.alb.yc.io/rules.sessionAffinity.header.name`

      Имя HTTP-заголовка для session affinity.

    * `gateway.alb.yc.io/rules.sessionAffinity.cookie.name` 

      Имя cookie для session affinity.

    * `gateway.alb.yc.io/rules.sessionAffinity.cookie.ttl`

      Время жизни cookie для session affinity.

    * `gateway.alb.yc.io/rules.sessionAffinity.sourceIP`

      Признак использования IP-адреса клиента для session affinity.

    * `gateway.alb.yc.io/rules.backends.balancing.mode`

      Режим балансировки нагрузки. Возможные значения: `RANDOM`, `ROUND_ROBIN`, `LEAST_REQUEST`.

    * `gateway.alb.yc.io/rules.backends.balancing.localityAwareRouting`

      Процент трафика, направляемого в зону доступности ресурса `HTTPRoute`, где размещены бэкенды в статусе healthy. Остальной трафик делится между другими зонами доступности. Параметр не применяется, если задан `strictLocality=true` (см. ниже).

    * `gateway.alb.yc.io/rules.backends.balancing.strictLocality`

      Строгая локальность маршрутизации трафика на бэкенды (только в зоне доступности ресурса `HTTPRoute`)

    * `gateway.alb.yc.io/rules.backends.balancing.panicThreshold`

      Порог panic mode для балансировки (%).

    * `gateway.alb.yc.io/rules.backends.hc.timeout`

      Таймаут ответа на проверку состояния.

    * `gateway.alb.yc.io/rules.backends.hc.interval`

      Интервал между проверками состояния.

    * `gateway.alb.yc.io/rules.backends.hc.healthyThreshold`

      Количество успешных проверок для присвоения ресурсу статуса healthy.

    * `gateway.alb.yc.io/rules.backends.hc.unhealthyThreshold`

      Количество неуспешных проверок для присвоения ресурсу статуса unhealthy.

    * `gateway.alb.yc.io/rules.backends.hc.port`

      Порт для проверок health check.

    * `gateway.alb.yc.io/rules.backends.hc.http.path`

      Путь для HTTP-проверок health check. Пример: `/health`. Используется для HTTP(S)-бэкендов.

    * `gateway.alb.yc.io/rules.backends.hc.http.useHTTP2`

      Использовать HTTP/2 для проверок health check. По умолчанию используется HTTP/1.1. Используется для HTTP(S)-бэкендов.

    * `gateway.alb.yc.io/rules.backends.hc.http.host`

      Адрес хоста для HTTP-проверок health check.

    * `gateway.alb.yc.io/rules.backends.hc.grpc.serviceName`

      Имя gRPC-сервиса для проверок health check gRPC-бэкендов.

    * `gateway.alb.yc.io/rules.backends.hc.stream.send`

      Данные для отправки при TCP health check. Используется для бэкендов с TCP-интерфейсом.

    * `gateway.alb.yc.io/rules.backends.hc.stream.receive`

      Ожидаемый ответ при TCP health check. Используется для бэкендов с TCP-интерфейсом.

    * `gateway.alb.yc.io/rules.timeout`

      Общий таймаут HTTP-соединения между балансировщиком и бэкендом.

    * `gateway.alb.yc.io/rules.idleTimeout`

      Таймаут неактивного HTTP-соединения.

    * `gateway.alb.yc.io/rules.httpUpgradeTypes`

      Поддерживаемые значения HTTP Upgrade (например, websocket).

    * `gateway.alb.yc.io/rules.securityProfileId`

      Идентификатор профиля безопасности {{ sws-name }} для маршрута.

    * `gateway.alb.yc.io/rules.rbac.action`
    
      Действие при совпадении заданных условий (`ALLOW`/`DENY`) для контроля доступа к бэкендам.

    * `gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.name`

      Имя заголовка для проверок условий RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.regex`

      Регулярное выражение для проверки значения заголовка для управления доступом к хосту по RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.exact`

      Точное значение заголовка для управления доступом к хосту по RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.header.prefix`

      Префикс значения заголовка для управления доступом к хосту по RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.ip.remoteIp`

      IP-адрес или CIDR-блок для управления доступом к хосту по RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<имя_группы>.<имя_принципала>.any`

      Любое совпадение заданных условий для управления доступом к хосту по RBAC (`true`/`false`).

    * `gateway.alb.yc.io/hosts.rbac.action`

      Действие при совпадении заданных условий (`ALLOW`/`DENY`) для контроля доступа к хосту по RBAC.

    * `gateway.alb.yc.io/rule.<имя_правила>.backends.balancing.mode`

      Режим балансировки для конкретного правила. Возможные значения: `RANDOM`, `ROUND_ROBIN`, `LEAST_REQUEST`.

    * `gateway.alb.yc.io/rule.<имя_правила>.timeout`

      Таймаут для конкретного правила балансировки.

    * `gateway.alb.yc.io/rule.<имя_правила>.idleTimeout`

      Таймаут неактивности для конкретного правила балансировки.

* `spec` (`HTTPRouteSpec`, обязательное)

  Спецификация ресурса. Подробнее см. [ниже](#spec).

## HTTPRouteSpec {#spec}

```yaml
parentRefs:
  - group: <string>
    kind: <string>
    namespace: <string>
    name: <string>
    sectionName: <string>
  - ...
hostnames:
  - <string>
  - ...
rules:
  - matches:
      - path:
          type: <string>
          value: <string>
        method: <string>
      - ...
    filters:
      - <HTTPRouteFilter>
      - ...
    backendRefs:
      - group: <string>
        kind: <string>
        name: <string>
        namespace: <string>
        port: <int32>
        weight: <int32>
        filters:
          - <HTTPRouteFilter>
          - ...
      - ...
  - ...
```

Где:

* `parentRefs` (`[]ParentReference`, обязательное)

  Список ресурсов `Gateway` (или их обработчиков из поля `spec.listeners` — см. [справочник](../../../application-load-balancer/k8s-ref/gateway.md#spec)), к которым должен быть привязан `HTTPRoute`.

  Также маршрут должен удовлетворять правилам, описанным в [конфигурации](../../../application-load-balancer/k8s-ref/gateway.md#spec) `Gateway` (поле `spec.listeners.allowedRoutes`).
  
  * `namespace` (`string`)
    
    Пространство имен, к которому относится ресурс `Gateway` (указано в его метаданных — в поле `metadata.namespace`).
  
    По умолчанию совпадает с пространством имен ресурса `HTTPRoute` (поле `metadata.namespace`).

  * `name` (`string`, обязательное)
    
    Имя ресурса `Gateway` (указано в его метаданных — в поле `metadata.name`).

  * `sectionName` (`string`)
  
    Имя обработчика, указанного в ресурсе `Gateway` (указано в поле `spec.listeners.name`).

* `hostnames` (`[]string`)

  Список доменных имен (значений заголовка `Host` для HTTP/1.1 или псевдозаголовка `:authority` для HTTP/2), соответствующих маршруту. Для каждого доменного имени будут созданы виртуальные хосты в HTTP-роутерах.

  {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

* `rules` (`[]HTTPRouteRule`)

  Правила маршрутизации и перенаправления запросов.

  * `matches` (`[]HTTPRouteMatch`)
  
    Список условий, хотя бы одному из которых должен соответствовать запрос, чтобы к нему было применено правило.
  
    Например, следующему списку условий будут удовлетворять все запросы к пути `/foo` методом `POST` и все запросы к пути `/bar` любым методом:
  
    ```yaml
    matches:
      - path:
          value: /foo
        method: POST
      - path:
          value: /bar
    ```
    
    Поддерживаются только поля, перечисленные ниже. Другие поля, описанные в [справочнике Gateway API](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRouteMatch) (`headers`, `queryParams`), не поддерживаются.

    * `path` (`HTTPPathMatch`)
  
      Указание на путь в URI запроса.

      * `type` (`string`)
        
        Тип указания на путь в URI запроса:

        * `Exact`: путь должен _совпадать_ со значением поля `rules.matches.path.value`.
        * `PathPrefix`: путь должен _начинаться_ со значения поля `rules.matches.path.value`.

        Помимо распределения трафика, от типа зависит механизм замены пути при перенаправлении. Подробнее см. [ниже](#filter).

      * `value` (`string`)

        Путь в URI входящего запроса (если тип — `Exact`) или его начало (если тип — `PathPrefix`).
 
    * `method` (`HTTPMethod`)
  
      HTTP-метод запроса.

  * `filters` (`[]HTTPRouteFilter`)
    
    Список фильтров, которые описывают изменение заголовков запроса при маршрутизации в любой бэкенд или перенаправление запроса. Подробнее см. [ниже](#filter).
  
    Разрешается указывать либо фильтр типа `RequestHeaderModifier` (изменение заголовков), либо фильтр типа `RequestRedirect` (перенаправление), но не оба сразу.

  * `backendRefs` (`[]HTTPBackendRef`)

    Список [сервисов {{ k8s }}](../../../managed-kubernetes/concepts/index.md#service), которые должны обрабатывать запрос в качестве бэкенда.

    Можно указать ресурс [YCStorageBucket](../../../application-load-balancer/k8s-ref/yc-storage-bucket.md) (бакет {{ objstorage-name }}) либо ресурс [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md).
  
     * `name` (`string`)

       Имя сервиса {{ k8s }} или ресурса с бакетом.

     * `namespace` (`string`)
  
       Пространство имен, к которому относится сервис или ресурс с бакетом.

     * `group` (`string`)

       Имя группы API {{ k8s }}, к которой относится ресурс с бакетом, например `gwin.yandex.cloud`. Только для ресурса `YCStorageBucket`.

       Значение по умолчанию — пустая строка, обозначающая корневую группу API.

     * `kind` (`string`)

       Тип ресурса {{ k8s }} с бакетом. Только для ресурса `YCStorageBucket`. Используется значение `YCStorageBucket`.

     * `port` (`int32`)

       Номер порта сервиса. Только для ресурса `Service`.

       Номер должен совпадать с одним из номеров портов, указанных в полях `spec.ports.port` ресурса `Service`. Подробнее см. в [конфигурации ресурса](../../../application-load-balancer/k8s-ref/service-for-gateway.md).

       Поле предназначено для работы Gateway API и не соответствует ни одному из полей ресурсов {{ alb-name }}.
       
     * `weight` (`int32`)

       Относительный вес бэкенда. Трафик между бэкендами в группе распределяется пропорционально их весам.

       Веса должны быть указаны либо у всех бэкендов в группе, либо ни у одного из них. Между бэкендами без указанных весов трафик распределяется, как если бы у них были указаны одинаковые положительные веса.
    
       Если указан неположительный вес, бэкенд не будет получать трафик.

     * `filters` (`[]HTTPRouteFilter`)

       Настройки изменения заголовков запроса при маршрутизации в бэкенд. Подробнее см. [ниже](#filter).
  
       Разрешается указывать только фильтр типа `RequestHeaderModifier` (изменение заголовков).


## HTTPRouteFilter {#filter}

```yaml
type: <string>
requestHeaderModifier:
  set:
    - name: <string>
      value: <string>
    - ...
  add:
    - name: <string>
      value: <string>
    - ...
  remove:
    - <string>
    - ...
requestRedirect:
  scheme: <string>
  hostname: <string>
  path:
    type: <string>
    replaceFullPath: <string>
    replacePrefixMatch: <string>
  port: <int32>
  statusCode: <int>
```

Где:

* `type` (`string`)
  
  Тип фильтра:

  * `RequestHeaderModifier` — изменение заголовков запроса. Настройки указываются в поле `requestHeaderModifier`.
  * `RequestRedirect` — перенаправление запроса. Настройки указываются в поле `requestRedirect`.

* `requestHeaderModifier` (`HTTPRequestHeaderFilter`)

  Настройки изменения заголовков запроса для фильтра типа `RequestHeaderModifier`.

  * `set` (`[]HTTPHeader`)
  
    Список перезаписываемых заголовков.

    * `name` (`string`)
      
      Имя перезаписываемого заголовка.

    * `value` (`string`)
  
      Значение, записываемое в заголовок.

  * `add` (`[]HTTPHeader`)
  
    Список добавляемых заголовков.

    * `name` (`string`)
      
      Имя добавляемого заголовка.

    * `value` (`string`)
  
      Значение добавляемого заголовка.
 
  * `remove` (`[]string`)
  
    Список имен удаляемых заголовков.

* `requestRedirect` (`HTTPRequestRedirectFilter`)

  Настройки перенаправления запроса для фильтра типа `RequestRedirect`.

  * `scheme` (`string`)
    
    Новая схема в URI запроса: `http` или `https`. По умолчанию схема остается без изменений.

  * `hostname` (`string`)
    
    Новое доменное имя в URI запроса. По умолчанию доменное имя остается без изменений.

  * `path` (`HTTPPathModifier`)
  
    Настройки замены пути в URI запроса.

    * `type` (`string`)
      
      Тип замены пути:
  
      * `ReplaceFullPath` — замена всего пути. Новый путь указывается в поле `replaceFullPath`.
      * `ReplacePrefixMatch` — замена в зависимости от указания пути [спецификации `HTTPRoute`](#spec) (поле `spec.rules.matches.path`): если указан тип `Exact`, заменяется весь путь, если `PathPrefix` — только его начало. Новый путь или его начало указывается в поле `replacePrefixMatch`.

    * `replaceFullPath` (`string`)
      
      Новый путь при типе замены `ReplaceFullPath`.

    * `replacePrefixMatch` (`string`)
  
      Новый путь или его начало при типе замены `ReplacePrefixMatch` (см. описание типа выше).

  * `port` (`int32`)
    
    Новый порт в URI запроса.
    
  * `statusCode` (`int`)
  
    HTTP-код состояния, возвращаемый при перенаправлении.
