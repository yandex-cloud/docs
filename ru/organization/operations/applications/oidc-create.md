---
title: Как создать OIDC-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете создать OIDC-приложение в {{ org-name }} для аутентификации пользователей вашей организации во внешних приложениях с помощью технологии единого входа по стандарту OpenID Connect.
---

# Создать OIDC-приложение в {{ org-full-name }}


Чтобы пользователи вашей [организации](../../concepts/organization.md) могли аутентифицироваться во внешних приложениях с помощью технологии единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC), создайте [OIDC-приложение](../../concepts/applications.md#oidc) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне поставщика услуг.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.

          OAuth-клиент является необходимым компонентом при создании OIDC-приложения, создается и удаляется одновременно с OIDC-приложением и неразрывно с ним связан.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

          1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application create --help
     ```

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name <имя_OAuth-клиента> \
       --scopes <атрибут>[,<атрибут>]
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов через запятую в формате `<атрибут1>,<атрибут2>`. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — место жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — [группы пользователей](../../concepts/groups.md) в организации.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: test-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Сохраните значение поля `id`, оно понадобится для создания и настройки приложения.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value`, оно понадобится для [настроек приложения](#setup-application) на стороне поставщика услуг.
  
  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name <имя_приложения> \
       --description <описание_приложения> \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes <атрибут>[,<атрибут>] \
       --group-distribution-type all-groups \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на втором шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — если при создании OAuth-клиента вы указали атрибут `groups`, укажите, какие группы пользователей будут переданы поставщику услуг. Возможные значения:
       * `all-groups` — поставщику услуг будут переданы все группы, в которые входит пользователь.

          Максимальное количество передаваемых групп — 1 000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп.
       * `assigned-groups` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые будут явно [заданы](#users-and-groups).
       * `none` — поставщику услуг не будут переданы группы, в которые входит пользователь.
     * `--labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

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

  1. Опишите в конфигурационном файле {{ TF }} параметры [OAuth-клиента](../../concepts/applications.md):

     ```hcl
     resource "yandex_iam_oauth_client" "example_oauth_client" {
       name      = "<имя_OAuth-клиента>"
       folder_id = "<идентификатор_каталога>"
       scopes    = ["<атрибут1>", "<атрибут2>"]
     }
     ```

     Где:

     * `name` — имя OAuth-клиента.
     * `folder_id` — идентификатор каталога, в котором будет создан OAuth-клиент.
     * `scopes` — набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов в квадратных скобках. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — место жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — группы пользователей в организации.

     Более подробную информацию о параметрах ресурса `yandex_iam_oauth_client` см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_oauth_client).

  1. Опишите в конфигурационном файле {{ TF }} параметры [секрета](../../concepts/applications.md#oidc-secret) OAuth-клиента:

     ```hcl
     resource "yandex_iam_oauth_client_secret" "example_oauth_client_secret" {
       oauth_client_id = "<идентификатор_OAuth-клиента>"
     }
     ```

     Где:

     * `oauth_client_id` — идентификатор OAuth-клиента, для которого создается секрет.

     Более подробную информацию о параметрах ресурса `yandex_iam_oauth_client_secret` см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_oauth_client_secret).

  1. Опишите в конфигурационном файле {{ TF }} параметры [OIDC-приложения](../../concepts/applications.md#oidc):

     ```hcl
     resource "yandex_organizationmanager_idp_application_oauth_application" "example_oidc_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"
       description     = "<описание_приложения>"
       
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

     * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `name` — имя OIDC-приложения. Обязательный параметр. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `description` — описание OIDC-приложения. Необязательный параметр.
     * `client_grant` — параметры подключения к OAuth-клиенту:
       * `client_id` — идентификатор OAuth-клиента. Обязательный параметр.
       * `authorized_scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `group_claims_settings` — настройки передачи групп пользователей поставщику услуг:
       * `group_distribution_type` — если при создании OAuth-клиента вы указали атрибут `groups`, укажите, какие группы пользователей будут переданы поставщику услуг. Возможные значения:
         * `ALL_GROUPS` — поставщику услуг будут переданы все группы, в которые входит пользователь.
         * `ASSIGNED_GROUPS` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые будут явно заданы.
         * `NONE` — поставщику услуг не будут переданы группы, в которые входит пользователь.
     * `labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
     ```

- API {#api}

  1. Воспользуйтесь методом REST API [OAuthClient.Create](../../../iam/api-ref/OAuthClient/create.md) для ресурса [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) или вызовом gRPC API [OAuthClientService/Create](../../../iam/api-ref/grpc/OAuthClient/create.md).
  1. Воспользуйтесь методом REST API [OAuthClientSecret.Create](../../../iam/api-ref/OAuthClientSecret/create.md) для ресурса [OAuthClientSecret](../../../iam/api-ref/OAuthClientSecret/index.md) или вызовом gRPC API [OAuthClientSecretService/Create](../../../iam/api-ref/grpc/OAuthClientSecret/create.md).
  1. Воспользуйтесь методом REST API [Application.Create](../../idp/application/oauth/api-ref/Application/create.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Create](../../idp/application/oauth/api-ref/grpc/Application/create.md).  

{% endlist %}

## Настройте приложение {#setup-application}

Чтобы настроить интеграцию внешнего приложения с созданным OIDC-приложением в {{ org-name }}, выполните настройки на стороне поставщика услуг и на стороне {{ org-name }}.

### Задайте настройки интеграции на стороне поставщика услуг {#setup-sp}

Значения настроек интеграции, которые нужно задать на стороне поставщика услуг, доступны на странице с информацией о приложении в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}/apps).

В зависимости от возможностей вашего поставщика услуг вы можете выполнить необходимые настройки вручную или автоматически, указав URL с конфигурацией:

{% list tabs %}

- Настройка вручную

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и скопируйте значения параметров, которые необходимо задать на стороне поставщика услуг:

      {% include [oidc-app-sp-parameter-list](../../../_includes/organization/oidc-app-sp-parameter-list.md) %}

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. На стороне поставщика услуг настройте интеграцию с OIDC-приложением {{ org-name }}, указав скопированные параметры и сгенерированный секрет. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- URL с конфигурацией

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}**.

      По ссылке доступны значения всех настроек, которые необходимо задать на стороне поставщика услуг (за исключением секрета).
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. Если ваш поставщик услуг поддерживает конфигурирование приложения с помощью URL с конфигурацией, на стороне поставщика услуг настройте интеграцию с OIDC-приложением {{ org-name }}, указав скопированные ссылку и секрет. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

{% endlist %}

### Настройте OIDC-приложение на стороне {{ org-name }} {#setup-idp}

Прежде чем настраивать OIDC-приложение на стороне {{ org-name }}, получите адрес (адреса) Redirect URI у вашего поставщика услуг. Затем перейдите к настройкам OIDC-приложения в {{ org-name }}:

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
       --redirect-uris <адрес>[,<адрес>]
     ```

     Где:

     * `--id` — идентификатор OAuth-клиента.
     * `--redirect-uris` — укажите полученный у поставщика услуг адрес или несколько адресов в формате `<адрес1>,<адрес2>`.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: test-oauth-client
     redirect_uris:
       - https://example.com
       - https://example.ru
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```


- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле {{ TF }} для ресурса `yandex_iam_oauth_client` укажите параметр `redirect_uris`:

     ```hcl
     resource "yandex_iam_oauth_client" "example_oauth_client" {
       name          = "<имя_OAuth-клиента>"
       folder_id     = "<идентификатор_каталога>"

       ...

       redirect_uris = ["<адрес1>", "<адрес2>"]
     }
     ```

     Где:

     * `name` — имя OAuth-клиента.
     * `folder_id` — идентификатор каталога, в котором будет создан OAuth-клиент.
     * `redirect_uris` — укажите полученный у поставщика услуг адрес или несколько адресов в квадратных скобках.

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

### Настройте пользователей и группы {#users-and-groups}

Чтобы пользователи вашей организации могли аутентифицироваться во внешнем приложении с помощью OIDC-приложения {{ org-name }}, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../concepts/groups.md):

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../security/index.md#organization-manager-oauthApplications-userAdmin) `organization-manager.oauthApplications.userAdmin` или выше.

{% endnote %}

{% include [oidc-app-update-users-groups](../../../_includes/organization/oidc-app-update-users-groups.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с поставщиком услуг, выполните аутентификацию во внешнем приложении от имени одного из добавленных в приложение пользователей.

#### См. также {#see-also}

* [{#T}](./oidc-update.md)
* [{#T}](./oidc-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)