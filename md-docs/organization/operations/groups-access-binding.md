# Назначить роль группе пользователей

Назначьте [группе пользователей](manage-groups.md) роль, чтобы предоставить доступ к какому-либо ресурсу. Воспользуйтесь инструкцией [Настроить доступ к управлению группой](access-manage-group.md), чтобы дать [субъекту](../../iam/concepts/access-control/index.md#subject) права на доступ к группе.

В сервисе Yandex Identity Hub группе можно назначить роль на организацию, облако, каталог, другую группу или сервисный аккаунт.

## Назначить роль на облако или каталог {#access-binding-cloud}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud) с учетной записью администратора или владельца облака.

  1. В левой части экрана нажмите на строку с именем [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), на который вы хотите назначить роль группе пользователей.

  1. В верхней части экрана перейдите на вкладку **Права доступа** и нажмите кнопку **Настроить доступ**. В открывшемся окне:

      1. Перейдите на вкладку **Группы** и выберите [группу](../concepts/groups.md) или воспользуйтесь поиском по названию группы.

          Вы также можете назначить роль одной из [системных](../../iam/concepts/access-control/system-group.md) групп:

          * `All users in organization X` — в группу входят все пользователи организации `X`.
          * `All users in federation N` — в группу входят все пользователи федерации `N`.

      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить группе на облако или каталог, который вы выбрали ранее. Вы можете назначить несколько ролей.

      1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Выберите [роль](../../iam/concepts/access-control/roles.md) из [справочника ролей Yandex Cloud](../../iam/roles-reference.md).
  1. Назначьте роль с помощью команды:

     ```bash
     yc <имя_сервиса> <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
       --role <идентификатор_роли> \
       --subject group:<идентификатор_группы>
     ```

     Где:
     
     * `--role` — идентификатор роли, например, `resource-manager.clouds.owner`.
     * `--subject group` — идентификатор [группы](../concepts/groups.md), которой назначается роль.

         Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), вместо параметра `--subject` используйте параметр `--organization-users <идентификатор_организации>` или `--federation-users <идентификатор_федерации>`, передав в нем соответственно идентификатор [организации](../quickstart.md) или [федерации удостоверений](../concepts/add-federation.md), всем пользователям, которым вы хотите назначить роль.
         
         Вы также можете назначить роль системной группе с помощью параметра `--subject`. Для этого передайте в нем идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), соответствующий выбранной системной группе.

     Например, назначьте роль `resource-manager.viewer` на [облако](../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

     ```bash
     yc resource-manager cloud add-access-binding mycloud \
       --role resource-manager.viewer \
       --subject group:aje6o61dvog2********
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную [роль](../../iam/concepts/access-control/roles.md) и [группу](../concepts/groups.md):

     ```hcl
     resource "yandex_resourcemanager_cloud_iam_member" "admin" {
       cloud_id    = "<идентификатор_облака>"
       role        = "<идентификатор_роли>"
       member      = "group:<идентификатор_группы>"
     }
     ```

     Где:
     
     * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Вы также можете назначить роль внутри отдельного [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder). Для этого вместо `cloud_id` укажите `folder_id` и нужный идентификатор каталога в параметрах ресурса.
     * `role` — назначаемая роль. Обязательный параметр.
     * `member` — группа, которой назначается роль. Указывается в виде `group:<идентификатор_группы>`. Обязательный параметр.

         Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), в параметре `member` укажите:

         * `system:group:organization:<идентификатор_организации>:users` — чтобы назначить роль системной группе `All users in organization X`;
         * `system:group:federation:<идентификатор_федерации>:users` — чтобы назначить роль системной группе `All users in federation N`.

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_member` см. в [документации провайдера](../../terraform/resources/iam_service_account_iam_member.md).
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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     terraform plan
     ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

     ```bash
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_папки>
     ```

- API {#api}

  Воспользуйтесь методом REST API `updateAccessBindings` для соответствующего ресурса.
  1. Выберите [роль](../../iam/concepts/access-control/roles.md) из [справочника ролей Yandex Cloud](../../iam/roles-reference.md).
  1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `group` и идентификатор группы:

     **body.json:**

     ```json
     {
       "accessBindingDeltas": [{
         "action": "ADD",
         "accessBinding": {
           "roleId": "editor",
           "subject": {
             "id": "<идентификатор_группы>",
             "type": "group"
           }
         }
       }]
     }
     ```

  1. Назначьте роль сервисному аккаунту. Например, на каталог с идентификатором `b1gvmob95yys********`:
     
     ```bash
     export FOLDER_ID=b1gvmob95yys********
     export IAM_TOKEN=CggaAT********
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --data '@body.json' \
       "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:updateAccessBindings"
     ```

  Вы можете ознакомиться с подробной инструкцией назначения роли для соответствующего ресурса:
  * [Настройка прав доступа к сервисному аккаунту](../../iam/operations/sa/set-access-bindings.md).
  * [Настройка прав доступа к облаку](../../resource-manager/operations/cloud/set-access-bindings.md).
  * [Настройка прав доступа к каталогу](../../resource-manager/operations/folder/set-access-bindings.md).

{% endlist %}

## Назначить роль на организацию {#access-binding-organization}

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

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_organization_iam_member` см. в [документации провайдера](../../terraform/resources/organizationmanager_organization_iam_member.md).
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

#### См. также {#see-also}

* [Настройка прав доступа к сервисному аккаунту](../../iam/operations/sa/set-access-bindings.md)
* [Настройка прав доступа к облаку](../../resource-manager/operations/cloud/set-access-bindings.md)
* [Настройка прав доступа к каталогу](../../resource-manager/operations/folder/set-access-bindings.md)