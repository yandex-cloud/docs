# Настроить права доступа к виртуальной машине

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [виртуальной машине](../../concepts/vm.md), назначьте на нее [роль](../../../iam/concepts/access-control/roles.md).

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. Выберите нужную ВМ.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ВМ.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на ВМ:

     ```bash
     yc compute instance add-access-binding --help
     ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute instance list
     ```
     
     Результат:
     ```text
     +----------------------+-----------------+---------------+---------+----------------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
     +----------------------+-----------------+---------------+---------+----------------------+
     | fhm0b28lgfp4******** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
     | fhm9gk85nj7g******** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
     +----------------------+-----------------+---------------+---------+----------------------+
     ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute instance list-access-bindings <идентификатор_ВМ>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       yc compute instance add-access-binding <идентификатор_ВМ> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../organization/operations/users-get.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       yc compute instance add-access-binding <идентификатор_ВМ> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая роль.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить роль на ВМ с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_instance_iam_binding" "sa-access" {
        instance_id = "<идентификатор_ВМ>"
        role        = "<роль>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>","<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `instance_id` — идентификатор ВМ.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_instance_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance_iam_binding).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) и с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc compute instance list-access-bindings <идентификатор_ВМ>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Instance/updateAccessBindings.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateAccessBindings](../../api-ref/grpc/Instance/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. Выберите нужную ВМ.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ВМ.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}
  
  Команда `set-access-bindings` полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     yc compute instance list-access-bindings <идентификатор_ВМ>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на ВМ:

     ```bash
     yc compute instance set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute instance set-access-bindings <идентификатор_ВМ> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — назначаемая роль:

       * `role` — идентификатор назначаемой роли.
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute instance set-access-bindings test-vm \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить несколько ролей на ВМ с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_instance_iam_binding" "role-1" {
        instance_id = "<идентификатор_ВМ>"
        role        = "<роль_1>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_compute_instance_iam_binding" "role-2" {
        instance_id = "<идентификатор_ВМ>"
        role        = "<роль_2>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `instance_id` — идентификатор ВМ.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_instance_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance_iam_binding).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) и с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc compute instance list-access-bindings <идентификатор_ВМ>
      ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../api-ref/Instance/setAccessBindings.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/SetAccessBindings](../../api-ref/grpc/Instance/setAccessBindings.md).

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. Выберите нужную ВМ.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва роли на ВМ:

     ```bash
     yc compute instance remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute instance list-access-bindings <идентификатор_ВМ>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc compute instance remove-access-binding <идентификатор_ВМ> \
       --role <идентификатор_роли> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

     Например, чтобы отозвать роль `{{ roles-viewer }}` у пользователя с идентификатором `ajel6l0jcb9s********` на ВМ:

     ```bash
     yc compute instance remove-access-binding test-vm \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы отозвать роль, назначенную на ВМ с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_compute_instance_iam_binding" "sa-access" {
        instance_id = "<идентификатор_ВМ>"
        role        = "<роль>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

  1. Примените изменения:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) и с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc compute instance list-access-bindings <идентификатор_ВМ>
      ```

- API {#api}

  Чтобы отозвать роли на ВМ, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Instance/updateAccessBindings.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateAccessBindings](../../api-ref/grpc/Instance/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}