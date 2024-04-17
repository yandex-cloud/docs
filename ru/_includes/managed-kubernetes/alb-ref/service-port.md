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

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.number` (см. [конфигурацию](../../../application-load-balancer/k8s-ref/ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.number` (см. [конфигурацию](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `name` | `string` | Имя порта внутри сервиса.

Имя используется при указании сервиса в качестве бэкенда:

* в `Ingress` — в поле `spec.rules.http.paths.backend.service.port.name` (см. [конфигурацию](../../../application-load-balancer/k8s-ref/ingress.md#backend));
* в группе бэкендов `HttpBackendGroup` — в поле `spec.backends.service.port.name` (см. [конфигурацию](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `protocol` | `TCP` | Сетевой протокол для порта. Только `TCP`. ||
|| `nodePort` | `int32` | Номер порта, открытого на узлах кластера, на которых развернут сервис. Балансировщик отправляет трафик на этот порт, а {{ k8s }} перенаправляет трафик сервису на его порт в параметре `port`.

Соответствует порту бэкенда в [группе бэкендов](../../../application-load-balancer/concepts/backend-group.md) {{ alb-name }}.
||
|#
