---
title: Как изменить данные пользователя в пуле в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить данные пользователя в пуле в {{ org-full-name }}.
---

# Изменить данные пользователя


Изменять пользовательские данные можно только у [локальных](../../../iam/concepts/users/accounts.md#local) пользователей.

Чтобы изменить данные локального пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и в открывшемся списке найдите нужного локального пользователя.

     При необходимости воспользуйтесь строкой поиска и фильтрами в верхней части экрана.
  1. В строке с нужным пользователем нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![person-pencil](../../../_assets/console-icons/person-pencil.svg) **{{ ui-key.yacloud_org.page.user.action_edit-user }}**. В открывшемся окне:

      1. Измените имя пользователя, [домен](../../concepts/domains.md) и полное имя.
      1. Добавьте или измените адрес электронной почты.
      1. Разверните блок **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** и измените имя, фамилию и номер телефона пользователя.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.organization.userpools.action_update-user }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения данных пользователя в [пуле](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user update --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Чтобы изменить пользователя, передайте его идентификатор и другие параметры в команде:

     ```bash
     yc organization-manager idp user update <идентификатор_пользователя> \
       --username <логин_и_домен_пользователя> \
       --full-name <имя_и_фамилия_пользователя> \
       --given-name <имя_пользователя> \
       --family-name <фамилия_пользователя> \
       --email <электронная_почта_пользователя> \
       --phone-number <номер_телефона_пользователя>
     ```

     Где:     

     * `--username` — новые логин и домен пользователя в формате `логин@домен`. Логин должен быть уникальным для данного пула пользователей.
     * `--full-name` — новые имя и фамилия пользователя.
     * `--given-name` — новое имя пользователя.
     * `--family-name` — новая фамилия пользователя.
     * `--email` — новая электронная почта пользователя.
     * `--phone-number` — новый номер телефона пользователя.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить данные пользователя в [пуле](../../concepts/user-pools.md):

  1. Откройте конфигурационный файл {{ TF }} и измените параметры пользователя:

     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id  = <идентификатор_пула>
       username     = "<логин_и_домен_пользователя>"
       full_name    = "<имя_и_фамилия_пользователя>"
       given_name   = "<имя_пользователя>"
       family_name  = "<фамилия_пользователя>"
       email        = "<электронная_почта_пользователя>"
       phone_number = "<номер_телефона_пользователя>"
     }
     ```

     Где:

     * `username` — новые логин и домен пользователя в формате `логин@домен`. Логин должен быть уникальным для данного [пула пользователей](../../concepts/user-pools.md).
     * `full_name` — новые имя и фамилия пользователя.
     * `given_name` — новое имя пользователя.
     * `family_name` — новая фамилия пользователя.
     * `email` — новая электронная почта пользователя.
     * `phone_number` — новый номер телефона пользователя.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_user` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_user).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} обновит все требуемые ресурсы. Проверить изменения можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager idp user get <идентификатор_пользователя>
     ```

- API {#api}

  Воспользуйтесь методом REST API [User.Update](../../idp/api-ref/User/update.md) для ресурса [User](../../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../../idp/api-ref/grpc/User/update.md).

{% endlist %}