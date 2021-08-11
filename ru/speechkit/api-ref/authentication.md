---
title: "Аутентификация в API Yandex SpeechKit"
description: "Для выполнения операций через API в сервисе для синтеза и распознавания речи – Yandex SpeechKit, необходимо получить IAM-токен для сервисного, федеративного или Яндекс аккаунта."
---
# Аутентификация в API

{% if audience=="external" %}

Для выполнения операций через API необходимо аутентифицироваться со своего аккаунта:

{% list tabs %}

- Аккаунт на Яндексе

   1. [Получите IAM-токен](../../iam/operations/iam-token/create.md).
   2. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

- Сервисный аккаунт

  В этом сервисе есть 2 способа аутентификации с сервисным аккаунтом:

   * С помощью [API-ключей](../../iam/concepts/authorization/api-key).

     {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Получите API-ключ](../../iam/operations/api-key/create.md).
      2. Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте API-ключ в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Api-Key <API-ключ>
          ```
   * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
      2. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

- Федеративный аккаунт

   1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-federation.md).
   2. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

{% endlist %}

{% endif %}
