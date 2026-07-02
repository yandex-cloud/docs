[Документация Yandex Cloud](../../../index.md) > [Yandex Certificate Manager](../../index.md) > [Концепции](../index.md) > [Домен](index.md) > Интеграция с сервисами Yandex Cloud

# Интеграция системы управления доменами с сервисами Yandex Cloud

Домены находятся на стадии [Preview](../../../overview/concepts/launch-stages.md).


Вы можете использовать подтвержденные домены из Certificate Manager в следующих сервисах Yandex Cloud:
* [Yandex API Gateway](#api-gw).

## Yandex API Gateway {#api-gw}

Если пользователь подтвердил свои права на домен, он может [указать](../../../api-gateway/operations/api-gw-domains.md) его как пользовательский в сервисе Yandex API Gateway.

Yandex API Gateway позволяет объединить несколько микросервисов в единый продукт, сами микросервисы могут быть запущены на [виртуальных машинах](../../../glossary/vm.md), в контейнерах или реализованы в виде функций. Вы сможете использовать домен для обращения к [API](../../../glossary/rest-api.md).

Для обеспечения TLS-соединения будет использован привязанный к домену сертификат.

#### Полезные ссылки {#see-also}

[Yandex API Gateway](../../../api-gateway/index.md)