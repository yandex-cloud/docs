---
title: Как создать пул пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете создать пул пользователей в {{ org-name }}.
---

# Создать пул пользователей


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-userpool }}**.
  1. Задайте название и описание [пула пользователей](../../concepts/user-pools.md).

      Название должно быть уникальным в рамках организации и соответствовать требованиям:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. В поле **{{ ui-key.yacloud_org.form.userpool.caption.domain }}** добавьте [домен](../../concepts/domains.md), который будет использоваться, если к пулу не привязаны другие домены.
  1. (Опционально) Добавьте метки:
     1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
     1. Введите метку в формате `ключ: значение`.
     1. Нажмите **Enter**.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.userpool.create.action.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool create --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool create \
       --organization-id <идентификатор_организации> \
       --userpool-name <название_пула> \
       --description <описание_пула> \
       --default-subdomain <домен_по_умолчанию> \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:
     
     * `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать пул пользователей.
     * `--userpool-name` — название пула пользователей. Название должно быть уникальным в рамках организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description` — описание пула пользователей. Необязательный параметр.
     * `--default-subdomain` — [домен](../../concepts/domains.md) по умолчанию. Будет использоваться, если к пулу не привязаны другие домены.
     * `--labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../add-account.md#add-local-user)
* [{#T}](add-domain.md)