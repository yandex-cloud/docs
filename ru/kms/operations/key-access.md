# Назначить права доступа на ключ шифрования

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится секрет.
   1. В списке сервисов выберите **{{ kms-name }}**.
   1. Нажмите на имя нужного ключа.
   1. На панели слева выберите раздел ![image](../../_assets/organization/icon-groups.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
   1. В открывшемся окне нажмите ![image](../../_assets/plus-sign.svg) **Выбрать пользователя**.
   1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к секрету.
   1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **Добавить роль** и выберите необходимые [роли](../security/index.md#roles-list).
   1. Нажмите **Сохранить**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}  

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Чтобы назначить роль на ключ:

      * Пользователю:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <идентификатор_ключа> \
            --user-account-id <идентификатор_пользователя> \
            --role <роль>
         ```

         Где:
         * `id` — идентификатор ключа.
         * `user-account-id` — [идентификатор пользователя](../../iam/operations/users/get.md).
         * `role` — назначаемая [роль](../security/index.md#roles-list).

      * [Сервисному аккаунту](../../iam/concepts/users/service-accounts.md):

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <идентификатор_ключа> \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --role <роль>
         ```

         Где:
         * `id` — идентификатор ключа.
         * `service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md).
         * `role` — назначаемая [роль](../security/index.md#roles-list).

{% endlist %}

{% note warning %}

Если вы [назначите](../../iam/operations/roles/grant.md) группе, пользователю или сервисному аккаунту роль на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых находится ключ, все разрешения этой роли будут действовать и для ключа.

Подробнее об этом читайте в разделе [Как устроено управление доступом](../../iam/concepts/access-control/#inheritance).

{% endnote %}
