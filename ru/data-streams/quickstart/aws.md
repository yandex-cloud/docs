# Настройка AWS CLI

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого вы будете работать с потоком данных.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `editor`.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статический ключ доступа сервисного аккаунта.

## Установите и настойте AWS CLI

1. Установите [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).
1. Выполните команду:

   ```bash
   aws configure
   ```

1. Последовательно введите:

   * `AWS Access Key ID [None]:` — сохраненный ранее идентификатор ключа сервисного аккаунта.
   * `AWS Secret Access Key [None]:` — сохраненный ранее секретный ключ сервисного аккаунта.
   * `Default region name [None]:` — `ru-central1`.