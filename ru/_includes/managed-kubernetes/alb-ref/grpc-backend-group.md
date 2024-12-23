# Поля ресурса GrpcBackendGroup



Ресурс `GrpcBackendGroup` позволяет объединять бэкенды — сервисы {{ k8s }}, между которыми распределяется gRPC-трафик, — в группу. По таким ресурсам [Ingress-контроллер {{ alb-name }}](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) создает [группы бэкендов](../../../application-load-balancer/concepts/backend-group.md).

Указание на `GrpcBackendGroup` нужно добавить в [ресурс `Ingress`](../../../application-load-balancer/k8s-ref/ingress.md). Этот `Ingress` должен иметь аннотацию `ingress.alb.yc.io/protocol: grpc`.

{% cut "Пример" %}

```yaml
---
apiVersion: alb.yc.io/v1alpha1
kind: GrpcBackendGroup
metadata:
  namespace: testapp-ns
  name: grpc-bg
spec:
  backends:
    - name: ying
      weight: 50
      service:
        name: grpc-testapp-service
        port:
          number: 8080

    - name: yang
      weight: 50
      service:
        name: grpc-testapp-service2
        port:
          number: 8080
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: testapp-ingress-with-grpc-bg
  namespace: testapp-ns
  annotations:
    ingress.alb.yc.io/group-name: default
    ingress.alb.yc.io/protocol: grpc
spec:
  rules:
    - host: grpc-first-server.info
      http:
        paths:
          - path: /helloworld.Greeter/SayHello
            pathType: Prefix
            backend:
              resource:
                apiGroup: alb.yc.io
                kind: GrpcBackendGroup
                name: grpc-bg
```                
{% endcut %}

`GrpcBackendGroup` — [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) из группы API `alb.yc.io`, предоставляемой Ingress-контроллером.

## GrpcBackendGroup {#grpc-backend-group}

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: GrpcBackendGroup
metadata:
  name: <string>
spec:
  backends:
    - name: <string>
      weight: <int64>
      service:
         name: <int64>
         port:
           name: <string>
           number: <int32>
      tls:
        sni: <string>
        trustedCa: <string>
      healthChecks:
        - grpc:
            serviceName: <string>
          port: <int32>
          healthyThreshold: <int32>
          unhealthyThreshold: <int32>
          timeout: <string>
          interval: <string>
    - ...
```

Где:

* `apiVersion`: `alb.yc.io/v1alpha1`
* `kind`: `GrpcBackendGroup`
* `metadata` (`ObjectMeta`, обязательное)
  
  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
  
    Это имя нужно указать в поле `spec.rules.http.paths.backend.resource.name` ресурса `Ingress` (см. [конфигурацию](../../../application-load-balancer/k8s-ref/ingress.md)).

    Не является именем группы бэкендов в {{ alb-name }}.

* `spec` (`GrpcBackendGroupSpec`)

  Спецификация ресурса.

  * `backends` (`[]GrpcBackend`)
  
    Список бэкендов, входящих в группу.
    
    * `name` (`string`, обязательное)
    
      Имя бэкенда.
    
    * `weight` (`int64`)

      Относительный вес бэкенда. Трафик между бэкендами в группе распределяется пропорционально их весам.

      Веса должны быть указаны либо у всех бэкендов в группе, либо ни у одного из них. Между бэкендами без указанных весов трафик распределяется, как если бы у них были указаны одинаковые положительные веса.

      Если указан неположительный вес, бэкенд не будет получать трафик.

    * `service` (`ServiceBackend`)

      Указание на [сервис {{ k8s }}](../../../managed-kubernetes/concepts/index.md#service), который должен обрабатывать запросы в качестве бэкенда.

      Ресурс `Service`, на который указывает это поле, должен быть описан по [принятой конфигурации](../../../application-load-balancer/k8s-ref/service-for-ingress.md).

      {% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}
        
    * `tls` (`BackendTLS`)
    
      Настройки TLS-соединений между узлами балансировщика и эндпоинтами бэкенда.
    
      Если поле указано, балансировщик устанавливает с бэкендом TLS-соединения и сравнивает полученные сертификаты с сертификатом, указанным в поле `trustedCa`. Если поле не указано, балансировщик устанавливает с бэкендом незащищенные соединения.
        
      * `sni` (`string`)
      
        Доменное имя, указываемое как значение TLS-расширения Server Name Indication (SNI).
      
      * `trustedCa` (`string`)
      
        Содержимое X.509-сертификата, выпущенного центром сертификации, в формате PEM.  

    * `healthChecks` (`[]HealthChecks`)

      Настройки пользовательских [проверок состояния](../../../application-load-balancer/concepts/backend-group.md#health-checks) приложений в кластере {{ managed-k8s-name }}.

      По умолчанию Ingress-контроллер {{ alb-name }} принимает от L7-балансировщика проверочные запросы на TCP-порт `10501` и проверяет работоспособность подов [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на каждом узле кластера. Суть проверки состояния заключается в том, что когда kube-proxy работоспособен, то даже если приложение в конкретном поде не отвечает, {{ k8s }} перенаправит трафик в другой под с этим приложением или на другой узел.
      
      С помощью параметров `healthChecks` вы можете [настроить собственные проверки состояния](../../../managed-kubernetes/tutorials/custom-health-checks.md) приложений.

      * `grpc` (`GrpcBackend`)

        Протокол, по которому будет осуществляться проверка — gRPC.

        * `serviceName` (`string`)

          Имя проверяемого сервиса.

      * `port` (`int32`)

        Порт на узлах кластера для проверки доступности приложения. Значение совпадает с портом, указанным в ресурсе [Service](../../../application-load-balancer/k8s-ref/service-for-ingress.md) типа `NodePort`, в параметре `spec.ports.nodePort`.

        Приложение будет доступно для проверок состояния по адресу `http://<IP-адрес_узла>:<порт>/<путь>`.

      * `healthyThreshold` (`int32`)

        Количество последовательных успешных проверок, после которых эндпоинт приложения считается работоспособным.

      * `unhealthyThreshold` (`int32`)

        Количество последовательных неуспешных проверок, после которых эндпоинт приложения считается неработоспособным.

      * `timeout` (`string`)

        Время ожидания ответа в секундах. Возможные значения — от `1s` до `60s`.

      * `interval` (`string`)

        Интервал отправки проверочных запросов в секундах.

        Возможные значения — от `1s` до `60s`. Значение `interval` должно быть больше значения `timeout` минимум на одну секунду.

      {% include [alb-custom-hc-enabling](../../../_includes/managed-kubernetes/alb-custom-hc-enabling.md) %}