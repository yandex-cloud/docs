# Квоты и лимиты Smart Web Security

В сервисе Smart Web Security действуют следующие ограничения:

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
|| Максимальное количество [профилей безопасности](profiles.md) в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud)
`smart-web-security.securityProfiles.count` | 5 ||
|| Максимальное количество [профилей ARL](arl.md) в облаке
`smart-web-security.advancedRateLimiterProfiles.count` | 5 ||
|| Максимальное количество [профилей WAF](waf.md) в облаке
`smart-web-security.wafProfiles.count` | 10 ||
|| Максимальное суммарное количество [правил профилей безопасности](rules.md) в облаке
`smart-web-security.securityProfileRules.count` | 250 ||
|| Максимальное суммарное количество [правил-исключений WAF](waf.md#exclusion-rules) в облаке
`smart-web-security.wafProfileExclusionRules.count` | 250 ||
|| Максимальное суммарное количество [правил в профилях ARL](rules.md#arl-rules) в облаке
`smart-web-security.advancedRateLimiterProfileRules.count` | 250 ||
|| Максимальное суммарное количество [условий](conditions.md) для сопоставления IP-адресов в облаке
`smart-web-security.ipMatchers.count` | 2 500 ||
|| Максимальное суммарное количество [списков IP-адресов](lists.md) в Smart Web Security
`smart-web-security.matchLists.count` | 20 ||
|| Максимальное суммарное количество [прокси-серверов](domain-protect.md#proxy) в облаке 
`smart-web-security.loadBalancers.count` | 1 ||
|| Максимальное суммарное количество [доменов](domain-protect.md#domain) в облаке 
`smart-web-security.loadBalancerDomains.count` | 10 ||
|| Максимальное суммарное количество [шаблонов ответа](response-templates.md) в облаке | 20 ||
|#

#### Лимиты {#limits}

**Вид ограничения** | **Значение**
----- | -----
Максимальное количество условий `HTTP header` в одном правиле | 20
Максимальное количество условий `Query Match` в одном правиле | 20
Максимальное количество IP-адресов, префиксов или диапазонов адресов в одном условии | 10 000
Максимальное количество условий `HTTP method` в одном правиле | 20
Максимальное количество условий `Host` в одном правиле | 20
Максимальная длина строки регулярного выражения | 255 символов
Максимальное количество запросов в секунду (RPS) суммарно на все [виртуальные хосты](../../application-load-balancer/concepts/http-router.md#virtual-host)<br/> балансировщика, подключенные к одному профилю безопасности^1^ | 20 000
Максимальное количество доменов для одного прокси-сервера | 20
Максимальное количество IP-адресов целевых ресурсов для одного домена | 20

^1^ Если вы ожидаете большее количество запросов в секунду, обратитесь к вашему аккаунт-менеджеру Yandex Cloud.