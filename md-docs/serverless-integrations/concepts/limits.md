[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Integrations](../index.md) > [Концепции](index.md) > Квоты и лимиты

# Квоты и лимиты в Serverless Integrations

{% note warning %}

Сервис Yandex Serverless Integrations прекращает работу 8 октября 2026 года. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса Yandex Serverless Integrations](../sunset.md).

{% endnote %}

В сервисе Serverless Integrations действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

### EventRouter {#eventrouter}

#### Квоты {#er-quotas}

Вид ограничения | Значение
--- | ---
Максимальное количество шин в облаке | 10
Максимальное количество коннекторов во всех шинах в облаке | 20
Максимальное количество правил во всех шинах в облаке | 50

#### Лимиты {#er-limits}

Вид ограничения | Значение
--- | ---
Максимальное количество приемников в правиле | 5
Максимальный размер сообщения, передаваемого в шину | 256 КБ