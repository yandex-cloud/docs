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
|| Количество [профилей безопасности](profiles.md) в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud)
`smart-web-security.securityProfiles.count` | 5 ||
|| Количество [профилей ARL](arl.md) в облаке
`smart-web-security.advancedRateLimiterProfiles.count` | 5 ||
|| Количество [профилей WAF](waf.md) в облаке
`smart-web-security.wafProfiles.count` | 10 ||
|| Суммарное количество [правил профилей безопасности](rules.md) в облаке
`smart-web-security.securityProfileRules.count` | 250 ||
|| Суммарное количество [правил-исключений WAF](waf.md#exclusion-rules) в облаке
`smart-web-security.wafProfileExclusionRules.count` | 250 ||
|| Суммарное количество [правил в профилях ARL](rules.md#arl-rules) в облаке
`smart-web-security.advancedRateLimiterProfileRules.count` | 250 ||
|| Суммарное количество [условий](conditions.md) для сопоставления IP-адресов в облаке
`smart-web-security.ipMatchers.count` | 2 500 ||
|| Количество списков IP-адресов в облаке
`smart-web-security.ipMatchLists.count` | 20 ||
|| Количество списков ASN в облаке
`smart-web-security.asnMatchLists.count` | 20 ||
|| Количество строковых списков в облаке
`smart-web-security.strMatchLists.count` | 20 ||
|| Количество списков регулярных выражений в облаке
`smart-web-security.regExpMatchLists.count` | 2 ||
|| Количество уникальных списков IP-адресов в одном профиле
`smart-web-security.uniqueIPMatchListsPerProfile.count` | 40 ||
|| Суммарное количество списков IP-адресов в одном профиле (с учетом повторений)
`smart-web-security.ipMatchListsPerProfile.count` | 100 ||
|| Количество уникальных списков ASN в одном профиле
`smart-web-security.uniqueAsnMatchListsPerProfile.count` | 40 ||
|| Суммарное количество списков ASN в одном профиле (с учетом повторений)
`smart-web-security.asnMatchListsPerProfile.count` | 100 ||
|| Количество уникальных строковых списков в одном профиле
`smart-web-security.uniqueStrMatchListsPerProfile.count` | 40 ||
|| Суммарное количество строковых списков в одном профиле (с учетом повторений)
`smart-web-security.strMatchListsPerProfile.count` | 100 ||
|| Количество уникальных списков регулярных выражений в одном профиле
`smart-web-security.uniqueRegExpMatchListsPerProfile.count` | 10 ||
|| Суммарное количество списков регулярных выражений в одном профиле (с учетом повторений)
`smart-web-security.regExpMatchListsPerProfile.count` | 10 ||
|| Количество элементов в списке IP-адресов
`smart-web-security.ipMatchListItems.count` | 10 000 ||
|| Количество элементов в списке ASN
`smart-web-security.asnMatchListItems.count` | 200 ||
|| Количество элементов в строковом списке
`smart-web-security.strMatchListItems.count` | 100 ||
|| Количество элементов в списке регулярных выражений
`smart-web-security.regExpMatchListItems.count` | 10 ||
|| Суммарное количество [прокси-серверов](domain-protect.md#proxy) в облаке 
`smart-web-security.loadBalancers.count` | 1 ||
|| Суммарное количество [доменов](domain-protect.md#domain) в облаке 
`smart-web-security.loadBalancerDomains.count` | 10 ||
|| Суммарное количество [шаблонов ответа](response-templates.md) в облаке
`smart-web-security.customPages.count` | 20 ||
|#

#### Лимиты {#limits}

**Вид ограничения** | **Значение**
----- | -----
Количество условий `HTTP header` в одном правиле | 20
Количество условий `Query Match` в одном правиле | 20
Количество IP-адресов, префиксов или диапазонов адресов в одном условии | 10 000
Количество условий `HTTP method` в одном правиле | 20
Количество условий `Host` в одном правиле | 20
Длина строки регулярного выражения | 255 символов
Количество запросов в секунду (RPS) суммарно на все [виртуальные хосты](../../application-load-balancer/concepts/http-router.md#virtual-host)<br/> балансировщика, подключенные к одному профилю безопасности^1^ | 20 000
Количество доменов для одного прокси-сервера | 20
Количество IP-адресов целевых ресурсов для одного домена | 20
Количество элементов в списке IP-адресов | 100 000
Количество элементов в списке ASN | 2 000
Количество элементов в строковом списке | 2 000
Количество элементов в списке регулярных выражений | 100

^1^ Если вы ожидаете большее количество запросов в секунду, обратитесь к вашему аккаунт-менеджеру Yandex Cloud.