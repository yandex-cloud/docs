---
title: Как удалить сервисный аккаунт
description: Следуя данной инструкции, вы сможете удалить сервисный аккаунт.
---

# Удаление сервисного аккаунта

{% note warning %}

Удаление [сервисного аккаунта](../../concepts/users/service-accounts.md) — неотменяемая операция. Восстановить удаленный сервисный аккаунт невозможно, только [создать его заново](create.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [delete-sa-via-console](../../../_includes/iam/delete-sa-via-console.md) %}

- CLI {#cli}

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
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```
  1. Удалите сервисный аккаунт:

      ```bash
      yc iam service-account delete my-robot
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

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

     Проверить, что сервисный аккаунт удален можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc iam service-account list
     ```

- API {#api}

  Чтобы удалить сервисный аккаунт, воспользуйтесь методом REST API [delete](../../api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Delete](../../api-ref/grpc/ServiceAccount/delete.md).

{% endlist %}

{% note info %}

Сервисный аккаунт нельзя удалить, пока он связан с некоторыми ресурсами облака, например группами виртуальных машин. Сначала измените сервисный аккаунт в настройках ресурса или удалите ресурс, а затем удалите сервисный аккаунт.

{% endnote %}
