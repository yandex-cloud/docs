[Документация Yandex Cloud](../index.md) > [Yandex Application Load Balancer](index.md) > Справочник метрик

# Метрики Application Load Balancer

Метрики сервиса Application Load Balancer автоматически передаются в [Monium](../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится балансировщик.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы вводите запрос в Monium в [разделе метрик](../monium/metrics/metric-explorer.md#add-graph) или при создании алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.

Имя метрики пишется в метку `name`.

Значение метки `service` — `application-load-balancer`.

## Метрики HTTP {#http-metrics}

Общие метки для всех метрик HTTP:

| Метка | Значение |
| --- | --- |
| backend | Имя бэкенда |
| backend_group | Имя [группы бэкендов](concepts/backend-group.md) |
| http_router | Имя [HTTP-роутера](concepts/http-router.md) |
| load_balancer | Идентификатор [L7-балансировщика](concepts/application-load-balancer.md) |
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

## Метрики Smart Web Security {#sws-metrics}

Метки для метрик профилей безопасности и ARL:

| Метка | Значение |
| --- | --- |
| **Общие метки** |
| load_balancer | Имя [L7-балансировщика](concepts/application-load-balancer.md) или [прокси-сервера](../smartwebsecurity/concepts/domain-protect.md#proxy) Smart Web Security |
| http_router | Имя [HTTP-роутера](concepts/http-router.md) |
| virtual_host | Имя [виртуального хоста](concepts/http-router.md#virtual-host) |
| **Специальные метки** |
| security_profile | Идентификатор [профиля безопасности](../smartwebsecurity/concepts/profiles.md) |
| rule_name | Имя [правила безопасности](../smartwebsecurity/concepts/rules.md) |

| Имя<br>Тип, единицы измерения | Описание |
| --- | --- |
| `load_balancer.smart_web_security.`<br/>`requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду.<br/>Общие метки:<ul><li>`route` — имя [маршрута](concepts/http-router.md#routes).</li><li>`zone` — [зона доступности](../overview/concepts/geo-scope.md).</li><li>`backend` — имя бэкенда.</li><li>`backend_group` — имя [группы бэкендов](concepts/backend-group.md).</li></ul><br/>Специальная метка `antirobot_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`captcha` — запрос направлен в сервис [Yandex SmartCaptcha](../smartcaptcha/index.md) для дополнительной верификации.</li><li>`js_challenge` — запрос направлен на [проверку JS Challenge](../smartwebsecurity/concepts/rules.md#client-checks).</li><li>`cookie_challenge` — запрос направлен на [проверку Cookie Challenge](../smartwebsecurity/concepts/rules.md#client-checks).</li><li>`deny` — запрос заблокирован.</li></ul> |
| `load_balancer.smart_web_security.`<br/>`arl_requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду, прошедших через модуль [Advanced Rate Limiter](../smartwebsecurity/concepts/arl.md).<br/>Общая метка `folderId` — идентификатор [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).<br/><br/>Специальные метки:<ul><li>`arl_profile` — идентификатор профиля Advanced Rate Limiter.</li><li>`arl_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`captcha` — запрос направлен в сервис Yandex SmartCaptcha для дополнительной верификации.</li><li>`deny` — запрос заблокирован.</li></ul></li></ul> |

[*monium-folder-project]: Для каждого каталога Yandex Cloud автоматически создается проект Monium с идентификатором `folder__<идентификатор_каталога>`. По умолчанию выбран проект текущего каталога. [Идентификатор каталога](../resource-manager/operations/folder/get-id.md) можно скопировать в консоли управления или получить с помощью CLI.

Подробнее о метриках читайте в подразделе [Статистика](concepts/monitoring.md#stats).

#### Полезные ссылки {#see-also}

[Посмотреть статистику L7-балансировщика](operations/application-load-balancer-get-stats.md)