### Используется профиль безопасности Yandex Smart Web Security {#use-sws}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.use-sws ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет настройки профиля безопасности Yandex Smart Web Security.

{% endnote %}

[Yandex Smart Web Security](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) — сервис для защиты от DDoS, [web-атак](https://yandex.cloud/ru/docs/glossary/ddos) и ботов на прикладном уровне L7 [сетевой модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). Smart Web Security [подключается](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) к Yandex Application Load Balancer.

Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу на соответствие [правилам](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules), заданным в [профиле безопасности](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/profiles). В зависимости от результатов проверки запросы пропускаются на защищаемый ресурс, блокируются или отправляются в сервис [Yandex SmartCaptcha](https://yandex.cloud/ru/docs/smartcaptcha/) для дополнительной верификации.

{% note warning "**Ручная проверка**" %}

Данное правило проверяет только встроенные средства защиты информации в Yandex Cloud. Если используется наложенное средство защиты, просьба вручную отметить правило выполненным.

{% endnote %}

#### Инструкции и решения по выполнению

* [Создание профиля безопасности и подключение его к виртуальному хосту L7-балансировщика](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart)