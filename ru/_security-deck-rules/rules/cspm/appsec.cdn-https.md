### В Yandex Cloud CDN используется HTTPS и собственный SSL-сертификат {#cdn-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | appsec.cdn-https ||
|#

#### Описание

Сервис [Cloud CDN](https://yandex.cloud/ru/docs/cdn) использует два участка, на которых пользовательский трафик может идти в открытом виде: от клиента до edge-узла CDN и от edge-узла до источника. Если на каком-либо из этих участков используется HTTP, трафик между пользователями и источником (в том числе cookie аутентификации и другие чувствительные данные) можно прочитать или изменить из любой сети по пути.

Шифрование веб-трафика по TLS — отраслевой стандарт: современные браузеры помечают сайты на чистом HTTP как небезопасные и ограничивают на них работу функций вроде аутентификации и геолокации. Для [CDN-ресурса](https://yandex.cloud/ru/docs/cdn/concepts/resource) рекомендуется включать HTTPS на обоих участках — от клиента до edge и от edge до источника — с [TLS-сертификатом](https://yandex.cloud/ru/docs/certificate-manager/concepts/imported-certificate) из [Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager/).

**Риски при невыполнении правила:** Без HTTPS на участках CDN cookie аутентификации, токены сессий и другие чувствительные данные, передаваемые между пользователями и источником, могут быть перехвачены или подменены злоумышленниками с доступом к сети, что открывает возможность для перехвата сессий и кражи данных.

#### Инструкции и решения по выполнению

Настройте HTTPS на CDN-ресурсе:

1. Добавьте TLS-сертификат в [Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager/operations/) — [выпустите через Let's Encrypt](https://yandex.cloud/ru/docs/certificate-manager/operations/managed/cert-create) или [загрузите собственный](https://yandex.cloud/ru/docs/certificate-manager/operations/import/cert-create).
2. [Включите HTTPS на CDN-ресурсе](https://yandex.cloud/ru/docs/cdn/operations/resources/configure-basics) и выберите сертификат.
3. Настройте подключение CDN к источнику по HTTPS и включите перенаправление с HTTP на HTTPS для клиентского трафика.
