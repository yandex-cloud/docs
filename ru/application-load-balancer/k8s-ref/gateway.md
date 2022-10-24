# Поля ресурса Gateway

В ресурсе `Gateway` определяются правила приема входящего трафика и выбора маршрутов ([ресурсов `HTTPRoute`](http-route.md)) для этого трафика. По этим правилам [Gateway API {{ alb-name }}](../tools/k8s-gateway-api/index.md) создает [балансировщик](../concepts/application-load-balancer.md) с нужными обработчиками и [HTTP-роутерами](../concepts/http-router.md).

`Gateway` предназначен для оператора кластера. Разработчики приложений должны использовать `HTTPRoute`.

`Gateway` — ресурс {{ k8s }}, определенный [проектом {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/). В этом справочнике описаны поля и аннотации ресурса, с которыми работает Gateway API {{ alb-name }}. Полный справочник ресурса см. в [документации {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1alpha2.Gateway).

## Gateway {#gateway}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: Gateway
metadata:
  name: <string>
  namespace: <string>
  annotations:
    gateway.alb.yc.io/security-groups: <string>
spec: <GatewaySpec>
```

Где:

* `apiVersion`: `gateway.networking.k8s.io/v1alpha2`
* `kind`: `Gateway`
* `metadata` (`ObjectMeta`, обязательное)
  
  Метаданные ресурса.

  * `name` (`string`, обязательное)
    
    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Не соответствует имени балансировщика в {{ alb-name }}.
  
  * `namespace` (`string`)
  
    [Пространство имен](../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.
   
  * `annotations` (`map[string]string`, обязательное)
    
    Аннотации ресурса.

    * `gateway.alb.yc.io/security-groups` (`string`, обязательное)

      {% include [security-groups-note](../_includes_service/security-groups-note.md) %}
    
      Список [групп безопасности](../../vpc/concepts/security-groups.md) {{ vpc-name }} для балансировщика. Идентификаторы групп перечисляются через запятую, например:
    
      ```
      gateway.alb.yc.io/security-groups: b0c2kotoidcoh6haf8cu,e2lnhhdj9a0aqmr78d36,e9bud5itjnl8mkjj7td1
      ```
    
      Для корректной работы балансировщика и Gateway API группы безопасности должны быть настроены, как описано в разделе [{#T}](../tools/k8s-ingress-controller/security-groups.md).

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
    
    Используется только для нужд {{ k8s }} и не соответствует имени обработчика в {{ alb-name }}.
  
    Имя должно иметь формат доменного, то есть соответствовать следующему регулярному выражению: 
    
    ```[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*```
  
    Например, имена `example`, `example.com`, `foo.example.com` подходят, а `example.com/bar`, `-example.` — нет.
    
    Максимальная длина имени — 63 символа.
    
  * `hostname` (`string`)

    Доменное имя, для которого действует обработчик.

    {% include [k8s-ingress-controller-hostnames-wildcard](../../_includes/application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}
  
    К обработчику будут привязаны только те маршруты (ресурсы [HTTPRoute](http-route.md)), доменные имена которых (поле `spec.hostnames`) <q>пересекаются</q> с доменным именем в этом поле.

  * `port` (`int32`)
    
    Порт, на котором обработчик принимает входящий трафик.
    
  * `protocol` (`string`)
    
    Протокол, по которому обработчик принимает входящий трафик: `HTTP` или `HTTPS`.

  * `tls` (`GatewayTlsConfig`)

    Настройки, по которым обработчик принимает входящий HTTPS-трафик.
  
    * `mode` (`string`)
      
      Режим терминирования TLS-соединений. 
      
      Единственное поддерживаемое значение и значение по умолчанию — `Terminate`: соединения терминируются с использованием сертификатов из поля `certificateRefs`, расшифрованный трафик отправляется на бэкенды. Режим `Passthrough` (соединения не терминируются) не поддерживается.

    * `certificateRefs` (`[]SecretObjectReference`)
  
      Список ресурсов {{ k8s }}, в которых хранятся TLS-сертификаты.

      Используется, только если значение поля `protocol` — `HTTPS`. В этом случае в списке должен быть хотя бы один сертификат.

      В балансировщике используется только первый сертификат из списка, остальные игнорируются.
  
      Добавить сертификат в кластер можно в виде секрета (ресурса `Secret`) через консоль управления {{ managed-k8s-name }} или с помощью kubectl:
  
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
  
        Значение по умолчанию — `Secret`.

      * `name` (`string`)
        
        Имя ресурса {{ k8s }}, в котором хранится сертификат.

      * `namespace` (`string`)
  
        Пространство имен, к которому относится имя ресурса с сертификатом.

  * `allowedRoutes` (`AllowedRoutes`)

    Правила, по которым для обработчика выбираются маршруты (ресурсы `HTTPRoute`). По этим маршрутам создаются [HTTP-роутеры](../concepts/http-router.md) и [группы бэкендов](../concepts/backend-group.md), привязываемые к обработчику.
  
    Чтобы `HTTPRoute` был выбран, в его [спецификации](http-route.md#spec) (поле `spec.parentRefs`) должно быть указание на `Gateway`.
  
    * `namespaces` (`RouteNamespaces`)
  
      Правило выбора пространств имен, к которым относятся ресурсы `HTTPRoute`, привязываемые к обработчику.
  
      * `from` (`string`)
        
        Тип правила:
  
        * `All` — выбираются ресурсы из всех пространств имен.
        * `Same` — выбираются ресурсы только из того же пространства имен, что и ресурс `Gateway` (поле `metadata.namespace`).
        * `Selector` — выбираются ресурсы из пространств имен, соответствующих требованиям из поля `selector`.

      * `selector` (`LabelSelector`)
  
        Селектор — набор требований к пространствам имен. Выбираются только те пространства, которые удовлетворяют всем требованиям из полей `matchExpressions` и `matchLabels`.
  
        Подробнее см. в [справочнике API {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#labelselector-v1-meta).
  
        Если значение поля `from` — не `Selector`, то поле `selector` игнорируется. 

* `addresses` (`[]GatewayAddress`)

  Настройки публичных IP-адресов балансировщика.

  Если поле не указано, балансировщику будет автоматически присвоен один публичный адрес. 

  * `type`: `IPAddress`
  * `value` (`string`)
  
    Публичный IP-адрес {{ vpc-full-name }}, присваиваемый балансировщику.
  
    Перед указанием адреса в этом поле его нужно зарезервировать по [инструкции](../../vpc/operations/get-static-ip.md).
