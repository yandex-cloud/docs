[Документация Yandex Cloud](../../index.md) > [Yandex Resource Manager](../index.md) > Концепции > Квоты и лимиты

# Квоты и лимиты в Resource Manager

В Resource Manager действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#resmgr-quotas}


#|
|| Вид ограничения | Значение ||
|| Максимальное количество облаков в организации 
`resource-manager.clouds.count` | 5 ||
|| Максимальное количество каталогов в облаке 
`resource-manager.folders.count` | 50 ||
|#




#### Лимиты {#resmgr-limits}

Лимиты для сервиса Resource Manager не определены.