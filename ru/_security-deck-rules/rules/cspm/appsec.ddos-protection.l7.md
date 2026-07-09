### Используется защита от DDoS-атак на уровне приложений (L7) {#l7}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.ddos-protection.l7 ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

При данном контроле автоматически проверяется наличие профилей безопасности Smart Web Security в сервисе ALB.

{% endnote %}

{% note warning "**Ручная проверка**" %}

Если используется наложенный сервис защиты от DDoS-атак, просьба вручную отметить контроль выполненным.

{% endnote %}

В Yandex Cloud существует базовая и расширенная защита от DDoS-атак, а также защита на прикладном уровне с помощью сервиса Yandex Smart Web Security. Необходимо убедиться, что у вас используется как минимум базовая защита.

* [Yandex Smart Web Security](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) — сервис для защиты от [DDoS-атак](https://yandex.cloud/ru/docs/glossary/ddos) и ботов на прикладном уровне L7 [сетевой модели OSI](https://ru.wikipedia.org/wiki/%D0%A1%D0%B5%D1%82%D0%B5%D0%B2%D0%B0%D1%8F_%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D1%8C_OSI). Smart Web Security [подключается](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) к Yandex Application Load Balancer. Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу на соответствие [правилам](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules), заданным в [профиле безопасности](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/profiles). В зависимости от результатов проверки запросы пропускаются на защищаемый ресурс, блокируются или отправляются в сервис [Yandex SmartCaptcha](https://yandex.cloud/ru/docs/smartcaptcha/) для дополнительной верификации. * [Yandex DDoS Protection](https://yandex.cloud/ru/docs/vpc/ddos-protection/) — это компонент сервиса Virtual Private Cloud для защиты облачных ресурсов от DDoS-атак. DDoS Protection предоставляется в партнерстве с Curator. Вы можете включать его самостоятельно на внешний [IP-адрес](https://yandex.cloud/ru/docs/vpc/concepts/address) через инструменты управления облаком. Работает до уровня L4 модели OSI. * [Расширенная](https://yandex.cloud/ru/services/ddos-protection) защита от DDoS-атак — работает на уровнях L3, L4 и L7 модели OSI. Вы также можете отслеживать показатели нагрузки, параметры атак и подключить Solidwall WAF в личном кабинете Curator. Чтобы включить расширенную защиту, обратитесь к вашему менеджеру или в техническую поддержку.

#### Инструкции и решения по выполнению

**Инструкции и решения по выполнению**:

* Как создать [профиль безопасности Smart Web Security](https://yandex.cloud/ru/docs/smartwebsecurity/operations/profile-create) * Вебинар [Защита от DDoS в Yandex Cloud](https://youtu.be/KWGbLQTth5U)
