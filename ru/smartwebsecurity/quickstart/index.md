# Как начать работать с {{ sws-full-name }}

{{ sws-name }} позволяет защитить вашу инфраструктуру от [DDoS-атак](../../glossary/ddos.md) и ботов на прикладном уровне L7 [модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI).

Работа сервиса состоит в проверке HTTP-запросов к защищаемому ресурсу через [виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) {{ alb-full-name }} на соответствие [правилам](../concepts/rules.md), заданным в [профиле безопасности](../concepts/profiles.md).

{% include [realized-waf-concept](../../_includes/smartwebsecurity/realized-waf-concept.md) %}

{% include [realized-arl-concept](../../_includes/smartwebsecurity/realized-arl-concept.md) %}

В зависимости от результатов проверки запросы направляются к виртуальному хосту, блокируются или отправляются в сервис [{{ captcha-full-name }}](../../smartcaptcha/) для дополнительной верификации.

Чтобы начать работу с сервисом:
* [Создайте профиль безопасности и подключите его к имеющемуся виртуальному хосту L7-балансировщика](../quickstart.md).
* [Создайте профиль WAF и подключите его к имеющемуся профилю безопасности](quickstart-waf.md).
* [Создайте профиль ARL и подключите его к имеющемуся профилю безопасности](quickstart-arl.md).
* [Настройте L7-балансировщик для дополнительной защиты](../concepts/index.md#alb-settings-recommendation)