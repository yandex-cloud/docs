Все метрики сервиса {{ certificate-manager-name }} имеют общую метку `service=certificate-manager`.

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `certificate.days_until_expiration`<br>`DGAUGE`, дни | Количество дней до истечения срока действия сертификата. Специальная метка `certificate` — идентификатор [сертификата](../../../certificate-manager/concepts/index.md#types). |
| `certificate.is_out_of_order`<br>`DGAUGE`, 0/1 | Доступность сертификата для обеспечения TLS-соединения.</br>Принимает значения:<ul><li>`1`, если сертификат не может быть использован для обеспечения TLS-соединения: находится в состоянии `Invalid`, `Revoked` или срок его действия истек.</li><li>`0` в любых других случаях, в том числе, когда сертификат находится в состоянии `Validating`.</li></ul>Специальная метка `certificate` — идентификатор [сертификата](../../../certificate-manager/concepts/index.md#types). |
| `quota.certificates_count.limit`<br>`DGAUGE`, штуки | Ограничение количества сертификатов на облако. |
| `quota.certificates_count.usage`<br>`DGAUGE`, штуки | Текущее потребление [квоты]({{ link-console-quotas }}) количества сертификатов на облако. |