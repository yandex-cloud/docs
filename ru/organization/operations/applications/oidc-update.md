---
title: Как изменить OIDC-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить OIDC-приложение в {{ org-name }}.
---

# Изменить OIDC-приложение в {{ org-full-name }}


{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Измените базовые настройки приложения {#update-basic-settings}

Чтобы изменить базовые настройки [OIDC-приложения](../../concepts/applications.md#oidc):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-name_kxMrU }}** измените имя приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-description_fcXBi }}** измените описание приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-labels_kc4MN }}** добавьте новые [метки](../../../resource-manager/concepts/labels.md) с помощью кнопки **{{ ui-key.yacloud.component.label-set.button_add-label }}**. Чтобы удалить существующую метку, используйте значок ![xmark](../../../_assets/console-icons/xmark.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application update --help
     ```
  
  1. Выполните команду:

     ```bash
     yc iam organization-manager idp application oauth application update \
       --id <идентификатор_приложения> \
       --new-name <имя_приложения> \
       --description <описание_приложения> \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes <атрибут>[,<атрибут>] \
       --group-distribution-type all-groups \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:

     * `--id` — идентификатор OIDC-приложения. Обязательный параметр.
     * `--new-name` — новое имя OIDC-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description` — новое описание OIDC-приложения.
     * `--client-id` — идентификатор нового OAuth-клиента.
     * `--authorized-scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов через запятую в формате `<атрибут1>,<атрибут2>`. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — адрес жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — [группы пользователей](../../concepts/groups.md) в организации.

         {% note warning %}
         
         Новый набор атрибутов пользователей сначала необходимо указать в [конфигурации поставщика услуг](#update-sp) с помощью параметра `--scopes`.
         
         {% endnote %}

     * `--group-distribution-type` — если при создании или изменении OAuth-клиента вы указали атрибут `groups`, измените группы пользователей, которые будут переданы поставщику услуг. Возможные значения:
       * `all-groups` — поставщику услуг будут переданы все группы, в которые входит пользователь.

          Максимальное количество передаваемых групп — 1 000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп.
       * `assigned-groups` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые [явно заданы](#users-and-groups).
       * `none` — поставщику услуг не будут переданы группы, в которые входит пользователь.
     * `--labels` — новый список [меток](../../../resource-manager/concepts/labels.md). Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле {{ TF }} измените параметры [OIDC-приложения](../../concepts/applications.md#oidc):

    ```hcl
    resource "yandex_organizationmanager_idp_application_oauth_application" "example_oidc_app" {
      application_id   = "<идентификатор_приложения>"
      organization_id = "<идентификатор_организации>"
      name            = "<новое_имя_приложения>"
      description     = "<новое_описание_приложения>"
      
      client_grant = {
        client_id         = "<идентификатор_OAuth-клиента>"
        authorized_scopes = ["<атрибут1>", "<атрибут2>"]
      }
      
      group_claims_settings = {
        group_distribution_type = "ALL_GROUPS"
      }
      
      labels = {
        "<ключ1>" = "<значение1>"
        "<ключ2>" = "<значение2>"
      }
    }
    ```

    Где:

    * `application_id` — идентификатор OIDC-приложения. Обязательный параметр.
    * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой находится OIDC-приложение. Обязательный параметр.
    * `name` — новое имя OIDC-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

    * `description` — новое описание OIDC-приложения. Необязательный параметр.
    * `client_grant` — параметры подключения к OAuth-клиенту:
      * `client_id` — идентификатор OAuth-клиента. Обязательный параметр.
      * `authorized_scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов в квадратных скобках. Возможные атрибуты:
        * `openid` — идентификатор пользователя. Обязательный атрибут.
        * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
        * `email` — адрес электронной почты пользователя.
        * `address` — место жительства пользователя.
        * `phone` — номер телефона пользователя.
        * `groups` — группы пользователей в организации.
    * `group_claims_settings` — настройки передачи групп пользователей поставщику услуг:
      * `group_distribution_type` — если при создании OAuth-клиента вы указали атрибут `groups`, укажите, какие группы пользователей будут переданы поставщику услуг. Возможные значения:
        * `ALL_GROUPS` — поставщику услуг будут переданы все группы, в которые входит пользователь.
        * `ASSIGNED_GROUPS` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые будут явно заданы.
        * `NONE` — поставщику услуг не будут переданы группы, в которые входит пользователь.
    * `labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр.

    Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application).

  1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

    ```bash
    yc organization-manager idp application oauth application get <идентификатор_приложения>
    ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../idp/application/oauth/api-ref/Application/update.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../idp/application/oauth/api-ref/grpc/Application/update.md).

{% endlist %}

## Измените конфигурацию поставщика услуг {#update-sp}

Чтобы изменить конфигурацию поставщика услуг в OIDC-приложении:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. {% include [oidc-app-update-sp-settings](../../../_includes/organization/oidc-app-update-sp-settings.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для настройки OAuth-клиента:

     ```bash
     yc iam oauth-client update --help
     ```

  1. Выполните команду:

     ```bash
     yc iam oauth-client update \
       --id <идентификатор_OAuth-клиента> \
       --new-name <новое_имя_OAuth-клиента> \
       --redirect-uris <адрес>[,<адрес>] \
       --scopes <атрибут>[,<атрибут>]
     ```

     Где:

     * `--id` — идентификатор OAuth-клиента.
     * `--new-name` — новое имя OAuth-клиента.
     * `--scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов через запятую в формате `<атрибут1>,<атрибут2>`. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — место жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — [группы пользователей](../../concepts/groups.md) в организации.

         {% note warning %}
         
         Новый набор атрибутов пользователей также необходимо указать в [базовых настройках приложения](#update-basic-settings) с помощью параметра `--authorized-scopes`.
         
         {% endnote %}

     * `--redirect-uris` — укажите новые полученные у поставщика услуг адрес или несколько адресов в формате `<адрес1>,<адрес2>`.

     Результат:

     ```text
     id: ajejklv8g9kh********
     name: my-oauth-client
     redirect_uris:
       - https://example2.com
       - https://example2.ru
     scopes:
       - openid
       - profile
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле {{ TF }} измените параметры OAuth-клиента:

    ```hcl
    resource "yandex_iam_oauth_client" "example_oauth_client" {
      oauth_client_id = "<идентификатор_OAuth-клиента>"
      name           = "<новое_имя_OAuth-клиента>"
      redirect_uris  = ["<адрес1>", "<адрес2>"]
      scopes         = ["<атрибут1>", "<атрибут2>"]
    }
    ```

    Где:

    * `oauth_client_id` — идентификатор OAuth-клиента. Обязательный параметр.
    * `name` — новое имя OAuth-клиента. Необязательный параметр.
    * `redirect_uris` — новый список адресов Redirect URI. Укажите один или несколько адресов в квадратных скобках. Необязательный параметр.
    * `scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов в квадратных скобках. Возможные атрибуты:
      * `openid` — идентификатор пользователя. Обязательный атрибут.
      * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
      * `email` — адрес электронной почты пользователя.
      * `address` — место жительства пользователя.
      * `phone` — номер телефона пользователя.
      * `groups` — группы пользователей в организации.

    Более подробную информацию о параметрах ресурса `yandex_iam_oauth_client` см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_oauth_client).

  1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

    ```bash
    yc iam oauth-client get <идентификатор_OAuth-клиента>
    ```

- API {#api}

  Воспользуйтесь методом REST API [OAuthClient.Update](../../../iam/api-ref/OAuthClient/update.md) для ресурса [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) или вызовом gRPC API [OAuthClientService/Update](../../../iam/api-ref/grpc/OAuthClient/update.md).


{% endlist %}

## Измените секрет приложения {#update-secret}

Посмотреть или изменить имеющийся в приложении [секрет](../../concepts/applications.md#oidc-secret) невозможно. Вместо этого вы можете сгенерировать новый секрет:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. Не забудьте указать новый секрет в настройках на стороне поставщика услуг. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания нового секрета OIDC-приложения:

     ```bash
     yc iam oauth-client-secret create --help
     ```

  1. Выполните команду:

     ```bash
     yc iam oauth-client-secret create --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: aje0hjqp68u6********
       oauth_client_id: ajejklv8g9kh********
       masked_secret: yccs__9e1d5f6d5c****
       created_at: "2025-10-23T11:44:50.739768533Z"
     secret_value: yccs__9e1d5f6d5c********
     ```

     Не забудьте указать новый секрет в настройках на стороне поставщика услуг. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле {{ TF }} создайте новый секрет OAuth-клиента:

    ```hcl
    resource "yandex_iam_oauth_client_secret" "example_oauth_client_secret" {
      oauth_client_id = "<идентификатор_OAuth-клиента>"
    }
    ```

    Где:

    * `oauth_client_id` — идентификатор OAuth-клиента, для которого создается новый секрет. Обязательный параметр.

    Более подробную информацию о параметрах ресурса `yandex_iam_oauth_client_secret` см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_oauth_client_secret).

  1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

    ```bash
    yc iam oauth-client-secret list --oauth-client-id <идентификатор_OAuth-клиента>
    ```


- API {#api}

  Воспользуйтесь методом REST API [OAuthClientSecret.Create](../../../iam/api-ref/OAuthClientSecret/create.md) для ресурса [OAuthClientSecret](../../../iam/api-ref/OAuthClientSecret/index.md) или вызовом gRPC API [OAuthClientSecretService/Create](../../../iam/api-ref/grpc/OAuthClientSecret/create.md).

{% endlist %}

## Измените список пользователей и групп приложения {#users-and-groups}

Измените список пользователей вашей [организации](../../concepts/organization.md), которые могут аутентифицироваться во внешнем приложении с помощью OIDC-приложения:

{% include [oidc-app-update-users-groups](../../../_includes/organization/oidc-app-update-users-groups.md) %}

#### См. также {#see-also}

* [{#T}](./oidc-create.md)
* [{#T}](./oidc-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)