# Поля ресурса TLSRoute


В ресурсе `TLSRoute` определяются правила маршрутизации трафика по бэкендам — сервисам {{ k8s }} (ресурсам [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md)). `TLSRoute` получает входящий трафик от тех ресурсов [Gateway](../../../application-load-balancer/k8s-ref/gateway.md), требованиям которых соответствует.

`TLSRoute` предназначен для разработчиков приложений. Оператор кластера должен использовать `Gateway`.

`TLSRoute` — ресурс {{ k8s }}, определенный [проектом {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/). Ниже описаны поля ресурса, с которыми работает Gateway API {{ alb-name }}. Полное описание конфигурации ресурса см. в [документации {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1alpha2.TLSRoute).

## TLSRoute {#tlsroute}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TLSRoute
metadata: <ObjectMeta>
spec: <TLSRouteSpec>
```

#|
|| **Поле**     | **Значение или тип**   | **Описание**                         ||
|| `apiVersion` | `gateway.networking.k8s.io/v1alpha2` | **Обязательное**.
                                                            Версия API Kubernetes. ||
|| `kind`       | `TLSRoute`              | **Обязательное**.
                                            Тип ресурса.                        ||
|| `metadata`   | `ObjectMeta`            | **Обязательное**.
                                            [Метаданные ресурса](#metadata).    ||
|| `spec`       | `TLSRouteSpec`          | **Обязательное**.
                                            [Спецификация ресурса](#spec).      ||
|#

{% cut "Пример" %}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TLSRoute
metadata:
  name: sample-route
  namespace: route-namespace
spec:
  parentRefs:
  - name: sample-gateway
    sectionName: sample-listener
    namespace: gateway-namespace
  hostnames:
  - "sample.example.com"
  rules:
  - backendRefs:
    - name: sample-service
      port: 80
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
namespace: <string>
```

#|
|| **Поле**     | **Значение или тип** | **Описание** ||
|| `name`       | `string`             | **Обязательное**.
                                         [Имя ресурса](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

Не является именем маршрута в {{ alb-name }}. ||
|| `namespace`  | `string`  | [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс.

Значение по умолчанию — `default`. ||
|#

## TLSRouteSpec {#spec}

```yaml
parentRefs: <[]ParentReference>
hostnames: <[]Hostname>
rules: <[]TLSRouteRule>
```

#|
|| **Поле**     | **Значение или тип**  | **Описание**                         ||
|| `parentRefs` | `[]ParentReference`   | **Обязательное**.
[Список ресурсов Gateway или их обработчиков](#parentrefs), к которым должен быть привязан `TLSRoute`.

Для привязки маршрута он должен удовлетворять правилам, описанным в [конфигурации](../../../application-load-balancer/k8s-ref/gateway.md#spec) `Gateway` (поле `spec.listeners.allowedRoutes`). ||
|| `hostnames`  | `[]Hostname`          | Список доменных имен, соответствующих атрибуту `SNI` сообщения `ClientHello`, которое используется при выполнении TLS handshake.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %} ||
|| `rules` | `[]TLSRouteRule` | **Обязательное**.
[Правила маршрутизации запросов](#rules). ||
|#

### ParentReference {#parentrefs}

```yaml
name: <string>
namespace: <string>
sectionName: <string>
```

#|
|| **Поле**     | **Значение или тип**  | **Описание**                         ||
|| `name` | `string` | **Обязательное**.
Имя ресурса `Gateway`. ||
|| `namespace`       | `string`   | Пространство имен, к которому относится ресурс `Gateway`.

По умолчанию совпадает с пространством имен ресурса `TLSRoute` (поле [metadata.namespace](#metadata)). ||
|| `sectionName` | `string` | Имя обработчика, указанного в ресурсе `Gateway`. ||
|#

### TLSRouteRule {#rules}

```yaml
backendRefs:
  - name: <string>
    namespace: <string>
    port: <int32>
    weight: <int32>
```

#|
|| **Поле**     | **Значение или тип**  | **Описание**                         ||
|| `backendRefs` | `[]BackendRef` | **Обязательное**.
Список сервисов {{ k8s }}, которые выступают в роли бэкендов и обрабатывают запрос.

Все перечисленные в списке сервисы будут помещены в одну [группу бэкендов](../../../application-load-balancer/concepts/backend-group.md). ||
|| `backendRefs.name`   | `string`              | **Обязательное**.
Имя сервиса {{ k8s }}, который выступает в качестве бэкенда.

Ресурс `Service`, на который указывает это поле, должен быть описан по [принятой конфигурации](../../../application-load-balancer/k8s-ref/service-for-gateway.md). ||
|| `backendRefs.namespace` | `string`           | Пространство имен, к которому относится ресурс `Service`.

По умолчанию совпадает с пространством имен ресурса `TLSRoute` (поле [metadata.namespace](#metadata)). ||
|| `backendRefs.port`   | `int32`               | Номер порта сервиса.

Этот номер должен совпадать с одним из номеров портов, указанных в полях [spec.ports.port](../../../application-load-balancer/k8s-ref/service-for-gateway.md#servicespec) ресурса `Service`. ||
|| `backendRefs.weight` | `int32`               | Относительный вес бэкенда. Трафик между бэкендами в группе бэкендов распределяется пропорционально их весам.

Веса должны быть указаны либо у всех бэкендов в группе, либо ни у одного из них. Между бэкендами без указанных весов трафик распределяется, как если бы у них были указаны одинаковые положительные веса.

Если указан неположительный вес, бэкенд не будет получать трафик. ||
|#
