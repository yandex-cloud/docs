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

* в [Ingress]({{ configuration-local-link }}/ingress.md#backend) — в поле `spec.rules.http.paths.backend.service.port.number`;
* в группе бэкендов [HttpBackendGroup]({{ configuration-local-link }}/http-backend-group.md) — в поле `spec.backends.service.port.number`.
||
|| `name` | `string` | Имя порта внутри сервиса.

Имя используется при указании сервиса в качестве бэкенда:

* в [Ingress]({{ configuration-local-link }}/ingress.md#backend) — в поле `spec.rules.http.paths.backend.service.port.name`;
* в группе бэкендов [HttpBackendGroup]({{ configuration-local-link }}/http-backend-group.md) — в поле `spec.backends.service.port.name`.
||
|| `protocol` | `TCP` | Сетевой протокол для порта. Только `TCP`. ||
|| `nodePort` | `int32` | Номер порта, открытого на узлах кластера, на которых развернут сервис. Балансировщик отправляет трафик на этот порт, а {{ k8s }} перенаправляет трафик сервису на его порт в параметре `port`.

Соответствует порту бэкенда в [группе бэкендов](../../../application-load-balancer/concepts/backend-group.md) {{ alb-name }}.
||
|#
