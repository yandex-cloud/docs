{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В списке [пулов пользователей](../../organization/concepts/user-pools.md) выберите нужный пул.
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}** отобразится список всех доступных доменов.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка [доменов](../../organization/concepts/domains.md) в [пуле пользователей](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain list --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain list <идентификатор_пула>
      ```

{% endlist %}