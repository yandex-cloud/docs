# Поля ресурса HttpBackendGroup

Ресурс `HttpBackendGroup` позволяет объединять бэкенды — сервисы Kubernetes, между которыми распределяется трафик, — в группу. По таким ресурсам [Ingress-контроллер Application Load Balancer](../tools/k8s-ingress-controller/index.md) создает [группы бэкендов](../concepts/backend-group.md).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../tools/gwin/index.md).

{% endnote %}

Указание на `HttpBackendGroup` нужно добавить в [ресурс `Ingress`](ingress.md).

При использовании `HttpBackendGroup` доступна расширенная функциональность Application Load Balancer. Бэкендами в такой группе могут быть сервисы Kubernetes и [бакеты Yandex Object Storage](../../storage/concepts/bucket.md). Также в `HttpBackendGroup` можно указывать относительные веса бэкендов для пропорционального распределения трафика между ними.

`HttpBackendGroup` — [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) из группы API `alb.yc.io`, предоставляемой Ingress-контроллером.

## HttpBackendGroup {#http-backend-group}

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: HttpBackendGroup
metadata:
  name: <string>
spec:
  backends:
    - name: <string>
      weight: <int64>
      useHttp2: <bool>
      service:
         name: <int64>
         port:
           name: <string>
           number: <int32>
      storageBucket:
        name: <string>
      tls:
        sni: <string>
        trustedCa: <string>
      healthChecks:
        - http:
            path: <string>
          port: <int32>
          healthyThreshold: <int32>
          unhealthyThreshold: <int32>
          timeout: <string>
          interval: <string>
      loadBalancingConfig:
        balancerMode: <string>
        panicThreshold: <int64>
        localityAwareRouting: <int64>
    - ...
