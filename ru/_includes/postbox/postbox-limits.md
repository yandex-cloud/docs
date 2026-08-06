#### Квоты {#postbox-quotas}

#|
|| Вид ограничения | Значение ||
|| Максимальное количество получателей, указанных в одном письме
`postbox.recipients_per_email.count` | 200 ||
|| Максимальный размер письма вместе с вложениями 
`postbox.email.size` | 10 МБ ||
|| Максимальное количество [адресов](../../postbox/concepts/glossary.md#adress) 
`postbox.identities.count` | 10 ||
|| Максимальная скорость отправки писем 
`postbox.send.rate` | 1 письмо в секунду ||
|| Максимальная частота вызовов метода [SendBulkEmail](../../postbox/operations/send-bulk-email.md) в одном облаке
`postbox.send_bulk.rate` | 1 запрос в секунду ||
|| Максимальное количество писем, которое можно отправить за интервал времени, равный 24 часам 
`postbox.emails_sent.count` | 200 ||
|| Максимальное количество [конфигураций](../../postbox/concepts/glossary.md#configuration) 
`postbox.configuration_sets.count` | 5 ||
|#

#### Лимиты {#postbox-limits}

Для метода [SendBulkEmail](../../postbox/operations/send-bulk-email.md) действуют следующие лимиты:

#|
|| Вид ограничения | Значение ||
|| Максимальное количество элементов `BulkEmailEntries` в одном запросе | 50 ||
|| Максимальное суммарное количество получателей во всех элементах `BulkEmailEntries`^1^ | 500 ||
|| Максимальный суммарный размер темы и тела общего шаблона (`TemplateContent.Subject`, `TemplateContent.Text` и `TemplateContent.Html`) | 1 МБ ||
|| Максимальное количество переменных в общем шаблоне | 50 ||
|#

^1^ При подсчете получателей учитываются адреса из `ToAddresses`, `CcAddresses` и `BccAddresses`.
