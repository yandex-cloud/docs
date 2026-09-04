# Создать OIDC-приложение в {{ org-full-name }} для интеграции с LibreChat

[LibreChat](https://www.librechat.ai/) — это бесплатная платформа с открытым исходным кодом для удобной работы с [большими языковыми моделями](../../../glossary/llm.md), AI-агентами и [MCP-серверами](../../../glossary/mcp.md), которую можно развернуть в собственной инфраструктуре. LibreChat поддерживает аутентификацию [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в LibreChat с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне LibreChat.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы предоставить пользователям вашей организации доступ в LibreChat:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Добавьте пользователей](#add-users).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `librechat-oidc-app`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) Добавьте описание и [метки](../../../resource-manager/concepts/labels.md) приложения.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию LibreChat с созданным OIDC-приложением в {{ org-full-name }}, выполните настройки на стороне {{ org-full-name }} и на стороне LibreChat.

### Получите учетные данные и создайте секрет приложения {#get-credentials-secret}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `librechat-oidc-app`.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
    1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

### Задайте дополнительные настройки OIDC-приложения в {{ org-full-name }} {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `librechat-oidc-app`.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

        1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите значение `https://<адрес_сервера>/oauth/openid/callback`, где `<адрес_сервера>` — публичный IP-адрес или доменное имя, на котором развернут ваш экземпляр LibreChat.

            {% note info %}

            В настройках OIDC-приложения на стороне {{ org-full-name }} значение `Redirect URI` можно добавить только со схемой `https://`, поэтому ваш экземпляр LibreChat должен быть доступен по протоколу `https`.

            {% endnote %}

        1. В блоке **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** включите опцию **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}**.
        1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте OIDC-аутентификацию на стороне LibreChat {#setup-sp}

1. На хосте, на котором развернут ваш экземпляр LibreChat, в среде его выполнения задайте следующие переменные окружения, определяющие параметры интеграции LibreChat с OIDC-приложением:

    * Переменные, содержащие основные настройки интеграции:

        Имя переменной | Значение
        --- | ---
        `OPENID_CLIENT_ID` | Значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**, полученное [ранее](#get-credentials-secret) в свойствах OIDC-приложения на стороне {{ yandex-cloud }}.
        `OPENID_CLIENT_SECRET` | Секрет OIDC-приложения, сгенерированный [ранее](#get-credentials-secret).
        `OPENID_ISSUER` | `"https://auth.yandex.cloud/"`
        `OPENID_SESSION_SECRET` | Дополнительный секрет, используемый для защиты сессий.</br></br>Самостоятельно сгенерируйте надежный секрет длиной не менее 32 символов.
        `OPENID_SCOPE` | `"openid profile email groups"`
        `OPENID_CALLBACK_URL` | `"/oauth/openid/callback"`
        `OPENID_USERNAME_CLAIM` | `"preferred_username"`
        `OPENID_NAME_CLAIM` | `"name"`
        `OPENID_EMAIL_CLAIM` | `"email"`
        `OPENID_USE_PKCE` | `true`
        `OPENID_BUTTON_LABEL` | `"Login with {{ org-full-name }}"`
        `OPENID_AUTO_REDIRECT` | `false`
    * Переменные, содержащие дополнительные настройки для синхронизации групп пользователей:

        Имя переменной | Значение
        --- | ---
        `OPENID_ROLE_SYNC_ENABLED` | `true`
        `OPENID_ROLE_SYNC_API_ENABLED` | `false`
        `OPENID_ROLE_SYNC_SOURCE` | `"id"`
        `OPENID_ROLE_SYNC_CLAIM` | `"groups"`
        `OPENID_ROLE_SYNC_ROLE_PRIORITY` | Список имен групп в {{ org-full-name }}, с которыми будет выполняться синхронизация.</br></br>Например: `"librechat-admins,librechat-users"`.
        `OPENID_ROLE_SYNC_FALLBACK_ROLE` | Группа пользователей, которая будет использоваться по умолчанию.</br></br>Например: `"librechat-users"`.
1. Перезапустите экземпляр LibreChat в среде выполнения с заданными переменными окружения.

## Добавьте пользователей {#add-users}

Чтобы разрешить пользователям аутентифицироваться в LibreChat:

1. [Создайте](../../../organization/operations/create-group.md) в {{ org-full-name }} [группу пользователей](../../../organization/concepts/groups.md) с одним из имен, указанных [ранее](#setup-sp) в переменной окружения `OPENID_ROLE_SYNC_ROLE_PRIORITY`. Например: `librechat-users`.
1. [Добавьте](../../../organization/operations/add-member-group.md) нужного пользователя в группу `librechat-users`.
1. Добавьте группу пользователей `librechat-users` в OIDC-приложение {{ org-full-name }}:

    {% include [oidc-manage-users](../../../_includes/organization/oidc-manage-users.md) %}

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `librechat-oidc-app`.
        1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
        1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
        1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud_org.common.resource-acl.label_groups_mQQ4T }}** и выберите группу пользователей `librechat-users`.
        1. Нажмите **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы OIDC-приложения и интеграции с LibreChat, выполните вход в LibreChat с учетной записью пользователя, добавленного в группу `librechat-users`. Для этого:

1. В окне браузера откройте страницу входа в ваш экземпляр LibreChat.
1. Выберите вход через {{ org-full-name }}.
1. Аутентифицируйтесь в {{ yandex-cloud }} с учетной записью пользователя вашей организации.
1. Убедитесь, что в результате успешной аутентификации вы вошли в LibreChat и что авторизованный пользователь относится в LibreChat к той же группе, что и в {{ org-full-name }} — `librechat-users`.
