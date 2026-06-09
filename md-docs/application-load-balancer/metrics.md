# Справочник метрик {{ monitoring-full-name }}

В этом разделе описаны метрики сервиса {{ alb-name }}, поставляемые в [{{ monitoring-name }}](../monitoring/index.md).

Имя метрики пишется в метку `name`.

Все метрики сервиса {{ alb-name }} имеют общую метку `service=application-load-balancer`.

## Метрики HTTP {#http-metrics}

Общие метки для всех метрик HTTP:

| Метка | Значение |
| --- | --- |
| backend | Имя бэкенда |
| backend_group | Имя [группы бэкендов](concepts/backend-group.md) |
| http_router | Имя [HTTP-роутера](concepts/http-router.md) |
| load_balancer | Имя [L7-балансировщика](concepts/application-load-balancer.md) |
| route | Имя [маршрута](concepts/http-router.md#routes) |
| virtual_host | Имя [виртуального хоста](concepts/http-router.md#virtual-host) |
| zone | [Зона доступности](../overview/concepts/geo-scope.md) |

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
| `load_balancer.request_bytes_per_second`<br>`DGAUGE`, байты/с | Суммарный объем запросов к балансировщику в секунду.<br>В комбинации с меткой `zone` будут учитываться только запросы из конкретной зоны доступности. |
| `load_balancer.requests_count_per_second`<br>`DGAUGE`, запросы/с | Количество запросов к балансировщику в секунду.<br>В комбинации с меткой `zone` будут учитываться только запросы из конкретной зоны доступности.<br>Специальная метка `code` — код ответа, например `200` или `grpc:CANCELLED`. |
| `load_balancer.requests_latency_milliseconds`<br>`IGUAGE`, миллисекунды | Гистограмма распределения задержки ответа (времени от получения балансировщиком первого байта запроса до отправки последнего байта ответа), от 50-го до 99-го перцентиля, в миллисекундах.<br>В комбинации с меткой `zone` будут учитываться только ответы в конкретной зоне доступности.<br>Специальная метка `bin` — бакеты гистограммы. |
| `load_balancer.response_bytes_per_second`<br>`DGAUGE`, байты/с  | Суммарный объем ответов балансировщика в секунду.<br>В комбинации с меткой `zone` будут учитываться только ответы в конкретной зоне доступности. |

## Метрики масштабирования {#scaling-metrics}

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
| `load_balancer.scaling.active_connections`<br>`DGAUGE`, штуки | Количество активных соединений. |
| `load_balancer.scaling.bytes_per_second`<br>`DGAUGE`, байты/с | Объем обрабатываемых данных в секунду. |
| `load_balancer.scaling.connections_per_second`<br>`DGAUGE`, соединения/с | Количество соединений в секунду. |
| `load_balancer.scaling.http_received_bytes_per_second`<br>`DGAUGE`, байты/с | Объем получаемых данных в секунду. |
| `load_balancer.scaling.http_transmitted_bytes_per_second`<br>`DGAUGE`, байты/с | Объем передаваемых данных в секунду. |
| `load_balancer.scaling.requests_per_second`<br>`DGAUGE`, запросы/с | Количество запросов в секунду. |

## Метрики {{ sws-name }} {#sws-metrics}

Общие метки для всех метрик {{ sws-name }}:

| Метка | Значение |
| --- | --- |
| **Общие метки** |
| load_balancer | Имя [L7-балансировщика](concepts/application-load-balancer.md) |
| http_router | Имя [HTTP-роутера](concepts/http-router.md) |
| virtual_host | Имя [виртуального хоста](concepts/http-router.md#virtual-host) |
| **Специальные метки** |
| security_profile | Идентификатор [профиля безопасности](../smartwebsecurity/concepts/profiles.md) |
| rule_name | Имя [правила безопасности](../smartwebsecurity/concepts/rules.md) |

| Имя<br>Тип, единицы измерения | Описание |
| --- | --- |
| `load_balancer.smart_web_security.`<br/>`requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду.<br/>Общие метки:<ul><li>`route` — имя [маршрута](concepts/http-router.md#routes).</li><li>`zone` — [зона доступности](../overview/concepts/geo-scope.md).</li><li>`backend` — имя бэкенда.</li><li>`backend_group` — имя [группы бэкендов](concepts/backend-group.md).</li></ul><br/>Специальная метка `antirobot_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`captcha` — запрос направлен в сервис [{{ captcha-full-name }}](../smartcaptcha/index.md) для дополнительной верификации.</li><li>`deny` — запрос заблокирован.</li></ul></li></ul> |
| `load_balancer.smart_web_security.`<br/>`arl_requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду, прошедших через модуль [Advanced Rate Limiter](../smartwebsecurity/concepts/arl.md).<br/>Общая метка `folderId` — идентификатор [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).<br/><br/>Специальные метки:<ul><li>`arl_profile` — идентификатор профиля Advanced Rate Limiter.</li><li>`arl_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`captcha` — запрос направлен в сервис {{ captcha-full-name }} для дополнительной верификации.</li><li>`deny` — запрос заблокирован.</li></ul></li></ul> |

Подробнее о метриках читайте в подразделе [Статистика](concepts/monitoring.md#stats).

#### См. также {#see-also}

[{#T}](operations/application-load-balancer-get-stats.md)