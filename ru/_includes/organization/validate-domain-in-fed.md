{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Подтвердите, что домен принадлежит вам:

     1. Перейдите в раздел управления DNS-записями на сайте DNS-провайдера вашего домена:
     1. Добавьте TXT-запись со следующими параметрами:

        * **Host** или **Subdomain** — `_yandexcloud-challenge`
        * **Text** или **Value** — значение поля `value`, полученное после [привязки домена](../../organization/operations/user-pools/add-domain.md).

     1. Дождитесь обновления записей в системе DNS. Обновление может занять до 72 часов.

  1. Посмотрите описание команды CLI для подтверждения домена в [федерации](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml validate-domain --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager federation saml validate-domain <имя_или_идентификатор_федерации> \
       --domain <домен>
     ```

     Где `--domain` — ваш домен.

     Например, подтвердите домен `my-domain.ru` в федерации `my-federation`:

     ```bash
     yc organization-manager federation saml validate-domain my-federation \
       --domain my-domain.ru
     ```

- API {#api}

   Воспользуйтесь методом REST API [Federation.ValidateDomain](../../organization/saml/api-ref/Federation/validateDomain.md) для ресурса [Federation](../../organization/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/ValidateDomain](../../organization/saml/api-ref/grpc/Federation/validateDomain.md).

{% endlist %}