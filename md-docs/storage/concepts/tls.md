# Протокол TLS



Object Storage поддерживает защищенную передачу данных между клиентом и сервисом по протоколу Transport Layer Security (TLS). Чтобы надежно защитить взаимодействие с сервисом, используйте протокол TLS версии 1.2 или выше.

{% note alert %}

Поддержка протокола TLS версий 1.0 и 1.1 в Object Storage прекращена с 1 августа 2025 года.

{% endnote %}

Если вы хотите использовать протокол TLS версий 1.0 и 1.1 для взаимодействия с Object Storage, примените следующие решения:
* Для хостинга сайта — [бакет](bucket.md), настроенный как [хостинг статического сайта](hosting.md), в качестве [источника](../../cdn/concepts/origins.md) контента в [Yandex Cloud CDN](../../cdn/concepts/index.md). Соединение между клиентом и CDN-сервером будет осуществляться по протоколу TLS версий 1.0 и 1.1, а между CDN-сервером и Object Storage — по протоколу TLS версии 1.2 или выше. 

  Пример размещения статического сайта в бакете Object Storage с доступом через Cloud CDN доступен в [практическом руководстве](../tutorials/cdn-hosting/index.md).
* Для остальных сценариев — ВМ Yandex Compute Cloud с веб-сервером и функцией [L7-балансировки](../../application-load-balancer/concepts/application-load-balancer.md), например [NGINX](https://nginx.org/ru/), в качестве обратного прокси-сервера. Соединение между клиентом и прокси-сервером будет осуществляться про протоколу TLS версий 1.0 или 1.1, а между прокси-сервером и Object Storage по протоколу TLS версии 1.2 или выше.


Большинство Amazon S3-совместимых клиентов к Object Storage не позволяют явно прописать версию TLS, а используют указанную в системе.

Подробнее о настройке клиентов для работы с протоколом TLS версии 1.2 и выше см. в документации:
* [AWS SDK для Java](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/security-java-tls.html)
* [AWS SDK для .NET](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/enforcing-tls.html)
* [AWS SDK для JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/enforcing-tls.html)


## Примеры использования {#examples}

* [Хостинг статического сайта на фреймворке Gatsby в Yandex Object Storage](../tutorials/gatsby-static-website.md)
* [Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN](../tutorials/cdn-hosting/index.md)