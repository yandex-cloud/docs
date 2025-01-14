---
title: Авторизованные ключи
description: Из статьи вы узнаете, что такое авторизованные ключи, зачем они нужны и какие сервисы поддерживают этот способ аутентификации.
---

# Авторизованные ключи


_Авторизованные ключи_ — это ключи с алгоритмом шифрования RSA-2048 или RSA-4096 с неограниченным сроком жизни. Такие ключи используются при [запросе IAM-токена](../../operations/iam-token/create-for-sa.md#via-cli) для сервисного аккаунта. Также авторизованные ключи применяются для аутентификации в некоторых сервисах {{ yandex-cloud }}, например [{{ ydb-full-name }}](../../../ydb/operations/connection.md#auth).

После [запроса авторизованного ключа](../../operations/authorized-key/create.md) вы получите JSON-файл с открытой и закрытой частью ключа. Сохраните этот файл. Его можно получить только один раз, скачать файл позднее нельзя.

Открытую часть ключа можно запросить с помощью метода REST API [get](../../api-ref/Key/get) для ресурса [Key](../../api-ref/Key/) или вызова gRPC API [KeyService/Get](../../api-ref/grpc/Key/get). Закрытую часть ключа запросить не получится, так как она хранится на стороне пользователя. Если вам нужна закрытая часть ключа и вы не имеете доступа к ранее сохраненному файлу, создайте новый авторизованный ключ.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

{% note warning %}

Закрытая часть ключа — это секретная информация, позволяющая выполнять операции в {{ yandex-cloud }}. Защитите ее при хранении.

{% endnote %}

Закрытая часть авторизованного ключа {{ yandex-cloud }} начинается со строки `PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID…` согласно стандарту [RFC 7468](https://datatracker.ietf.org/doc/html/rfc7468#section-2). Данная строка предназначена для облегчения [обнаружения секретов](../../../security/operations/search-secrets.md) в случае их утечки.

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

Авторизованные ключи в качестве способа аутентификации поддерживают несколько сервисов:



* [{{ kms-full-name }}](../../../kms/tutorials/index.md)
* [{{ maf-full-name }}](../../../managed-airflow/tutorials/data-processing-automation.md)
* [{{ managed-k8s-full-name }}](../../../managed-kubernetes/tutorials/index.md)
* [{{ ydb-full-name }}](../../../ydb/operations/connection.md#auth)
* [{{ monitoring-full-name }}](../../../monitoring/operations/unified-agent/non-yc.md#example)

