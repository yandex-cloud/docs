{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../organization/concepts/user-pools.md).
  1. Выберите домен, который необходимо подтвердить.
  1. В открывшемся блоке будет указана информация для прохождения процедуры проверки прав на домен.
  1. После прохождения процедуры нажмите **{{ ui-key.yacloud_org.common.confirm }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}  

  1. Подтвердите, что домен принадлежит вам:

     1. Перейдите в раздел управления DNS-записями на сайте DNS-провайдера вашего домена:
     1. Добавьте TXT-запись со следующими параметрами:

        * **Host** или **Subdomain** — `_yandexcloud-challenge`
        * **Text** или **Value** — значение поля `value`, полученное после [привязки домена](../../organization/operations/user-pools/add-domain.md).

     1. Дождитесь обновления записей в системе DNS. Обновление может занять до 72 часов.

  1. Посмотрите описание команды CLI для подтверждения домена в [пуле пользователей](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain validate --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain validate <идентификатор_пула> <домен> \
        --name <домен>
      ```

      Например, подтвердите домен `my-domain.ru` в федерации `my-federation`:

      ```bash
      yc organization-manager federation saml validate-domain my-federation \
        --domain my-domain.ru
      ```

{% endlist %}