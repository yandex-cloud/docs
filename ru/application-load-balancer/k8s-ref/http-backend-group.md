# Поля ресурса HttpBackendGroup

Ресурс `HttpBackendGroup` позволяет объединять бэкенды — сервисы {{ k8s }}, между которыми распределяется трафик, — в группу. По таким ресурсам [Ingress-контроллер {{ alb-name }}](../tools/k8s-ingress-controller/index.md) создает [группы бэкендов](../concepts/backend-group.md).

Указание на `HttpBackendGroup` нужно добавить в [ресурс `Ingress`](ingress.md).

{% include [k8s-ingress-controller-backend-group-features](../../_includes/application-load-balancer/k8s-ingress-controller-backend-group-features.md) %}

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
    - ...
```

* `apiVersion`: `alb.yc.io/v1alpha1`
* `kind`: `HttpBackendGroup`
* `metadata` (`ObjectMeta`, обязательное)
  
  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
  
    Это имя нужно указать в поле `spec.rules.http.paths.backend.resource.name` ресурса `Ingress` (см. [справочник](ingress.md)).

    Не соответствует имени группы бэкендов в {{ alb-name }}.

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

      Указание на [сервис {{ k8s }}](../../managed-kubernetes/concepts/index.md#service), который должен обрабатывать запросы в качестве бэкенда.

      Ресурс `Service`, на который указывает это поле, должен быть описан по [спецификации](service.md).

      Для бэкенда должен быть указан либо сервис, либо бакет {{ objstorage-name }} (`storageBucket`), но не оба одновременно.

      {% include [k8s-ingress-controller-service-backend](../../_includes/application-load-balancer/k8s-ingress-controller-service-backend.md) %}
        
    * `storageBucket` (`StorageBucketBackend`)

      Указание на [бакет {{ objstorage-full-name }}](../../storage/concepts/bucket.md), который должен обрабатывать запросы в качестве бэкенда. Подробнее об использовании бакета как бэкенда см. в разделе [{#T}](../concepts/backend-group.md#types).

      {% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

      Для бэкенда должен быть указан либо бакет, либо сервис {{ k8s }} (`service`), но не оба одновременно.
      
      * `name` (`string`, обязательное)
      
        Имя бакета.
        
    * `tls` (`BackendTLS`)
    
      Настройки TLS-соединений между узлами балансировщика и эндпоинтами бэкенда.
    
      Если поле указано, балансировщик устанавливает с бэкендом TLS-соединения и сравнивает полученные сертификаты с сертификатом, указанным в поле `trustedCa`. Если поле не указано, балансировщик устанавливает с бэкендом незащищенные соединения.
        
      * `sni` (`string`)
      
        Доменное имя, указываемое как значение TLS-расширения Server Name Indication (SNI).
      
      * `trustedCa` (`string`)
      
        Содержимое X.509-сертификата, выпущенного центром сертификации, в формате PEM.  

