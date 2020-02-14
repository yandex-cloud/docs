{% include [include](../sa-assign-role-note.md) %}

Через консоль управления сервисному аккаунту можно назначить роль только на каталог, в котором он был создан. Чтобы назначить ему роль на другой ресурс, используйте CLI или API.

{% list tabs %}

- Консоль управления

  Чтобы назначить сервисному аккаунту роль на каталог, в котором он был создан:

  {% include [grant-role-console-sa](../grant-role-console-sa.md) %}

- CLI

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы назначить сервисному аккаунту роль на ресурс, выполните команду:

  ```
  yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
      --role <ROLE-ID> \
      --subject serviceAccount:<SERVICE-ACCOUNT-ID>
  ```

  где:

  * `<SERVICE-NAME>` — имя сервиса, на чей ресурс назначается роль, например `resource-manager`.
  * `<RESOURCE>` — категория ресурса, например `cloud`.
  * `<RESOURCE-NAME>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
  * `<RESOURCE-ID>` — идентификатор ресурса.
  * `<ROLE-ID>` — идентификатор роли, например `{{ roles-cloud-owner }}`.
  * `<SERVICE-ACCOUNT-ID>` — идентификатор сервисного аккаунта, которому назначается роль.

  Например, чтобы назначить сервисному аккаунту роль `viewer` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) `my-folder`:

  {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- API

  {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}
