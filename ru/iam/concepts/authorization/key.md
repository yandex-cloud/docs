---
title: Авторизованные ключи
description: Из статьи вы узнаете, что такое авторизованные ключи, зачем они нужны и какие сервисы поддерживают этот способ аутентификации.
---

# Авторизованные ключи


_Авторизованные ключи_ — это ключи с алгоритмом шифрования RSA-2048 или RSA-4096 с неограниченным сроком жизни. Такие ключи используются при [запросе](../../operations/iam-token/create-for-sa.md#via-cli) на получение [IAM-токена](./iam-token.md) для сервисного аккаунта. При этом использовать авторизованные ключи непосредственно для аутентификации в [API {{ yandex-cloud }}](../../../api-design-guide/index.yaml) нельзя.

В результате [запроса](../../operations/authentication/manage-authorized-keys.md#create-authorized-key) на получение авторизованного ключа вы получите JSON-файл, содержащий открытую и закрытую части ключа. Сохраните этот файл — повторно получить его будет невозможно.

{% note warning %}

Закрытая часть ключа — это секретная информация, позволяющая выполнять операции в {{ yandex-cloud }}. Защитите ее при хранении.

{% endnote %}

Открытую часть ключа можно получить повторно с помощью метода REST API [get](../../api-ref/Key/get.md) для ресурса [Key](../../api-ref/Key/index.md) или вызова gRPC API [KeyService/Get](../../api-ref/grpc/Key/get.md). Закрытая часть авторизованного ключа хранится только на стороне пользователя и повторно запросить ее нельзя. В случае утери закрытой части ключа, создайте новый авторизованный ключ.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

Закрытая часть авторизованного ключа {{ yandex-cloud }} начинается со строки `PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID…` согласно стандарту [RFC 7468](https://datatracker.ietf.org/doc/html/rfc7468#section-2). Данная строка предназначена для облегчения [обнаружения секретов](../../../security/operations/search-secrets.md) в случае их утечки.

#### См. также {#see-also}

* [{#T}](../../operations/authentication/manage-authorized-keys.md#create-authorized-key)
* [{#T}](../../operations/authentication/manage-authorized-keys.md#delete-authorized-key)
* [{#T}](../../../cli/operations/authentication/service-account.md)
* [{#T}](../../operations/iam-token/create-for-sa.md)