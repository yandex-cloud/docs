Все метрики сервиса {{ alb-name }} имеют общую метку `service=application-load-balancer`.

### Метрики HTTP {#http-metrics}

Общие метки для всех метрик HTTP:

| Метка | Значение |
| --- | --- |
| backend | Имя бэкенда |
| backend_group | Имя [группы бэкендов](../../../application-load-balancer/concepts/backend-group.md) |
| http-router | Имя [HTTP-роутера](../../../application-load-balancer/concepts/http-router.md) |
| load_balancer | Имя [L7-балансировщика](../../../application-load-balancer/concepts/application-load-balancer.md) |
| route | Имя [маршрута](../../../application-load-balancer/concepts/http-router.md#routes) |
| virtual_host | Имя [виртуального хоста](../../../application-load-balancer/concepts/http-router.md#virtual-host) |
| zone | [Зона доступности](../../../overview/concepts/geo-scope.md) |

Метрики HTTP:

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
| `load_balancer.request_bytes_per_second`<br>`DGAUGE`, байты/с | Суммарный объем запросов к балансировщику в секунду.<br>В комбинации с меткой *zone* будут учитываться только запросы из конкретной зоны доступности. |
| `load_balancer.requests_count_per_second`<br>`DGAUGE`, запросы/с | Количество запросов к балансировщику в секунду.<br>В комбинации с меткой *zone* будут учитываться только запросы из конкретной зоны доступности.<br>Специальная метка *code* — код ответа, например `200` или `grpc:CANCELLED`. |
| `load_balancer.requests_latency_milliseconds`<br>`HIST`, миллисекунды | Гистограмма распределения задержки ответа (времени от получения балансировщиком первого байта запроса до отправки последнего байта ответа), от 50-го до 99-го перцентиля, в миллисекундах.<br>В комбинации с меткой *zone* будут учитываться только ответы в конкретной зоне доступности.<br>Специальная метка *bin* — бакеты гистограммы. |
| `load_balancer.response_bytes_per_second`<br>`DGAUGE`, байты/с  | Суммарный объем ответов балансировщика в секунду.<br>В комбинации с меткой *zone* будут учитываться только ответы в конкретной зоне доступности. |

### Метрики масштабирования {#scaling-metrics}

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
| `load_balancer.scaling.active_connections`<br>`DGAUGE`, штуки | Количество активных соединений. |
| `load_balancer.scaling.bytes_per_second`<br>`DGAUGE`, байты/с | Объем обрабатываемых данных в секунду. |
| `load_balancer.scaling.connections_per_second`<br>`DGAUGE`, соединения/с | Количество соединений в секунду. |
| `load_balancer.scaling.http_received_bytes_per_second`<br>`DGAUGE`, байты/с | Объем получаемых данных в секунду. |
| `load_balancer.scaling.http_transmitted_bytes_per_second`<br>`DGAUGE`, байты/с | Объем передаваемых данных в секунду. |
| `load_balancer.scaling.requests_per_second`<br>`DGAUGE`, запросы/с | Количество запросов в секунду. |
