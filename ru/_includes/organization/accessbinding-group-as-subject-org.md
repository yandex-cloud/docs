{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите [группу](../../organization/concepts/groups.md) или воспользуйтесь поиском по названию группы.

     Вы также можете назначить роль одной из [системных](../../iam/concepts/access-control/system-group.md) групп:

     * `All users in organization X` — в группу входят все пользователи организации `X`.
     * `All users in federation N` — в группу входят все пользователи федерации `N`.

  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить группе на организацию. Вы можете назначить несколько ролей.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. Назначьте [роль](../../iam/concepts/access-control/roles.md) для [группы](../../organization/concepts/groups.md):

     ```bash
     yc organization-manager organization add-access-binding \
       --subject group:<идентификатор_группы> \
       --role <идентификатор_роли> \
       --organization-users <идентификатор_организации> \
       --federation-users <идентификатор_федерации>
     ```

     Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), вместо параметра `--subject` используйте параметр `--organization-users <идентификатор_организации>` или `--federation-users <идентификатор_федерации>`. Передайте в нем соответственно идентификатор [организации](../../organization/quickstart.md) или [федерации удостоверений](../../organization/concepts/add-federation.md), всем пользователям, которым вы хотите назначить роль.
         
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

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную [роль](../../iam/concepts/access-control/roles.md) и [группу](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_organization_iam_member" "users-editors" {
       organization_id = "<идентификатор_облака>"
       role            = "<идентификатор_роли>"
       member          = "group:<идентификатор_группы>"
     }
     ```

     Где:
     
     * `organization_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.
     * `member` — группа, которой назначается роль. Указывается в виде `group:<идентификатор_группы>`. Обязательный параметр.

         Для того чтобы назначить роль одной из [системных групп](../../iam/concepts/access-control/system-group.md), в параметре `member` укажите:

         * `system:group:organization:<идентификатор_организации>:users` — чтобы назначить роль системной группе `All users in organization X`;
         * `system:group:federation:<идентификатор_федерации>:users` — чтобы назначить роль системной группе `All users in federation N`.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_organization_iam_member` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого в указанном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_папки>
     ```

{% endlist %}