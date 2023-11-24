---
title: "Назначить права доступа на ключ шифрования"
description: "Следуя данной инструкции, вы сможете назначить права доступа на ключ шифрования."
---

# Назначить права доступа на ключ шифрования

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится секрет.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
   1. Нажмите на имя нужного ключа.
   1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. В открывшемся окне нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
   1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к секрету.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../security/index.md#roles-list).
   1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

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
