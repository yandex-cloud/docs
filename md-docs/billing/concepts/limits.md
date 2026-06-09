# Квоты и лимиты в сервисе Yandex Cloud Billing

В Yandex Cloud Billing действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, отправьте [запрос в техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько. 

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#billing-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество бюджетов в одном [платежном аккаунте](billing-account.md) 
`billing.budgets.count` | 20 ||
|| Количество облаков, [привязанных к одному платежному аккаунту](../operations/pin-cloud.md) 
`billing.cloudBindings.count`| 5 ||
|| Количество [экземпляров DataLens](../../datalens/concepts/index.md), привязанных к одному платежному аккаунту 
`billing.datalensBindings.count` | 5 ||
|| Количество [сообществ DataSphere](../../datasphere/concepts/community.md), привязанных к одному платежному аккаунту 
`billing.datasphereCommunityBindings.count` | 100 ||
|| Количество [экземпляров SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/quickstart), привязанных к одному платежному аккаунту 
`billing.speechsenseSpaceBindings.count` | 100 ||
|| Количество [экземпляров Трекер](https://yandex.ru/support/tracker/ru/), привязанных к одному платежному аккаунту 
`billing.trackerBindings.count` | 5 ||
|| Количество [экземпляров SourceCraft](https://sourcecraft.dev/portal/docs/ru), привязанных к одному платежному аккаунту
`billing.sourceCraftBindings.count` | 5 ||
|| Количество [экземпляров Яндекс 360](https://360.yandex.ru/business/help/), привязанных к одному платежному аккаунту
`billing.yandex360Bindings.count` | 5 ||
|| Количество экземпляров [Алиса Про](https://yandex.ru/support/yandex-360/business/alice-pro/ru/?utm_source=b2bsupport), привязанных к одному платежному аккаунту
`billing.aliceProBindings.count` | 5 ||
|#

#### Лимиты {#dataproc-limits}

Для уточнения действующих в сервисе лимитов, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).