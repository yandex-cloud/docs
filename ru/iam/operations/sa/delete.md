# Удаление сервисного аккаунта

{% note warning %}

Удаление [сервисного аккаунта](../../concepts/users/service-accounts.md) — неотменяемая операция. Восстановить удаленный сервисный аккаунт невозможно, только [создать его заново](create.md).

{% endnote %}

{% list tabs %}

- Консоль управления

  {% include [delete-sa-via-console](../../../_includes/iam/delete-sa-via-console.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды удаления сервисного аккаунта:

      ```bash
      yc iam service-account delete --help
      ```

  2. Выберите сервисный аккаунт, например `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```
  3. Удалите сервисный аккаунт:

      ```bash
      yc iam service-account delete my-robot
      ```

- API

  Чтобы удалить сервисный аккаунт, воспользуйтесь методом [delete](../../api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

{% endlist %}
