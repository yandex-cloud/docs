{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![icon-federation](../../_assets/organization/icon-federation.svg) **{{ ui-key.yacloud_org.pages.federations }}** и выберите нужную [федерацию](../../organization/concepts/add-federation.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.form.federation.note.tab-domains }}**. 
  1. В блоке с нужным доменом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления домена из [федерации](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml delete-domain --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml delete-domain <имя_или_идентификатор_федерации> \
        --domain <домен>
      ```

      Где `--domain` — ваш домен.

      Например, удалите домен `my-domain.ru` из федерации `my-federation`:

      ```bash
      yc organization-manager federation saml delete-domain my-federation \
        --domain my-domain.ru
      ```

- API {#api}

  Воспользуйтесь методом REST API [Federation.DeleteDomain](../../organization/saml/api-ref/Federation/deleteDomain.md) для ресурса [Federation](../../organization/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/DeleteDomain](../../organization/saml/api-ref/grpc/Federation/deleteDomain.md).

{% endlist %}