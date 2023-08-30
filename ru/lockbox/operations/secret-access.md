# Настроить права доступа к секрету

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите на имя нужного секрета.
  1. На панели слева выберите раздел ![image](../../_assets/organization/icon-groups.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне нажмите ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
  1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к секрету.
  1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../security/index.md#roles-list).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите идентификатор секрета (столбец `ID` в выводе команды):

      ```bash
      yc lockbox secret list
      ```

      Результат:

      ```bash
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      |          ID          |    NAME     | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      | e6qtoqv06f1b******** | test-secret |            | 2022-09-12 08:10:11 | e6qtpq6a9k7q******** | ACTIVE |
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      ```

  1. Чтобы назначить роль на секрет:

      * Пользователю:

        ```bash
        yc lockbox secret add-access-binding \
          --id <идентификатор_секрета> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```

        Где:
        * `id` — идентификатор секрета.
        * `user-account-id` — [идентификатор пользователя](../../iam/operations/users/get.md).
        * `role` — назначаемая [роль](../security/index.md#roles-list).

      * [Сервисному аккаунту](../../iam/concepts/users/service-accounts.md):

        ```bash
        yc lockbox secret add-access-binding \
          --id <идентификатор_секрета> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```

        Где:
        * `id` — идентификатор секрета.
        * `service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md).
        * `role` — назначаемая [роль](../security/index.md#roles-list).

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры прав доступа к секрету:

      ```hcl
      resource "yandex_lockbox_secret_iam_binding" "secret-viewer" {
        secret_id = "<идентификатор_секрета>"
        role      = "<роль>"

        members = [
          "serviceAccount:<идентификатор_сервисного_аккаунта_1>",
          "serviceAccount:<идентификатор_сервисного_аккаунта_2>"
        ]
      }
      ```

      Где:

      * `secret_id` — идентификатор секрета.
      * `role` — назначаемая [роль](../security/index.md#roles-list).
      * `members` — идентификаторы [пользователей](../../iam/operations/users/get), групп или [сервисных аккаунтов](../../iam/operations/sa/get-id.md), которым будет присвоена роль.

      Более подробную информацию о параметрах ресурса `yandex_lockbox_secret_iam_binding` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lockbox_secret_iam_binding).

  1. Создайте ресурсы

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc lockbox secret list-access-binding <идентификатор_секрета>
      ```

- API

  Чтобы настроить права доступа к секрету, воспользуйтесь методом REST API [setAccessBindings](../api-ref/Secret/setAccessBindings.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/SetAccessBindings](../api-ref/grpc/secret_service.md#SetAccessBindings).

{% endlist %}

{% note warning %}

Если вы [назначите](../../iam/operations/roles/grant.md) группе, пользователю или сервисному аккаунту роль на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых находится секрет, все разрешения этой роли будут действовать и для секрета.

Подробнее об этом читайте в разделе [Как устроено управление доступом](../../iam/concepts/access-control/#inheritance).

{% endnote %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
