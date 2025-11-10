---
title: Как редактировать пул пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете редактировать пул пользователей в {{ org-name }}.
---

# Редактировать пул пользователей


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. В строке с нужным [пулом пользователей](../../../organization/concepts/user-pools.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **Изменить**.
  1. Задайте новое название или описание пула пользователей.

      Название должно быть уникальным в организации и соответствовать требованиям:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. Задайте новый [домен](../../concepts/domains.md), который будет использоваться, если к пулу не привязаны другие домены.
  1. Добавьте или удалите метки.
  1. Нажмите **{{ ui-key.yacloud_org.actions.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool update --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool update <идентификатор_пула> \
       --userpool-name <название_пула> \
       --description <описание_пула> \
       --default-subdomain <домен_по_умолчанию> \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:
     
     * `--userpool-name` — новое название пула пользователей. Название должно быть уникальным в рамках организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description` — новое описание пула пользователей.
     * `--labels` — новый список [меток](../../../resource-manager/concepts/labels.md). Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Update](../../idp/api-ref/Userpool/update.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Update](../../idp/api-ref/grpc/Userpool/update.md).

{% endlist %}