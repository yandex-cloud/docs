# Поля и аннотации ресурса Ingress

В ресурсе `Ingress` определяются правила распределения входящего трафика между сервисами {{ k8s }}. По этим правилам [Ingress-контроллер {{ alb-name }}](../tools/k8s-ingress-controller/index.md) создает [балансировщик](../concepts/application-load-balancer.md) с нужными обработчиками и [HTTP-роутерами](../concepts/http-router.md). [Сервисы](service.md), выступающие в роли бэкендов {{ alb-name }}, могут быть указаны в `Ingress` напрямую или в составе [групп бэкендов `HttpBackendGroup`](http-backend-group.md).

`Ingress` — стандартный ресурс {{ k8s }}. В этом справочнике описаны поля и аннотации ресурса, с которыми работает Ingress-контроллер {{ alb-name }}. Полный справочник ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/ingress-v1/).

## Ingress {#ingress}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: <string>
  annotations:
    ...
spec: <IngressSpec>
```

Где:

* `apiVersion`: `networking.k8s.io/v1`
* `kind`: `Ingress`
* `metadata` (`ObjectMeta`, обязательное)
  
  Метаданные ресурса.

  * `name` (`string`, обязательное)
    
    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Не соответствует имени балансировщика в {{ alb-name }}.
   
  * `annotations` (`map[string]string`, обязательное)
    
    Аннотации ресурса. Подробнее см. [ниже](#annotations).

* `spec` (`IngressSpec`, обязательное)

  Спецификация ресурса. Подробнее см. [ниже](#spec).

## Аннотации (metadata.annotations) {#annotations}

```yaml
metadata:
  annotations:
    ingress.alb.yc.io/group-name: <string>
    ingress.alb.yc.io/subnets: <string>
    ingress.alb.yc.io/security-groups: <string>
    ingress.alb.yc.io/external-ipv4-address: <string>
    ingress.alb.yc.io/internal-ipv4-address: <string>
    ingress.alb.yc.io/internal-alb-subnet: <string>
    ingress.alb.yc.io/protocol: <string>
    ingress.alb.yc.io/group-settings-name: <string>
    ingress.alb.yc.io/transport-security: <string>
    ingress.alb.yc.io/prefix-rewrite: <string>
    ingress.alb.yc.io/upgrade-types: <string>
    ingress.alb.yc.io/request-timeout: <string>
    ingress.alb.yc.io/idle-timeout: <string>
