# Настроить права доступа к секрету

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
  1. В списке сервисов выберите **{{ lockbox-short-name }}**.
  1. Нажмите на имя нужного секрета.
  1. На панели слева выберите раздел ![image](../../_assets/organization/icon-groups.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
  1. В открывшемся окне нажмите ![image](../../_assets/plus-sign.svg) **Выбрать пользователя**.
  1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к секрету.
  1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **Добавить роль** и выберите необходимые [роли](../security/index.md#roles-list).
  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}  

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите идентификатор секрета (столбец `ID` в выводе команды):

      ```bash
      yc lockbox secret list
      ```

      Результат:

      ```bash
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      |          ID          |    NAME     | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      | e6qtoqv06f1bbjs38sqc | test-secret |            | 2022-09-12 08:10:11 | e6qtpq6a9k7qskiruuq4 | ACTIVE |
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      ```

  1. Назначьте роль на секрет для пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):
      * Для пользователя:

        ```bash
        yc lockbox secret add-access-binding \
          --id <идентификатор_секрета> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```

        Где:
        * `id` — идентификатор секрета.
        * `user-account-id` — [идентификатор пользователя](../../iam/operations/users/get.md).
        * `role` — назначаемая [роль](../security/index.md#roles-list).

      * Для сервисного аккаунта:

        ```bash
        yc lockbox secret add-access-binding \
          --id <идентификатор_секрета> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```

        Где:
        * `id` — идентификатор секрета.
        * `service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md).
        * `role` — назначаемая [роль](../security/index.md#roles-list).

{% endlist %}

{% note info %}

Вы также можете [назначить](../../iam/operations/roles/grant.md) группе, пользователю или сервисному аккаунту роль на ресурс, от которого наследуются права доступа, например, на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).

{% endnote %}

#### См. также {#see-also}

* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
