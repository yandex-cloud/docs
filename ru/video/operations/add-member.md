---
title: Как добавить участника в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете добавить участника в {{ video-full-name }}.
---

# Добавить участника

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.dashboard.action_add-user }}**, чтобы пригласить пользователя в [организацию](../../organization/quickstart.md). В открывшемся окне:
  
      1. Введите почтовый адрес пользователя, которого вы хотите пригласить в организацию (например, `login@yandex.ru`).

          Вы можете указать несколько электронных адресов через запятую, чтобы [пригласить](../../organization/operations/add-account.md#send-invitation) в организацию сразу несколько пользователей.
      1. Для отправки приглашений нажмите кнопку **{{ ui-key.yacloud_components.organization.action_next }}**. Откроется окно для назначения ролей и добавления пользователей в группу.

      1. {% include [assign-roles-on-invite](../../_includes/organization/assign-roles-on-invite.md) %}

          Например, вы можете назначить пользователю роль `video.editor` для создания, изменения и удаления ресурсов сервиса и трансляции видеопотока или `video.viewer` — только для просмотра ресурсов сервиса.

      1. {% include [add-to-group-on-invite](../../_includes/organization/add-to-group-on-invite.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  
  Сервис {{ video-name }} станет доступен приглашенным пользователям после того, как они примут приглашение и им будут назначены необходимые для работы с сервисом разрешения.

{% endlist %}