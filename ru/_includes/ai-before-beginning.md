Чтобы воспользоваться примерами в этом разделе:

1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.
1. [Получите идентификатор любого каталога](../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `editor` или выше.
1. [Получите IAM-токен](../iam/operations/iam-token/create.md) для своего аккаунта на Яндексе.

Чтобы выполнять эти операции от имени [сервисного аккаунта](../iam/concepts/users/service-accounts.md):
1. [Назначьте сервисному аккаунту роль](../iam/operations/sa/assign-role-for-sa.md) `editor` или выше на каталог, в котором он был создан.
1. Не указывайте в запросе идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.
1. Выберите способ аутентификации: получите [IAM-токен](../iam/operations/iam-token/create-for-sa.md) или [API-ключ](../iam/operations/api-key/create.md).