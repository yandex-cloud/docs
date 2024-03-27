# Поля и аннотации ресурса Service

Ресурс `Service` определяет [сервис {{ k8s }}](../../../managed-kubernetes/concepts/index.md#service). Для инструментов {{ alb-name }} для {{ managed-k8s-name }} — [Ingress-контроллера](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) и [Gateway API](../../../application-load-balancer/tools/k8s-gateway-api/index.md) — сервисы представляют собой бэкенды, между которыми распределяется входящий трафик.  Сервисы, выступающие в роли бэкендов {{ alb-name }}, могут быть указаны в [ресурсе `Ingress`](../../../application-load-balancer/k8s-ref/ingress.md) напрямую или в составе [групп бэкендов `HttpBackendGroup`](../../../application-load-balancer/k8s-ref/http-backend-group.md). При использовании Gateway API сервисы-бэкенды указываются в [ресурсе `HTTPRoute`](../../../application-load-balancer/k8s-ref/http-route.md).

`Service` — стандартный ресурс {{ k8s }}. В этом справочнике описаны поля и аннотации ресурса, с которыми работают инструменты {{ alb-name }} для {{ managed-k8s-name }}. Полный справочник ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

```yaml
apiVersion: v1
kind: Service
metadata: <ObjectMeta>
spec: <ServiceSpec>
```

#|
|| **Поле**     | **Значение или тип**   | **Описание**                   ||
|| `apiVersion` | `v1` | **Обязательное**
                                           Версия API Kubernetes          ||
|| `kind`       | `Service`              | Тип ресурса                    ||
|| `metadata`   | `ObjectMeta`           | **Обязательное**
                                          [Метаданные ресурса](#metadata) ||
|| `spec`       | `ServiceSpec`          | **Обязательное**
                                          [Спецификация ресурса](#servicespec)   ||
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

```yaml
name: <string>
annotations:
  ingress.alb.yc.io/protocol: <string>
  ingress.alb.yc.io/transport-security: <string>
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

* **ingress.alb.yc.io/protocol** {#annot-protocol}

  Протокол соединений между балансировщиком и бэкендами, описанными в `Ingress`:

  * `http` — HTTP/1.1. Значение по умолчанию.
  * `http2` — HTTP/2.
  * `grpc` — gRPC.

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

  Протокол шифрования соединений между балансировщиком и бэкендами, указанными в `Ingress` напрямую (без `HttpBackendGroup`).

  Допустимое значение: `tls` — TLS без проверки сертификата.

  Если аннотация не указана, балансировщик соединяется с бэкендами без шифрования.

  Для бэкендов, входящих в состав групп, значение аннотации игнорируется. Шифрование соединений балансировщика с бэкендами из групп настраивается с помощью поля `spec.backend.tls` ресурса `HttpBackendGroup` (см. [справочник ресурса](../../../application-load-balancer/k8s-ref/http-backend-group.md)).

## ServiceSpec {#servicespec}

```yaml
type: NodePort
ports:
  - <ServicePort>
  -
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `type`   | `NodePort` | **Обязательное**
Тип сервиса.

{% include [k8s-ingress-controller-nodeport-note](../../application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}
||
|| `ports`    | `[]ServicePort`      | **Обязательное**
[Список портов, на которых доступен сервис](#ports).
||
|#

## ServicePort {#ports}

```yaml
port: <int32>
name: <string>
protocol: <protocol>
nodePort: <int32>
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `port`    | `int32`      | **Обязательное**
Номер порта, на котором доступен сервис.

Номер используется при указании сервиса в качестве бэкенда:

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.number` (см. [справочник](../../../application-load-balancer/k8s-ref/ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.number` (см. [справочник](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `name` | `string` | Имя порта внутри сервиса.

Имя используется при указании сервиса в качестве бэкенда:

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.name` (см. [справочник](../../../application-load-balancer/k8s-ref/ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.name` (см. [справочник](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `protocol` | `TCP` | Сетевой протокол для порта. Только `TCP` ||
|| `nodePort` | `int32` | Номер порта, открытого на узлах кластера, на которых развернут сервис. Балансировщик отправляет трафик на этот порт, а {{ k8s }} перенаправляет трафик сервису на его порт в параметре `port`.

Соответствует порту бэкенда в [группе бэкендов](../../../application-load-balancer/concepts/backend-group.md) {{ alb-name }}.
||
|#