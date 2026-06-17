# Назначить роль на всю организацию

Чтобы участники группы могли работать с ресурсами Yandex Cloud в организации, назначьте группе соответствующие [роли](../../iam/concepts/access-control/roles.md).

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Права доступа**.

  1. Справа сверху нажмите кнопку **Назначить роли**.

  1. Перейдите на вкладку **Группы** и выберите [группу](../concepts/groups.md) или воспользуйтесь поиском по названию группы.

     Вы также можете назначить роль одной из [системных](../../iam/concepts/access-control/system-group.md) групп:

     * `All users in organization X` — в группу входят все пользователи организации `X`.
     * `All users in federation N` — в группу входят все пользователи федерации `N`.

  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить группе на организацию. Вы можете назначить несколько ролей.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Назначьте [роль](../../iam/concepts/access-control/roles.md) для [группы](../concepts/groups.md):

     ```bash
     yc organization-manager organization add-access-binding \
       --subject group:<идентификатор_группы> \
       --role <идентификатор_роли> \
       --organization-users <идентификатор_организации> \
       --federation-users <идентификатор_федерации>
     ```

     Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), вместо параметра `--subject` используйте параметр `--organization-users <идентификатор_организации>` или `--federation-users <идентификатор_федерации>`. Передайте в нем соответственно идентификатор [организации](../quickstart.md) или [федерации удостоверений](../concepts/add-federation.md), всем пользователям которых вы хотите назначить роль.
         
     Вы также можете назначить роль системной группе с помощью параметра `--subject`. Для этого передайте в нем идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), соответствующий выбранной системной группе.

  1. Проверьте, что запрошенные права были выданы:

     ```bash
     yc organization-manager organization list-access-bindings <идентификатор_организации>
     ```

     Ответ содержит список всех ролей, выданных пользователям и группам в организации:

     ```text
     +------------------------------------------+--------------+----------------------+
     |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
     +------------------------------------------+--------------+----------------------+
     | organization-manager.admin               | userAccount  | ajev1p2345lj******** |
     | organization-manager.organizations.owner | userAccount  | ajev1p2345lj******** |
     | editor                                   | group        | ajev1p2345lj******** |
     | viewer                                   | group        | ajev1p2345lj******** |
     +------------------------------------------+--------------+----------------------+
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную [роль](../../iam/concepts/access-control/roles.md) и [группу](../concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_organization_iam_member" "users-editors" {
       organization_id = "<идентификатор_организации>"
       role            = "<идентификатор_роли>"
       member          = "group:<идентификатор_группы>"
     }
     ```

     Где:
     
     * `organization_id` — [идентификатор организации](organization-get-id.md). Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.
     * `member` — группа, которой назначается роль. Указывается в виде `group:<идентификатор_группы>`. Обязательный параметр.

         Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), в параметре `member` укажите:

         * `system:group:organization:<идентификатор_организации>:users` — чтобы назначить роль системной группе `All users in organization X`;
         * `system:group:federation:<идентификатор_федерации>:users` — чтобы назначить роль системной группе `All users in federation N`.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_organization_iam_member` смотрите в [документации провайдера](../../terraform/resources/organizationmanager_organization_iam_member.md).
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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     После этого в указанном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы все требуемые ресурсы. Проверить создание ресурсов можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_папки>
     ```

{% endlist %}