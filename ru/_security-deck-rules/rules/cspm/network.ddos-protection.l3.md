### Используется защита от DDoS атак на уровне сети (L3) {#l3}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.ddos-protection.l3 ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет наличие защиты от DDoS атак на уровне сети (L3).

{% endnote %}

{% note warning "**Ручная проверка**" %}

Если используется наложенный сервис защиты от DDoS, просьба вручную отметить контроль выполненным.

{% endnote %}

В Yandex Cloud существует базовая и расширенная защита от DDoS атак, а также защита на прикладном уровне с помощью сервиса Yandex Smart Web Security. Необходимо убедиться, что у вас используется как минимум базовая защита.

[Yandex Smart Web Security](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) — сервис для защиты от [DDoS-атак](https://yandex.cloud/ru/docs/glossary/ddos) и ботов на прикладном уровне L7 сетевой модели [OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). Smart Web Security [подключается](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) к Yandex Application Load Balancer. Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу на соответствие [правилам](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules), заданным в [профиле безопасности](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/profiles). В зависимости от результатов проверки запросы пропускаются на защищаемый ресурс, блокируются или отправляются в сервис [Yandex SmartCaptcha](https://yandex.cloud/ru/docs/smartcaptcha/) для дополнительной верификации.

[Yandex DDoS Protection](https://yandex.cloud/ru/docs/vpc/ddos-protection/) — это компонент сервиса Virtual Private Cloud для защиты облачных ресурсов от DDoS-атак. DDoS Protection предоставляется в партнерстве с Curator. Вы можете включать ее самостоятельно на [внешний IP-адрес](https://yandex.cloud/ru/docs/vpc/concepts/address) через инструменты управления облаком. Работает до L4 уровня модели OSI.

[Расширенная защита](https://yandex.cloud/ru/services/ddos-protection) от DDoS-атак — работает на 3, 4 и 7 уровнях модели OSI. Вы также можете отслеживать показатели нагрузки, параметры атак и подключить Solidwall WAF в личном кабинете Curator. Чтобы включить расширенную защиту, обратитесь к вашему менеджеру или в техническую поддержку.

#### Инструкции и решения по выполнению

* [Все материалы по защите от DDoS в Yandex Cloud](https://yandex.cloud/ru/docs/vpc/ddos-protection/)