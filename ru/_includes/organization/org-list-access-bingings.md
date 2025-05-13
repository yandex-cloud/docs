Вы можете посмотреть все [роли](../../organization/security/index.md), назначенные субъектам в организации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. На странице **{{ ui-key.yacloud_org.pages.acl }}** отобразится информация о пользователях и ролях, которые им назначены.

     {% include [switch-org-note](switch-org-note.md) %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. {% include [get-federation-id-cli](../../_includes/organization/get-federation-id-cli.md) %}

  1. Посмотрите описание команды CLI для получения списка ролей, назначенных в организации:

     ```bash
     yc organization-manager organization list-access-bindings --help
     ```

  1. Получите перечень ролей, назначенных в организации, указав ее имя или идентификатор:

     ```bash
     yc organization-manager organization list-access-bindings <идентификатор_организации>
     ```

     Результат:

     ```text
     +------------------------------------------+----------------+----------------------+
     |                 ROLE ID                  |  SUBJECT TYPE  |      SUBJECT ID      |
     +------------------------------------------+----------------+----------------------+
     | auditor                                  | serviceAccount | ajefbjkmgjt1******** |
     | admin                                    | userAccount    | asefbskmgjt1******** |
     | organization-manager.organizations.owner | userAccount    | ajcfabjkmgjt******** |
     +------------------------------------------+----------------+----------------------+
     ```

- API {#api}

  Воспользуйтесь методом REST API [ListAccessBindings](../../organization/api-ref/Organization/listAccessBindings.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/ListAccessBindings](../../organization/api-ref/grpc/Organization/listAccessBindings.md).

{% endlist %}
