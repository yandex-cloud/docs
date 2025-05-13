---
title: Изменить данные организации в {{ org-full-name }}
description: Из этой статьи вы узнаете, как изменить данные организации в {{ org-name }}.
---

# Изменить данные организации

{% note info %}

Изменить данные организации может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [Роли](../security/index.md#admin).

{% endnote %}

Чтобы изменить данные вашей организации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}) с учетной записью администратора или владельца организации.

      На открывшейся главной странице сервиса {{ cloud-center }} приведены основные сведения о вашей организации.

      {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

  1. Чтобы изменить название и описание текущей организации, нажмите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.dashboard.organization.action.edit-button }}** в блоке с названием организации в центральной части экрана.

  1. В открывшемся окне измените название, техническое название, размер и описание организации.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.forms.action.save }}**.

{% endlist %}

{% include [where-change-billing-info](../../_includes/organization/where-change-billing-info.md) %}