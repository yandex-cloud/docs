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

  1. Выберите сервисный аккаунт, например `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```
  1. Удалите сервисный аккаунт:

      ```bash
      yc iam service-account delete my-robot
      ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить сервисный аккаунт:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием сервисного аккаунта. 
     Пример описания сервисного аккаунта в конфигурации {{ TF }}:

     ```hcl
     ...
     resource "yandex_iam_service_account" "sa" {
       name        = "my-robot"
       description = "this is my favorite service account"
      }
     ...
     ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
  
  1. Проверьте конфигурацию командой:
     ```bash
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```text
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```bash
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```bash
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить, что сервисны аккаунт удален можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc iam service-account list
     ```

- API

  Чтобы удалить сервисный аккаунт, воспользуйтесь методом [delete](../../api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

{% endlist %}
