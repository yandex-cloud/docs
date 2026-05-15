# Квоты в Cloud Backup

В сервисе Cloud Backup действуют [_квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#backup-quotas}


#|
|| Вид ограничения | Значение ||
|| Количество виртуальных машин, подключенных к Cloud Backup, в одном облаке^1^ 
`backup.vms.count` | 50 ||
|| Количество серверов BareMetal, подключенных к Cloud Backup, в одном облаке^1^ 
`backup.bmservers.count` | 20 ||
|| Суммарный размер резервных копий в одном облаке 
`backup.storage.size` | 10 ТБ ||
|#

^1^ Виртуальная машина или сервер BareMetal считаются подключенными к Cloud Backup, если они привязаны хотя бы к одной [политике резервного копирования](policy.md). При превышении квоты вы не сможете привязывать новые ВМ и серверы BareMetal к политикам резервного копирования.