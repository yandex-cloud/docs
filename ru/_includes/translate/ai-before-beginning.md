Для работы с API {{ translate-name }} необходимо отправлять данные для аутентификации в каждом запросе. Способ аутентификации зависит от типа аккаунта, от имени которого вы будете отправлять запросы:

{% list tabs group=authentication %}

- Аккаунт на Яндексе или федеративный аккаунт {#yandex-account}
  
  {% include [user-auth](user-auth.md) %}
  
- Сервисный аккаунт {#service-account}

  1. Выберите один из способов аутентификации:
     * Получите [IAM-токен](../../iam/operations/iam-token/create-for-sa.md). Передавайте IAM-токен в заголовке `Authorization` в формате:
     
        ```yaml
        Authorization: Bearer <IAM-токен>
        ```

     * [Создайте API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key). Передайте API-ключ в заголовке `Authorization` в следующем формате:

        ```yaml
        Authorization: Api-Key <API-ключ>
        ```
  1. [Назначьте сервисному аккаунту роль](../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-translate-user }}` или выше на каталог, в котором он был создан.

      Не указывайте в запросах идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.
  
{% endlist %}

