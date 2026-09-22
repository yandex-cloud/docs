# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Warpgate


[Warpgate](https://warpgate.null.page/) — это [бастион-хост](*bastion-host) с открытым исходным кодом для безопасного доступа к внутренним сервисам по протоколам SSH, HTTP, MySQL, PostgreSQL, Kubernetes, RDP и VNC. Warpgate поддерживает аутентификацию пользователей по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) через внешних поставщиков удостоверений.

Чтобы пользователи вашей [организации](*organization) могли входить в Warpgate через OIDC, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) и настройте интеграцию с Warpgate. В этом руководстве вы также настроите передачу [групп пользователей](*users-groups) в Warpgate и сопоставите их с ролями доступа.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать пользователям вашей организации доступ в Warpgate:

1. [Создайте OIDC-приложение](#create-app).
1. [Создайте группу пользователей и добавьте в нее пользователей](#create-group).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Создайте OIDC-приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Нажмите кнопку ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа (SSO) **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
      1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** укажите `warpgate-oidc-app`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** укажите описание, например `OIDC-приложение для интеграции с Warpgate`.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
  1. В созданном приложении справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** отметьте атрибут `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}` и выберите значение `{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}`. По умолчанию в новом OIDC-приложении этот атрибут отключен.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name warpgate-oauth-client \
       --scopes openid,email,profile,groups \
       --profile-id web
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны Warpgate. Указаны атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `groups` — [группы пользователей](../../../organization/concepts/groups.md) в организации. Понадобятся для сопоставления групп с ролями доступа Warpgate.
     * {% include [org-oidc-app-select-web-type-legend-cli](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-legend-cli.md) %}

     Результат:

     ```text
     id: ajeqqip130i1********
     name: warpgate-oauth-client
     folder_id: b1g500m2195v********
     authentication_methods:
       - client_secret_basic
       - client_secret_post
     status: ACTIVE
     profile_id: web
     pkce_required: true
     ```

     Сохраните значение поля `id`, оно понадобится для создания и настройки приложения.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2026-09-12T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value`, оно понадобится для настройки Warpgate.

  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name warpgate-oidc-app \
       --description "OIDC-приложение для интеграции с Warpgate" \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes openid,email,profile,groups \
       --group-distribution-type assigned-groups
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр.
     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на предыдущем шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — укажите `assigned-groups`, чтобы передавать в Warpgate только группы, добавленные в приложение.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: warpgate-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: ASSIGNED_GROUPS
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     status: ACTIVE
     created_at: "2026-09-12T10:51:28.790866Z"
     updated_at: "2026-09-12T12:37:19.274522Z"
     ```

     Сохраните идентификатор созданного OIDC-приложения.

{% endlist %}

## Создайте группу пользователей и добавьте в нее пользователей {#create-group}

Объедините пользователей, которым нужен одинаковый уровень доступа в Warpgate, в [группу](../../../organization/concepts/groups.md) в организации. Затем сопоставьте название группы с ролью доступа Warpgate.

### Создайте группу {#create-group-step}

Создайте группу с названием `warpgate-users`.

{% include [create-group-org](../../../_includes/organization/create-group-org.md) %}

### Добавьте пользователей в группу {#add-users-to-group}

По [инструкции](../../../organization/operations/add-member-group.md) добавьте всех пользователей, которым нужен доступ в Warpgate, в группу `warpgate-users`.

### Добавьте группу в OIDC-приложение {#add-group-to-app}

Чтобы пользователи из группы `warpgate-users` могли входить в Warpgate через созданное OIDC-приложение, а сама группа передавалась в атрибуте `groups`, явно добавьте эту группу в приложение.

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-userAdmin) `organization-manager.oauthApplications.userAdmin` или выше.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `warpgate-oidc-app`.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
  1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
  1. В открывшемся окне выберите группу `warpgate-users`.
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Получите идентификатор](../../../organization/operations/group-get-id.md) группы `warpgate-users`.
  1. Добавьте группу в приложение:

     ```bash
     yc organization-manager idp application oauth application add-assignments \
       --id <идентификатор_приложения> \
       --subject-id <идентификатор_группы>
     ```

     Где:

     * `--id` — идентификатор OIDC-приложения.
     * `--subject-id` — идентификатор группы `warpgate-users`.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Warpgate с созданным OIDC-приложением, выполните настройки на стороне {{ org-full-name }} и на стороне Warpgate.

### Получите параметры подключения OIDC-приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `warpgate-oidc-app`.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и сохраните значение параметра **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** — Client ID.
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите информацию о созданном OIDC-приложении:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Сохраните значение `client_id` из блока `client_grant` — это Client ID для настройки Warpgate.

  1. Используйте секрет OAuth-клиента, который был сохранен при создании приложения. Если вы не сохранили секрет, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value` — это Client Secret для настройки Warpgate.

{% endlist %}

Для {{ org-full-name }} issuer URL имеет вид `https://{{ auth-main-host }}`. Он потребуется для настройки Warpgate.

### Настройте Redirect URI {#setup-redirect}

Warpgate использует адрес вида `https://<домен_warpgate>/_warpgate/api/sso/return`, где `<домен_warpgate>` — [внешний домен](https://warpgate.null.page/sso/#external-host) вашего экземпляра Warpgate, заданный в параметре `external_host` конфигурационного файла.

Например, если `external_host: warpgate.example.com`, Redirect URI будет иметь вид:

```text
https://warpgate.example.com/_warpgate/api/sso/return
```

{% note info %}

По умолчанию Warpgate формирует Redirect URI с символом `@` (`/@warpgate/api/sso/return`). {{ org-full-name }} не поддерживает этот символ. Чтобы Warpgate заменил префикс `@warpgate` на `_warpgate`, укажите в конфигурации SSO-провайдера Warpgate параметр `return_url_prefix: _`.

{% endnote %}

Укажите полученный адрес в настройках OAuth-клиента:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `warpgate-oidc-app`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите:

     ```text
     https://<домен_warpgate>/_warpgate/api/sso/return
     ```

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Обновите OAuth-клиент, указав Redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <идентификатор_OAuth-клиента> \
    --redirect-uris "https://<домен_warpgate>/_warpgate/api/sso/return"
  ```

{% endlist %}

{% note warning %}

Redirect URI в {{ org-full-name }} и Warpgate должны полностью совпадать, включая схему, домен и путь.

{% endnote %}

### Создайте роль доступа в Warpgate {#setup-warpgate-role}

На стороне Warpgate создайте [роль доступа](https://warpgate.null.page/roles/#access-roles), которая будет назначаться пользователям после успешной аутентификации через {{ org-full-name }}:

1. Войдите в Warpgate под учетной записью администратора.
1. В меню перейдите в раздел **Config** → **Access roles**.
1. Нажмите **Add a role**.
1. Задайте имя роли, например `user`, и сохраните изменения.

На следующем шаге укажите название этой роли в параметре `role_mappings` конфигурационного файла Warpgate.

### Настройте SSO-провайдер в конфигурационном файле Warpgate {#setup-warpgate-sso}

{% note info %}

Подробнее о настройке единого входа в Warpgate читайте в [официальной документации Warpgate](https://warpgate.null.page/sso/).

{% endnote %}

Откройте конфигурационный файл Warpgate (`warpgate.yaml`) и добавьте в него провайдер единого входа с типом `custom`:

```yaml
sso_providers:
- name: idh
  auto_create_users: true
  return_url_prefix: _
  return_url_domain: external_host
  label: SSO with Identity Hub
  provider:
    type: custom
    client_id: <client_id_OIDC-приложения>
    client_secret: <секрет_OIDC-приложения>
    issuer_url: https://{{ auth-main-host }}
    scopes: ["openid", "profile", "email", "groups"]
    roles_claim: groups
    role_mappings:
      'warpgate-users': 'user'
external_host: <домен_warpgate>
```

Где:

* `name` — идентификатор провайдера.
* `auto_create_users: true` — Warpgate автоматически создает учетные записи для пользователей, впервые авторизованных через {{ org-full-name }}. Имя пользователя берется из атрибута `preferred_username`, а при его отсутствии — из атрибута `email`.
* `return_url_prefix: _` — заменяет символ `@` на `_` в Redirect URI, так как {{ org-full-name }} не поддерживает `@` в этом адресе.
* `return_url_domain: external_host` — Warpgate формирует Redirect URI на основе домена из параметра `external_host`.
* `label` — название кнопки входа на странице аутентификации Warpgate.
* `provider` — параметры OIDC-провайдера:
  * `type: custom` — тип интеграции с произвольным OIDC-совместимым поставщиком удостоверений, в данном случае — с {{ org-full-name }}.
  * `client_id` и `client_secret` — Client ID и секрет OIDC-приложения, полученные [ранее](#get-credentials).
  * `issuer_url` — Issuer URL {{ org-full-name }}: `https://{{ auth-main-host }}`.
  * `scopes` — атрибуты пользователя, которые Warpgate запрашивает у {{ org-full-name }}. Должны совпадать с атрибутами, указанными при настройке OIDC-приложения.
  * `roles_claim: groups` — атрибут ID-токена с группами пользователя. Значение `groups` соответствует стандартному атрибуту групп {{ org-full-name }}.
  * `role_mappings` — соответствие между группами {{ org-full-name }} и ролями доступа Warpgate. В примере группа `warpgate-users` сопоставлена с ролью `user`, [созданной ранее](#setup-warpgate-role). Warpgate синхронизирует только роли, указанные в этом параметре, не затрагивая остальные роли пользователя.
* `external_host` — внешний домен экземпляра Warpgate, например `warpgate.example.com`. Должен совпадать с доменом, указанным в Redirect URI OIDC-приложения.

Сохраните файл конфигурации и перезапустите Warpgate, чтобы применить изменения.

## Убедитесь в корректной работе приложения {#validate}

1. Выйдите из Warpgate, если вы уже авторизованы.
1. Откройте страницу входа Warpgate по адресу вашего экземпляра, например `https://warpgate.example.com`.
1. Нажмите кнопку входа с названием из параметра `label`.
1. На странице аутентификации {{ yandex-cloud }} войдите под пользователем, который состоит в группе `warpgate-users`.
1. Убедитесь, что после успешной аутентификации браузер возвращается в Warpgate, а пользователь получает доступ к интерфейсу с ролью `user`.
1. При необходимости откройте раздел **Users** в Warpgate и проверьте, что созданному пользователю назначена ожидаемая роль.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы {{ org-full-name }}, [удалите](../../../organization/operations/applications/oidc-deactivate-remove.md#delete) OIDC-приложение.

При необходимости также [удалите](../../../organization/operations/delete-group.md) созданную группу пользователей `warpgate-users`.

[*bastion-host]: {% include [bastion-host-popup](../../../_popups/bastion-host.md) %}

[*organization]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}

[*users-groups]: {% include [users-groups](../../../_popups/identity-hub/users-groups.md) %}
