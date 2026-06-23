# Создать OIDC-приложение в {{ org-full-name }} для интеграции с NetBird


[NetBird](https://netbird.io/) — это платформа для организации защищенного доступа к сетевым ресурсам. NetBird поддерживает аутентификацию по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC), что позволяет настроить единый вход пользователей организации через {{ org-full-name }}.

В этом руководстве вы создадите OIDC-приложение и [пул пользователей](../../../organization/concepts/user-pools.md) в {{ org-full-name }}, получите `Client ID`, секрет приложения и [URL с конфигурацией](../../../organization/concepts/applications/oidc.md#oidc-sp-setup), а затем настроите внешний OIDC-провайдер в NetBird Dashboard.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать пользователям вашей организации доступ в NetBird:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте OIDC-приложение](#create-app).
1. [Создайте пул пользователей и добавьте в него пользователей](#create-userpool).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за использование [OIDC-приложения](../../../organization/concepts/applications/oidc.md) ([тарифы {{ org-full-name }}](../../../organization/pricing.md)).

### Перед началом работы {#check-to-begin}

Убедитесь, что:

* у вас есть доступ к [{{ org-full-name }}]({{ link-org-cloud-center }}) с правами на создание OIDC-приложений и пулов пользователей;
* развернут self-hosted NetBird, с доступом администратора к NetBird Dashboard;
* известен публичный URL NetBird Dashboard, например `https://netbird.example.com`;
* пользователи, которые должны входить в NetBird, добавлены в организацию или для них [созданы](../../../organization/operations/add-account.md#local-users) локальные учетные записи в пуле пользователей.

{% note info %}

В примерах ниже используется адрес NetBird `https://netbird.example.com`. Замените его на адрес вашего экземпляра NetBird.

{% endnote %}

## Создайте OIDC-приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Нажмите кнопку ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа (SSO) **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
      1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** укажите `netbird-oidc-app`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** укажите описание, например `OIDC-приложение для интеграции с NetBird`.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name netbird-oauth-client
     ```

     Где `--name` — имя OAuth-клиента.

     Результат:

     ```text
     id: aje9rrbpcndp********
     name: netbird-oauth-client
     folder_id: b1g07hj5r6i4********
     status: ACTIVE
     ```

     Где `id` — идентификатор созданного OAuth-клиента. Сохраните его значение — оно понадобится для создания OIDC-приложения и секрета.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeedld61h87********
       oauth_client_id: aje9rrbpcndp********
       masked_secret: yccs__ecf960********
       created_at: "2026-06-11T17:22:20.955Z"
     secret_value: yccs__ecf9609df********
     ```

     Где `secret_value` — секрет для OAuth-клиента. Сохраните его значение — оно понадобится для настройки NetBird.

  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name netbird-oidc-app \
       --description "OIDC-приложение для интеграции с NetBird" \
       --client-id <идентификатор_OAuth-клиента> \
       --group-distribution-type none
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md), в которой нужно создать OIDC-приложение.
     * `--client-id` — идентификатор OAuth-клиента, созданного на предыдущем шаге.
     * `--group-distribution-type` — значение `none`, так как в базовом сценарии интеграции NetBird группы пользователей не передаются.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: netbird-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

     Сохраните идентификатор созданного OIDC-приложения.

{% endlist %}

### Настройте OIDC-атрибуты пользователя {#setup-scopes}

Для NetBird обычно используются стандартные [атрибуты](../../../organization/concepts/applications/oidc.md#oidc-attributes) (scopes):

**Минимально необходимый набор**: `openid, email, profile`.

Возможные атрибуты:

* `openid` — идентификатор пользователя. Обязательный атрибут.
* `profile` — дополнительная информация о пользователе: имя, фамилия, аватар.
* `email` — адрес электронной почты пользователя.
* `address` — место жительства пользователя.
* `phone` — номер телефона пользователя.
* `groups` — [группы пользователей](../../../organization/concepts/groups.md) в организации.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `netbird-oidc-app`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_scopes }}** укажите рекомендуемый набор scopes: `openid, profile, email`.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Обновите OAuth-клиент, указав рекомендуемый набор scopes:

     ```bash
     yc iam oauth-client update \
       --id <идентификатор_OAuth-клиента> \
       --scopes openid,profile,email
     ```

     Где:

     * `--id` — идентификатор OAuth-клиента, созданного ранее.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны NetBird. В примере указан рекомендуемый набор:
       * `openid` — идентификатор пользователя. Обязательный атрибут;
       * `profile` — дополнительная информация о пользователе: имя, фамилия, аватар;
       * `email` — адрес электронной почты пользователя.

  1. Обновите OIDC-приложение, указав те же атрибуты:

     ```bash
     yc organization-manager idp application oauth application update \
       --id <идентификатор_приложения> \
       --authorized-scopes openid,profile,email
     ```

     Где:

     * `--id` — идентификатор OIDC-приложения, созданного ранее.
     * `--authorized-scopes` — атрибуты, которые были указаны при обновлении OAuth-клиента.

{% endlist %}

## Создайте пул пользователей и добавьте в него пользователей {#create-userpool}

[Пул пользователей](../../../organization/concepts/user-pools.md) в {{ org-full-name }} определяет, кто может аутентифицироваться в приложении. В этом руководстве используются локальные пользователи. Если подходящий пул уже существует, используйте его и переходите к следующему разделу.

### Создайте пул пользователей {#create-userpool-step}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-userpool }}**.
  1. Задайте имя пула, например `netbird-users`, и при необходимости описание. Имя должно быть уникальным в рамках организации и соответствовать требованиям:
     
     {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}
     
  1. В поле **{{ ui-key.yacloud_org.form.userpool.caption.domain }}** укажите [домен](../../../organization/concepts/domains.md) по умолчанию для пользователей пула. Этот домен будет использоваться, если к пулу не привязаны другие домены.
  1. (Опционально) Добавьте метки для организации ресурсов:
     
     * Нажмите **{{ ui-key.yacloud.common.add }}**.
     * Введите метку в формате `<ключ>: <значение>`.
     * Нажмите **Enter**.
     
  1. (Опционально) В поле **{{ ui-key.yacloud_org.form.userpool.caption.settings-data }}** выберите пользовательские настройки, доступные для изменения на портале [Мой аккаунт](../../../organization/concepts/my-account.md). По умолчанию разрешено управление паролем.
  1. В поле **{{ ui-key.yacloud_org.form.userpool.caption.session-lifetime }}** задайте период времени, в течение которого будут действительны [сессии](../../../organization/concepts/sessions.md) пользователя и не будет требоваться повторная аутентификация в {{ org-full-name }}.
  1. Нажмите **{{ ui-key.yacloud_org.form.userpool.create.action.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Создайте пул пользователей:

     ```bash
     yc organization-manager idp userpool create \
       --organization-id <идентификатор_организации> \
       --userpool-name netbird-users \
       --description "Пул пользователей для входа в NetBird" \
       --default-subdomain <домен_по_умолчанию>
     ```

     Где `--default-subdomain` — домен, который будет использоваться для логинов пользователей, если к пулу не привязаны другие домены.

     Сохраните идентификатор созданного пула пользователей.

{% endlist %}

### Добавьте пользователей в пул {#add-users-to-pool}

Добавьте в пул всех пользователей, которым нужен доступ в NetBird. Пул поддерживает два типа пользователей:

* *Локальные пользователи {{ org-full-name }}* — [создаются](../../../organization/operations/add-account.md#local-users) и управляются внутри {{ org-full-name }}. Подходят для сотрудников и сервисных учетных записей, которым не требуется внешний [IdP](../../../glossary/sso.md). Добавить таких пользователей можно вручную, через приглашение или из списка пользователей организации.
* *Пользователи с [аккаунтом на Яндексе](../../../iam/concepts/users/accounts.md#passport)* — входят с помощью Яндекс ID. Подходят, если организация использует учетные записи Яндекса для доступа.

### Добавьте пользователей или группы в OIDC-приложение {#add-users-to-app}

Чтобы пользователи из пула могли входить в NetBird через созданное OIDC-приложение, явно добавьте в него нужных пользователей или группы пользователей.

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-userAdmin) `organization-manager.oauthApplications.userAdmin` или выше.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `netbird-oidc-app`.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
  1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
  1. В открывшемся окне выберите нужных пользователей или группы пользователей, например, созданный пул `netbird-users` или пользователей Яндекс ID.
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md) или [группы пользователей](../../../organization/operations/group-get-id.md).
  1. Добавьте пользователя или группу в приложение:

     ```bash
     yc organization-manager idp application oauth application add-assignments \
       --id <идентификатор_приложения> \
       --subject-id <идентификатор_пользователя_или_группы>
     ```

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию NetBird с созданным OIDC-приложением, выполните настройки на стороне {{ org-full-name }} и на стороне NetBird.

### Получите параметры подключения OIDC-приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `netbird-oidc-app`.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и сохраните:

      * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` — Client ID.
      * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` — URL OpenID Connect Discovery.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите информацию о приложении:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Сохраните значение `client_id` из блока `client_grant`.

  1. Получите URL issuer:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     Сохраните полученное значение. NetBird обычно использует именно issuer URL, а необходимые endpoints получает автоматически через discovery. Если ваша версия NetBird ожидает discovery URL, используйте значение из поля **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** в интерфейсе {{ cloud-center }}.

     Для {{ org-full-name }} issuer URL имеет вид `https://auth.yandex.cloud`. Discovery endpoint доступен по адресу `https://auth.yandex.cloud/.well-known/openid-configuration`.

  1. Если секрет не был сохранен ранее, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value`.

{% endlist %}

### Настройте Redirect URI {#setup-redirect}

NetBird использует callback URL для завершения OIDC-аутентификации. Обычно он имеет вид:

```text
https://<домен_NetBird>/oauth2/callback
```

Например:

```text
https://netbird.example.com/oauth2/callback
```

Укажите этот адрес в настройках OAuth-клиента. Если NetBird показывает callback URL в интерфейсе настройки провайдера, используйте именно это значение.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `netbird-oidc-app`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите:

     ```text
     https://<домен_NetBird>/oauth2/callback
     ```

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Обновите OAuth-клиент, указав Redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <идентификатор_OAuth-клиента> \
    --redirect-uris "https://<домен_NetBird>/oauth2/callback"
  ```

{% endlist %}

{% note warning %}

Redirect URI в {{ org-full-name }} должен полностью совпадать с callback URL, который использует NetBird: схема, домен, путь и наличие или отсутствие завершающего `/` должны быть одинаковыми.

{% endnote %}

### Настройте внешний OIDC-провайдер в NetBird Dashboard {#setup-netbird}

{% note info %}

Подробнее о настройке внешних Identity Provider в NetBird читайте в [официальной документации NetBird](https://docs.netbird.io/selfhosted/identity-providers/generic-oidc).

{% endnote %}

1. Откройте NetBird Dashboard по адресу вашего экземпляра, например `https://netbird.example.com`, и войдите под учетной записью администратора.
1. Перейдите в раздел **Settings** → **Identity Providers**.
1. Нажмите **Add Identity Provider** или аналогичную кнопку в вашей версии NetBird.
1. Выберите тип провайдера **OpenID Connect** или **Generic OIDC**.
1. Заполните параметры подключения:

   * **Name** — например `Yandex Cloud Identity Hub`.
   * **Client ID** — значение `client_id`, полученное в {{ org-full-name }}.
   * **Client Secret** — секрет OIDC-приложения.
   * **Issuer URL** или **Authority** — issuer URL, полученный в {{ org-full-name }}.

1. Если NetBird показывает callback URL, убедитесь, что он совпадает со значением, указанным в Redirect URI OIDC-приложения.
1. Сохраните настройки.
1. Если в NetBird настроено несколько провайдеров, при необходимости назначьте созданный провайдер провайдером по умолчанию.
1. Перезапустите сервисы NetBird, чтобы изменения вступили в силу. Например, для Docker Compose:

   ```bash
   docker compose down
   docker compose up -d
   ```

{% note info %}

В зависимости от версии NetBird названия разделов и полей могут незначительно отличаться. Если интерфейс вашей версии не позволяет указать отдельные endpoints, достаточно задать issuer URL: NetBird получит `authorization_endpoint`, `token_endpoint`, `userinfo_endpoint` и `jwks_uri` автоматически.

{% endnote %}

## Убедитесь в корректной работе приложения {#validate}

1. Выйдите из NetBird Dashboard, если вы уже авторизованы.
1. Откройте страницу входа в NetBird.
1. Нажмите кнопку входа через настроенный OIDC-провайдер, например **Continue with Yandex Cloud**.
1. На странице аутентификации {{ yandex-cloud }} войдите под пользователем, который:

   * добавлен в нужный пул пользователей;
   * добавлен в OIDC-приложение напрямую или через группу.

1. Убедитесь, что после успешной аутентификации браузер возвращается в NetBird, а пользователь получает доступ к Dashboard.
1. Если в NetBird отображается профиль пользователя, проверьте, что вход выполнен под ожидаемой учетной записью и корректно передается адрес электронной почты.

## Возможные ошибки {#troubleshooting}

### `redirect_uri mismatch` {#redirect-uri-mismatch}

Причина: callback URL в NetBird не совпадает со значением Redirect URI в OAuth-клиенте.

Что проверить:

* используется один и тот же URL в NetBird и в {{ org-full-name }};
* совпадают схема `https`, домен, путь `/oauth2/callback` и завершающий `/`, если он есть.

### `invalid_client` {#invalid-client}

Причина: в NetBird указан неверный Client ID или Client Secret.

Что проверить:

* в NetBird указан актуальный `client_id` созданного OIDC-приложения;
* секрет был сохранен корректно и не был заменен новым без обновления настроек NetBird.

### `invalid_scope` {#invalid-scope}

Причина: NetBird запрашивает scopes, которые не разрешены для приложения.

Что проверить:

* в OAuth-клиенте и OIDC-приложении разрешены `openid`, `email`, `profile`;
* в NetBird не указаны дополнительные scopes, которые не настроены в {{ org-full-name }}.

Если ошибка сохраняется, начните с минимального набора scopes: `openid profile email`, а затем добавляйте остальные по необходимости.

### Пользователь не может войти {#user-cannot-login}

Что проверить:

* пользователь добавлен в пул пользователей;
* пользователь активирован;
* пользователь или его группа добавлены в OIDC-приложение;
* у пользователя заполнен адрес электронной почты, если NetBird использует claim `email`.

### NetBird не принимает токен {#token-rejected}

Что проверить:

* значение `issuer` в токене совпадает с issuer URL, указанным в NetBird;
* значение `aud` соответствует Client ID приложения;
* NetBird Management service может обращаться к JWKS endpoint провайдера;
* NetBird использует правильный claim пользователя: `sub`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы [удалите](../../../organization/operations/applications/oidc-deactivate-remove.md#delete) OIDC-приложение.
