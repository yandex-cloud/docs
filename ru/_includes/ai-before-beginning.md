Чтобы воспользоваться примерами, установите [cURL](https://curl.haxx.se) и получите данные вашего аккаунта для авторизации:

{% list tabs %}

- Аккаунт пользователя на Яндексе

    1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
  1. [Получите IAM-токен](../iam/operations/iam-token/create.md), необходимый для аутентификации.
  1. [Получите идентификатор любого каталога](../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `ai.vision.user` или выше.

- Сервисный аккаунт

  1. Выберите способ аутентификации:
     * Получите [IAM-токен](../iam/operations/iam-token/create-for-sa.md), используемый в примерах.
     * [Создайте API-ключ](../iam/operations/api-key/create.md). Передайте API-ключ в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Api-Key <API-ключ>
          ```
  1. [Назначьте сервисному аккаунту роль](../iam/operations/sa/assign-role-for-sa.md) `ai.vision.user` или выше на каталог, в котором он был создан.

      Не указывайте в запросах идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.

- Федеративный аккаунт

  1. [Аутентифицируйтесь в CLI от имени федеративного пользователя](../cli/operations/authentication/federated-user.md).
  1. С помощью CLI получите [IAM-токен](../iam/concepts/authorization/iam-token.md), необходимый для аутентификации:

      ```bash
      yc iam create-token
      ```
  1. [Получите идентификатор любого каталога](../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `ai.vision.user` или выше.
  
{% endlist %}

