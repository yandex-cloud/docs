---
title: Интеграция {{ certificate-manager-full-name }} с сервисами {{ yandex-cloud }}
description: Из статьи вы узнаете, в каких сервисах {{ yandex-cloud }} можно использовать сертификаты из {{ certificate-manager-name }}.
---

# Интеграция с сервисами {{ yandex-cloud }}


Вы можете использовать сертификаты из {{ certificate-manager-name }} в следующих сервисах {{ yandex-cloud }}:
* [{{ objstorage-full-name }}](#os).
* [{{ alb-full-name }}](#alb).
* [{{ api-gw-full-name }}](#api-gw).
* [{{ cdn-full-name }}](#cdn).
* [{{ sws-full-name }}](#sws).

Также вы можете хранить приватный ключ пользовательского сертификата в виде секрета [{{ lockbox-full-name }}](#lockbox) с помощью {{ TF }}.

## {{ objstorage-full-name }} {#os}

Если бакет используется для хостинга статического сайта, [используйте сертификат](../../storage/operations/hosting/certificate.md#cert-manager) из {{ certificate-manager-name }} для доступа к сайту по протоколу `HTTPS`. При изменении сертификата в {{ certificate-manager-name }}, он будет автоматически обновлен во всех использующих его бакетах.

{% note warning %}

* Доступ к бакету по `HTTPS` открывается в течение получаса после выбора сертификата.
* Применение изменений сертификата также может занимать до получаса.

{% endnote %}

## {{ alb-full-name }} {#alb}

[{{ alb-name }}](../../application-load-balancer/index.yaml) может обрабатывать TLS-трафик: устанавливать соединения и терминировать TLS-сессии с помощью сертификатов, добавленных в {{ certificate-manager-name }}. Сертификаты из {{ certificate-manager-name }} можно использовать в обработчиках [L7-балансировщиков](../../application-load-balancer/operations/application-load-balancer-create.md).

## {{ api-gw-full-name }} {#api-gw}

{{ api-gw-full-name }} позволяет объединить несколько микросервисов в единый продукт. [Микросервисы](/blog/posts/2022/03/microservice-architecture) могут быть запущены в [виртуальных машинах](../../glossary/vm.md), контейнерах или реализованы в виде функций. Вы сможете использовать домен для обращения к [API](../../glossary/rest-api.md).

Для обеспечения TLS-соединения будет использован привязанный к домену сертификат.

## {{ cdn-full-name }} {#cdn}

{{ cdn-full-name }} позволяет организовать доставку контента до конечных потребителей с помощью сети распространения контента (Content Delivery Network, CDN). 

Для доступа к [CDN-ресурсу](../../cdn/concepts/resource.md) по протоколу HTTPS можно [использовать](../../storage/operations/hosting/certificate.md#cert-manager) сертификат из {{ certificate-manager-name }}.

## {{ sws-full-name }} {#sws}

{{ sws-full-name }} позволяет защитить инфраструктуру от информационных угроз на прикладном уровне L7 модели [OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). Например, [DDoS-атак](../../glossary/ddos.md), ботов, SQL-инъекций.

Для подключения [домена](../../smartwebsecurity/concepts/domain-protect.md#domain) к [прокси-серверу](../../smartwebsecurity/concepts/domain-protect.md#proxy) по протоколу HTTPS можно использовать сертификат из {{ certificate-manager-name }}.

## {{ lockbox-full-name }} {#lockbox}

Вы можете хранить приватный ключ пользовательского сертификата {{ certificate-manager-name }} в {{ lockbox-name }} [с помощью {{ TF }}](../operations/import/cert-create.md#create-lockbox).

## Примеры использования {#examples}

* [{#T}](../tutorials/tls-termination/index.md)
* [{#T}](../tutorials/virtual-hosting.md)
* [{#T}](../tutorials/gatsby-static-website.md)

#### См. также {#see-also}

* [Статический сайт в {{ objstorage-name }}](../../tutorials/web/static/index.md)
* [{{ api-gw-full-name }}](../../api-gateway/)