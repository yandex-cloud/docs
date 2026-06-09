# Квоты и лимиты в Yandex Cloud Postbox

В сервисе Yandex Cloud Postbox действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#postbox-quotas}

#|
|| Вид ограничения | Значение ||
|| Максимальное количество получателей, указанных в одном письме
`postbox.recipients_per_email.count` | 50 ||
|| Максимальный размер письма вместе с вложениями 
`postbox.email.size` | 10 МБ ||
|| Максимальное количество адресов 
`postbox.identities.count` | 10 ||
|| Максимальная скорость отправки писем 
`postbox.send.rate` | 1 письмо в секунду ||
|| Максимальное количество писем, которое можно отправить за интервал времени, равный 24 часам 
`postbox.emails_sent.count` | 200 ||
|| Максимальное количество [конфигураций](glossary.md#configuration) 
`postbox.configuration_sets.count` | 5 ||
|#