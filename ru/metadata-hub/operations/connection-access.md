---
title: Настроить права доступа к подключению
description: Следуя данной инструкции, вы сможете настроить права доступа к подключению.
---

# Настроить права доступа к подключению

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно настроить доступ к подключению.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
  1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к подключению.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../security/index.md#roles-list).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.   

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/connection-manager.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
