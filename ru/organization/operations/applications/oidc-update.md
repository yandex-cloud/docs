---
title: Как изменить OIDC-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить OIDC-приложение в {{ org-name }}.
---

# Изменить OIDC-приложение в {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Измените базовые настройки приложения {#update-basic-settings}

Чтобы изменить базовые настройки [OIDC-приложения](../../concepts/applications.md#oidc):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-name_kxMrU }}** измените имя приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-description_fcXBi }}** измените описание приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-labels_kc4MN }}** добавьте новые [метки](../../../resource-manager/concepts/labels.md) с помощью кнопки **{{ ui-key.yacloud.component.label-set.button_add-label }}**. Чтобы удалить существующую метку, используйте значок ![xmark](../../../_assets/console-icons/xmark.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Измените конфигурацию поставщика услуг {#update-sp}

Чтобы изменить конфигурацию поставщика услуг в OIDC-приложении:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. {% include [oidc-app-update-sp-settings](../../../_includes/organization/oidc-app-update-sp-settings.md) %}

{% endlist %}

## Измените секрет приложения {#update-secret}

Посмотреть или изменить имеющийся в приложении [секрет](../../concepts/applications.md#oidc-secret) невозможно. Вместо этого вы можете сгенерировать новый секрет:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. Не забудьте указать новый секрет в настройках на стороне поставщика услуг. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

{% endlist %}

## Измените список пользователей и групп приложения {#users-and-groups}

Измените список пользователей вашей [организации](../../concepts/organization.md), которые могут аутентифицироваться во внешнем приложении с помощью OIDC-приложения:

{% include [oidc-app-update-users-groups](../../../_includes/organization/oidc-app-update-users-groups.md) %}

#### См. также {#see-also}

* [{#T}](./oidc-create.md)
* [{#T}](./oidc-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)