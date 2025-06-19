---
title: Назначение роли
description: Следуя данной инструкции, вы сможете назначить роль на ресурс.
---

# Назначение роли

Чтобы предоставить доступ к ресурсу, назначьте на него [роль](../../concepts/access-control/roles.md). Ее могут получить:

* [пользователи с аккаунтом на Яндексе](../../concepts/users/accounts.md#passport);
* [локальные пользователи](../../concepts/users/accounts.md#local);
* [федеративные пользователи](../../concepts/users/accounts.md#saml-federation);
* [сервисные аккаунты](../../concepts/users/service-accounts.md);
* [группы пользователей](../../../organization/concepts/groups.md).

Роль можно назначить не только на сам ресурс, но и на его родительский ресурс, так как от него наследуются права доступа. Например, если сервисному аккаунту назначить роль на облако, этот сервисный аккаунт получит разрешения на все ресурсы во всех каталогах этого облака. Подробнее см. в разделе [{#T}](../../concepts/access-control/index.md).

[Узнайте](../../concepts/access-control/resources-with-access-control.md), на какие ресурсы можно назначать роли.

Чтобы выбрать роли, обратитесь к [их справочнику](../../roles-reference.md).

## Назначить роль на каталог или облако {#cloud-or-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите нужное облако или каталог.
   1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к облаку или каталогу.
   1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые роли.
   1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Чтобы назначить роль на облако или каталог:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc resource-manager <cloud_или_folder> add-access-binding --help
      ```

      Укажите `cloud` для облака и `folder` для каталога.

   1. Получите список доступных облаков или каталогов вместе с их идентификаторами:

      ```bash
      yc resource-manager <cloud_или_folder> list
      ```

   1. Получите [идентификатор пользователя](../users/get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.
   1. С помощью одной из команд ниже назначьте роль:

      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc resource-manager <cloud_или_folder> add-access-binding \
            --id <идентификатор_облака_или_каталога> \
            --role <роль> \
            --user-account-id <идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc resource-manager <cloud_или_folder> add-access-binding \
            --id <идентификатор_облака_или_каталога> \
            --role <роль> \
            --subject federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc resource-manager <cloud_или_folder> add-access-binding \
            --id <идентификатор_облака_или_каталога> \
            --role <роль> \
            --service-account-id <идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc resource-manager <cloud_или_folder> add-access-binding \
            --id <идентификатор_облака_или_каталога> \
            --role <роль> \
            --subject group:<идентификатор_группы>
         ```

      * Всем пользователям организации:

         ```bash
         yc resource-manager <cloud_или_folder> add-access-binding \
            --id <идентификатор_облака_или_каталога> \
            --role <роль> \
            --organization-users <идентификатор_организации>
         ```

      * Всем пользователям федерации удостоверений:

         ```bash
         yc resource-manager <cloud_или_folder> add-access-binding \
            --id <идентификатор_облака_или_каталога> \
            --role <роль> \
            --federation-users <идентификатор_федерации>
         ```

- API {#api}

   Чтобы назначить роль на облако, воспользуйтесь методом REST API [updateAccessBindings](../../../resource-manager/api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Cloud/updateAccessBindings.md).

   Чтобы назначить роль на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

   Передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}

## Назначить роль на организацию {#organization}

Чтобы выдать права доступа на организацию, вам нужна роль не ниже `{{ roles-organization-admin }}`. Подробнее о последовательности ролей см. в [документе {{ org-full-name }}](../../../organization/security/index.md#roles-list).

Чтобы назначить роль на организацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. Если у нужного пользователя, сервисного аккаунта или группы пользователей уже есть хотя бы одна роль, в строке с этим пользователем, сервисным аккаунтом или группой нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

      Если нужного нужного пользователя, сервисного аккаунта или группы пользователей нет в списке, в правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**. В открывшемся окне выберите нужного пользователя, сервисный аккаунт или группу из списка. При необходимости воспользуйтесь строкой поиска.

  1. Нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите [роль](../../../iam/concepts/access-control/roles.md), которую хотите назначить. Вы можете назначить несколько ролей.

      Описание доступных ролей можно найти в [справочнике ролей {{ yandex-cloud }}](../../../iam/roles-reference.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Чтобы назначить роль на организацию:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc organization-manager organization add-access-binding --help
      ```

   1. Получите список доступных организаций вместе с их идентификаторами:

      ```bash
      yc organization-manager organization list
      ```

   1. Получите [идентификатор пользователя](../users/get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.
   1. С помощью одной из команд ниже назначьте роль:

      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <идентификатор_организации> \
            --role <роль> \
            --user-account-id <идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <идентификатор_организации> \
            --role <роль> \
            --subject federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <идентификатор_организации> \
            --role <роль> \
            --service-account-id <идентификатор_сервисного_аккаунта>
         ```

      * Всем пользователям организации:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <идентификатор_организации> \
            --role <роль> \
            --organization-users <идентификатор_организации>
         ```

      * Всем пользователям федерации удостоверений:

         ```bash
         yc organization-manager organization add-access-binding \
            --id <идентификатор_организации> \
            --role <роль> \
            --federation-users <идентификатор_федерации>
         ```


- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Чтобы назначить роль на организацию:

   1. Получите [идентификатор пользователя](../users/get.md), [сервисного аккаунта](../sa/get-id.md) или группы пользователей, которым назначаете роль.
   1. Опишите в конфигурационном файле ресурс с ролью на организацию.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "<название_ресурса>" {
        organization_id = "<идентификатор_организации>"
        role            = "<роль>"
        members         = [<пользователи>]
      }
      ```

      Где:

      * `organization_id` — [идентификатор](../../../organization/operations/organization-get-id.md) организации. Обязательный параметр.
      * `role` — назначаемая роль. Для каждой роли можно использовать только один ресурс `yandex_organizationmanager_organization_iam_binding`. Обязательный параметр.
      * `members` — пользователи, которым назначается роль. Укажите:

         * `members = ["userAccount:<идентификатор_пользователя>"]` — для пользователя с аккаунтом на Яндексе или локального пользователя.
         * `members = ["federatedUser:<идентификатор_пользователя>"]` — для федеративного пользователя.
         * `members = ["serviceAccount:<идентификатор_пользователя>"]` — для сервисного аккаунта.
         * `members = ["group:<идентификатор_пользователя>"]` — для группы пользователей.
         * `members = ["system:group:organization:<идентификатор_организации>:users"]` — для всех пользователей [организации](../../../organization/quickstart.md).
         * `members = ["system:group:federation:<идентификатор_федерации>:users"]` — для всех пользователей [федерации удостоверений](../../../organization/concepts/add-federation.md).

      Более подробную информацию см. в [документации провайдера]({{ tf-provider-link }}).

   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Назначьте роль.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      После этого в организации будут созданы нужные ресурсы. Проверить их создание можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

      ```bash
      yc organization-manager organization list-access-bindings <имя_или_идентификатор_организации>
      ```

- API {#api}

   Чтобы назначить роль на организацию, воспользуйтесь методом REST API [updateAccessBindings](../../../organization/api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../../../organization/api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}

## Назначить роль на ресурс {#resource}

Вы можете назначить роль не только на организацию, облако или каталог, но и на их дочерние ресурсы. Они перечислены в разделе [{#T}](../../concepts/access-control/resources-with-access-control.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы назначить роль на ресурс:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ресурс.
   1. Откройте его страницу.
   1. Перейдите в раздел ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ресурсу.
   1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые роли.
   1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Чтобы назначить роль на ресурс:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc <имя_сервиса> <ресурс> add-access-binding --help
      ```

      Пример для [виртуальной машины {{ compute-full-name }}](../../../compute/concepts/vm.md):

      ```bash
      {{ yc-compute-instance }} add-access-binding --help
      ```

   1. Получите список ресурсов вместе с их идентификаторами:

      ```bash
      yc <имя_сервиса> <ресурс> list
      ```

   1. Получите [идентификатор пользователя](../users/get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.
   1. С помощью одной из команд ниже назначьте роль:

      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc <имя_сервиса> <ресурс> add-access-binding \
            --id <идентификатор_ресурса> \
            --role <роль> \
            --user-account-id <идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc <имя_сервиса> <ресурс> add-access-binding \
            --id <идентификатор_ресурса> \
            --role <роль> \
            --subject federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc <имя_сервиса> <ресурс> add-access-binding \
            --id <идентификатор_ресурса> \
            --role <роль> \
            --service-account-id <идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc <имя_сервиса> <ресурс> add-access-binding \
            --id <идентификатор_ресурса> \
            --role <роль> \
            --subject group:<идентификатор_группы>
         ```

      * Всем пользователям организации:

         ```bash
         yc <имя_сервиса> <ресурс> add-access-binding \
            --id <идентификатор_ресурса> \
            --role <роль> \
            --organization-users <идентификатор_организации>
         ```

      * Всем пользователям федерации удостоверений:

         ```bash
         yc <имя_сервиса> <ресурс> add-access-binding \
            --id <идентификатор_ресурса> \
            --role <роль> \
            --federation-users <идентификатор_федерации>
         ```

- API {#api}

   Чтобы назначить роль на ресурс, воспользуйтесь методом REST API или вызовом gRPC API `updateAccessBindings` для нужного ресурса и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ресурс.
   1. Откройте его страницу.
   1. Перейдите в раздел ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ресурсу.
   1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые роли.
   1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Чтобы назначить несколько ролей на ресурс:

   1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc <имя_сервиса> <ресурс> list-access-bindings \
         --id <идентификатор_ресурса>
      ```

      Пример для [виртуальной машины {{ compute-full-name }}](../../../compute/concepts/vm.md):

      ```bash
      {{ yc-compute-instance }} list-access-bindings \
         --id <идентификатор_ВМ>
      ```

   1. Посмотрите описание команды CLI для назначения ролей:

      ```bash
      yc <имя_сервиса> <ресурс> set-access-bindings --help
      ```

   1. Получите список ресурсов вместе с их идентификаторами:

      ```bash
      yc <имя_сервиса> <ресурс> list
      ```

   1. Получите [идентификатор пользователя](../users/get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.
   1. С помощью одной из команд ниже назначьте роли:

      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc <имя_сервиса> <ресурс> set-access-bindings \
            --id <идентификатор_ресурса> \
            --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc <имя_сервиса> <ресурс> set-access-bindings \
            --id <идентификатор_ресурса> \
            --access-binding role=<роль>,subject=federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc <имя_сервиса> <ресурс> set-access-bindings \
            --id <идентификатор_ресурса> \
            --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc <имя_сервиса> <ресурс> set-access-bindings \
            --id <идентификатор_ресурса> \
            --access-binding role=<роль>,subject=group:<идентификатор_группы>
         ```

      * Всем пользователям организации:

         ```bash
         yc <имя_сервиса> <ресурс> set-access-bindings \
            --id <идентификатор_ресурса> \
            --access-binding role=<роль>,subject=system:group:organization:<идентификатор_организации>:users
         ```

      * Всем пользователям федерации удостоверений:

         ```bash
         yc <имя_сервиса> <ресурс> set-access-bindings \
            --id <идентификатор_ресурса> \
            --access-binding role=<роль>,subject=system:group:federation:<идентификатор_федерации>:users
         ```

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc <имя_сервиса> <ресурс> set-access-bindings \
         --id <идентификатор_ресурса> \
         --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
         --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
         --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

   Чтобы назначить несколько ролей на ресурс, воспользуйтесь методом REST API или вызовом gRPC API `setAccessBindings` для нужного ресурса. Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

   * Роль в параметре `accessBindings[].roleId`.
   * Идентификатор субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.id`.
   * Тип субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.type`.

{% endlist %}
