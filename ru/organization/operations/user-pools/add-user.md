---
title: Как добавить пользователя в пул в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете добавить пользователя в пул в {{ org-name }}.
---

# Добавить пользователя


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../../organization/concepts/user-pools.md).  
  1. На вкладке **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** нажмите **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.
  1. Введите логин пользователя и выберите [домен](../../concepts/domains.md) из списка. Если необходимого домена нет, [добавьте новый](add-domain.md).
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_full-name }}** укажите ФИО пользователя.  
  1. (Опционально) Добавьте электронную почту пользователя.
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_password }}** введите пароль для входа или сгенерируйте новый. После первого входа его потребуется изменить.

     Пароль может содержать только буквы латинского алфавита, цифры или следующие символы: `,`, `_`, `.`, `-`.

  1. (Опционально) Добавьте пользовательское изображение.
  1. Включите опцию **Учетная запись активна**, если нужно активировать пользователя сразу после добавления. Активированные пользователи получают доступ к ресурсам организации.
  1. (Опционально) В блоке **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** укажите имя, фамилию и номер телефона пользователя.
  1. Нажмите **Добавить пользователя**.

{% endlist %}