[Документация Yandex Cloud](../../index.md) > [Yandex Data Processing](../index.md) > [Концепции](index.md) > Квоты и лимиты

# Квоты и лимиты в Yandex Data Processing

В сервисе Yandex Data Processing действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#dataproc-quotas}

Виртуальные машины, из которых состоят кластеры сервиса Yandex Data Processing, расходуют [квоты](https://console.yandex.cloud/cloud?section=quotas) вашего облака для сервиса Yandex Compute Cloud.

#### Лимиты {#dataproc-limits}

Вид ограничения | Значение
--- | ---
Минимальная конфигурация хоста | b2.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Cascade Lake, 4 ГБ RAM)
Максимальная конфигурация хоста | m4a-c224-m1792 (224 vCPU AMD Zen 4, 1792 ГБ RAM)
Максимальное общее количество подкластеров | 12
Максимальное количество хостов в одном подкластере | 32
Максимальный объем хранилища для одного хоста на сетевых HDD- (`network-hdd`) или SSD-дисках (`network-ssd`) | 4096 ГБ
Максимальный объем хранилища для одного хоста на сетевых нереплицируемых дисках (`network-ssd-nonreplicated`) | 262 074 ГБ