{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![icon-federation](../../_assets/organization/icon-federation.svg) **{{ ui-key.yacloud_org.pages.federations }}** и выберите нужную федерацию.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.form.federation.note.tab-domains }}**.
  1. В верхнем правом углу нажмите **{{ ui-key.yacloud_org.organization.federations.action.add_domain }}**.
  1. Введите имя домена.
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

  Чтобы использовать домен для добавления новых пользователей, [подтвердите](../../organization/operations/user-pools/validate-domain.md) его.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для привязки домена к федерации:

     ```bash
     yc organization-manager federation saml add-domain --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml add-domain <имя_или_идентификатор_федерации> \
        --domain <домен>
      ```

      Где `--domain` — ваш домен.

      Результат:

      ```text
      done (1s)
      domain: example. com
      status: NEED_TO_VALIDATE
      status_code: organization/domain-diagnostics#need-to-validate
      created_at: "2025-10-09T06:40:18.704791371Z"
      validated_at: "1970-01-01T00:00:00Z"
      challenges:
      - created_at: "2025-10-09T06:40:18.704791371Z"
      updated_at: "2025-10-09T06:40:18.704791371Z"
      type: DNS_TXT
      status: PENDING
      dns_challenge:
      name: _yandexcloud-challenge. example. com
      type: TXT
      value: TlHc5HKJDeQIgPqaoiiSXxgy3CWFD+MLMJJP********
      ```

      Сохраните значение поля `value`, оно понадобится для [подтверждения домена](../../organization/operations/user-pools/validate-domain.md).

- API {#api}

  Воспользуйтесь методом REST API [Federation.AddDomain](../../organization/saml/api-ref/Federation/addDomain.md) для ресурса [Federation](../../organization/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/AddDomain](../../organization/saml/api-ref/grpc/Federation/addDomain.md).

{% endlist %}