---
title: Как создать пул пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете создать пул пользователей в {{ org-name }}.
---

# Создать пул пользователей


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-userpool }}**.
  1. Задайте название и описание [пула пользователей](../../../organization/concepts/user-pools.md).

      Название должно быть уникальным в рамках организации и соответствовать требованиям:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. В поле **{{ ui-key.yacloud_org.form.userpool.caption.domain }}** добавьте [домен](../../concepts/domains.md), который будет использоваться для всех пользователей пула по умолчанию.
  1. (Опционально) Добавьте метки:
     1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
     1. Введите метку в формате `ключ: значение`.
     1. Нажмите **Enter**.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.userpool.create.action.create }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](add-user.md)
* [{#T}](add-domain.md)