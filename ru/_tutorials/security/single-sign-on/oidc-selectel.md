---
title: Создать OIDC-приложение в {{ org-full-name }} для интеграции с Selectel
description: Как настроить интеграцию {{ org-full-name }} с Selectel для единого входа пользователей организации по стандарту OpenID Connect.
---

# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Selectel


Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли входить в Selectel по стандарту OpenID Connect (OIDC), создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в {{ org-full-name }} и настройте интеграцию с Selectel.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы настроить единый вход в Selectel:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Проверьте работу единого входа](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
      1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя приложения: `selectel-oidc`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Откройте созданное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

### Создайте федерацию в Selectel {#setup-sp}

{% note info %}

Создать федерацию в Selectel может [владелец аккаунта](https://docs.selectel.ru/access-control/user-types/#account-owner) или пользователь с ролью [`iam.admin`](https://docs.selectel.ru/access-control/role-reference/#iam-admin).

{% endnote %}

Чтобы настроить федерацию:

1. Войдите в [панель управления Selectel](https://my.selectel.ru/iam/federations).
1. В верхнем меню выберите **IAM** и перейдите в раздел **Федерации**.
1. Нажмите **Добавить федерацию** и выберите **OpenID Connect (OIDC)**.
1. В блоке **Настройки федерации**:
    1. В поле **Имя** задайте имя федерации, например `identity-hub-oidc`.
    1. (Опционально) В поле **Описание** задайте описание федерации.
    1. В поле **Время жизни сессии** задайте время жизни сессии или оставьте значение по умолчанию — 24 часа.
1. В блоке **Настройки IDP** укажите параметры интеграции:

    * **IdP Issuer** — `https://{{ auth-main-host }}`.
    * **Client ID** — значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**, скопированное на предыдущем этапе.
    * **Client secret** — секрет приложения, сохраненный на предыдущем этапе.
    * **Auth URL** — `https://{{ auth-main-host }}/oauth/authorize`.
    * **Token URL** — `https://{{ auth-main-host }}/oauth/token`.
    * **JWKS URI** — `https://{{ auth-main-host }}/oauth/jwks/keys`.

1. Отключите опцию **Автосоздание пользователей**, если она включена.
1. Нажмите **Создать федерацию**.
1. На странице созданной федерации скопируйте ее идентификатор из поля **ID**.

### Настройте приложение в {{ org-full-name }} {#setup-idp}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Вернитесь в [{{ org-full-name }}]({{ link-org-cloud-center }}), выберите раздел **{{ ui-key.yacloud_org.pages.apps }}** и откройте приложение `selectel-oidc`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите адрес:

          ```text
          https://api.selectel.ru/v1/auth/federations/oidc/<идентификатор_федерации>/callback
          ```

          Где `<идентификатор_федерации>` — идентификатор федерации, созданной в Selectel на предыдущем этапе.
      1. В блоке **{{ ui-key.yacloud_org.application.overview.oauth_security_section_title }}** в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_authentication_methods }}** оставьте выбранными оба способа передачи секрета: `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_basic }}` и `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_post }}`.
      1. В блоке **{{ ui-key.yacloud_org.application.overview.oauth_security_section_title }}** отключите опцию **{{ ui-key.yacloud_org.organization.apps.AppEditPage.field-require-pkce_9rAab }}**.

          {% note alert %}

          Для интеграции с Selectel приложение {{ org-full-name }} не должно требовать использования расширения безопасности [PKCE](../../../organization/concepts/applications/oidc.md#pkce) при обмене данными.

          {% endnote %}

      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** выберите атрибуты `openid`, `email` и `profile`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Добавьте пользователей {#add-users}

Добавьте пользователей в OIDC-приложение {{ org-full-name }} и в федерацию Selectel.

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь с [ролью](../../../organization/security/index.md#organization-manager-oauthApplications-userAdmin) `organization-manager.oauthApplications.userAdmin` или выше.

{% endnote %}

#### Добавьте пользователей в OIDC-приложение {#add-users-idp}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

Чтобы добавить пользователей:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Откройте приложение `selectel-oidc` в [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
  1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
  1. В открывшемся окне выберите пользователя или [группу пользователей](../../../organization/concepts/groups.md).
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

#### Добавьте пользователей в Selectel {#add-users-sp}

Чтобы добавить пользователя в федерацию Selectel:

1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md) в {{ org-full-name }}.
1. В [панели управления Selectel](https://my.selectel.ru/iam/users) в верхнем меню выберите **IAM** и перейдите в раздел **Пользователи панели**.
1. Нажмите **Добавить пользователя панели**.
1. В блоке **Данные пользователя**:
    1. В поле **Способ входа** выберите **Федерация (<имя_федерации>)**.
    1. В поле **External ID** укажите ID пользователя, полученный на первом шаге.
    1. В поле **Почта** укажите адрес электронной почты пользователя.
1. В блоке **Настройки доступа** выберите область доступа и назначьте пользователю необходимые [разрешения](https://docs.selectel.ru/access-control/permissions/).
1. Нажмите **Добавить пользователя**.

## Проверьте работу единого входа {#validate}

Чтобы проверить интеграцию, выполните вход в Selectel от имени пользователя, добавленного в OIDC-приложение:

1. Откройте [страницу входа в Selectel](https://my.selectel.ru/login/).
1. Если вы уже вошли в Selectel, выйдите из учетной записи.
1. Нажмите **Войти с помощью SSO**.
1. Введите идентификатор созданной федерации Selectel и нажмите **Войти по SSO**.
1. На странице аутентификации {{ yandex-cloud }} войдите в учетную запись пользователя. Пользователь должен быть добавлен в OIDC-приложение или состоять в группе, добавленной в приложение.
1. Если при первом входе Selectel запросит ФИО, укажите его и нажмите **Войти по SSO**.
1. Убедитесь, что вы вошли в Selectel.