```

Где:

* `ingress.alb.yc.io/group-name` (`string`, обязательное)

  Имя группы ресурсов `Ingress`, объединяемых в один балансировщик. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
     
  Поле обязательно, даже если для балансировщика используется один `Ingress`.
    
* `ingress.alb.yc.io/subnets` (`string`)

  Список [подсетей](../../vpc/concepts/network.md#subnet) {{ vpc-name }}, в которых [расположен балансировщик](../concepts/application-load-balancer.md#lb-location). Идентификаторы подсетей перечисляются через запятую, например:

  ```
  ingress.alb.yc.io/subnets: b0c2kotoidcoh6haf8cu,e2lnhhdj9a0aqmr78d36,e9bud5itjnl8mkjj7td1
  ```

  Поле обязательно хотя бы для одного из `Ingress`, объединенных в группу (аннотация `ingress.alb.yc.io/group-name`) для создания одного балансировщика. В балансировщике используются все подсети, указанные в соответствующих `Ingress`.
    
  Все подсети одного балансировщика должны относиться к одной сети, из каждой [зоны доступности](../../overview/concepts/geo-scope.md) можно указать не более одной сети.

* `ingress.alb.yc.io/security-groups` (`string`)

  Список [групп безопасности](../../vpc/concepts/security-groups.md) {{ vpc-name }} для балансировщика. Идентификаторы групп перечисляются через запятую, например:

  ```
  ingress.alb.yc.io/security-groups: b0c2kotoidcoh6haf8cu,e2lnhhdj9a0aqmr78d36,e9bud5itjnl8mkjj7td1
  ```

  В балансировщике, созданном по группе из нескольких `Ingress` (аннотация `ingress.alb.yc.io/group-name`), используются все группы безопасности, указанные в этих `Ingress`.

  Для корректной работы балансировщика и Ingress-контроллера группы безопасности должны быть настроены, как описано в разделе [{#T}](../tools/k8s-ingress-controller/security-groups.md).

* `ingress.alb.yc.io/external-ipv4-address` (`string`)

  Настройка публичного IP-адреса балансировщика.
    
  Чтобы использовать [зарезервированный IP-адрес](../../vpc/operations/get-static-ip.md), укажите его в значении аннотации. Чтобы балансировщик получил IP-адрес автоматически, укажите значение `auto`.

  Если вы указали значение `auto`, то при удалении Ingress-контроллера IP-адрес также будет удален из облака. Чтобы избежать этого, используйте имеющийся зарезервированный адрес.

  Для балансировщика должен быть настроен либо публичный, либо внутренний IP-адрес (аннотация `ingress.alb.yc.io/internal-ipv4-address`), но не оба одновременно.

* `ingress.alb.yc.io/internal-ipv4-address` (`string`)

  Настройка внутреннего IP-адреса балансировщика.

  IP-адрес должен относиться к подсети, указанной в аннотации `ingress.alb.yc.io/internal-alb-subnet`. Чтобы использовать конкретный IP-адрес из этой подсети, укажите его в значении аннотации. Чтобы балансировщик получил IP-адрес автоматически, укажите значение `auto`.

  Для балансировщика должен быть настроен либо внутренний, либо публичный IP-адрес (аннотация `ingress.alb.yc.io/external-ipv4-address`), но не оба одновременно.

* `ingress.alb.yc.io/internal-alb-subnet` (`string`)

  Идентификатор подсети внутреннего IP-адреса балансировщика.

  Поле обязательно, если для балансировщика настроен внутренний IP-адрес (аннотация `ingress.alb.yc.io/internal-ipv4-address`).

* `ingress.alb.yc.io/protocol` (`string`)

  Протокол соединений между балансировщиком и бэкендами, описанными в `Ingress`:

  * `http` — HTTP/1.1. Значение по умолчанию.
  * `http2` — HTTP/2.
  * `grpc` — gRPC.

* `ingress.alb.yc.io/group-settings-name` (`string`)

  Имя для настроек Ingress-группы, объединяемых в один балансировщик.

  Чтобы задать настройки, создайте дополнительный ресурс `IngressGroupSettings`, например:

  ```yaml
  apiVersion: alb.yc.io/v1alpha1
  kind: IngressGroupSettings
  metadata:
    name: non-default-settings
  logOptions:
    logGroupID: <идентификатор лог-группы>
    discardRules:
      - discardPercent: 50
        grpcCodes:
          - OK
          - CANCELLED
          - UNKNOWN
      - discardPercent: 67
        httpCodeIntervals:
          - HTTP_1XX
      - discardPercent: 20
        httpCodes:
          - 200
          - 404
  ```

  Подробнее см. в описании параметра `logOptions` метода REST API [create](../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md).

* `ingress.alb.yc.io/transport-security` (`string`)

  Протокол шифрования соединений между балансировщиком и бэкендами, указанными в `Ingress` напрямую (без `HttpBackendGroup`):

  * `tls` — TLS без проверки сертификата.

  Если аннотация не указана, балансировщик соединяется с бэкендами без шифрования.

  Для бэкендов, входящих в состав групп, значение аннотации игнорируется. Шифрование соединений балансировщика с бэкендами из групп настраивается с помощью поля `spec.backend.tls` ресурса `HttpBackendGroup` (см. [справочник ресурса](http-backend-group.md)).

* `ingress.alb.yc.io/prefix-rewrite` (`string`)

  Замена для путей в URI или имен gRPC-вызовов, перечисленных в [спецификации `Ingress`](#spec) (поле `rules.http.paths`), при маршрутизации запросов на бэкенды.

  Замена зависит от типа пути или имени: при `pathType: Exact` путь или имя заменяется целиком, при `pathType: Prefix` заменяется только указанное начало.

  > Например, чтобы при всех входящих запросах к вашему API балансировщик отправлял бэкендам запросы к конкретной версии, настройте следующую замену:
  > 
  > ```yaml
  > ...
  > metadata:
  >   annotations:
  >     ingress.alb.yc.io/prefix-rewrite: /api/v4/
  > ...
  > spec:
  >   rules:
  >     - host: <доменное имя>
  >       http:
  >         paths:
  >           - path: /api/
  >             pathType: Prefix
  >             ...
  > ```
  
  В {{ alb-name }} замена будет настроена во всех [HTTP-роутерах](../concepts/http-router.md), созданных по ресурсу `Ingress`.
  
* `ingress.alb.yc.io/upgrade-types` (`string`)

  Значения HTTP-заголовка `Upgrade` во входящих запросах, поддерживаемые балансировщиком. Значения перечисляются через запятую.

  > Например, с помощью этой аннотации можно включить поддержку протокола [WebSocket](https://{{ lang }}.wikipedia.org/wiki/WebSocket):
  > 
  > ```yaml
  > ingress.alb.yc.io/upgrade-types: WebSocket
  > ```

  В {{ alb-name }} значения `Upgrade` будут настроены во всех HTTP-роутерах, созданных по ресурсу `Ingress`.

* `ingress.alb.yc.io/request-timeout` (`string`)

  Максимальный период, на который может быть установлено соединение между узлом балансировщика и бэкендом. По истечении этого периода балансировщик отправляет клиенту ответ `504 Gateway Timeout`.

  Значение по умолчанию: `60s`.

  В {{ alb-name }} таймаут будет настроен во всех HTTP-роутерах, созданных по ресурсу `Ingress`.

* `ingress.alb.yc.io/idle-timeout` (`string`)

  Максимальный период, в течение которого соединение между узлом балансировщика и бэкендом может простаивать без передачи данных. По истечении этого периода балансировщик отправляет клиенту ответ `504 Gateway Timeout`.

  Если аннотация не указана, соединение может простаивать в течение любого периода до истечения общего таймаута (аннотация `ingress.alb.yc.io/request-timeout`).

  В {{ alb-name }} таймаут будет настроен во всех HTTP-роутерах, созданных по ресурсу `Ingress`.

## IngressSpec {#spec}

```yaml
tls:
  - hosts:
      - <string>
      - ...
    secretName: <string>
  - ...
