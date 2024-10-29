---
title: Настройка прав доступа к бакету {{ objstorage-full-name }} с помощью {{ iam-name }}
description: Следуя данной инструкции, вы сможете назначить роль на бакет.
---

# Настройка прав доступа к бакету с помощью {{ iam-name }}

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

Чтобы настроить доступ к [бакету](../../concepts/bucket.md) с помощью [{{ iam-name }}](../../security/index.md), назначьте пользователю, группе пользователей или сервисному аккаунту [роль](../../security/index.md#roles-list) на бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя бакета, к которому вы хотите выдать доступ.
  1. В меню слева выберите **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Выберите роль для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

Также вы можете [назначить](../../../iam/operations/roles/grant.md) роль на бакет в сервисе {{ iam-name }}.