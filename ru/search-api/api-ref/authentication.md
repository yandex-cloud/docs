---
title: Как аутентифицироваться в API v2 сервиса {{ search-api-full-name }}
description: В данном разделе приведены способы аутентификации в API v2 сервиса {{ search-api-name }}.
---

# Аутентификация в API v2

При работе с [API v2](../concepts/index.md#api-v2) сервиса {{ search-api-name }} данные для аутентификации необходимо отправлять в каждом запросе. Способ аутентификации зависит от типа аккаунта, от имени которого вы будете отправлять запросы:

{% list tabs group=authentication %}

- Аккаунт на Яндексе или федеративный аккаунт {#yandex-account}
  
  1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md), необходимый для аутентификации. Передавайте полученный токен в заголовке `Authorization` каждого запроса в формате:

      ```yaml
      Authorization: Bearer <IAM-токен>
      ```

  1. [Назначьте](../../iam/operations/roles/grant.md#cloud-or-folder) пользователю роль `search-api.webSearch.user` на каталог, который будет использоваться для запросов к {{ search-api-name }}. Идентификатор каталога должен передаваться в теле каждого запроса в поле `folderId` (`folder_id`).
  
- Сервисный аккаунт {#service-account}

  1. Выберите один из способов аутентификации:
     * Получите [IAM-токен](../../iam/operations/iam-token/create-for-sa.md). Передавайте IAM-токен в заголовке `Authorization` в формате:
     
        ```yaml
        Authorization: Bearer <IAM-токен>
        ```

     * [Создайте API-ключ](../../iam/operations/api-key/create.md). Передайте API-ключ в заголовке `Authorization` в следующем формате:

        ```yaml
        Authorization: Api-Key <API-ключ>
        ```
  1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `search-api.webSearch.user` на каталог, в котором он был создан и который будет использоваться для запросов к {{ search-api-name }}. Идентификатор каталога должен передаваться в теле каждого запроса в поле `folderId` (`folder_id`).
  
{% endlist %}

#### См. также {#see-also}

* [{#T}](../operations/web-search.md)
* [{#T}](../security/index.md)