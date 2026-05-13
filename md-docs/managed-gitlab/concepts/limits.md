# Квоты и лимиты в Managed Service for GitLab

В сервисе Managed Service for GitLab действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#quotas}

#|
|| Вид ограничения | Значение ||
|| Количество инстансов в одном облаке 
`managed-gitlab.instances.count` | 5 ||
|| Размер диска | 500 ГБ ||
|| Количество управляемых раннеров в одном облаке
`managed-gitlab.runners.count` | 5 ||
|| Количество управляемых воркеров в одном облаке
`managed-gitlab.workers.count` | 10 ||
|#


#### Лимиты {#limits}

Вид ограничения | Минимальное значение | Максимальное значение
--- | --- | ---
Класс хоста | s2.micro (2 vCPU, 8 ГБ RAM) | s2.large (16 vCPU, 64 ГБ RAM)
Размер диска | 30 ГБ | 500 ГБ