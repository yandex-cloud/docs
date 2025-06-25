---
title: Что такое TLS? Обзор Transport Layer Security
description: TLS (Transport Layer Security) – это протокол, который поддерживает защищенную передачу данных между клиентом и сервисом. Чтобы надежно защитить взаимодействие с сервисом, используйте протокол TLS версии 1.2 или выше.
keywords:
  - протокол tls
  - tls
  - transport layer security
---

# Протокол TLS



{{ objstorage-name }} поддерживает защищенную передачу данных между клиентом и сервисом по протоколу Transport Layer Security (TLS). Чтобы надежно защитить взаимодействие с сервисом, используйте протокол TLS версии 1.2 или выше.

{% note alert %}

Поддержка протокола TLS версий 1.0 и 1.1 в {{ objstorage-name }} прекращается с 1 июля 2025 года.

{% endnote %}

Рекомендуем обновить протокол TLS в клиентской части программного обеспечения до версии 1.2 или выше.

Чтобы временно продолжить использовать протокол TLS версий 1.0 и 1.1 для взаимодействия с {{ objstorage-name }}, примените следующие решения:
* Для хостинга сайта — [бакет](bucket.md), настроенный как [хостинг статического сайта](hosting.md), в качестве [источника](../../cdn/concepts/origins.md) контента в [{{ cdn-full-name }}](../../cdn/concepts/index.md). Соединение между клиентом и CDN-сервером будет осуществляться по протоколу TLS версий 1.0 и 1.1, а между CDN-сервером и {{ objstorage-name }} — по протоколу TLS версии 1.2 или выше. 

  Пример размещения статического сайта в бакете {{ objstorage-name }} с доступом через {{ cdn-name }} доступен в [практическом руководстве](../tutorials/cdn-hosting.md).
* Для остальных сценариев — ВМ {{ compute-full-name }} с веб-сервером и функцией [L7-балансировки](../../application-load-balancer/concepts/application-load-balancer.md), например [NGINX](https://nginx.org/ru/), в качестве обратного прокси-сервера. Соединение между клиентом и прокси-сервером будет осуществляться про протоколу TLS версий 1.0 или 1.1, а между прокси-сервером и {{ objstorage-name }} по протоколу TLS версии 1.2 или выше.


Большинство Amazon S3-совместимых клиентов к {{ objstorage-name }} не позволяют явно прописать версию TLS, а используют указанную в системе.

Подробнее о настройке клиентов для работы с протоколом TLS версии 1.2 и выше см. в документации:
* [AWS SDK для Java](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/security-java-tls.html)
* [AWS SDK для .NET](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/enforcing-tls.html)
* [AWS SDK для JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/enforcing-tls.html)


## Примеры использования {#examples}

* [{#T}](../tutorials/gatsby-static-website.md)
* [{#T}](../tutorials/cdn-hosting.md)


