---
title: Как активировать пользователя в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете активировать пользователя в {{ org-name }}.
---

# Активировать пользователя

Вы можете активировать пользователей, которые ранее были [деактивированы](./deactivate-user.md). После активации пользователи вновь получают доступ к тем ресурсам организации, на которые им назначены [права доступа](../../../iam/concepts/access-control/roles.md).

{% include [activate-deactivate-passport-user-notice](../../../_includes/organization/activate-deactivate-passport-user-notice.md) %}

## Активировать федеративного пользователя {#activate-federated}

Чтобы активировать аккаунт федеративного пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для активации федеративных пользователей:

     ```bash
     yc organization-manager federation saml reactivate-user-accounts --help
     ```

  1. Получите список федераций в организации:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список федераций.

  1. Получите список деактивированных пользователей федерации:

     ```bash
     yc organization-manager federation saml list-user-accounts <идентификатор_федерации> \
       --organization-id <идентификатор_организации> \
       --filter active=false
     ```

     Где:

     * `<идентификатор_федерации>` — идентификатор федерации, в которой нужно получить список пользователей.
     * `--organization-id` — идентификатор организации, в которой находится федерация.
     * `--filter active=false` — фильтр для получения только деактивированных пользователей.

  1. Чтобы активировать пользователей, передайте их идентификаторы в команде:

     ```bash
     yc organization-manager federation saml reactivate-user-accounts <идентификатор_федерации> \
       --subject-ids <идентификатор_пользователя_1>,<идентификатор_пользователя_2>,...,<идентификатор_пользователя_N> \
       --organization-id <идентификатор_организации>
     ```

     Где:
     
     * `<идентификатор_федерации>` — идентификатор федерации, в которой нужно активировать пользователей.
     * `--subject-ids` — список идентификаторов пользователей, которых необходимо активировать.
     * `--organization-id` — идентификатор организации, в которой находится федерация.

- API {#api}

  Воспользуйтесь методом REST API [Federation.Reactivate](../../saml/api-ref/Federation/reactivateUserAccounts.md) для ресурса [Federation](../../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Reactivate](../../saml/api-ref/grpc/Federation/reactivateUserAccounts.md).

{% endlist %}


## Активировать локального пользователя {#activate-local}


Чтобы активировать аккаунт локального пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для активации пользователя [пула](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user reactivate --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Чтобы активировать пользователя, передайте его идентификатор в команде:

     ```bash
     yc organization-manager idp user reactivate <идентификатор_пользователя>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры пользователя:

     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id = "<идентификатор_пула>"
       username    = "<имя_пользователя>"
       full_name   = "<полное_имя_пользователя>"
       is_active   = true
     }
     ```

     Где:
     
     * `userpool_id` — идентификатор пула, в котором находится нужный пользователь.
     * `username` — имя нужного пользователя.
     * `full_name` — полное имя нужного пользователя.
     * `is_active` — флаг активации. Укажите `true`, чтобы активировать пользователя.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_user` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_user).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager idp user get <идентификатор_пользователя>
     ```

- API {#api}

  Воспользуйтесь методом REST API [User.Reactivate](../../idp/api-ref/User/reactivate.md) для ресурса [User](../../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Reactivate](../../idp/api-ref/grpc/User/reactivate.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](deactivate-user.md)