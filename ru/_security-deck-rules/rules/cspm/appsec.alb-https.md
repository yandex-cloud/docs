### В Yandex Application Load Balancer используется HTTPS {#alb-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.alb-https ||
|#

#### Описание

**Риски при невыполнении правила**: без HTTPS весь трафик между пользователями и балансировщиком передаётся в открытом виде, что позволяет перехватить или подменить учётные данные, токены сессий и персональные данные любому, у кого есть доступ к сети (атаки MITM).

Сервис [Application Load Balancer](https://yandex.cloud/ru/docs/application-load-balancer) поддерживает как HTTP-, так и HTTPS-обработчики. При использовании HTTP-обработчика трафик между клиентами и балансировщиком передаётся в открытом виде — любой, у кого есть доступ к сети по пути, может прочитать или изменить запросы и ответы, в том числе учётные данные, cookie сессии и персональные данные.

Шифрование веб-трафика по TLS — отраслевой стандарт: современные браузеры помечают сайты на чистом HTTP как небезопасные, ограничивают на них работу функций вроде аутентификации и геолокации и постепенно отказываются от поддержки HTTP для новых API.

Для любого сервиса, который работает с пользовательскими данными или аутентификацией, используйте HTTPS-обработчик с [TLS-сертификатом](https://yandex.cloud/ru/docs/certificate-manager/concepts/imported-certificate) из [Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager/).

#### Инструкции и решения по выполнению

Настройте HTTPS-обработчик на балансировщике:

1. Добавьте TLS-сертификат в [Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager/operations/) — [выпустите через Let's Encrypt](https://yandex.cloud/ru/docs/certificate-manager/operations/managed/cert-create) или [загрузите собственный](https://yandex.cloud/ru/docs/certificate-manager/operations/import/cert-create).
2. Добавьте HTTPS-обработчик на балансировщик по [инструкции по терминации TLS](https://yandex.cloud/ru/docs/application-load-balancer/tutorials/tls-termination/).
3. Если HTTP-обработчик нужен только для перенаправления на HTTPS, настройте [перенаправление с HTTP на HTTPS](https://yandex.cloud/ru/docs/application-load-balancer/concepts/http-router#route-types). В противном случае удалите его.
