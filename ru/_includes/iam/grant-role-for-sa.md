{% include [include](../sa-assign-role-note.md) %}

Через консоль управления сервисному аккаунту можно назначить роль только на каталоги, которые находятся в том же облаке, что и каталог, в котором был создан сервисный аккаунт. Чтобы назначить ему роль на другой ресурс, используйте CLI или API.

{% list tabs %}

- Консоль управления

    Чтобы назначить сервисному аккаунту роль на каталог:

    1. В [консоли управления]({{ link-console-main }}) откройте страницу каталога, на который будет назначена роль.
    1. Перейдите в раздел **Права доступа в каталоге** (кнопка **Права доступа** на панели слева).
    1. Установите переключатель **Наследуемые роли** в активное состояние, чтобы в списке отобразились сервисные аккаунты, которые не принадлежат текущему каталогу.
    1. Нажмите значок ![image](../../_assets/options.svg) напротив имени сервисного аккаунта.
    1. Нажмите кнопку **Изменить роли**.
    1. Нажмите кнопку **Добавить роль** и выберите роль, которую хотите добавить.
    1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы назначить сервисному аккаунту роль на ресурс, выполните команду:

  ```bash
  yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
    --role <role-id> \
    --subject serviceAccount:<service-account-id>
  ```

  Где:

  * `<service-name>` — имя сервиса, на чей ресурс назначается роль, например `resource-manager`.
  * `<resource>` — категория ресурса, например `cloud`.
  * `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
  * `<resource-id>` — идентификатор ресурса.
  * `<role-id>` — идентификатор роли, например `{{ roles-cloud-owner }}`.
  * `<service-account-id>` — идентификатор сервисного аккаунта, которому назначается роль.

  Например, чтобы назначить сервисному аккаунту роль `viewer` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) `my-folder`:

  {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- API

  {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}
