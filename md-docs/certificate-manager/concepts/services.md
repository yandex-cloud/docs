# Интеграция с сервисами Yandex Cloud


Вы можете использовать сертификаты из Certificate Manager в следующих сервисах Yandex Cloud:
* [Yandex Object Storage](#os).
* [Yandex Application Load Balancer](#alb).
* [Yandex API Gateway](#api-gw).
* [Yandex Cloud CDN](#cdn).
* [Yandex Smart Web Security](#sws).

Также вы можете хранить приватный ключ пользовательского сертификата в виде секрета [Yandex Lockbox](#lockbox) с помощью Terraform.

## Yandex Object Storage {#os}

Если бакет используется для хостинга статического сайта, [используйте сертификат](../../storage/operations/hosting/certificate.md#cert-manager) из Certificate Manager для доступа к сайту по протоколу `HTTPS`. При изменении сертификата в Certificate Manager, он будет автоматически обновлен во всех использующих его бакетах.

{% note warning %}

* Доступ к бакету по `HTTPS` открывается в течение получаса после выбора сертификата.
* Применение изменений сертификата также может занимать до получаса.

{% endnote %}

## Yandex Application Load Balancer {#alb}

[Application Load Balancer](../../application-load-balancer/index.md) может обрабатывать TLS-трафик: устанавливать соединения и терминировать TLS-сессии с помощью сертификатов, добавленных в Certificate Manager. Сертификаты из Certificate Manager можно использовать в обработчиках [L7-балансировщиков](../../application-load-balancer/operations/application-load-balancer-create.md).

## Yandex API Gateway {#api-gw}

Yandex API Gateway позволяет объединить несколько микросервисов в единый продукт. [Микросервисы](https://yandex.cloud/ru/blog/posts/2022/03/microservice-architecture) могут быть запущены в [виртуальных машинах](../../glossary/vm.md), контейнерах или реализованы в виде функций. Вы сможете использовать домен для обращения к [API](../../glossary/rest-api.md).

Для обеспечения TLS-соединения будет использован привязанный к домену сертификат.

## Yandex Cloud CDN {#cdn}

Yandex Cloud CDN позволяет организовать доставку контента до конечных потребителей с помощью сети распространения контента (Content Delivery Network, CDN). 

Для доступа к [CDN-ресурсу](../../cdn/concepts/resource.md) по протоколу HTTPS можно [использовать](../../storage/operations/hosting/certificate.md#cert-manager) сертификат из Certificate Manager.

## Yandex Smart Web Security {#sws}

Yandex Smart Web Security позволяет защитить инфраструктуру от информационных угроз на прикладном уровне L7 модели [OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). Например, [DDoS-атак](../../glossary/ddos.md), ботов, SQL-инъекций.

Для подключения [домена](../../smartwebsecurity/concepts/domain-protect.md#domain) к [прокси-серверу](../../smartwebsecurity/concepts/domain-protect.md#proxy) по протоколу HTTPS можно использовать сертификат из Certificate Manager.

## Yandex Lockbox {#lockbox}

Вы можете хранить приватный ключ пользовательского сертификата Certificate Manager в Yandex Lockbox [с помощью Terraform](../operations/import/cert-create.md#create-lockbox).

## Примеры использования {#examples}

* [Терминирование TLS-соединений](../tutorials/tls-termination/index.md)
* [Организация виртуального хостинга](../tutorials/virtual-hosting.md)
* [Хостинг статического сайта на фреймворке Gatsby в Yandex Object Storage](../tutorials/gatsby-static-website.md)

#### См. также {#see-also}

* [Статический сайт в Object Storage](../../tutorials/web/static/index.md)
* [Yandex API Gateway](../../api-gateway/index.md)