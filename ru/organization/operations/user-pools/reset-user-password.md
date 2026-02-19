---
title: Как задать или сбросить пароль локального пользователя в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете задать или сбросить пароль локального пользователя в {{ org-full-name }}.
---

# Изменить пароль локального пользователя


## Сбросить пароль {#reset}

Чтобы задать пароль [локального](../../../iam/concepts/users/accounts.md#local) пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и найдите нужного локального пользователя.

      При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.
  1. В строке с нужным пользователем нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите ![key](../../../_assets/console-icons/key.svg) **{{ ui-key.yacloud_org.entity.user.action.reset-password_jk19s }}**.
  1. В появившемся окне подтвердите сброс пароля.

      Сохраните сгенерированный пароль и передайте его пользователю. После закрытия окна посмотреть новый пароль будет невозможно.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для сброса пароля пользователя в [пуле](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user reset-password --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Выполните команду, указав идентификатор нужного пользователя:

      ```bash
      yc organization-manager idp user reset-password <идентификатор_пользователя>
      ```

      Результат:

      ```text
      generated password for user 'ek0gkfu0jc7v********' is 'rhls-mpvg-****-****'
      ```

      Сохраните сгенерированный пароль и передайте его пользователю. После закрытия командной оболочки посмотреть новый пароль будет невозможно.

- API {#api}

  Воспользуйтесь методом REST API [User.GeneratePassword](../../idp/api-ref/User/generatePassword.md) для ресурса [User](../../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/GeneratePassword](../../idp/api-ref/grpc/User/generatePassword.md).

{% endlist %}

Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.

## Задать пароль {#set}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  Задать произвольный пароль локальному пользователю через интерфейс {{ cloud-center }} нельзя. Чтобы изменить пароль на сгенерированный, воспользуйтесь [инструкцией](#reset).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения пароля пользователя в пуле:

     ```bash
     yc organization-manager idp user set-password --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Выполните команду, указав идентификатор нужного пользователя и задав новый пароль пользователя в параметре `--password`:

      ```bash
      yc organization-manager idp user set-password <идентификатор_пользователя> \
        --password <новый_пароль>
      ```

      {% note info %}

      Новый пароль должен соответствовать заданной [парольной политике](../../concepts/password-policy.md) пула пользователей.

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры пользователя:

     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id = "<идентификатор_пула>"
       username    = "<имя_пользователя>"
       full_name   = "<полное_имя_пользователя>"
       password_spec = {
         password = "<новый_пароль>"
       }
     }
     ```

     Где:

     * `userpool_id` — идентификатор [пула](../../concepts/user-pools.md), в котором находится нужный пользователь.
     * `username` — имя пользователя.
     * `full_name` — полное имя пользователя.
     * `password` — новый пароль пользователя.

     {% note info %}

     Новый пароль должен соответствовать заданной [парольной политике](../../concepts/password-policy.md) пула пользователей.

     {% endnote %}

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_user` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_user).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} обновит все требуемые ресурсы. Проверить изменения можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [User.SetOwnPassword](../../idp/api-ref/User/setOwnPassword.md) для ресурса [User](../../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/SetOwnPassword](../../idp/api-ref/grpc/User/setOwnPassword.md).

{% endlist %}