# Поля ресурса Service

Ресурс `Service` определяет [сервис {{ k8s }}](../../managed-kubernetes/concepts/index.md#service). Для [Ingress-контроллера {{ alb-name }}](../tools/k8s-ingress-controller/index.md) сервисы представляют собой бэкенды, между которыми распределяется входящий трафик. Указать на сервис как на бэкенд можно:

* напрямую, в [ресурсе `Ingress`](ingress.md);
* или в составе группы бэкендов, в [ресурсе `HttpBackendGroup`](http-backend-group.md).

`Service` — стандартный ресурс {{ k8s }}. В этом справочнике описаны поля и аннотации ресурса, с которыми работает Ingress-контроллер {{ alb-name }}. Полный справочник ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: <string>
spec:
  type: NodePort
  ports:
    - name: <string>
      port: <int32>
      protocol: TCP
      nodePort: <int32>
    - ...
```

Где:

* `apiVersion`: `v1`
* `kind`: `Service`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.
  
  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

* `spec` (`ServiceSpec`)

  Спецификация ресурса.
  
  * `type`: `NodePort`

    {% include [k8s-ingress-controller-nodeport-note](../../_includes/application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}
  
  * `ports` (`[]ServicePort`)
  
    Список портов, на которых доступен сервис.

    * `port` (`int32`, обязательное)

      Номер порта, на котором доступен сервис.

      Номер можно использовать при указании сервиса в качестве бэкенда:

      * в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.number` (см. [справочник](ingress.md));
      * в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.number` (см. [справочник](http-backend-group.md)).
  
    * `name` (`string`)
    
      Имя порта внутри сервиса.
    
      Имя можно использовать при указании сервиса в качестве бэкенда:
      
      * в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.name` (см. [справочник](ingress.md));
      * в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.name` (см. [справочник](http-backend-group.md)).
    
    * `protocol`: `TCP`
    * `nodePort` (`int32`)
    
      Номер порта, открытого на узлах кластера, на которых развернут сервис. Балансировщик отправляет трафик на этот порт, а {{ k8s }} перенаправляет трафик сервису на его порт `port`.
    
      Соответствует порту бэкенда в [группе бэкендов](../concepts/backend-group.md) {{ alb-name }}.
