# Квоты и лимиты в сервисе {{ billing-name }}

В {{ billing-name }} действуют следующие ограничения:

* [_Квоты_]({{ link-console-quotas }}) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры {{ yandex-cloud }}. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, отправьте [запрос в техническую поддержку]({{ link-console-support }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько. 

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [{{ quota-manager-name }}](../../quota-manager/quickstart.md).

#### Квоты {#billing-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество бюджетов в одном [платежном аккаунте](billing-account.md) 
`billing.budgets.count` | 20 ||
|| Количество облаков, [привязанных к одному платежному аккаунту](../operations/pin-cloud.md) 
`billing.cloudBindings.count`| 5 ||
|| Количество [экземпляров {{ datalens-name }}](../../datalens/concepts/index.md), привязанных к одному платежному аккаунту 
`billing.datalensBindings.count` | 5 ||
|| Количество [сообществ {{ ml-platform-short-name }}](../../datasphere/concepts/community.md), привязанных к одному платежному аккаунту 
`billing.datasphereCommunityBindings.count` | 100 ||
|| Количество [экземпляров {{ speechsense-name }}]({{ link-docs-ai }}speechsense/quickstart), привязанных к одному платежному аккаунту 
`billing.speechsenseSpaceBindings.count` | 100 ||
|| Количество [экземпляров {{ tracker-name }}]({{ link-tracker-cloudless }}), привязанных к одному платежному аккаунту 
`billing.trackerBindings.count` | 5 ||
|| Количество [экземпляров {{ src-full-name }}]({{ link-src-docs }}), привязанных к одному платежному аккаунту
`billing.sourceCraftBindings.count` | 5 ||
|| Количество [экземпляров Яндекс 360](https://360.yandex.ru/business/help/), привязанных к одному платежному аккаунту
`billing.yandex360Bindings.count` | 5 ||
|| Количество экземпляров [Алиса Про](https://yandex.ru/support/yandex-360/business/alice-pro/ru/?utm_source=b2bsupport), привязанных к одному платежному аккаунту
`billing.aliceProBindings.count` | 5 ||
|#

#### Лимиты {#dataproc-limits}

Для уточнения действующих в сервисе лимитов, обратитесь в [техническую поддержку]({{ link-console-support }}).