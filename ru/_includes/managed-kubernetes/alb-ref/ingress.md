# Поля и аннотации ресурса Ingress

В ресурсе `Ingress` определяются правила распределения входящего трафика между сервисами {{ k8s }}. По этим правилам [Ingress-контроллер {{ alb-name }}](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) создает [балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md) с нужными обработчиками и [HTTP-роутерами](../../../application-load-balancer/concepts/http-router.md). [Сервисы](../../../application-load-balancer/k8s-ref/service.md), выступающие в роли бэкендов {{ alb-name }}, могут быть указаны в `Ingress` напрямую или в составе [групп бэкендов `HttpBackendGroup`](../../../application-load-balancer/k8s-ref/http-backend-group.md).

`Ingress` — стандартный ресурс {{ k8s }}. В этом справочнике описаны поля и аннотации ресурса, с которыми работает Ingress-контроллер {{ alb-name }}. Полный справочник ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/ingress-v1/).

## Ingress {#ingress}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata: <ObjectMeta>
spec: <IngressSpec>
```

#|
|| **Поле**     | **Значение или тип**   | **Описание**                   ||
|| `apiVersion` | `networking.k8s.io/v1` | **Обязательное**
                                           Версия API Kubernetes          ||
|| `kind`       | `Ingress`              | Тип ресурса                    ||
|| `metadata`   | `ObjectMeta`           | **Обязательное**
                                          [Метаданные ресурса](#metadata) ||
|| `spec`       | `IngressSpec`          | **Обязательное**
                                          [Спецификация ресурса](#spec)   ||
|#

{% cut "Пример" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: alb-demo-tls
  annotations:
    ingress.alb.yc.io/subnets: <список_идентификаторов_подсетей>
    ingress.alb.yc.io/security-groups: <список_идентификаторов_групп_безопасности>
    ingress.alb.yc.io/external-ipv4-address: <auto_или_статический_IP-адрес>
    ingress.alb.yc.io/group-name: my-ingress-group
spec:
  tls:
    - hosts:
        - <доменное_имя>
      secretName: yc-certmgr-cert-id-<идентификатор_TLS-сертификата>
  rules:
    - host: <доменное_имя>
      http:
        paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: alb-demo-1
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: alb-demo-2
                port:
                  number: 80
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: alb-demo-2
                port:
                  name: http
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
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
  ingress.alb.yc.io/modify-header-response-append: <string>
  ingress.alb.yc.io/modify-header-response-replace: <string>
  ingress.alb.yc.io/modify-header-response-rename: <string>
  ingress.alb.yc.io/modify-header-response-remove: <string>
  ingress.alb.yc.io/use-regex: <string>
```

#|
|| **Поле**      | **Значение или тип** | **Описание** ||
|| `name`        | `string`             | **Обязательное**
                                          [Имя ресурса](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names)
                                          Не соответствует имени балансировщика в Application Load Balancer ||
