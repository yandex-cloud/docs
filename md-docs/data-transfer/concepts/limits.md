[Документация Yandex Cloud](../../index.md) > [Yandex Data Transfer](../index.md) > [Концепции](index.md) > Квоты и лимиты

# Квоты и лимиты в Data Transfer

В сервисе Yandex Data Transfer действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.


Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).


#### Квоты {#dataproc-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество эндпоинтов 
`datatransfer.total_endpoints.count` | 100 ||
|| Количество трансферов 
`datatransfer.total_transfers.count` | 50 ||
|| Количество запущенных трансферов 
`datatransfer.running_transfers.count` | 10 ||
|#


#### Лимиты {#dataproc-limits}

| Вид ограничения                  | Значение |
|----------------------------------|---------:|
| Количество эндпоинтов            |      400 |
| Количество трансферов            |      200 |
| Количество запущенных трансферов |       50 |