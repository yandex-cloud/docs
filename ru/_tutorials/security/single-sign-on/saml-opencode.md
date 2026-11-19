# Создать SAML-приложение в {{ org-full-name }} для интеграции с OpenCode Console


[OpenCode Console](https://opencode.ai/console) позволяет управлять [рабочими пространствами](https://opencode.ai/docs/console/workspaces/) (workspaces) и настраивать [единый вход](../../../glossary/sso.md) (SSO) для их участников. Чтобы пользователи вашей [организации](*organization) могли входить в рабочее пространство с помощью {{ org-full-name }}, создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) и настройте интеграцию по протоколу [SAML 2.0](https://ru.wikipedia.org/wiki/SAML).

Руководство описывает настройку доступа к рабочему пространству в OpenCode Console. Настройка доступа к экземпляру OpenCode, запущенному локально или на сервере, не рассматривается.

{% include [opencode-sso-single-connection](../../../_includes/organization/opencode-sso-single-connection.md) %}

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы настроить единый вход:

1. [Подготовьтесь к работе](#before-you-begin).
1. [Получите параметры OpenCode Console](#saml-sp-settings).
1. [Создайте и настройте SAML-приложение](#saml-create-app).
1. [Активируйте SAML в OpenCode Console](#saml-activate).
1. [Предоставьте пользователям доступ к приложению](#add-users).
1. [Привяжите и подтвердите почтовый домен](#verify-domain).
1. [Проверьте вход в рабочее пространство](#validate).

## Перед началом работы {#before-you-begin}

1. Подготовьте организацию в {{ org-full-name }}. Если у вас еще нет организации, [создайте ее](../../../organization/operations/enable-org.md).
1. Убедитесь, что у вас есть рабочее пространство в OpenCode Console и роль **Owner** в нем. Настраивать SSO может только владелец рабочего пространства.
1. Подготовьте почтовый домен вашей организации и убедитесь, что можете добавлять TXT-записи в его DNS-зону. Домен потребуется привязать к рабочему пространству и подтвердить в OpenCode Console.
1. Убедитесь, что у пользователей, которые будут входить через SSO, в {{ org-full-name }} указан адрес электронной почты в этом домене.

{% include [opencode-sso-activation-warning](../../../_includes/organization/opencode-sso-activation-warning.md) %}

## Получите параметры OpenCode Console {#saml-sp-settings}

1. Войдите в [OpenCode Console](https://opencode.ai/console) как владелец рабочего пространства и выберите нужное рабочее пространство.
1. Откройте **Settings** → **Security** и нажмите **Configure SSO**.
1. Выберите **SAML 2.0** и вариант настройки произвольного поставщика удостоверений **Custom SAML**.
1. На шаге **Set up your provider** скопируйте значения **ACS URL (Callback)** и **SP Entity ID**. Они понадобятся для настройки приложения в {{ org-full-name }}.

    Используйте значения из вашего подключения. Адреса содержат уникальный идентификатор подключения SSO и имеют вид:

    * **ACS URL (Callback)** — `https://opencode.ai/console/auth/sso/<идентификатор_подключения>/callback`.
    * **SP Entity ID** — `https://opencode.ai/console/auth/sso/<идентификатор_подключения>/metadata`.

## Создайте и настройте SAML-приложение {#saml-create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. В другой вкладке браузера откройте сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. Нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:

        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** укажите имя приложения, например `opencode-saml`.
        1. (Опционально) Добавьте описание и [метки](../../../resource-manager/concepts/labels.md) приложения.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
    1. На странице созданного приложения нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и задайте настройки:

        * **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** — значение **SP Entity ID** из OpenCode Console.
        * **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** — значение **ACS URL (Callback)** из OpenCode Console.
        * **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** — **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-assertions_thJgN }}**.

        Поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** оставьте пустым.
    1. Нажмите **{{ ui-key.yacloud.common.save }}**.
    1. Настройте передачу адреса электронной почты пользователя:

        1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
        1. Нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** укажите `email`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** выберите `SubjectClaims.email`.
        1. Нажмите **{{ ui-key.yacloud.common.add }}**.

        Если атрибут `email` уже есть, проверьте его значение вместо создания нового атрибута.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** и в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**.

{% endlist %}

{% note info %}

OpenCode Console требует, чтобы поставщик удостоверений подписывал SAML-ответ или содержащиеся в нем утверждения. Также поставщик должен передавать адрес электронной почты пользователя в атрибуте `email` или в `NameID`. В этом руководстве используются подпись утверждений и отдельный атрибут `email`.

{% endnote %}

## Активируйте SAML в OpenCode Console {#saml-activate}

1. Вернитесь к настройке **Custom SAML** в OpenCode Console и нажмите **Next**.
1. На шаге **Add provider details** в поле **IdP Metadata** вставьте URL метаданных приложения, скопированный из {{ org-full-name }}.
1. Нажмите **Fetch**. Проверьте, что заполнились поля **IdP Entity ID**, **IdP SSO URL** и **IdP Certificate**.

    Вместо загрузки по URL можно использовать **Upload XML** и загрузить файл метаданных, скачанный со страницы SAML-приложения в {{ org-full-name }}.
1. В поле **Display Name** укажите имя поставщика удостоверений, например `Identity Hub SAML`.
1. Нажмите **Next**.
1. На шаге **Review** проверьте параметры и нажмите **Activate SSO**.

## Предоставьте пользователям доступ к приложению {#add-users}

Пользователей или [группы пользователей](*users-groups) нужно явно добавить в созданное SAML-приложение {{ org-full-name }}:

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

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
* [Создать SAML-приложение в {{ org-full-name }}](../../../organization/operations/applications/saml-create.md).

[*organization]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}

[*users-groups]: {% include [users-groups](../../../_popups/identity-hub/users-groups.md) %}
