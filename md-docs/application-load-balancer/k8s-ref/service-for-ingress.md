# Поля и аннотации ресурса Service для Ingress-контроллера

Ресурс `Service` соответствует [сервису Kubernetes](../../managed-kubernetes/concepts/index.md#service). Для [Ingress-контроллера](../tools/k8s-ingress-controller/index.md) Application Load Balancer сервисы представляют собой бэкенды, между которыми распределяется входящий трафик в кластере Managed Service for Kubernetes. Сервисы, выступающие в роли бэкендов Application Load Balancer, могут быть указаны в ресурсе [Ingress](ingress.md) напрямую или в составе групп бэкендов [HttpBackendGroup](http-backend-group.md).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../tools/gwin/index.md).

{% endnote %}

`Service` — стандартный ресурс Kubernetes. Ниже описаны поля и аннотации ресурса, с которыми работают инструменты Application Load Balancer для Managed Service for Kubernetes. Полное описание конфигурации ресурса см. в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

# Service

```yaml
apiVersion: v1
kind: Service
metadata: <ObjectMeta>
spec: <ServiceSpec>
```

#|
|| **Поле**     | **Значение или тип**   | **Описание**           ||
|| `apiVersion` | `v1` |                   **Обязательное**.

Версия API Kubernetes. ||
|| `kind`       | `Service`              | Тип ресурса.           ||
|| `metadata`   | `ObjectMeta`           | **Обязательное**.

Метаданные ресурса. ||
|| `spec`       | `ServiceSpec`          | **Обязательное**.

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

## ObjectMeta {#metadata}

# ObjectMeta

```yaml
name: <string>
annotations:
  ingress.alb.yc.io/protocol: <string>
  ingress.alb.yc.io/transport-security: <string>
  ingress.alb.yc.io/health-checks: <string>
```

#|
|| **Поле**      | **Значение или тип** | **Описание** ||
|| `name`        | `string`             | **Обязательное**.

[Имя ресурса](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

Не является именем балансировщика в Application Load Balancer. ||
|| `annotations` | `map[string]string`  | **Обязательное**.

Аннотации ресурса. ||
|#

### Аннотации (metadata.annotations) {#annotations}

# Аннотации

Аннотации — это коллекция пар `ключ:значение`, которые используются для присвоения метаданных объекту. Значения аннотаций всегда имеют тип данных `string`. Подробнее об аннотациях см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

В Application Load Balancer аннотации используются в ресурсах `Service` только для настройки Ingress-контроллеров.

Для объекта `ObjectMeta` можно передать следующие аннотации:

* **ingress.alb.yc.io/protocol** {#annot-protocol}

   Протокол соединений между балансировщиком и бэкендами, описанными в `Ingress`:

   * `http` — HTTP/1.1. Значение по умолчанию.
   * `http2` — HTTP/2.
   * `grpc` — gRPC.

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

   Протокол шифрования соединений между балансировщиком и бэкендами, указанными в `Ingress` напрямую (без `HttpBackendGroup`).

   Допустимое значение: `tls` — TLS без проверки сертификата.

   Если аннотация не указана, балансировщик соединяется с бэкендами без шифрования.

   Для бэкендов, входящих в состав групп, значение аннотации игнорируется. Шифрование соединений балансировщика с бэкендами из групп настраивается с помощью поля `spec.backend.tls` ресурса `HttpBackendGroup` (см. [конфигурацию ресурса](http-backend-group.md)).

* **ingress.alb.yc.io/health-checks** {#annot-health-checks}

  Параметры, которые позволяют настроить пользовательские проверки состояния приложений в кластере. Рекомендуется настраивать [проверки состояния](../concepts/backend-group.md#health-checks) для всех бэкендов.

  * `http-path` — путь в URI запроса к эндпоинту приложения для проверок состояния (только для соединений с бэкендами по протоколам `http` и `http2`). Значение по умолчанию — `/healthz`.

  * `grpc-service-name` — имя GRPC-сервиса приложения для проверок состояния (только для соединений с бэкендами по протоколу `grpc`). Если не указано, то выполняется проверка состояния бэкенда в целом.

  * `port` — порт на узлах кластера для проверки доступности приложения. Приложение будет доступно для проверок состояния по адресу `http://<IP-адрес_узла>:<порт>/<путь>`.

  * `healthy-threshold` — количество последовательных успешных проверок, после которых эндпоинт приложения считается работоспособным. Значение по умолчанию — `1`.

  * `unhealthy-threshold` — количество последовательных неуспешных проверок, после которых эндпоинт приложения считается неработоспособным. Значение по умолчанию — `1`.

  * `timeout` — время ожидания ответа в секундах. Возможные значения — от `1s` до `60s`, по умолчанию — `2s`.

  * `interval` — интервал отправки проверочных запросов в секундах. Возможные значения — от `1s` до `60s`, по умолчанию — `5s`. Значение `interval` должно быть больше значения `timeout` минимум на одну секунду.

  Обязательный параметр — `port`. Если не указывать остальные, вместо них будут использоваться значения по умолчанию.

  Параметры перечисляются через запятую. Пример:

     ```
     ...
     annotations:
       ingress.alb.yc.io/health-checks: port=30103,http-path=/health-1,timeout=10s,interval=20s,healthy-threshold=3,unhealthy-threshold=2
     ...
     ```

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

Сервисы Kubernetes, используемые в качестве бэкендов (указанные в правилах `Ingress` напрямую или в `HttpBackendGroup`/`GrpcBackendGroup`), должны иметь тип `NodePort`. Подробнее об этом типе см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

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

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.number` (см. [конфигурацию](ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.number` (см. [конфигурацию](http-backend-group.md)).
||
|| `name` | `string` | Имя порта внутри сервиса.

Имя используется при указании сервиса в качестве бэкенда:

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.name` (см. [конфигурацию](ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.name` (см. [конфигурацию](http-backend-group.md)).
||
|| `protocol` | `TCP` | Сетевой протокол для порта. Только `TCP`. ||
|| `nodePort` | `int32` | Номер порта, открытого на узлах кластера, на которых развернут сервис. Балансировщик отправляет трафик на этот порт, а Kubernetes перенаправляет трафик сервису на его порт в параметре `port`.

Соответствует порту бэкенда в [группе бэкендов](../concepts/backend-group.md) Application Load Balancer.
||
|#