|| `annotations` | `map[string]string`  | **Обязательное**
                                          [Аннотации ресурса](#annotations) ||
|#

### Аннотации (metadata.annotations) {#annotations}

Аннотации — это коллекция пар `ключ:значение`, которые используются для присвоения метаданных объекту. Значения аннотаций всегда имеют тип данных `string`. Подробнее об аннотациях см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

Для объекта `ObjectMeta` можно передать следующие аннотации:

* **ingress.alb.yc.io/group-name** {#annot-group-name}

  Имя группы ресурсов `Ingress`, объединяемых в один балансировщик. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  Поле обязательно, даже если для балансировщика используется один `Ingress`.

* **ingress.alb.yc.io/subnets** {#annot-subnets}

  Список [подсетей](../../../vpc/concepts/network.md#subnet) {{ vpc-name }}, в которых [расположен балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md#lb-location). Идентификаторы подсетей перечисляются через запятую, например:

  ```yaml
  ingress.alb.yc.io/subnets: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
  ```

  Поле обязательно хотя бы для одного из `Ingress`, объединенных в группу (аннотация [ingress.alb.yc.io/group-name](#annot-group-name)) для создания одного балансировщика. В балансировщике используются все подсети, указанные в соответствующих `Ingress`.

  Все подсети одного балансировщика должны относиться к одной сети, из каждой [зоны доступности](../../../overview/concepts/geo-scope.md) можно указать не более одной сети.

* **ingress.alb.yc.io/security-groups** {#annot-security-groups}

  Список [групп безопасности](../../../vpc/concepts/security-groups.md) {{ vpc-name }} для балансировщика. Идентификаторы групп перечисляются через запятую, например:

  ```yaml
  ingress.alb.yc.io/security-groups: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
  ```

  В балансировщике, созданном по группе из нескольких `Ingress` (аннотация [ingress.alb.yc.io/group-name](#annot-group-name)), используются все группы безопасности, указанные в этих `Ingress`.

  Для корректной работы балансировщика и Ingress-контроллера группы безопасности должны быть настроены, как описано в разделе [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

* **ingress.alb.yc.io/external-ipv4-address** {#annot-external-ipv4-address}

  Настройка публичного IP-адреса балансировщика.

  Чтобы использовать [зарезервированный IP-адрес](../../../vpc/operations/get-static-ip.md), укажите его в значении аннотации. Чтобы балансировщик получил IP-адрес автоматически, укажите значение `auto`.

  Если вы указали значение `auto`, то при удалении Ingress-контроллера IP-адрес также будет удален из облака. Чтобы избежать этого, используйте имеющийся зарезервированный адрес.

  Для балансировщика должен быть настроен либо публичный, либо внутренний IP-адрес (аннотация [ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address)), но не оба одновременно.

* **ingress.alb.yc.io/internal-ipv4-address** {#annot-internal-ipv4-address}

  Настройка внутреннего IP-адреса балансировщика.

  IP-адрес должен относиться к подсети, указанной в аннотации [ingress.alb.yc.io/internal-alb-subnet](#annot-internal-alb-subnet). Чтобы использовать конкретный IP-адрес из этой подсети, укажите его в значении аннотации. Чтобы балансировщик получил IP-адрес автоматически, укажите значение `auto`.

  Для балансировщика должен быть настроен либо внутренний, либо публичный IP-адрес (аннотация [ingress.alb.yc.io/external-ipv4-address](#annot-external-ipv4-address)), но не оба одновременно.

* **ingress.alb.yc.io/internal-alb-subnet** {#annot-internal-alb-subnet}

  Идентификатор подсети внутреннего IP-адреса балансировщика.

  Поле обязательно, если для балансировщика настроен внутренний IP-адрес (аннотация [ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address)).

* **ingress.alb.yc.io/protocol** {#annot-protocol}

  Протокол соединений между балансировщиком и бэкендами, описанными в `Ingress`:

  * `http` — HTTP/1.1. Значение по умолчанию.
  * `http2` — HTTP/2.
  * `grpc` — gRPC.

* **ingress.alb.yc.io/group-settings-name** {#annot-group-settings-name}

  Имя для настроек Ingress-группы, объединяемых в один балансировщик.

  Чтобы задать настройки, создайте дополнительный ресурс [IngressGroupSettings](#groupsettings).

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

  Протокол шифрования соединений между балансировщиком и бэкендами, указанными в `Ingress` напрямую (без `HttpBackendGroup`):

  Допустимое значение: `tls` — TLS без проверки сертификата.

  Если аннотация не указана, балансировщик соединяется с бэкендами без шифрования.

  Для бэкендов, входящих в состав групп, значение аннотации игнорируется. Шифрование соединений балансировщика с бэкендами из групп настраивается с помощью поля `spec.backend.tls` ресурса `HttpBackendGroup` (см. [справочник ресурса](../../../application-load-balancer/k8s-ref/http-backend-group.md)).

* **ingress.alb.yc.io/prefix-rewrite** {#annot-prefix-rewrite}

  Замена для путей в URI или имен gRPC-вызовов, перечисленных в [спецификации `Ingress`](#spec) (поле `rules.http.paths`), при маршрутизации запросов на бэкенды.

  Замена зависит от типа пути или имени: при `pathType: Exact` путь или имя заменяется целиком, при `pathType: Prefix` заменяется только указанное начало.

  {% cut "Пример" %}

  Чтобы при всех входящих запросах к вашему API балансировщик отправлял бэкендам запросы к конкретной версии, настройте следующую замену:

  ```yaml
  ...
  metadata:
    annotations:
      ingress.alb.yc.io/prefix-rewrite: /api/v4/
  ...
  spec:
    rules:
      - host: <доменное имя>
        http:
          paths:
            - path: /api/
              pathType: Prefix
              ...
  ```

  {% endcut %}

  В {{ alb-name }} замена будет настроена во всех [HTTP-роутерах](../../../application-load-balancer/concepts/http-router.md), созданных по ресурсу `Ingress`.
  
* **ingress.alb.yc.io/upgrade-types** {#annot-upgrade-types}

  Поддерживаемые балансировщиком значения HTTP-заголовка `Upgrade` во входящих запросах. Значения перечисляются через запятую.

  > Например, с помощью этой аннотации можно включить поддержку протокола [WebSocket](https://{{ lang }}.wikipedia.org/wiki/WebSocket):
  > 
  > ```yaml
  > ingress.alb.yc.io/upgrade-types: WebSocket
  > ```

  В {{ alb-name }} значения `Upgrade` будут настроены во всех HTTP-роутерах, созданных по ресурсу `Ingress`.

* **ingress.alb.yc.io/request-timeout** {#annot-request-timeout}

  Максимальный период, на который может быть установлено соединение между узлом балансировщика и бэкендом. По истечении этого периода балансировщик отправляет клиенту ответ `504 Gateway Timeout`.

  Значение по умолчанию: `60s`.

  В {{ alb-name }} таймаут будет настроен во всех HTTP-роутерах, созданных по ресурсу `Ingress`.

* **ingress.alb.yc.io/idle-timeout** {#annot-idle-timeout}

  Максимальный период, в течение которого соединение между узлом балансировщика и бэкендом может простаивать без передачи данных. По истечении этого периода балансировщик отправляет клиенту ответ `504 Gateway Timeout`.

  Если аннотация не указана, соединение может простаивать в течение любого периода до истечения общего таймаута (аннотация [ingress.alb.yc.io/request-timeout](#annot-request-timeout)).

  В {{ alb-name }} таймаут будет настроен во всех HTTP-роутерах, созданных по ресурсу `Ingress`.

* **ingress.alb.yc.io/modify-header-response-append** {#annot-modify-header-response-append}

  Добавляет строку к значению заголовка ответа. Заголовок и строка указываются в формате:

  ```yaml
  ingress.alb.yc.io/modify-header-response-append: <ключ>=<значение>
  ```

  Где:

    * `<ключ>` — имя изменяемого заголовка.
    * `<значение>` — строка, которая будет добавлена к значению заголовка.

* **ingress.alb.yc.io/modify-header-response-replace** {#annot-modify-header-response-replace}

  Заменяет значение заголовка ответа. Заголовок и его новое значение указываются в формате:

  ```yaml
  ingress.alb.yc.io/modify-header-response-replace: <ключ>=<значение>
  ```

  Где:

    * `<ключ>` — имя изменяемого заголовка.
    * `<значение>` — новое значение заголовка.

* **ingress.alb.yc.io/modify-header-response-rename** {#annot-modify-header-response-rename}

  Переименовывает заголовок ответа. Заголовок и его новое имя указываются в формате:

  ```yaml
  ingress.alb.yc.io/modify-header-response-rename: <ключ>=<значение>
  ```

  Где:

    * `<ключ>` — имя изменяемого заголовка.
    * `<значение>` — новое имя заголовка.

* **ingress.alb.yc.io/modify-header-response-remove** {#annot-modify-header-response-remove}

  Удаляет заголовок ответа. Заголовок для удаления указывается в формате:

  ```yaml
  ingress.alb.yc.io/modify-header-response-remove: <ключ>=true
  ```

  Где `<ключ>` — имя удаляемого заголовка.

* **ingress.alb.yc.io/use-regex** {#annot-use-regex}

  Включает поддержку регулярных выражений стандарта [RE2](https://github.com/google/re2/wiki/Syntax) при сопоставлении пути запроса, если передана строка `true`. Применимо только если для параметра `pathType` указано значение `Exact`.

## IngressSpec {#spec}

```yaml
tls:
  - <IngressTLS>
  - ...
rules:
  - <IngressRule>
  - ...
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||

|| `tls`    | `[]IngressTLS`        | **Обязательное**
[Настройки для приема HTTPS-трафика](#tls): наборы доменных имен и соответствующие этим наборам TLS-сертификаты.

Если поле указано, для балансировщика будут созданы [обработчики](../../../application-load-balancer/concepts/application-load-balancer.md#listener) двух видов: одни будут принимать HTTPS-трафик на порте 443, а другие — перенаправлять запросы с HTTP (порт 80) на HTTPS. При этом правила распределения трафика для тех же доменных имен, явно указанные в других `Ingress`, без поля `tls`, будут иметь приоритет над перенаправлением с HTTP на HTTPS.

Если поле не указано, для балансировщика будут созданы только обработчики для приема HTTP-трафика на порте 80.
||

|| `rules` | `[]IngressRule`  | **Обязательное**
[Список правил](#rule) распределения входящего трафика по бэкендам в зависимости от доменного имени (поле `host`) и запрашиваемого ресурса (поле `http.paths`).

В {{ alb-name }} правила соответствуют [виртуальным хостам](../../../application-load-balancer/concepts/http-router.md#virtual-host) HTTP-роутеров.
||
|#

### IngressTLS {#tls}

```yaml
hosts:
  - <string>
  - ...
secretName: <string>
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||

|| `hosts`    | `[]string`        | **Обязательное**
Доменные имена, которым соответствует TLS-сертификат `secretName`.

Для каждого имени, как для значения TLS-расширения Server Name Indication (SNI), в балансировщике будет создан отдельный обработчик.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}
||

|| `secretName` | `string`  | **Обязательное**
Указание на TLS-сертификат из {{ certificate-manager-full-name }} в формате `yc-certmgr-cert-id-<идентификатор сертификата>`. Под этим именем в {{ managed-k8s-name }} доступен [секрет](https://kubernetes.io/docs/concepts/configuration/secret/) с сертификатом.

В {{ certificate-manager-name }} можно [выпустить сертификат от Let's Encrypt<sup>®</sup>](../../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный сертификат](../../../certificate-manager/operations/import/cert-create.md).

{% include [k8s-ingress-controller-secret-name](../../application-load-balancer/k8s-ingress-controller-secret-name.md) %}
||
|#

### IngressRule {#rule}

```yaml
host: <string>
http:
  paths:
    - path: <string>
      pathType: <string>
      backend: <IngressBackend>
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||

|| `host`    | `string`        | **Обязательное**
Доменное имя (значение заголовка `Host` для HTTP/1.1 или псевдозаголовка `:authority` для HTTP/2), для которого действует правило.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

||

|| `http` | `HTTPIngressRuleValue`  | **Обязательное**
Правило распределения входящих запросов с доменным именем, указанным в поле `host`, в зависимости от запрашиваемого ресурса.

||

|| `http.paths` | `[]HTTPIngressPath`  | **Обязательное**
Список маршрутов: запрашиваемых ресурсов, для которых действует правило, и соответствующих им бэкендов.

Порядок маршрутов в списке важен: они сверяются с входящим запросом по очереди, и первый подошедший маршрут используется в маршрутизации. Поэтому рекомендуется помещать наиболее специфичные маршруты в начало списка. Эта логика отличается от описанной в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress/#multiple-matches), где приоритет имеют маршруты с самыми длинными путями (поле `rules.http.paths.path`).

{% note warning %}

Если балансировщик создается по нескольким `Ingress` (с одинаковым значением аннотации [ingress.alb.yc.io/group-name](#annot-group-name)) и в них есть правила для одного доменного имени, то порядок обработки маршрутов гарантируется только внутри каждого из `Ingress`, но не <q>между</q> ними.

{% endnote %}

||

|| `http.paths.path` | `string`  | **Обязательное**
Указание на запрашиваемый ресурс:

* Для простого HTTP — путь в URI входящего запроса (если тип — `Exact`) или его начало (если тип — `Prefix`).
* Для gRPC (когда значение аннотации [ingress.alb.yc.io/protocol](#annot-protocol) — `grpc`) — полное имя gRPC-вызова (если тип — `Exact`) или его начало (если тип — `Prefix`). Пример: `/my.custom.server.Service/Method`.

В обоих случаях значение должно начинаться с `/`.

||

|| `http.paths.pathType` | `string`  | **Обязательное**
Тип указания на запрашиваемый ресурс:

* `Exact`: путь в URI запроса или имя gRPC-вызова должно _совпадать_ со значением поля `rules.http.paths.path`.
* `Prefix`: путь в URI запроса или имя gRPC-вызова должно _начинаться_ со значения поля `rules.http.paths.path`.

Помимо распределения трафика, от типа зависит механизм замены пути или имени вызова в запросах к бэкендам, если замена настроена с помощью аннотации [ingress.alb.yc.io/prefix-rewrite](#annot-prefix-rewrite).

||

|| `http.paths.backend` | `IngressBackend`  | **Обязательное**
Указание на [бэкенд или группу бэкендов](#backend), которые должны обрабатывать запросы с указанным доменным именем и путем в URI или именем gRPC-вызова.

|#

#### IngressBackend {#backend}

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

#|
|| **Поле** | **Значение или тип** | **Описание** ||

|| `service`    | `IngressServiceBackend`        | **Обязательное**
Указание на [сервис {{ k8s }}](../../../managed-kubernetes/concepts/index.md#service), который должен обрабатывать запросы в качестве бэкенда.

Ресурс `Service`, на который указывает это поле, должен быть описан по [спецификации](../../../application-load-balancer/k8s-ref/service.md).

Для элемента списка `spec.rules.http.paths` должен быть указан либо сервис-бэкенд, либо группа бэкендов (`resource`), но не оба одновременно.

{% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}

||

|| `resource` | `TypedLocalObjectReference`  | **Обязательное**
Указание на группу бэкендов, которые должны обрабатывать запросы.

Ресурс `HttpBackendGroup`, на который указывает это поле, реализован Ingress-контроллером как [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/). Он должен быть описан по [спецификации](../../../application-load-balancer/k8s-ref/http-backend-group.md).

Для элемента списка `spec.rules.http.paths` должна быть указана либо группа бэкендов, либо сервис-бэкенд (`service`), но не оба одновременно.

* `kind`: `HttpBackendGroup`
* `name` (`string`) — имя группы бэкендов.

    Имя должно совпадать с именем, указанным в поле `metadata.name` ресурса `HttpBackendGroup`. Подробнее см. в [спецификации ресурса](../../../application-load-balancer/k8s-ref/http-backend-group.md).

* `apiGroup`: `alb.yc.io`

||
|#

## IngressGroupSettings {#groupsettings}

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: IngressGroupSettings
metadata:
  name: non-default-settings
logOptions:
  logGroupID: <идентификатор_лог-группы>
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

Укажите идентификатор лог-группы и параметры [правил отбрасывания логов](../../../application-load-balancer/concepts/application-load-balancer.md#discard-logs-rules):

* `httpCodes` — HTTP-коды.
* `httpCodeIntervals` — классы HTTP-кодов.
* `grpcCodes` — gRPC-коды.
* `discardPercent` — процент отбрасываемых логов.