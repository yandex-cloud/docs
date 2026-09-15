### Используется профиль безопасности Yandex Smart Web Security {#use-sws}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.use-sws ||
|#

#### Описание

**Как работает правило:** проверяются только встроенные средства защиты информации в Yandex Cloud. Если используется наложенное средство защиты, просьба вручную отметить правило выполненным.

[Yandex Smart Web Security](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) — сервис для защиты от [DDoS-, веб-атак](https://yandex.cloud/ru/docs/glossary/ddos) и ботов на прикладном уровне L7 [сетевой модели OSI](https://ru.wikipedia.org/wiki/%D0%A1%D0%B5%D1%82%D0%B5%D0%B2%D0%B0%D1%8F_%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D1%8C_OSI). Smart Web Security [подключается](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart) к Yandex Application Load Balancer.

Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу на соответствие [правилам](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/rules), заданным в [профиле безопасности](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/profiles). В зависимости от результатов проверки запросы пропускаются на защищаемый ресурс, блокируются или отправляются в сервис [Yandex SmartCaptcha](https://yandex.cloud/ru/docs/smartcaptcha/) для дополнительной верификации.

**Риски при невыполнении правила:** Без Smart Web Security веб-приложения подвержены DDoS-атакам на уровне L7, бот-трафику и веб-эксплойтам (таким как SQL-инъекции и XSS), которые могут нарушить доступность приложения и целостность данных. Незащищённые эндпоинты являются основной целью для автоматизированных инструментов атак.

#### Инструкции и решения по выполнению

[Создание профиля безопасности и подключение его к виртуальному хосту L7-балансировщика](https://yandex.cloud/ru/docs/smartwebsecurity/quickstart).
