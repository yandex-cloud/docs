# Интеграция с сервисами {{ yandex-cloud }}


Вы можете использовать сертификаты из {{ certificate-manager-name }} в следующих сервисах {{ yandex-cloud }}:
* [{{ objstorage-full-name }}](#os).
* [{{ alb-full-name }}](#alb).
* [{{ api-gw-full-name }}](#api-gw).



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


#### См. также {#see-also}

* [Статический веб-сайт в {{ objstorage-name }}](../../tutorials/web/static.md)
* [{{ api-gw-full-name }}](../../api-gateway/)