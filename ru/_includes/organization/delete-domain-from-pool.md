{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../organization/concepts/user-pools.md).
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}** рядом с необходимым доменом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.organization.userpool.action_delete-domain }}**.
  1. В открывшемся окне подтвердите удаление домена.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления домена из [пула пользователей](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool domain delete <идентификатор_пула> <домен>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.DeleteDomain](../../organization/idp/api-ref/Userpool/deleteDomain.md) для ресурса [Userpool](../../organization/idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/DeleteDomain](../../organization/idp/api-ref/grpc/Userpool/deleteDomain.md).

{% endlist %}