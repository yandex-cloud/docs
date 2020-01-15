# Создание нового облака

[При регистрации](../../../billing/quickstart/index.md#create_billing_account) для вас будет автоматически создано [облако](../../concepts/resources-hierarchy.md#cloud) с именем `cloud`. После того, как вы привязали платежный аккаунт, вы сможете создать дополнительное облако.

Чтобы создать дополнительное облако:

  1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../../../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account) или попросите вашего администратора назначить вам роль `billing.accounts.member` на платежный аккаунт.
  1. Откройте главную страницу [консоли управления]({{ link-console-main }}).
  1. Нажмите значок ![image](../../../_assets/options.svg) напротив своего биллинг-аккаунта.
  1. Выберите **Создать облако**.
  1. Укажите имя облака и нажмите **Создать**. Вы будете перенаправлены на страницу каталога `default` в новом облаке.

{% note info %}

При создании облака вы автоматически получите роль [владельца](../../concepts/resources-hierarchy.md#owner) в этом облаке.

{% endnote %}

#### См. также {#see-also}

* [{#T}](update.md)
* [{#T}](set-access-bindings.md)
* [{#T}](switch-cloud.md)
* [{#T}](../folder/create.md)