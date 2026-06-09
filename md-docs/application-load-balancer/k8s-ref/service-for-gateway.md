# Поля и аннотации ресурса Service для Gateway API

Ресурс `Service` соответствует [сервису {{ k8s }}](../../managed-kubernetes/concepts/index.md#service). Для [Gateway API]({{ gateway-local-link }}/index.md) сервисы представляют собой бэкенды, между которыми распределяется входящий трафик в кластере {{ managed-k8s-name }}. Сервисы, выступающие в роли бэкендов {{ alb-name }}, указываются в ресурсе [HTTPRoute]({{ configuration-local-link }}/http-route.md).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [{{ yandex-cloud }} Gwin]({{ gwin-tip-local-link }}).

{% endnote %}

`Service` — стандартный ресурс {{ k8s }}. Ниже описаны поля и аннотации ресурса, с которыми работают инструменты {{ alb-name }} для {{ managed-k8s-name }}. Полное описание конфигурации ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

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

Не является именем балансировщика в {{ alb-name }}. ||
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

Сервисы {{ k8s }}, используемые в качестве бэкендов (указанные в правилах `Ingress` напрямую или в `HttpBackendGroup`/`GrpcBackendGroup`), должны иметь тип `NodePort`. Подробнее об этом типе см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

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

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.number` (см. [конфигурацию]({{ configuration-local-link }}/ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.number` (см. [конфигурацию]({{ configuration-local-link }}/http-backend-group.md)).
||
|| `name` | `string` | Имя порта внутри сервиса.

Имя используется при указании сервиса в качестве бэкенда:

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.name` (см. [конфигурацию]({{ configuration-local-link }}/ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.name` (см. [конфигурацию]({{ configuration-local-link }}/http-backend-group.md)).
||
|| `protocol` | `TCP` | Сетевой протокол для порта. Только `TCP`. ||
|| `nodePort` | `int32` | Номер порта, открытого на узлах кластера, на которых развернут сервис. Балансировщик отправляет трафик на этот порт, а {{ k8s }} перенаправляет трафик сервису на его порт в параметре `port`.

Соответствует порту бэкенда в [группе бэкендов](../concepts/backend-group.md) {{ alb-name }}.
||
|#