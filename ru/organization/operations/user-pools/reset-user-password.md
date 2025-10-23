---
title: Как задать или сбросить пароль локального пользователя в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете задать или сбросить пароль локального пользователя в {{ org-full-name }}.
---

# Изменить пароль локального пользователя


{% include [note-preview](../../../_includes/note-preview.md) %}

## Сбросить пароль {#reset}

Чтобы задать пароль [локального](../../../iam/concepts/users/accounts.md#local) пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и найдите нужного локального пользователя.

      При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.
  1. В строке с нужным пользователем нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите ![key](../../../_assets/console-icons/key.svg) **{{ ui-key.yacloud_org.entity.user.action.reset-password_jk19s }}**.
  1. В появившемся окне подтвердите сброс пароля.

      Сохраните сгенерированный пароль и передайте его пользователю. После закрытия окна посмотреть новый пароль будет невозможно.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для сброса пароля пользователя в [пуле](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user reset-password --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Выполните команду, указав идентификатор нужного пользователя:

      ```bash
      yc organization-manager idp user reset-password <идентификатор_пользователя>
      ```

      Результат:

      ```text
      generated password for user 'ek0gkfu0jc7v********' is 'rhls-mpvg-****-****'
      ```

      Сохраните сгенерированный пароль и передайте его пользователю. После закрытия командной оболочки посмотреть новый пароль будет невозможно.

{% endlist %}

Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.

## Задать пароль {#set}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  Задать произвольный пароль локальному пользователю через интерфейс {{ cloud-center }} нельзя. Чтобы изменить пароль на сгенерированный, воспользуйтесь [инструкцией](#reset).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения пароля пользователя в пуле:

     ```bash
     yc organization-manager idp user set-password --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Выполните команду, указав идентификатор нужного пользователя и задав новый пароль пользователя в параметре `--password`:

      ```bash
      yc organization-manager idp user set-password <идентификатор_пользователя> \
        --password <новый_пароль>
      ```

      {% note info %}

      Пароль пользователя может состоять из латинских букв, цифр и специальных символов.
      
      Пароль должен быть не короче семи символов, содержать как минимум одну латинскую букву в верхнем регистре, одну — в нижнем регистре, одну цифру и один специальный символ. 

      {% endnote %}

{% endlist %}