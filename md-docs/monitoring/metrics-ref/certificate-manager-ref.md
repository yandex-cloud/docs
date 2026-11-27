[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > [Справочник метрик](index.md) > Certificate Manager

# Метрики Yandex Certificate Manager

В этом разделе описаны метрики сервиса [Certificate Manager](../../certificate-manager/index.md), поставляемые в Monitoring.

Метрики сервиса Certificate Manager автоматически передаются в [Monium](../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находятся сертификаты.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы вводите запрос в Monium в [разделе метрик](../../monium/metrics/metric-explorer.md#add-graph) или при создании алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.

Имя метрики пишется в метку `name`.

Идентификатор сервиса — `certificate-manager`.

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `certificate.days_until_expiration`<br>`DGAUGE`, дни | Количество дней до истечения срока действия сертификата. Специальная метка `certificate` — идентификатор [сертификата](../../certificate-manager/concepts/index.md#types). |
| `certificate.is_out_of_order`<br>`DGAUGE`, 0/1 | Доступность сертификата для обеспечения TLS-соединения.</br>Принимает значения:<ul><li>`1`, если сертификат не может быть использован для обеспечения TLS-соединения: находится в состоянии `Invalid`, `Revoked` или срок его действия истек.</li><li>`0` в любых других случаях, в том числе, когда сертификат находится в состоянии `Validating`.</li></ul>Специальная метка `certificate` — идентификатор [сертификата](../../certificate-manager/concepts/index.md#types). |
| `quota.certificates_count.limit`<br>`DGAUGE`, штуки | Ограничение количества сертификатов на облако. |
| `quota.certificates_count.usage`<br>`DGAUGE`, штуки | Текущее потребление [квоты](https://console.yandex.cloud/cloud?section=quotas) количества сертификатов на облако. |

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.