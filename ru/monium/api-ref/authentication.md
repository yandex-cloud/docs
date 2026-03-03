---
title: Аутентификация в API {{ monitoring-full-name }}
description: 'Для выполнения операций через API {{ monitoring-full-name }} необходимо получить IAM-токен для своего аккаунта. Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API в формате — Authorization: Bearer <IAM-TOKEN>'
---

# Аутентификация в API {{ yandex-cloud }}

Для выполнения операций через [API](../../glossary/rest-api.md) можно использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [API-ключ](../../iam/concepts/authorization/api-key.md). Любой из этих способов аутентификации подходит для работы с [{{ prometheus-name }}](../../monitoring/operations/prometheus/index.md).

## IAM-токен {#iam-token}

{% include [authentication-iam-token](../../_includes/authentication-iam-token.md) %}

## API-ключ {#api-key}

{% include [authentication-api-key](../../_includes/authentication-api-key.md) %}

{% note info %}

Чтобы выполнять операции записи в лог-группу, задайте для API-ключа [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.logging.write`.

{% endnote %}

#### См. также {#see-also}

[{#T}](../../iam/concepts/users/accounts.md)