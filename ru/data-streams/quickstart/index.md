---
title: Подготовка окружения для {{ yds-full-name }}
description: Следуя данной инструкции, вы сможете подготовить окружение для {{ yds-name }}.
---

# Подготовка окружения для {{ yds-name }}

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роль `editor` на ваш каталог.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.
1. Настройте AWS CLI:
    1. Установите [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) и выполните команду:

        ```bash
        aws configure
        ```

    1. Последовательно введите:

        * `AWS Access Key ID [None]:` — [идентификатор ключа](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `AWS Secret Access Key [None]:` — [секретный ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `Default region name [None]:` — регион `{{ region-id }}`.
