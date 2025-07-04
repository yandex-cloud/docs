# Балансировщики нагрузки

Балансировщик нагрузки служит для приема входящего трафика и передачи его на эндпоинты бэкендов. Маршрутизация запросов происходит по настройкам [обработчиков](#listener) балансировщика. Подача трафика на бэкенды настраивается в [группах бэкендов](backend-group.md).

Балансировщик хранит список эндпоинтов, куда должен направляться поступающий трафик и снимает TLS-шифрование перед отправкой трафика на бэкенды. При работе с TLS балансировщик использует современные протоколы (TLSv1.2, TLSv1.3) и шифры. Если балансировщик нагрузки будет обслуживать несколько доменов, можно сконфигурировать разные сертификаты и разные [HTTP-роутеры](http-router.md) для разных доменов, используя механизм TLS SNI.

Для удобства и безопасности можно использовать балансировщик вместе с сервисом {{ certificate-manager-full-name }} для хранения ваших TLS-сертификатов. Также можно задействовать сервисы {{ monitoring-full-name }} для мониторинга обработки запросов.

## Группы безопасности {#security-groups}

При создании балансировщика указываются [группы безопасности](../../vpc/concepts/security-groups.md) — они содержат набор правил, по которым балансировщик получает входящий трафик и отправляет его на виртуальные машины бэкендов. Каждой ВМ также назначены группы безопасности.

Чтобы балансировщик работал корректно:

* Группы безопасности балансировщика должны разрешать:
  * Получение внешнего входящего трафика на портах, указанных в [обработчике](#listener). Например, для HTTP(S)-трафика — TCP-соединения на портах `80` и `443` с любых адресов (CIDR — `0.0.0.0/0`).
  * Получение входящего трафика для проверки состояния узлов балансировщика в разных [зонах доступности](../../overview/concepts/geo-scope.md) — TCP-соединения на порте `30080` с источником `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
  * Отправку трафика на ВМ бэкендов — виртуальные машины, IP-адреса которых включены в [целевые группы](target-group.md). Например, любые исходящие соединения на внутренние адреса ВМ (любой протокол, весь диапазон портов, CIDR — `<внутренний_IP-адрес_ВМ>/32`).

  {% include [security-groups-note](../_includes_service/security-groups-note.md) %}

* Группы безопасности ВМ бэкендов должны разрешать получение входящего трафика от балансировщика на портах, указанных в [группах бэкендов](backend-group.md). Например, любые входящие соединения из подсетей, в которых [расположен балансировщик](#lb-location), или хотя бы из одной из его групп безопасности.

О том, как настроить группы безопасности для Ingress-контроллера и Gateway API, см. в разделе [{#T}](../tools/k8s-ingress-controller/security-groups.md).

## Расположение балансировщика и его внутренние IP-адреса {#lb-location}

При создании балансировщика указываются [сеть](../../vpc/concepts/network.md) и [подсети](../../vpc/concepts/network.md#subnet) в [зонах доступности](../../overview/concepts/geo-scope.md). В этих подсетях будут располагаться узлы балансировщика нагрузки. Трафик на бэкенды приложения будет поступать от узлов балансировщика в этих подсетях.

{% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

О рекомендуемом размере подсетей для балансировщика см. [ниже](#lcu-scaling-subnet-sizes).

Балансировщик можно отключить в выбранных зонах доступности. В этом случае внешний трафик перестанет поступать на узлы балансировщика в этих зонах доступности. При этом узлы балансировщика в других зонах продолжат подавать трафик на бэкенды в зонах, где балансировщик был отключен, если настройки [локализации трафика](backend-group.md#locality) позволяют это.

Также вы можете [разрешить или запретить](../operations/manage-zone/allow-and-deny-shift.md) автоматический перенос трафика из зоны доступности. Такой перенос выполняют технические специалисты {{ yandex-cloud }}, когда одна из зон недоступна. Это позволит вашим сервисам сохранять работоспособность. После восстановления зоны трафик направляется в те зоны, которые настроены для балансировщика.

### Внутренние IP-адреса {#internal-ips}

Балансировщик резервирует внутренние IP-адреса в указанных подсетях и назначает адреса своим узлам. Эти адреса используются для связи между узлами балансировщика и бэкендами. IP-адреса узлов отображаются в списке внутренних адресов.

Чтобы нагрузка корректно распределялась на бэкенды, добавьте разрешение на входящий трафик из подсетей, в которых находятся узлы балансировщика:

1. Определите CIDR для каждой подсети, которую используют узлы балансировщика.
1. Чтобы узлы могли свободно взаимодействовать с бэкендами, добавьте эти CIDR в список разрешенных источников.

> Например, балансировщик использует подсети с CIDR `10.0.1.0/24` и `10.0.2.0/24`, а бэкенды принимают трафик на порт `8080`. Тогда, чтобы разрешить трафик от узлов балансировщика, потребуется два [правила](../../vpc/concepts/security-groups.md#security-groups-rules):
> 
> | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
> | --- | --- | --- | --- | --- |
> | Входящий | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.0.1.0/24` |
> | Входящий | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.0.2.0/24` |

## Автомасштабирование и ресурсные единицы {#lcu-scaling}

В каждой зоне доступности балансировщика создается внутренняя группа виртуальных машин, которые называются _ресурсными единицами_. 

{% include [lcu-thresholds](../../_includes/application-load-balancer/lcu-thresholds.md) %}

{#lcu-scaling-example}
> Например, рассмотрим следующую нагрузку:
>
> {% include [lcu-example](../../_includes/application-load-balancer/lcu-example.md) %}
>
> Эти показатели соответствуют **8 ресурсным единицам**:
>
> {% include [lcu-example-amounts](../../_includes/application-load-balancer/lcu-example-amounts.md) %}

По умолчанию минимальное количество ресурсных единиц в каждой зоне доступности — 2. Его можно увеличить в настройках автомасштабирования. Подробнее см. [ниже](#lcu-scaling-settings).

От количества ресурсных единиц зависит стоимость использования балансировщика. Подробнее см. в разделе [{#T}](../pricing.md).


### Настройки автомасштабирования {#lcu-scaling-settings}

В настройках балансировщика вы можете указать:

Минимальное количество ресурсных единиц в каждой зоне доступности

: Если вы ожидаете повышенную нагрузку на балансировщик, то можете заранее увеличить минимальное количество ресурсных единиц в каждой зоне, чтобы не дожидаться, когда оно увеличится вслед за нагрузкой.

  По умолчанию минимум равен 2. Указать минимальное значение меньше 2 нельзя.

Максимальное суммарное количество ресурсных единиц

: Стоимость использования балансировщика зависит от количества его ресурсных единиц (см. [правила тарификации](../pricing.md)). По умолчанию количество не ограничено. Вы можете установить ограничение, чтобы контролировать расходы.

  Если указанное максимальное количество слишком мало для нагрузки, оказываемой на балансировщик, он может работать некорректно.

  Значение должно быть не меньше, чем количество зон доступности балансировщика, умноженное на минимальное количество ресурсных единиц в каждой зоне.

Настроить автомасштабирование группы ресурсных единиц балансировщика можно при его [создании](../operations/application-load-balancer-create.md) или [изменении](../operations/application-load-balancer-update.md).


### Рекомендуемые размеры подсетей {#lcu-scaling-subnet-sizes}

Чтобы {{ alb-name }} обеспечивал доступность балансировщика, как указано в [документе об уровне обслуживания сервиса](https://yandex.ru/legal/cloud_sla_apploadbalancer/), в подсетях балансировщика должно быть доступно достаточное количество [внутренних IP-адресов](../../vpc/concepts/address.md#internal-addresses). Рекомендуется рассчитывать размер подсетей так, чтобы на каждую [ресурсную единицу](../pricing.md) пикового потребления приходилось минимум по два свободных IP-адреса.

> Например, если балансировщик использует в каждой зоне доступности 8 ресурсных единиц, как в [примере](#lcu-scaling-example), то в каждой подсети рекомендуется иметь хотя бы 8 × 2 = 16 свободных адресов. Для балансировщика желательно указать подсети размером не меньше /27.

## Обработчик {#listener}

Обработчик определяет, на каких портах, адресах и по каким протоколам балансировщик будет принимать трафик.

Некоторые входящие порты, например порт 22, зарезервированы для служебных целей, использовать их нельзя.

Принципы маршрутизации запросов к [группам бэкендов](backend-group.md) зависят от _типа обработчика_:

* **{{ ui-key.yacloud.alb.label_listener-type-http }}**: балансировщик принимает HTTP- или HTTPS-запросы и распределяет их между группами бэкендов по правилам, описанным в [HTTP-роутерах](http-router.md), либо перенаправляет HTTP-запросы на HTTPS. Группы бэкендов, получающие трафик, должны иметь [тип](backend-group.md#group-type) **{{ ui-key.yacloud.alb.label_proto-http }}** или **{{ ui-key.yacloud.alb.label_proto-grpc }}**.
* **{{ ui-key.yacloud.alb.label_listener-type-stream }}**: балансировщик принимает входящий трафик в открытых или зашифрованных TCP-соединениях и транслирует его группам бэкендов типа **{{ ui-key.yacloud.alb.label_proto-stream }}**.

Если обработчик принимает зашифрованный трафик, для него настраиваются _основной обработчик_ и необязательные _обработчики SNI_. В каждом обработчике SNI доменному имени, указанному при установке TLS-соединения как [Server Name Indication](https://{{ lang }}.wikipedia.org/wiki/Server_Name_Indication) (SNI), сопоставляются TLS-сертификат и HTTP-роутер (если тип обработчика — **{{ ui-key.yacloud.alb.label_listener-type-http }}**) либо группа бэкендов (если тип обработчика — **{{ ui-key.yacloud.alb.label_listener-type-stream }}**). Основной обработчик отвечает за TLS-соединения с доменными именами, которым не соответствует ни один обработчик SNI.

{% note tip %}

Некоторые браузеры переиспользуют TLS-соединения с одним IP-адресом, если в сертификате соединения есть нужное доменное имя. При этом обработчик SNI заново не выбирается, и трафик может направляться в неправильный HTTP-роутер. Используйте разные сертификаты в разных обработчиках SNI и в основном обработчике. Для распределения трафика между доменными именами одного сертификата настройте виртуальные хосты HTTP-роутера.

{% endnote %}

Один балансировщик может обслуживать и обычный, и шифрованный трафик на разных портах, а также иметь публичные и внутренние IP-адреса на разных обработчиках.

### Пример {#listener-example}

Обработчик может описывать прием HTTP-трафика на 80-м порту и делать перенаправление на 443 порт и протокол HTTPS. Обработчик получит HTTP-запрос от клиента и вернет ответ с HTTP-кодом 302. Дальнейшие запросы будут поступать уже на порт 443 по протоколу HTTPS.

Если используется HTTPS-обработчик, то необходимо указать [сертификат](../../certificate-manager/concepts/imported-certificate.md) из {{ certificate-manager-name }} который будет использоваться для терминирования TLS.

## Статистика {#stats}

Статистика работы балансировщика автоматически записывается в метрики сервиса [{{ monitoring-full-name }}](../../monitoring/). Доступны следующие дашборды и показатели:

* **HTTP-статистика**:

  * **RPS** — количество запросов к балансировщику в секунду (requests per second).
  * **4XX**, **5XX** — количество ответов балансировщика с HTTP-кодами 4XX и 5XX и [соответствующими им gRPC-кодами](../../api-design-guide/concepts/errors.md#error-list) в секунду.
  * **Request size** — суммарный объем запросов к балансировщику в секунду.
  * **Response size** — суммарный объем ответов балансировщика в секунду.
  * **Latency** — задержка ответа (время от получения балансировщиком первого байта запроса до отправки последнего байта ответа), от 50-го до 99-го перцентиля.

* **Статистика масштабирования**:

  * **Active connections** — количество активных соединений.
  * **Connections per second** — количество соединений в секунду.
  * **Requests per second** — количество запросов в секунду.
  * **Bytes per second** — объем обрабатываемых данных в секунду.

Полный список метрик, передаваемых в {{ monitoring-full-name }}, представлен в [справочнике](../metrics.md).

В {{ alb-name }} доступна обобщенная статистика балансировщика. В {{ monitoring-name }} можно смотреть статистику с разбивкой по ресурсам, привязанным к балансировщику (HTTP-роутерам, виртуальным хостам, маршрутам и т. д.), а также [создавать алерты](../../monitoring/operations/alert/create-alert.md).

Инструкции по просмотру статистики см. в разделе [{#T}](../operations/application-load-balancer-get-stats.md).

## Логирование {#logging}

Вы можете [настроить](../operations/application-load-balancer-manage-logs.md) поставку логов балансировщика в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

Подробности о просмотре логов см. в [{#T}](../operations/application-load-balancer-get-logs.md).

Полный список сохраняемых параметров представлен в [справочнике логов](../logs-ref.md).

Также вы можете [передавать логи балансировщика в БД PostgreSQL](../tutorials/logging.md).

### Правила отбрасывания логов {#discard-logs-rules}

Запись и хранение логов в {{ cloud-logging-name }} тарифицируются согласно [правилам](../../logging/pricing.md#prices) сервиса. Чтобы записывать меньше логов, добавьте правила их отбрасывания.

Доступные правила:

#|
|| **Правило** | **Значение** ||
||**HTTP-коды**
|
* `100` — Continue
* `101` — Switching Protocol
* `102` — Processing
* `200` — OK
* `201` — Created
* `202` — Accepted
* `203` — Non Authoritative Information
* `204` — No Content
* `205` — Reset Content
* `206` — Partial Content
* `207` — Multi-Status
* `300` — Multiple Choices
* `301` — Moved Permanently
* `302` — Found
* `303` — See Other
* `304` — Not Modified
* `305` — Use Proxy
* `307` — Temporary Redirect
* `308` — Permament Redirect
* `400` — Bad Request
* `401` — Unauthorized
* `402` — Payment Required
* `403` — Forbidden
* `404` — Not Found
* `405` — Method Not Allowed
* `406` — Not Acceptable
* `407` — Proxy Authentication Required
* `408` — Request Timeout
* `409` — Conflict
* `410` — Gone
* `411` — Length Required
* `412` — Precondition Failed
* `413` — Request Entity Too Large
* `414` — Request-URI Too Long
* `415` — Unsupported Media Type
* `416` — Requested Range Not Satisfiable
* `417` — Expectation Failed
* `418` — I'm a teapot
* `419` — Insufficient Space on Resource
* `420` — Method Failure
* `422` — Unprocessable Entity
* `423` — Locked
* `424` — Failed Dependency
* `428` — Precondition Required
* `429` — Too Many Requests
* `431` — Request Header Fields Too Large
* `451` — Unavailable For Legal Reasons
* `500` — Internal Server Error
* `501` — Not Implemented
* `502` — Bad Gateway
* `503` — Service Unavailable
* `504` — Gateway Timeout
* `505` — HTTP Version Not Supported
* `507` — Insufficient Storage
* `511` — Network Authentication Required||
||**Классы HTTP-кодов**
|
* `1XX`
* `2XX`
* `3XX`
* `4XX`
* `5XX`
* `ALL`||
||**gRPC-коды**
|
* `GRPC_OK`
* `GRPC_CANCELLED`
* `GRPC_UNKNOWN`
* `GRPC_INVALID_ARGUMENT`
* `GRPC_DEADLINE_EXCEEDED`
* `GRPC_NOT_FOUND`
* `GRPC_ALREADY_EXISTS`
* `GRPC_PERMISSION_DENIED`
* `GRPC_UNAUTHENTICATED`
* `GRPC_RESOURCE_EXHAUSTED`
* `GRPC_FAILED_PRECONDITION`
* `GRPC_ABORTED`
* `GRPC_OUT_OF_RANGE`
* `GRPC_UNIMPLEMENTED`
* `GRPC_INTERNAL`
* `GRPC_UNAVAILABLE`||
|#

## Примеры использования {#examples}

* [{#T}](../tutorials/virtual-hosting.md)
* [{#T}](../tutorials/alb-with-ddos-protection/index.md)
* [{#T}](../tutorials/balancer-with-sws-profile.md)
* [{#T}](../tutorials/migration-from-nlb-to-alb/index.md)
* [{#T}](../tutorials/alb-ingress-controller.md)
* [{#T}](../tutorials/application-load-balancer-website/console.md)
* [{#T}](../tutorials/custom-health-checks.md)
* [{#T}](../tutorials/logging.md)
* [{#T}](../tutorials/alb-ingress-controller-log-options.md)