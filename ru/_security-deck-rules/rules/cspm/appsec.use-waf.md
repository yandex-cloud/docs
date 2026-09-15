### Используется Web Application Firewall {#use-waf}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.use-waf ||
|#

#### Описание

**Как работает правило:** проверяются только встроенные средства защиты информации в Yandex Cloud. Если используется наложенное средство защиты, просьба вручную отметить правило выполненным.

Для снижения рисков, связанных с веб-атаками, рекомендуем использовать Yandex Smart Web Security [Web Application Firewall (WAF)](https://yandex.cloud/ru/docs/glossary/waf). Web Application Firewall анализирует входящие HTTP-запросы к веб-приложению по предварительно настроенным правилам. На основе результатов анализа к HTTP-запросам применяются определенные [действия](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules#rule-action).

Вы можете управлять межсетевым экраном веб-приложений с помощью [профиля WAF](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/waf), который подключается к [профилю безопасности](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/profiles) Smart Web Security в виде отдельного [правила](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules).

**Риски при невыполнении правила:** Без WAF веб-приложения уязвимы для атак из списка OWASP Top 10, включая SQL-инъекции, межсайтовый скриптинг (XSS) и удалённое выполнение кода. Эти атаки могут привести к утечке данных, захвату учётных записей и полной компрометации приложения.

#### Инструкции и решения по выполнению

Создайте и подключите профиль WAF к профилю безопасности Smart Web Security. Предварительно рекомендуется настроить и протестировать базовые правила и правила Smart Protection в профиле безопасности.

1. [Создайте](https://yandex.cloud/ru/docs/smartwebsecurity/operations/waf-profile-create) профиль WAF.
2. [Настройте](https://yandex.cloud/ru/docs/smartwebsecurity/operations/configure-set-rules) набор правил WAF.
3. [Добавьте](https://yandex.cloud/ru/docs/smartwebsecurity/operations/exclusion-rule-add) правило-исключение в профиль WAF.
4. [Подключите](https://yandex.cloud/ru/docs/smartwebsecurity/operations/rule-add) профиль WAF к профилю безопасности.
