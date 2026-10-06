---
title: Удалить организацию в {{ org-full-name }}
description: Из этой статьи вы узнаете, как удалить организацию в {{ org-full-name }}.
---

# Удалить организацию

Для удаления организации {{ yandex-360 }} воспользуйтесь [инструкцией {{ yandex-360 }}](https://yandex.ru/support/yandex-360/business/admin/ru/organization/delete-organization).

{% note info %}

Удалить организацию может пользователь с ролью `organization-manager.organizations.owner`. Как назначить роль пользователю, читайте в разделе [Роли](../security/index.md#add-role).

Перед удалением организации:
1. [Удалите](../../resource-manager/operations/cloud/delete.md) из организации все облака или [переместите](../../resource-manager/operations/cloud/change-organization.md) их в другую организацию.
1. [Удалите](../../billing/operations/delete-account.md) все привязанные к организации платежные аккаунты.

{% endnote %}

Чтобы удалить организацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}) с учетной записью администратора или владельца организации.

      На открывшейся главной странице сервиса {{ cloud-center }} приведены основные сведения о вашей организации.

      {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

  1. Чтобы удалить текущую организацию, нажмите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.dashboard.organization.action.delete-button }}** в блоке с названием организации в центральной части экрана.

  1. В открывшемся окне:
  
     1. Укажите, когда следует удалить организацию. Задайте один из возможных периодов или выберите `Удалить сейчас`. Срок удаления организации по умолчанию — 7 дней.
     1. Введите название организации, чтобы подтвердить удаление. 

  1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

После удаления организации вы больше не сможете использовать ресурсы {{ yandex-cloud }}, которые были созданы в этой организации.

## Решение ошибки при удалении организации {#troubleshooting}

Если при удалении организации появляется следующая ошибка, значит, в организации остались облака, которые не позволяют удалить ее:

```text
Service 'resource-manager.cloud' has banned deletion operation with reason: Organization `<идентификатор_организации>` has cloud(s)
```

Чтобы устранить ошибку:

1. [Удалите](../../resource-manager/operations/cloud/delete.md) все облака из организации или [переместите](../../resource-manager/operations/cloud/change-organization.md) их в другую организацию.
1. Если вы выбрали удаление облаков, дождитесь его завершения. По умолчанию срок удаления облака — 7 дней. После окончания этого срока необратимое удаление может занять до 72 часов.
1. Повторите удаление организации.

Если к организации привязаны платежные аккаунты, их также необходимо [удалить](../../billing/operations/delete-account.md).

При возникновении других проблем создайте запрос в [техническую поддержку]({{ link-console-support }}).
