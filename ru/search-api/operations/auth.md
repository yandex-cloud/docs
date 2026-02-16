---
title: Как аутентифицироваться в API v1 сервиса {{ search-api-full-name }}
description: В данном разделе приведены способы аутентификации в API v1 сервиса {{ search-api-name }}.
---

# Аутентификация в API v1

Для работы с {{ search-api-name }} при помощи API v1 необходимо отправлять запросы к API от имени сервисного аккаунта. API v1 поддерживает только аутентификацию с помощью [API-ключей](../../iam/concepts/authorization/api-key.md).

{% note warning %}

Если ваш API-ключ мог быть скомпрометирован, отзовите его и выпустите новый. 

{% endnote %}

1. [Получите идентификатор каталога](../../resource-manager/operations/folder/get-id.md) сервисного аккаунта.
1. [Получите API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key).
1. Полученные значения передавайте в каждом запросе:

    {% list tabs %}

    - GET-запросы

      В [GET-запросах](../concepts/get-request.md) передавайте значения идентификатора каталога и API-ключа в [URL запроса](../concepts/get-request.md#get-request-format) в полях `folderid` и `apikey`:
   
      ```text
      curl 'https://yandex.<домен>/search/xml?folderid=<идентификатор_каталога>&apikey=<значение_API-ключа>&query=<текст_поискового_запроса>'
      ```

    - POST-запросы

      В [POST-запросах](../concepts/post-request.md) передавайте значение API-ключа в заголовке запроса `Authorization` в следующем формате:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Api-Key <API-ключ>" \
        ...
      ```

      Идентификатор каталога передавайте в [URL запроса](../concepts/post-request.md#post-request-format) в поле `folderid`:

      ```text
      https://yandex.<домен>/search/xml?folderid=<идентификатор_каталога>
      ```

    {% endlist %}