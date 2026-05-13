# Справочник метрик Yandex Monitoring

В этом разделе описаны метрики сервиса Certificate Manager, поставляемые в [Monitoring](../monitoring/index.md).

Имя метрики пишется в метку `name`.

Все метрики сервиса Certificate Manager имеют общую метку `service=certificate-manager`.

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `certificate.days_until_expiration`<br>`DGAUGE`, дни | Количество дней до истечения срока действия сертификата. Специальная метка `certificate` — идентификатор [сертификата](concepts/index.md#types). |
| `certificate.is_out_of_order`<br>`DGAUGE`, 0/1 | Доступность сертификата для обеспечения TLS-соединения.</br>Принимает значения:<ul><li>`1`, если сертификат не может быть использован для обеспечения TLS-соединения: находится в состоянии `Invalid`, `Revoked` или срок его действия истек.</li><li>`0` в любых других случаях, в том числе, когда сертификат находится в состоянии `Validating`.</li></ul>Специальная метка `certificate` — идентификатор [сертификата](concepts/index.md#types). |
| `quota.certificates_count.limit`<br>`DGAUGE`, штуки | Ограничение количества сертификатов на облако. |
| `quota.certificates_count.usage`<br>`DGAUGE`, штуки | Текущее потребление [квоты](https://console.yandex.cloud/cloud?section=quotas) количества сертификатов на облако. |

#### См. также {#see-also}

[Добавить алерт для сертификата](operations/alert.md)