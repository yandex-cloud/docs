---
title: Как создать SAML-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете создать SAML-приложение в {{ org-name }} для аутентификации пользователей вашей организации во внешних приложениях с помощью технологии единого входа по стандарту SAML.
---

# Создать SAML-приложение в {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы пользователи вашей [организации](../../concepts/organization.md) могли аутентифицироваться во внешних приложениях с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне поставщика услуг.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

          1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте приложение {#setup-application}

Чтобы настроить интеграцию внешнего приложения с созданным SAML-приложением в {{ org-name }}, выполните настройки на стороне поставщика услуг и на стороне {{ org-name }}.

### Задайте настройки интеграции на стороне поставщика услуг {#setup-sp}

Значения настроек интеграции, которые нужно задать на стороне поставщика услуг, доступны на странице с информацией о приложении в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}/apps).

В зависимости от возможностей вашего поставщика услуг вы можете выполнить необходимые настройки вручную или автоматически, загрузив файл с метаданными или указав URL с метаданными:

{% list tabs %}

- Настройка вручную

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значения параметров, которые необходимо задать на стороне поставщика услуг:

      {% include [saml-app-sp-parameter-list](../../../_includes/organization/saml-app-sp-parameter-list.md) %}

  1. Скачайте сертификат приложения в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, нажав кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}**.
  1. На стороне поставщика услуг настройте интеграцию с SAML-приложением {{ org-name }}, указав скопированные параметры и добавив скачанный сертификат. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- Файл с метаданными

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит значения всех необходимых настроек и сертификат, который используется для проверки подписи SAML-ответов. Загрузите скачанный файл на стороне поставщика услуг, если ваш поставщик услуг поддерживает конфигурирование приложения с помощью файла с метаданными. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- URL с метаданными

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**.

      По ссылке доступны значения всех необходимых настроек и сертификат, который используется для проверки подписи SAML-ответов. Укажите полученную ссылку в настройках на стороне поставщика услуг, если ваш поставщик услуг поддерживает конфигурирование приложения с помощью URL с метаданными. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

{% endlist %}

### Настройте SAML-приложение на стороне {{ org-name }} {#setup-idp}

Прежде чем настраивать SAML-приложение на стороне {{ org-name }}, получите необходимые значения настроек у вашего поставщика услуг. Затем перейдите к настройкам SAML-приложения в {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. {% include [saml-app-update-sp-settings](../../../_includes/organization/saml-app-update-sp-settings.md) %}

{% endlist %}

### Настройте атрибуты пользователей и групп {#setup-attributes}

Вы можете настроить атрибуты, которые будут передаваться из {{ org-name }} поставщику услуг:

{% include [saml-app-update-assertions](../../../_includes/organization/saml-app-update-assertions.md) %}

### Настройте пользователей и группы {#users-and-groups}

Чтобы пользователи вашей организации могли аутентифицироваться во внешнем приложении с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../concepts/groups.md):

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

{% include [saml-app-update-users-groups](../../../_includes/organization/saml-app-update-users-groups.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с поставщиком услуг, выполните аутентификацию во внешнем приложении от имени одного из добавленных в приложение пользователей.

#### См. также {#see-also}

* [{#T}](./saml-update.md)
* [{#T}](./saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)