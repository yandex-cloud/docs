---
title: Как создать OIDC-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете создать OIDC-приложение в {{ org-name }} для аутентификации пользователей вашей организации во внешних приложениях с помощью технологии единого входа по стандарту OpenID Connect.
---

# Создать OIDC-приложение в {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

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