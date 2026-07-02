[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > [Инструменты Application Load Balancer](index.md) > Gateway API > Конфигурация ресурсов > GRPCRoute

# Поля ресурса GRPCRoute

В ресурсе `GRPCRoute` определяются правила маршрутизации трафика по бэкендам — сервисам Kubernetes (ресурсам [Service](service-for-gateway.md)) или перенаправления трафика. `GRPCRoute` получает входящий трафик от тех [ресурсов `Gateway`](gateway.md), требованиям которых соответствует.

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](gwin-index.md).

{% endnote %}

`GRPCRoute` предназначен для разработчиков приложений. Оператор кластера должен использовать `Gateway`.

`GRPCRoute` — ресурс Kubernetes, определенный [проектом Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/). Ниже описаны поля и аннотации ресурса, с которыми работает Gateway API Application Load Balancer. Полное описание конфигурации ресурса приведено в [документации Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.GRPCRoute).

## GRPCRoute {#grpc-route}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GRPCRoute
metadata:
  name: <string>
  namespace: <string>
spec: <GRPCRouteSpec>
```

Где:

* `apiVersion: gateway.networking.k8s.io/v1`
* `kind: GRPCRoute`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Формат описан в [документации Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Не является именем маршрута в Application Load Balancer.
 
  * `namespace` (`string`)

    [Пространство имен](../concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

* `spec` (`GRPCRouteSpec`, обязательное)

  Спецификация ресурса. Подробнее читайте [ниже](#spec).


{% cut "Пример" %}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GRPCRoute
metadata:
  name: mosquitoes-grpc-route
  namespace: mosquitoes-ns
spec:
  hostnames:
  - "forest.zoo.com"
  parentRefs:
  - name: gateway-api-test-gateway
    namespace: default
  rules:
  - backendRefs:
    - name: mosquitoes-service
      port: 8080
    matches:
    - method:
        type: "Exact"
        method: "IdentifyA"
```

{% endcut %}

## GRPCRouteSpec {#spec}

```yaml
parentRefs:
  - namespace: <string>
    name: <string>
    sectionName: <string>
  - ...
hostnames:
  - <string>
  - ...
rules:
  - matches:
      - method:
          type: <string>
          service: <string>
          method: <string>
      - ...
    filters:
      - type: <string>
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
    backendRefs:
      - name: <string>
        namespace: <string>
        port: <int32>
        weight: <int32>
      - ...
  - ...
```

Где:

* `parentRefs` (`[]ParentReference`, обязательное)

  Список ресурсов `Gateway` (или их обработчиков из поля `spec.listeners` — подробнее в [справочнике](gateway.md#spec)), к которым должен быть привязан `GRPCRoute`.

  Также маршрут должен удовлетворять правилам, описанным в [конфигурации](gateway.md#spec) `Gateway` (поле `spec.listeners.allowedRoutes`).
  
  * `namespace` (`string`)
    
    Пространство имен, к которому относится ресурс `Gateway` (указано в его метаданных — в поле `metadata.namespace`).
  
    По умолчанию совпадает с пространством имен ресурса `GRPCRoute` (поле `metadata.namespace`).

  * `name` (`string`, обязательное)
    
    Имя ресурса `Gateway` (указано в его метаданных — в поле `metadata.name`).

  * `sectionName` (`string`)
  
    Имя обработчика, указанного в ресурсе `Gateway` (поле `spec.listeners.name`).

* `hostnames ([]string)`

  Список доменных имен (значений псевдозаголовка `:authority`), соответствующих маршруту. Для каждого доменного имени будут созданы виртуальные хосты в HTTP-роутерах.

  Чтобы указать на все возможные поддомены любых уровней, вместо первого уровня доменного имени используйте звездочку `*`. В этом случае значение нужно обернуть в кавычки.
  
  > Например, значение `"*.example.com"` соответствует доменным именам `foo.example.com`, `foo-bar.example.com`, `foo.bar.example.com`, `foo.bar.baz.example.com` и т. п. (но не `example.com`).
  
  Заменить звездочкой только часть первого уровня доменного имени, например `*foo.example.com`, нельзя.

* `rules` (`[]GRPCRouteRule`)

  Правила маршрутизации и перенаправления gRPC-вызовов.

  * `matches` (`[]GRPCRouteMatch`)
  
    Список условий, хотя бы одному из которых должен соответствовать gRPC-вызов, чтобы к нему было применено правило.

    Например, следующему списку условий будут удовлетворять все gRPC-вызовы, имена которых включают сервис `service.example` и метод `Login`, а также вызовы, имена которых включают сервис `service.v2.example` и любой из методов этого сервиса:

    ```yaml
    - matches:
      - method:
          service: service.example
          method: Login
      - method:
          service: service.v2.example
    ```

    Поддерживается только поле `method`. Поле `headers`, описанное в [справочнике Gateway API](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.GRPCHeaderMatch), не поддерживается.

    * `method` (`GRPCMethodMatch`)
      
        Указание на gRPC-сервис и gRPC-метод, из которых должно состоять имя вызова. Хотя бы одно из этих полей должно быть заполнено.

      * `service`

        Указание на gRPC-сервис.

      * `method`

        Указание на gRPC-метод.

      * `type` (`GRPCMethodMatchType`)

        Тип указания на метод и сервис в имени вызова:

        * `Exact` — метод и/или сервис должны совпадать со значением поля `rules.matches.method`.
        * `RegularExpression` — метод и/или сервис должны соответствовать регулярному выражению, указанному в поле `rules.matches.method`.

  * `filters` (`[]GRPCRouteFilter`)

    Настройки изменения заголовков вызова при маршрутизации в бэкенд.

    * `type` (`string`)
      
      Тип фильтра:

      * `RequestHeaderModifier` — изменение заголовков вызова. Настройки указываются в поле `requestHeaderModifier`.

    * `requestHeaderModifier` (`HTTPHeaderFilter`)

        Настройки изменения заголовков вызова для фильтра типа `RequestHeaderModifier`.

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

  * `backendRefs` (`[]GRPCBackendRef`)

    Список [сервисов Kubernetes](../concepts/index.md#service), которые должны обрабатывать вызовы в качестве бэкенда.
      
     * `name` (`string`)

       Имя сервиса Kubernetes. Ресурс `Service`, на который указывает это поле, должен быть описан по [принятой конфигурации](service-for-gateway.md). 

     * `namespace` (`string`)
  
       Пространство имен, к которому относится ресурс `Service`. По умолчанию совпадает с пространством имен ресурса `GRPCRoute` (поле `metadata.namespace`).

     * `port` (`int32`)

       Номер порта сервиса.

       Номер должен совпадать с одним из номеров портов, указанных в полях `spec.ports.port` ресурса `Service`. Подробнее в [конфигурации ресурса](service-for-gateway.md).
       
     * `weight` (`int32`)

       Относительный вес бэкенда. Трафик между бэкендами в группе распределяется пропорционально их весам.

       Веса должны быть указаны либо у всех бэкендов в группе, либо ни у одного из них. Между бэкендами без указанных весов трафик распределяется, как если бы у них были указаны одинаковые положительные веса.
    
       Если указан неположительный вес, бэкенд не будет получать трафик.