rules:
  - host: <string>
    http:
      paths:
        - path: <string>
          pathType: <string>
          backend: <IngressBackend>
  - ...
```

Где:

* `tls` (`[]IngressTLS`)

  Настройки для приема HTTPS-трафика: наборы доменных имен и соответствующие этим наборам TLS-сертификаты.

  Если поле указано, для балансировщика будут созданы [обработчики](../concepts/application-load-balancer.md#listener) двух видов: одни будут принимать HTTPS-трафик на порте 443, а другие — перенаправлять запросы с HTTP (порт 80) на HTTPS. При этом правила распределения трафика для тех же доменных имен, явно указанные в других `Ingress`, без поля `tls`, будут иметь приоритет над перенаправлением с HTTP на HTTPS. 
  
  Если поле не указано, для балансировщика будут созданы только обработчики для приема HTTP-трафика на порте 80.
  
  * `hosts` (`[]string`, обязательное)
    
    Доменные имена, которым соответствует TLS-сертификат `secretName`.

    Для каждого имени как для значения TLS-расширения Server Name Indication (SNI) в балансировщике будет создан отдельный обработчик.

    {% include [k8s-ingress-controller-hostnames-wildcard](../../_includes/application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}
  
  * `secretName` (`string`, обязательное)

    Указание на TLS-сертификат из {{ certificate-manager-full-name }} в формате `yc-certmgr-cert-id-<идентификатор сертификата>`. Под этим именем в {{ managed-k8s-name }} доступен [секрет](https://kubernetes.io/docs/concepts/configuration/secret/) с сертификатом.

    В {{ certificate-manager-name }} можно [выпустить сертификат от Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный сертификат](../../certificate-manager/operations/import/cert-create.md).

    {% include [k8s-ingress-controller-secret-name](../../_includes/application-load-balancer/k8s-ingress-controller-secret-name.md) %}

* `rules` (`[]IngressRule`, обязательное)

  Список правил распределения входящего трафика по бэкендам в зависимости от доменного имени (поле `host`) и запрашиваемого ресурса (поле `http.paths`).

  В {{ alb-name }} правила соответствуют [виртуальным хостам](../concepts/http-router.md#virtual-host) HTTP-роутеров.

  * `host` (`string`, обязательное)

    Доменное имя (значение заголовка `Host` для HTTP/1.1 или псевдозаголовка `:authority` для HTTP/2), для которого действует правило.

    {% include [k8s-ingress-controller-hostnames-wildcard](../../_includes/application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

  * `http` (`HTTPIngressRuleValue`, обязательное)
    
    Правило распределения входящих запросов с доменным именем, указанным в поле `rules.host`, в зависимости от запрашиваемого ресурса. 
        
    * `paths` (`[]HTTPIngressPath`, обязательное)
    
      Список маршрутов: запрашиваемых ресурсов, для которых действует правило, и соответствующих им бэкендов.
      
      Порядок маршрутов в списке важен: они сверяются с входящим запросом по очереди, и первый подошедший маршрут используется в маршрутизации. Поэтому рекомендуется помещать наиболее специфичные маршруты в начало списка. Эта логика отличается от описанной в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress/#multiple-matches), где приоритет имеют маршруты с самыми длинными путями (поле `rules.http.paths.path`).
  
      {% note warning %}
  
      Если балансировщик создается по нескольким `Ingress` (с одинаковым значением аннотации `ingress.alb.yc.io/group-name`) и в них есть правила для одного доменного имени, то порядок обработки маршрутов гарантируется только внутри каждого из `Ingress`, но не <q>между</q> ними.
  
      {% endnote %}

      * `pathType` (`string`, обязательное)
        
        Тип указания на запрашиваемый ресурс:
    
        * `Exact`: путь в URI запроса или имя gRPC-вызова должно _совпадать_ со значением поля `rules.http.paths.path`.
        * `Prefix`: путь в URI запроса или имя gRPC-вызова должно _начинаться_ со значения поля `rules.http.paths.path`.

        Помимо распределения трафика, от типа зависит механизм замены пути или имени вызова в запросах к бэкендам, если замена настроена с помощью [аннотации](#annotations) `ingress.alb.yc.io/prefix-rewrite`. 
        
      * `path` (`string`, обязательное)
    
        Указание на запрашиваемый ресурс:
        
        * Для простого HTTP — путь в URI входящего запроса (если тип — `Exact`) или его начало (если тип — `Prefix`).
        * Для gRPC (когда значение [аннотации](#annotations) `ingress.alb.yc.io/protocol` — `grpc`) — полное имя gRPC-вызова (если тип — `Exact`) или его начало (если тип — `Prefix`). Пример: `/my.custom.server.Service/Method`.
  
        В обоих случаях значение должно начинаться с `/`.

      * `backend` (`IngressBackend`, обязательное)

        Указание на бэкенд или группу бэкендов, которые должны обрабатывать запросы с указанным доменным именем и путем в URI или именем gRPC-вызова. Подробнее см. [ниже](#backend).

## IngressBackend {#backend}

```yaml
service:
  name: <string>
  port:
    name: <string>
    number: <int32>
