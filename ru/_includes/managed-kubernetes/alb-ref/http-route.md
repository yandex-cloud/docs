# Поля ресурса HTTPRoute


В ресурсе `HTTPRoute` определяются правила маршрутизации трафика по бэкендам — сервисам {{ k8s }} ([ресурсам `Service`](../../../application-load-balancer/k8s-ref/service.md)) или перенаправления трафика. `HTTPRoute` получает входящий трафик от тех [ресурсов `Gateway`](../../../application-load-balancer/k8s-ref/gateway.md), требованиям которых соответствует.

`HTTPRoute` предназначен для разработчиков приложений. Оператор кластера должен использовать `Gateway`.

`HTTPRoute` — ресурс {{ k8s }}, определенный [проектом {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/). В этом справочнике описаны поля и аннотации ресурса, с которыми работает Gateway API {{ alb-name }}. Полный справочник ресурса см. в [документации {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1alpha2.HTTPRoute).

## HTTPRoute {#httproute}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: HTTPRoute
metadata:
  name: <string>
  namespace: <string>
spec: <HTTPRouteSpec>
```

Где:

* `apiVersion`: `gateway.networking.k8s.io/v1alpha2`
* `kind`: `HTTPRoute`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Не соответствует имени маршрута в {{ alb-name }}.
 
  * `namespace` (`string`)

    [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

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

  Также маршрут должен удовлетворять правилам, описанным в [спецификации](../../../application-load-balancer/k8s-ref/gateway.md#spec) `Gateway` (поле `spec.listeners.allowedRoutes`).
  
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
    
    Поддерживаются только поля, перечисленные ниже. Другие поля, описанные в [справочнике Gateway API](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1beta1.HTTPRouteMatch) (`headers`, `queryParams`), не поддерживаются.

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

    Ресурс `Service`, на который указывает это поле, должен быть описан по [спецификации](../../../application-load-balancer/k8s-ref/service.md).
  
     * `name` (`string`)

       Имя сервиса {{ k8s }}.

     * `namespace` (`string`)
  
       Пространство имен, к которому относится сервис.

     * `port` (`int32`)

       Номер порта сервиса.

       Номер должен совпадать с одним из номеров портов, указанных в полях `spec.ports.port` ресурса `Service`. Подробнее см. в [спецификации ресурса](../../../application-load-balancer/k8s-ref/service.md).

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