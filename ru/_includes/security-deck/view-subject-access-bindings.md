{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. [Войдите в аккаунт]({{ link-passport-login }}) пользователя организации с [ролью](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше на эту организацию.
  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![person-gear](../../_assets/console-icons/person-gear.svg) **Диагностика доступа**.
  1. Нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.acl-diagnostics.action_select-subject }}** и в открывшемся окне:
  
      1. Выберите нужного [пользователя](../../overview/roles-and-resources.md#users), [сервисный аккаунт](../../iam/concepts/users/accounts.md#sa), [группу пользователей](../../organization/concepts/groups.md), [системную группу](../../iam/concepts/access-control/system-group.md) или [публичную группу](../../iam/concepts/access-control/public-group.md).

          При необходимости воспользуйтесь поиском.
      1. Нажмите **{{ ui-key.yacloud.common.select }}**.
  
  Откроется список доступов, назначенных выбранному субъекту. Для каждого доступа в списке указываются имя/идентификатор и тип ресурса, к которому выдан доступ, назначенная субъекту на этот ресурс [роль](../../iam/concepts/access-control/roles.md), а также информация о том, была ли эта роль назначена субъекту напрямую или была унаследована из группы, членом которой является этот субъект.
  
  Если у выбранного субъекта много доступов, отобразится только часть из них. Чтобы отобразить остальные доступы, нажмите кнопку **Загрузить ещё** внизу страницы.
  
  При необходимости воспользуйтесь фильтром по идентификатору ресурса, идентификатору роли или по способу назначения доступа: `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` или `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка доступов субъекта:

     ```bash
     yc iam access-analyzer list-subject-access-bindings --help
     ```

  1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или [группы пользователей](../../organization/operations/group-get-id.md) для просмотра списка доступов.

  1. С помощью команды `yc iam access-analyzer list-subject-access-bindings` получите список доступов субъекта:

     ```bash
     yc iam access-analyzer list-subject-access-bindings \
        --organization-id=<идентификатор_организации> \
        --subject-id=<идентификатор_субъекта>
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../organization/operations/organization-get-id.md).
     * `--subject-id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject): [пользователя](../../overview/roles-and-resources.md#users), [сервисного аккаунта](../../iam/concepts/users/accounts.md#sa), [группы пользователей](../../organization/concepts/groups.md), [системной группы](../../iam/concepts/access-control/system-group.md) или [публичной группы](../../iam/concepts/access-control/public-group.md).

     Результат:

     ```text
     +---------+-------------------------+----------------------+----------+
     | ROLE ID |      RESOURCE TYPE      |     RESOURCE ID      | GROUP ID |
     +---------+-------------------------+----------------------+----------+
     | admin   | resource-manager.cloud  | b1g2c5615qja******** |          |
     | admin   | resource-manager.folder | b1gq979gqitb******** |          |
     +---------+-------------------------+----------------------+----------+
     ```
  
     Список доступов будет представлен в виде таблицы. Для каждого доступа в списке указывается роль, назначенная субъекту на этот ресурс, тип ресурса и его идентификатор. Если эта роль не была назначена субъекту напрямую, а была унаследована из группы, то отобразится идентификатор этой группы.

{% endlist %}