resource:
  kind: HttpBackendGroup
  name: <string>
  apiGroup: alb.yc.io
```

Где:

* `service` (`IngressServiceBackend`)
  
  Указание на [сервис {{ k8s }}](../../managed-kubernetes/concepts/index.md#service), который должен обрабатывать запросы в качестве бэкенда.

  Ресурс `Service`, на который указывает это поле, должен быть описан по [спецификации](service.md).

  Для элемента списка `spec.rules.http.paths` должен быть указан либо сервис-бэкенд, либо группа бэкендов (`resource`), но не оба одновременно.

  {% include [k8s-ingress-controller-service-backend](../../_includes/application-load-balancer/k8s-ingress-controller-service-backend.md) %}

* `resource` (`TypedLocalObjectReference`)

  Указание на группу бэкендов, которые должны обрабатывать запросы.

  Ресурс `HttpBackendGroup`, на который указывает это поле, реализован Ingress-контроллером как [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/). Он должен быть описан по [спецификации](http-backend-group.md).

  Для элемента списка `spec.rules.http.paths` должна быть указана либо группа бэкендов, либо сервис-бэкенд (`service`), но не оба одновременно.

  * `kind`: `HttpBackendGroup`
  * `name` (`string`)
  
    Имя группы бэкендов.
  
    Имя должно совпадать с именем, указанным в поле `metadata.name` ресурса `HttpBackendGroup`. Подробнее см. в [спецификации ресурса](http-backend-group.md).

  * `apiGroup`: `alb.yc.io`
