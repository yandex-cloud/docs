[Документация Yandex Cloud](../../index.md) > [Yandex Application Load Balancer](../index.md) > Инструменты для Managed Service for Kubernetes > Gateway API > Конфигурация ресурсов > Service для Gateway API

# Поля и аннотации ресурса Service для Gateway API

Ресурс `Service` соответствует [сервису Kubernetes](../../managed-kubernetes/concepts/index.md#service). Для [Gateway API](../tools/k8s-gateway-api/index.md) сервисы представляют собой бэкенды, между которыми распределяется входящий трафик в кластере Managed Service for Kubernetes. Сервисы, выступающие в роли бэкендов Application Load Balancer, указываются в ресурсе [HTTPRoute](http-route.md).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../tools/gwin/index.md).

{% endnote %}

`Service` — стандартный ресурс Kubernetes. Ниже описаны поля и аннотации ресурса, с которыми работают инструменты Application Load Balancer для Managed Service for Kubernetes. Полное описание конфигурации ресурса приведено в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

# Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: <string>
spec: <ServiceSpec>
```

#|
|| **Поле**        | **Значение или тип**   | **Описание**          ||
|| `apiVersion`    | `v1`                   | **Обязательное**.

Версия API Kubernetes. ||
|| `kind`          | `Service`              | Тип ресурса.          ||
|| `metadata`      | `ObjectMeta`           | **Обязательное**.

Метаданные ресурса. ||
|| `metadata.name` | `string`               | **Обязательное**.

[Имя ресурса](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

Не является именем балансировщика в Application Load Balancer. ||
|| `spec`          | `ServiceSpec`          | **Обязательное**.

Спецификация ресурса. ||
|#

{% cut "Пример" %}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: alb-demo-1
spec:
  selector:
    app: alb-demo-1
  type: NodePort
  ports:
    - name: http
      port: 80
      protocol: TCP
      nodePort: 30081
```

{% endcut %}

## ServiceSpec {#servicespec}

# ServiceSpec

```yaml
type: NodePort
ports:
  - <ServicePort>
  -
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `type`   | `NodePort` | **Обязательное**.

Тип сервиса.

{% note warning %}

Сервисы Kubernetes, используемые в качестве бэкендов (указанные в правилах `Ingress` напрямую или в `HttpBackendGroup`/`GrpcBackendGroup`), должны иметь тип `NodePort`. Подробнее об этом типе в [документации Kubernetes](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

{% endnote %} ||
|| `ports`    | `[]ServicePort`      | **Обязательное**.

Список портов, на которых доступен сервис. ||
|#

## ServicePort {#ports}

# ServicePort

```yaml
port: <int32>
name: <string>
protocol: <protocol>
nodePort: <int32>
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `port`    | `int32`      | **Обязательное**.
Номер порта, на котором доступен сервис.

Номер используется при указании сервиса в качестве бэкенда:

* в [Ingress](ingress.md#backend) — в поле `spec.rules.http.paths.backend.service.port.number`;
* в группе бэкендов [HttpBackendGroup](http-backend-group.md) — в поле `spec.backends.service.port.number`.
||
|| `name` | `string` | Имя порта внутри сервиса.

Имя используется при указании сервиса в качестве бэкенда:

* в [Ingress](ingress.md#backend) — в поле `spec.rules.http.paths.backend.service.port.name`;
* в группе бэкендов [HttpBackendGroup](http-backend-group.md) — в поле `spec.backends.service.port.name`.
||
|| `protocol` | `TCP` | Сетевой протокол для порта. Только `TCP`. ||
|| `nodePort` | `int32` | Номер порта, открытого на узлах кластера, на которых развернут сервис. Балансировщик отправляет трафик на этот порт, а Kubernetes перенаправляет трафик сервису на его порт в параметре `port`.

Соответствует порту бэкенда в [группе бэкендов](../concepts/backend-group.md) Application Load Balancer.
||
|#