[Документация Yandex Cloud](../../index.md) > [Yandex SmartCaptcha](../index.md) > Концепции > Квоты и лимиты

# Квоты и лимиты SmartCaptcha

В сервисе SmartCaptcha действуют следующие ограничения:

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
|| Максимальное количество капч на облако 
`smart-captcha.captchas.count` | 10 ||
|| Максимальное количество [вариантов заданий](captcha-variants.md) на облако | 32 ||
|| Максимальное количество [правил показа](captcha-variants.md#captcha-view-rules) на облако | 250 ||
|#


#### Лимиты {#limits}

Лимиты для сервиса SmartCaptcha не определены.