```

Где:

* `apiVersion`: `alb.yc.io/v1alpha1`
* `kind`: `HttpBackendGroup`
* `metadata` (`ObjectMeta`, обязательное)
  
  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
  
    Это имя нужно указать в поле `spec.rules.http.paths.backend.resource.name` ресурса `Ingress` (см. [конфигурацию](ingress.md)).

    Не является именем группы бэкендов в Application Load Balancer.

* `spec` (`HttpBackendGroupSpec`)

  Спецификация ресурса.
  
  * `backends` (`[]HttpBackend`)
  
    Список бэкендов, входящих в группу.
    
    * `name` (`string`, обязательное)
    
      Имя бэкенда.
    
    * `weight` (`int64`)

      Относительный вес бэкенда. Трафик между бэкендами в группе распределяется пропорционально их весам.

      Веса должны быть указаны либо у всех бэкендов в группе, либо ни у одного из них. Между бэкендами без указанных весов трафик распределяется, как если бы у них были указаны одинаковые положительные веса.

      Если указан неположительный вес, бэкенд не будет получать трафик.
    
    * `useHttp2` (`bool`)
    
      Разрешает устанавливать HTTP/2-соединения между узлами балансировщика и эндпоинтами бэкенда.

      Значение по умолчанию — `false`: устанавливаются HTTP/1.1-соединения.

    * `service` (`ServiceBackend`)

      Указание на [сервис Kubernetes](../../managed-kubernetes/concepts/index.md#service), который должен обрабатывать запросы в качестве бэкенда.

      Ресурс `Service`, на который указывает это поле, должен быть описан по [принятой конфигурации](service-for-ingress.md).

      Для бэкенда должен быть указан либо сервис, либо бакет Object Storage (`storageBucket`), но не оба одновременно.

      * `name` (`string`, обязательное)
      
        Имя сервиса Kubernetes.
      
      * `port` (`ServiceBackendPort`, обязательное)
      
        Порт сервиса, к которому будет обращаться `Ingress`.
      
        Поле предназначено для работы Ingress-контроллера и не соответствует ни одному из полей ресурсов Application Load Balancer.
      
        * `name` (`string`)
      
          Имя порта сервиса.
      
          Имя должно совпадать с одним из имен портов, указанных в полях `spec.ports.name` ресурса `Service`. Подробнее см. в [спецификации ресурса](service-for-ingress.md).
      
          Для порта сервиса должно быть указано либо имя, либо номер (`number`), но не оба одновременно.
      
        * `number` (`int32`)
      
          Номер порта сервиса.
      
          Номер должен совпадать с одним из номеров портов, указанных в полях `spec.ports.port` ресурса `Service`. Подробнее см. в [спецификации ресурса](service-for-ingress.md).
      
          Для порта сервиса должен быть указан либо номер, либо имя (`name`), но не оба одновременно.
        
    * `storageBucket` (`StorageBucketBackend`)

      Указание на [бакет Yandex Object Storage](../../storage/concepts/bucket.md), который должен обрабатывать запросы в качестве бэкенда. Подробнее об использовании бакета как бэкенда см. в разделе [Типы бэкендов](../concepts/backend-group.md#types).

      {% note warning %}
        
      Чтобы бакет можно было использовать в качестве бэкенда, [откройте публичный доступ](../../storage/operations/buckets/bucket-availability.md) к списку объектов в бакете и к их чтению.
        
      {% endnote %}

      Для бэкенда должен быть указан либо бакет, либо сервис Kubernetes (`service`), но не оба одновременно.
      
      * `name` (`string`, обязательное)
      
        Имя бакета.
        
    * `tls` (`BackendTLS`)
    
      Настройки TLS-соединений между узлами балансировщика и эндпоинтами бэкенда.
    
      Если поле указано, балансировщик устанавливает с бэкендом TLS-соединения и сравнивает полученные сертификаты с сертификатом, указанным в поле `trustedCa`. Если поле не указано, балансировщик устанавливает с бэкендом незащищенные соединения.
        
      * `sni` (`string`)
      
        Доменное имя, указываемое как значение TLS-расширения Server Name Indication (SNI).
      
      * `trustedCa` (`string`)
      
        Содержимое X.509-сертификата, выпущенного центром сертификации, в формате PEM.  

    * `healthChecks` (`[]HealthChecks`)

      Настройки пользовательских [проверок состояния](../concepts/backend-group.md#health-checks) приложений в кластере Managed Service for Kubernetes.

      По умолчанию Ingress-контроллер Application Load Balancer принимает от L7-балансировщика проверочные запросы на TCP-порт `10501` и проверяет работоспособность подов [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на каждом узле кластера. Суть проверки состояния заключается в том, что когда kube-proxy работоспособен, то даже если приложение в конкретном поде не отвечает, Kubernetes перенаправит трафик в другой под с этим приложением или на другой узел.
      
      С помощью параметров `healthChecks` вы можете [настроить собственные проверки состояния](../tutorials/custom-health-checks.md) приложений.

      * `http` (`HttpBackend`)

        Протокол, по которому будет осуществляться проверка — HTTP.

        * `path` (`string`)

          Путь в URI запроса к эндпоинту приложения для проверок состояния, например `/health`.

      * `port` (`int32`)

        Порт на узлах кластера для проверки доступности приложения. Значение совпадает с портом, указанным в ресурсе [Service](service-for-ingress.md) типа `NodePort`, в параметре `spec.ports.nodePort`.

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

      {% note info %}
      
      Настроить проверки состояния приложения также можно с помощью аннотации [ingress.alb.yc.io/health-checks](service-for-ingress.md#annot-health-checks) ресурса [Service](service-for-ingress.md).
      
      {% endnote %}

    * `loadBalancingConfig` (`LoadBalancingConfig`)

      Настройки балансировки.

      * `balancerMode` (`string`)

        Режим распределения трафика между эндпоинтами бэкенда. Возможные значения — `ROUND_ROBIN`, `RANDOM`, `LEAST_REQUEST`, `MAGLEV_HASH`. [Подробнее о каждом режиме](../concepts/backend-group.md#balancing-mode).

      * `panicThreshold` (`int64`)

        Процент работоспособных эндпоинтов. Если он опустится ниже указанного, включится [режим паники](../concepts/backend-group.md#panic-mode).

        Значение по умолчанию — `0`, при котором режим паники не активируется никогда.

      * `localityAwareRouting` (`int64`)

        Процент входящего трафика, который балансировщик передает бэкендам из своей зоны доступности. Остальной трафик поровну делится между другими зонами. [Подробнее о локализации трафика](../concepts/backend-group.md#locality).

        Значение по умолчанию — `0`.