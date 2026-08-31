[Документация Yandex Cloud](../../index.md) > [Yandex Identity and Access Management](../index.md) > [Концепции](index.md) > Квоты и лимиты

# Квоты и лимиты в Identity and Access Management

В сервисе Yandex Identity and Access Management действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#iam-quotas}

#|
|| Вид ограничения | Значение ||
|| Суммарное количество [привязок](access-control/index.md#access-bindings) прав доступа в облаке^1^
`iam.accessBindings.count` | 1 000 ||
|| Суммарное количество [привязок](access-control/index.md#access-bindings) прав доступа в организации^1^
`iam.accessBindings.count` | 2 000 ||
|| Количество федераций сервисных аккаунтов
`iam.oidcWLIFederations.count` | 50 ||
|| Количество сервисных аккаунтов, привязанных к федерациям
`iam.saFederatedCredentials.count` | 200 ||
|| Количество сервисных аккаунтов в одном облаке
`iam.serviceAccounts.count` | 100 ||
|| Количество API-ключей  в одном облаке
`iam.apiKeys.count` | 1 000 ||
|| Количество авторизованных ключей  в одном облаке
`iam.authorizedKeys.count` | 1 000 ||
|| Количество статических ключей  в одном облаке
`iam.accessKeys.count` | 1 000 ||
|#

^1^ Квота учитывает не только привязки на само облако или организацию, но и все привязки на вложенные в них ресурсы, поэтому квота организации всегда не меньше квоты облака.


#### Лимиты {#iam-limits}

Лимиты для сервиса Identity and Access Management не определены.