---
title: Как посмотреть группы пользователя
description: Следуя данной инструкции, вы сможете посмотреть группы пользователя.
---

# Посмотреть группы пользователя

Чтобы посмотреть, в какие [группы](../../organization/concepts/groups.md) входит конкретный [пользователь](../../overview/roles-and-resources.md#users):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и в открывшемся списке выберите нужного пользователя.

      При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.user.title_groups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра групп пользователя:

     ```bash
     yc organization-manager group list-effective --help
     ```

  1. [Получите идентификатор пользователя](users-get.md).
  
  1. Выполните команду:

     ```bash
     yc organization-manager group list-effective --subject_id <идентификатор_пользователя>
     ```

     Где `--subject_id` — идентификатор нужного пользователя, полученный на предыдущем шаге.

{% endlist %}