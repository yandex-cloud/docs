{% include [include](../sa-assign-role-note.md) %}

Через консоль управления сервисному аккаунту можно назначить роль только на каталоги, которые находятся в одном облаке с каталогом сервисного аккаунта, и на это облако. Чтобы назначить ему роль на другой ресурс, используйте CLI или API.

{% list tabs %}

- Консоль управления

    Роли сервисному аккаунту назначаются так же, как пользовательскому аккаунту.
    
    Чтобы назначить сервисному аккаунту роль на каталог:

    {% include [grant-role-console-sa](../grant-role-console-sa.md) %}

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

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.
     * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде {% if product == "yandex-cloud" %}`userAccount:<идентификатор пользователя>`{% endif %}{% if product == "cloud-il" %}`federatedUser:<идентификатор пользователя>`{% endif %} или `serviceAccount:<идентификатор сервисного аккаунта>`. Обязательный параметр.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_resourcemanager_folder_iam_binding" "admin-account-iam" {
       folder_id   = "<идентификатор каталога>"
       role        = "<роль>"
       members     = [
         "serviceAccount:<идентификатор сервисного аккаунта>",
       ]
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_binding` см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_iam_binding).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc resource-manager folder list-access-bindings <имя каталога>|<идентификатор каталога>
     ```

{% endlist %}
