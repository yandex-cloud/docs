---
title: "Настройка прав доступа к симметричному ключу шифрования"
description: "Следуя данной инструкции, вы сможете назначить роли на симметричный ключ шифрования."
---

# Настройка прав доступа к симметричному ключу шифрования

Вы можете предоставить пользователю, сервисному аккаунту или группе пользователей доступ к [симметричному ключу](../concepts/key.md). Для этого назначьте [роли](../../iam/concepts/access-control/roles.md) на ключ. Чтобы выбрать нужные, [узнайте](../security/index.md#roles-list), какие роли действуют в сервисе.

## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

* Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится секрет.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
   1. Нажмите на имя нужного ключа.
   1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ключу.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые роли.
   1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

* CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы назначить роль на симметричный ключ:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc kms symmetric-key add-access-binding --help
      ```

   1. Получите список симметричных ключей вместе с их идентификаторами:

      ```bash
      yc kms symmetric-key list
      ```

   1. Получите [идентификатор пользователя](../../iam/operations/users/get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роль.
   1. С помощью одной из команд ниже назначьте роль:

      * Пользователю:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <идентификатор_ключа> \
            --role <роль> \
            --user-account-id <идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <идентификатор_ключа> \
            --role <роль> \
            --subject federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <идентификатор_ключа> \
            --role <роль> \
            --service-account-id <идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc kms symmetric-key add-access-binding \
            --id <идентификатор_ключа> \
            --role <роль> \
            --subject group:<идентификатор_группы>
         ```

* API {#api}

   Воспользуйтесь методом [updateAccessBindings](../api-ref/SymmetricKey/updateAccessBindings.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/UpdateAccessBindings](../api-ref/grpc/symmetric_key_service.md#UpdateAccessBindings) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

* Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится секрет.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
   1. Нажмите на имя нужного ключа.
   1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ключу.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые роли.
   1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

* CLI {#cli}

   {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы назначить несколько ролей на симметричный ключ шифрования:

   1. Убедитесь, что на симметричный ключ не назначены роли, которые вы не хотите потерять:

      ```bash
      yc kms symmetric-key list-access-bindings \
         --id <идентификатор_ключа>
      ```

   1. Посмотрите описание команды CLI для назначения ролей:

      ```bash
      yc kms symmetric-key set-access-bindings --help
      ```

   1. Получите список симметричных ключей шифрования вместе с их идентификаторами:

      ```bash
      yc kms symmetric-key list
      ```

   1. Получите [идентификатор пользователя](../../iam/operations/users/get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.
   1. С помощью одной из команд ниже назначьте роли:

      * Пользователю с аккаунтом на Яндексе:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <идентификатор_ключа> \
            --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <идентификатор_ключа> \
            --access-binding role=<роль>,subject=federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <идентификатор_ключа> \
            --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc kms symmetric-key set-access-bindings \
            --id <идентификатор_ключа> \
            --access-binding role=<роль>,subject=group:<идентификатор_группы>
         ```

      Для каждой роли передайте отдельный флаг `--access-binding`. Пример:

       ```bash
      yc kms symmetric-key set-access-bindings \
         --id <идентификатор_ключа> \
         --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
         --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
         --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

* API {#api}

   {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

   Воспользуйтесь методом [setAccessBindings](../api-ref/SymmetricKey/setAccessBindings.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/SetAccessBindings](../api-ref/grpc/symmetric_key_service.md#SetAccessBindings). Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

   * Роль в параметре `accessBindings[].roleId`.
   * Идентификатор субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.id`.
   * Тип субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.type`.

{% endlist %}
