# Поля ресурса Gateway

В ресурсе `Gateway` определяются правила приема входящего трафика и выбора маршрутов (ресурсов [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md), [GRPCRoute](../../../application-load-balancer/k8s-ref/grpc-route.md) и [TLSRoute](../../../application-load-balancer/k8s-ref/tls-route.md)) для этого трафика. По этим правилам [Gateway API {{ alb-name }}](../../../application-load-balancer/tools/k8s-gateway-api/index.md) создает:

* [балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md) с нужными обработчиками;
* [группы бэкендов](../../../application-load-balancer/concepts/backend-group.md);
* [HTTP-роутеры](../../../application-load-balancer/concepts/http-router.md) (если используются ресурсы [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md) или [GRPCRoute](../../../application-load-balancer/k8s-ref/grpc-route.md)).

`Gateway` предназначен для оператора кластера. Разработчики приложений должны использовать `TLSRoute`, `HTTPRoute` или `GRPCRoute`.

`Gateway` — ресурс {{ k8s }}, определенный [проектом {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/). Ниже описаны поля и аннотации ресурса, с которыми работает Gateway API {{ alb-name }}. Полное описание конфигурации ресурса см. в [документации {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.Gateway).

## Gateway {#gateway}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: <string>
  namespace: <string>
  annotations:
    gateway.alb.yc.io/security-groups: <string>
    gateway.alb.yc.io/subnets: <string>
    gateway.alb.yc.io/autoScale.minZoneSize: <string>
    gateway.alb.yc.io/autoScale.maxSize: <string>
    gateway.alb.yc.io/zone.<зона_доступности>.receiveTraffic: <bool>
    gateway.alb.yc.io/logs.logGroupId: <string>
    gateway.alb.yc.io/logs.disable: <bool>
    gateway.alb.yc.io/logs.discardRule.<имя_правила>.httpCodes: <string>
    gateway.alb.yc.io/logs.discardRule.<имя_правила>.httpCodeIntervals: <string>
    gateway.alb.yc.io/logs.discardRule.<имя_правила>.grpcCodes: <string>
    gateway.alb.yc.io/logs.discardRule.<имя_правила>.discardPercent: <string>
spec: <GatewaySpec>
```

Где:

* `apiVersion`: `gateway.networking.k8s.io/v1`
* `kind`: `Gateway`
* `metadata` (`ObjectMeta`, обязательное)
  
  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Не является именем балансировщика в {{ alb-name }}.
  
  * `namespace` (`string`)
  
    [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

  * `annotations` (`map[string]string`, обязательное)

    Аннотации ресурса.

    {% note info %}

    Вы можете определить ресурс [GatewayPolicy](../../../application-load-balancer/k8s-ref/gateway-policy.md) вместо аннотаций. Набор параметров ресурса `GatewayPolicy` и аннотации `Gateway` равнозначны.

    {% endnote %}

    * `gateway.alb.yc.io/security-groups` (`string`, обязательное)

      Список [групп безопасности](../../../vpc/concepts/security-groups.md) {{ vpc-name }} для балансировщика. Идентификаторы групп перечисляются через запятую, например:

      ```
      gateway.alb.yc.io/security-groups: b0c2kotoidcoh6haf8cu,e2lnhhdj9a0aqmr78d36,e9bud5itjnl8mkjj7td1
      ```

      Для корректной работы балансировщика и Gateway API группы безопасности должны быть настроены, как описано в разделе [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

    * `gateway.alb.yc.io/subnet-ids` (`string`)

      Список [подсетей](../../../vpc/concepts/network.md#subnet) {{ vpc-name }} в [зонах доступности](../../../overview/concepts/geo-scope.md), где размещен балансировщик. Идентификаторы подсетей перечисляются через запятую.

    * `gateway.alb.yc.io/autoScale.minZoneSize` (`string`)

      Минимальное количество [ресурсных единиц](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) в каждой зоне доступности. По умолчанию минимум равен 2. Указать минимальное значение меньше 2 нельзя.

    * `gateway.alb.yc.io/autoScale.maxSize` (`string`)

      Максимальное суммарное количество ресурсных единиц. По умолчанию количество не ограничено. Значение должно быть не меньше, чем количество зон доступности балансировщика, умноженное на минимальное количество ресурсных единиц в каждой зоне.

    * `gateway.alb.yc.io/zone.<зона_доступности>.receiveTraffic` (`bool`)

      Значение `true` выключает трафик на узлы балансировщика в указанной зоне доступности.

    * `gateway.alb.yc.io/logs.disable` (`bool`)

      Значение `true` выключает логирование балансировщика.

    * `gateway.alb.yc.io/logs.logGroupId` (`string`)

      Идентификатор [лог-группы](../../../logging/concepts/log-group.md) для записи [логов балансировщика](../../../application-load-balancer/logs-ref.md) в {{ cloud-logging-full-name }}.

    * `gateway.alb.yc.io/logs.discardRule.<имя_правила>.httpCodes` (`string`)

      Список HTTP-кодов. Коды перечисляются через запятую. Параметр правила отбрасывания логов. Для имени правила используйте латинские буквы, цифры и дефис.

    * `gateway.alb.yc.io/logs.discardRule.<имя_правила>.httpCodeIntervals` (`string`)

      Список классов HTTP-кодов (например, `HTTP_4XX`). Классы перечисляются через запятую. Параметр правила отбрасывания логов. Для имени правила используйте латинские буквы и цифры.

    * `gateway.alb.yc.io/logs.discardRule.<имя_правила>.grpcCodes` (`string`)

      Список gRPC-кодов. Коды перечисляются через запятую. Параметр правила отбрасывания логов. Для имени правила используйте латинские буквы и цифры.

    * `gateway.alb.yc.io/logs.discardRule.<имя_правила>.discardPercent` (`string`)

      Доля отбрасываемых логов в процентах. Параметр правила отбрасывания логов. Для имени правила используйте латинские буквы и цифры.

* `spec` (`GatewaySpec`, обязательное)

  Спецификация ресурса. Подробнее см. [ниже](#spec).

## GatewaySpec {#spec}

```yaml
gatewayClassName: yc-df-class
listeners:
  - name: <string>
    hostname: <string>
    port: <int32>
    protocol: <string>
    tls:
      mode: <string>
      certificateRefs:
        - group: <string>
          kind: <string>
          name: <string>
          namespace: <string>
        - ...
    allowedRoutes:
      namespaces:
        from: <string>
        selector:
          matchExpressions:
            - key: <string>
              operator: <string>
              values:
                - <string>
                - ...
          matchLabels:
            <string>: <string>
            ...
  - ...
addresses:
  - type: IPAddress
    value: <string>
  - ...
```

Где:

* `gatewayClassName`: `yc-df-class`
* `listeners` (`[]Listener`)

  Обработчики балансировщика.

  * `name` (`string`)
    
    Внутреннее имя обработчика.
    
    Используется только для нужд {{ k8s }} и не является именем обработчика в {{ alb-name }}.
  
    Имя должно иметь формат доменного, то есть соответствовать следующему регулярному выражению: 
    
    ```[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*```
  
    Например, имена `example`, `example.com`, `foo.example.com` подходят, а `example.com/bar`, `-example.` — нет.
    
    Максимальная длина имени — 63 символа.
    
  * `hostname` (`string`)

    Доменное имя, для которого действует обработчик.

    {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}
  
    К обработчику будут привязаны только те маршруты (ресурсы [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md), [GRPCRoute](../../../application-load-balancer/k8s-ref/grpc-route.md) и [TLSRoute](../../../application-load-balancer/k8s-ref/tls-route.md)), доменные имена которых (поле `spec.hostnames`) «пересекаются» с доменным именем в этом поле.

  * `port` (`int32`)
    
    Порт, на котором обработчик принимает входящий трафик.
    
  * `protocol` (`string`)
    
    Протокол, по которому обработчик принимает входящий трафик: `HTTP`, `HTTPS` или `TLS`.

  * `tls` (`GatewayTlsConfig`)

    Настройки TLS, которые используются при работе с входящим HTTPS- или TLS-трафиком.
  
    * `mode` (`string`)
      
      Режим терминирования TLS-соединений.
      
      Единственное поддерживаемое значение и значение по умолчанию — `Terminate`: соединения терминируются с использованием сертификатов из поля `certificateRefs`, расшифрованный трафик отправляется на бэкенды. Режим `Passthrough` (соединения не терминируются) не поддерживается.

    * `certificateRefs` (`[]SecretObjectReference`)
  
      Список ресурсов {{ k8s }}, в которых хранятся TLS-сертификаты.

      Используется, только если значение поля `protocol` — `HTTPS` или `TLS`. В этом случае в списке должен быть хотя бы один сертификат.

      В балансировщике используется только первый сертификат из списка, остальные игнорируются.
  
      Можно указать сертификат {{ certificate-manager-name }} (ресурс [YCCertificate](../../../application-load-balancer/k8s-ref/yc-certificate.md)) либо добавить сертификат в кластер в виде секрета (ресурса `Secret`) через консоль управления {{ managed-k8s-name }} или с помощью kubectl:
  
      ```
      kubectl create secret tls <имя_секрета> \
        -n <имя_пространства_имен> \
        --cert <путь_к_файлу_с_сертификатом> \
        --key <путь_к_файлу_с_закрытым_ключом_сертификата>
      ```
  
      * `group` (`string`)

        Имя группы API {{ k8s }}, к которой относится ресурс с сертификатом, например `networking.k8s.io`.

        Значение по умолчанию — пустая строка, обозначающая корневую группу API.

      * `kind` (`string`)

        Тип ресурса {{ k8s }}, в котором хранится сертификат.
  
        Значение по умолчанию — `Secret`. Для сертификата {{ certificate-manager-name }} используется значение `YCCertificate`.

      * `name` (`string`)

        Имя ресурса {{ k8s }}, в котором хранится сертификат.

      * `namespace` (`string`)
  
        Пространство имен, к которому относится имя ресурса с сертификатом.

  * `allowedRoutes` (`AllowedRoutes`)

    Правила, по которым для обработчика выбираются маршруты (ресурсы [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md), [GRPCRoute](../../../application-load-balancer/k8s-ref/grpc-route.md) и [TLSRoute](../../../application-load-balancer/k8s-ref/tls-route.md)). Чтобы маршрут был выбран, в конфигурации этих ресурсов должно быть указание на `Gateway` в поле `spec.parentRefs`.

    По этим маршрутам создаются [группы бэкендов](../../../application-load-balancer/concepts/backend-group.md), привязываемые к обработчику. При использовании `HTTPRoute` или `GRPCRoute` также создаются [HTTP-роутеры](../../../application-load-balancer/concepts/http-router.md).

    * `namespaces` (`RouteNamespaces`)
  
      Правило выбора пространств имен, к которым относятся ресурсы `HTTPRoute`, `GRPCRoute` и `TLSRoute`, привязываемые к обработчику.
  
      * `from` (`string`)
        
        Тип правила:
  
        * `All` — выбираются ресурсы из всех пространств имен.
        * `Same` — выбираются ресурсы только из того же пространства имен, что и ресурс `Gateway` (поле `metadata.namespace`).
        * `Selector` — выбираются ресурсы из пространств имен, соответствующих требованиям из поля `selector`.

      * `selector` (`LabelSelector`)
  
        Селектор — набор требований к пространствам имен. Выбираются только те пространства, которые удовлетворяют всем требованиям из полей `matchExpressions` и `matchLabels`.
  
        Подробнее см. в [справочнике API {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#labelselector-v1-meta).
  
        Если значение поля `from` — не `Selector`, то поле `selector` игнорируется.

* `addresses` (`[]GatewayAddress`)

  Настройки публичных IP-адресов балансировщика.

  Если поле не указано, балансировщику будет автоматически присвоен один публичный адрес.

  * `type`: `IPAddress`

  * `value` (`string`)
  
    Публичный IP-адрес {{ vpc-full-name }}, присваиваемый балансировщику.
  
    Перед указанием адреса в этом поле его нужно зарезервировать по [инструкции](../../../vpc/operations/get-static-ip.md).
