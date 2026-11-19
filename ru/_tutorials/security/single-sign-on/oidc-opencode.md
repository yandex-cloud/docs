# Создать OIDC-приложение в {{ org-full-name }} для интеграции с OpenCode Console


[OpenCode Console](https://opencode.ai/console) позволяет управлять [рабочими пространствами](https://opencode.ai/docs/console/workspaces/) (workspaces) и настраивать [единый вход](../../../glossary/sso.md) (SSO) для их участников. Чтобы пользователи вашей [организации](*organization) могли входить в рабочее пространство с помощью {{ org-full-name }}, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) и настройте интеграцию по протоколу [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC).

Руководство описывает настройку доступа к рабочему пространству в OpenCode Console. Настройка доступа к экземпляру OpenCode, запущенному локально или на сервере, не рассматривается.

{% include [opencode-sso-single-connection](../../../_includes/organization/opencode-sso-single-connection.md) %}

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы настроить единый вход:

1. [Подготовьтесь к работе](#before-you-begin).
1. [Создайте OIDC-приложение и получите учетные данные](#oidc-create-app).
1. [Создайте подключение в OpenCode Console](#oidc-create-connection).
1. [Настройте адрес возврата и атрибуты](#oidc-redirect-uri).
1. [Предоставьте пользователям доступ к приложению](#add-users).
1. [Привяжите и подтвердите почтовый домен](#verify-domain).
1. [Проверьте вход в рабочее пространство](#validate).

## Перед началом работы {#before-you-begin}

1. Подготовьте организацию в {{ org-full-name }}. Если у вас еще нет организации, [создайте ее](../../../organization/operations/enable-org.md).
1. Убедитесь, что у вас есть рабочее пространство в OpenCode Console и роль **Owner** в нем. Настраивать SSO может только владелец рабочего пространства.
1. Подготовьте почтовый домен вашей организации и убедитесь, что можете добавлять TXT-записи в его DNS-зону. Домен потребуется привязать к рабочему пространству и подтвердить в OpenCode Console.
1. Убедитесь, что у пользователей, которые будут входить через SSO, в {{ org-full-name }} указан адрес электронной почты в этом домене.
1. Подготовьте [каталог](*folder), в котором будет создан OAuth-клиент.

{% include [opencode-sso-activation-warning](../../../_includes/organization/opencode-sso-activation-warning.md) %}

## Создайте OIDC-приложение и получите учетные данные {#oidc-create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. Нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:

        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** укажите имя приложения, например `opencode-oidc`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент.
        1. (Опционально) Добавьте описание и [метки](../../../resource-manager/concepts/labels.md) приложения.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
    1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

## Создайте подключение в OpenCode Console {#oidc-create-connection}

1. Войдите в [OpenCode Console](https://opencode.ai/console) как владелец рабочего пространства и выберите нужное рабочее пространство.
1. Откройте **Settings** → **Security** и нажмите **Configure SSO**.
1. Выберите **OpenID Connect** и вариант настройки произвольного поставщика удостоверений **Custom OIDC**.
1. Заполните поля:

    * **Issuer URL** — `https://auth.yandex.cloud`.
    * **Client ID** — идентификатор OAuth-клиента, скопированный из {{ org-full-name }}.
    * **Client Secret** — секрет приложения, созданный в {{ org-full-name }}.
    * **Display Name** — имя поставщика удостоверений, например `Identity Hub OIDC`.

1. Нажмите **Save**. OpenCode Console проверит доступность поставщика удостоверений и активирует SSO.
1. Скопируйте точный адрес **Callback URL** из сохраненного подключения. Он имеет вид `https://opencode.ai/console/auth/sso/<идентификатор_подключения>/callback`.

{% note warning %}

Точный адрес **Callback URL** создается только после сохранения подключения. Не используйте шаблон адреса из формы настройки. До добавления этого адреса в {{ org-full-name }} вход через SSO работать не будет.

{% endnote %}

## Настройте адрес возврата и атрибуты {#oidc-redirect-uri}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Вернитесь к OIDC-приложению в {{ org-full-name }}.
    1. Нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
    1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** вставьте точный **Callback URL**, скопированный из OpenCode Console. Поле **Post Logout Redirect URI** оставьте пустым.
    1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** выберите атрибуты `openid`, `email` и `profile`.
    1. {% include [org-oidc-app-disable-pkce](../../../_tutorials/_tutorials_includes/org-oidc-app-disable-pkce.md) %}
    1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Предоставьте пользователям доступ к приложению {#add-users}

Пользователей или [группы пользователей](*users-groups) нужно явно добавить в созданное OIDC-приложение {{ org-full-name }}:

{% include [oidc-manage-users](../../../_includes/organization/oidc-manage-users.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. В сервисе [{{ org-full-name }}]({{ link-org-cloud-center }}) откройте **{{ ui-key.yacloud_org.pages.apps }}** и выберите созданное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. Выберите нужного пользователя или группу пользователей и нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

{% include [opencode-verify-domain](../../../_includes/organization/opencode-verify-domain.md) %}

{% include [opencode-validate](../../../_includes/organization/opencode-validate.md) %}

#### Полезные ссылки {#see-also}

* [Настройка SSO в OpenCode Console](https://opencode.ai/v2/docs/console/sso/).
* [Создать OIDC-приложение в {{ org-full-name }}](../../../organization/operations/applications/oidc-create.md).

[*organization]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}

[*users-groups]: {% include [users-groups](../../../_popups/identity-hub/users-groups.md) %}

[*folder]: {% include [folder-definition](../../../_popups/resource-manager/folder-definition.md) %}
