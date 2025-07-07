---
title: Удалить организацию в {{ org-full-name }}
description: Из этой статьи вы узнаете, как удалить организацию в {{ org-name }}.
---

# Удалить организацию

{% note info %}

Удалить организацию может пользователь с ролью `organization-manager.organizations.owner`. Как назначить роль пользователю, читайте в разделе [Роли](../security/index.md#add-role).

Перед удалением организации:
1. [Удалите](../../resource-manager/operations/cloud/delete.md) из организации все облака.
1. [Удалите](../../billing/operations/delete-account.md) привязанный к организации платежный аккаунт.

{% endnote %}

Чтобы удалить организацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}) с учетной записью администратора или владельца организации.

      На открывшейся главной странице сервиса {{ cloud-center }} приведены основные сведения о вашей организации.

      {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

  1. Чтобы удалить текущую организацию, нажмите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.dashboard.organization.action.delete-button }}** в блоке с названием организации в центральной части экрана.

  1. В открывшемся окне укажите, когда следует удалить организацию. Задайте один из возможных периодов или выберите `Удалить сейчас`. Срок удаления организации по умолчанию — 7 дней.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

После удаления организации вы больше не сможете использовать ресурсы {{ yandex-cloud }}, которые были созданы в этой организации.

При возникновении проблем обратитесь в [службу поддержки]({{ link-console-support }}).