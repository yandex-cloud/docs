---
title: Как изменить SAML-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить SAML-приложение в {{ org-name }}.
---

# Изменить SAML-приложение в {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Измените базовые настройки приложения {#update-basic-settings}

Чтобы изменить базовые настройки [SAML-приложения](../../concepts/applications.md#saml):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-name_d22aF }}** измените имя приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-description_cjpok }}** измените описание приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-labels_uT2D2 }}** добавьте новые [метки](../../../resource-manager/concepts/labels.md) с помощью кнопки **{{ ui-key.yacloud.component.label-set.button_add-label }}**. Чтобы удалить существующую метку, используйте значок ![xmark](../../../_assets/console-icons/xmark.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Измените конфигурацию поставщика услуг {#update-sp}

Чтобы изменить конфигурацию поставщика услуг в SAML-приложении:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. {% include [saml-app-update-sp-settings](../../../_includes/organization/saml-app-update-sp-settings.md) %}

{% endlist %}

## Измените сертификат ключа проверки электронной подписи {#update-cert}

{% include [saml-app-cert-intro-phrase](../../../_includes/organization/saml-app-cert-intro-phrase.md) %}

В любой момент вы можете выпустить любое количество новых сертификатов ключа проверки электронной подписи для SAML-приложения. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_manage_certs }}** и в открывшемся окне:

      1. Нажмите кнопку **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.action-generate-new-certificate }}**. В результате будет создан новый сертификат, который отобразится в списке.
      1. Чтобы активировать новый сертификат, в строке с этим сертификатом включите опцию **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.table.column-active }}**.

          {% include [saml-app-cert-update-warn](../../../_includes/organization/saml-app-cert-update-warn.md) %}

      1. Чтобы скачать новый сертификат, в строке с этим сертификатом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.common.download }}**.
      1. Чтобы удалить сертификат, в строке с этим сертификатом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, после чего подтвердите удаление. Удалить можно только неактивный сертификат.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.close }}**.

{% endlist %}

## Измените атрибуты пользователей и групп {#update-attributes}

Чтобы изменить атрибуты, которые будут передаваться из {{ org-name }} поставщику услуг:

{% include [saml-app-update-assertions](../../../_includes/organization/saml-app-update-assertions.md) %}

## Измените список пользователей и групп приложения {#users-and-groups}

Измените список пользователей вашей [организации](../../concepts/organization.md), которые могут аутентифицироваться во внешнем приложении с помощью SAML-приложения:

{% include [saml-app-update-users-groups](../../../_includes/organization/saml-app-update-users-groups.md) %}

#### См. также {#see-also}

* [{#T}](./saml-create.md)
* [{#T}](./saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)