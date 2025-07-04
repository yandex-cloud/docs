Получите данные вашего аккаунта для аутентификации:

{% list tabs group=authentication %}

- Аккаунт на Яндексе или федеративный аккаунт {#yandex-account}

  1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md).
  1. [Получите идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
  1. При обращении к {{ vision-name }} через API в каждом запросе передавайте полученные параметры:

      * Для Vision API и Classifier API:

          Указывайте IAM-токен в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Bearer <IAM-токен>
          ```

          Идентификатор каталога указывайте в теле запроса в параметре `folderId`.

      * Для [OCR API](../../vision/ocr/api-ref/index.md):

          * в заголовке `Authorization` указывайте IAM-токен;
          * в заголовке `x-folder-id` указывайте идентификатор каталога.

          ```
          Authorization: Bearer <IAM-токен>
          x-folder-id: <идентификатор_каталога>
          ```

- Сервисный аккаунт {#service-account}

  {{ vision-name }} поддерживает два способа аутентификации с сервисным аккаунтом:

  * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
      1. Полученный IAM-токен передавайте в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Bearer <IAM-токен>
          ```

  * С помощью [API-ключей](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../iam/api-keys-disclaimer.md) %}

      1. [Получите API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key).
      1. Полученный API-ключ передавайте в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Api-Key <API-ключ>
          ```

  Не указывайте в запросах идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.

{% endlist %}