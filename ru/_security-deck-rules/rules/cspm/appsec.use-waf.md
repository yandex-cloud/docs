### Используется Web Application Firewall {#use-waf}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.use-waf ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет настройки Web Application Firewall.

{% endnote %}

{% note warning "**Ручная проверка**" %}

Данное правило проверяет только встроенные средства защиты информации в Yandex Cloud. Если используется наложенное средство защиты, просьба вручную отметить правило выполненным.

{% endnote %}

Для снижения рисков, связанных с веб-атаками, рекомендуем использовать [Yandex Smart Web Security Web Application Firewall (WAF)](https://yandex.cloud/ru/docs/glossary/waf). Web Application Firewall анализирует входящие HTTP-запросы к веб-приложению по предварительно настроенным правилам. На основе результатов анализа к HTTP-запросам применяются определенные [действия](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules#rule-action).

Вы можете управлять межсетевым экраном веб-приложений с помощью [профиля WAF](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/waf), который подключается к [профилю безопасности](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/profiles) Smart Web Security в виде отдельного [правила](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules).

#### Инструкции и решения по выполнению

* [Создание профиля WAF и подключение его к профилю безопасности Smart Web Security](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart#waf)