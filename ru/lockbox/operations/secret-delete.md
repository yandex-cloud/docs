---
title: "Как удалить секрет в {{ lockbox-full-name }}"
description: "Следуя данной инструкции, вы сможете удалить секрет." 
---

# Удалить секрет

Чтобы удалить секрет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
  1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. В меню слева выберите **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
  1. Напротив нужного секрета нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления секрета:

     ```bash
     yc lockbox secret delete --help
     ```

  1. Запросите список секретов:

     ```bash
     yc lockbox secret list --cloud-id <идентификатор_облака> --folder-name <имя_каталога>
     ```

	 Результат:

	 ```text
	 +----------------------+------------------+------------+---------------------+----------------------+--------+
     |          ID          |       NAME       | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
     +----------------------+------------------+------------+---------------------+----------------------+--------+
     | e6q942hj2r5n******** | <имя_секрета_1>  |            | 2021-11-09 13:07:12 | e2r9pdm39tn2******** | ACTIVE |
     | e4qkyo469mu2******** | <имя_секрета_2>  |            | 2021-12-09 06:50:37 | e6fpq386othp******** | ACTIVE |
     +----------------------+------------------+------------+---------------------+----------------------+--------+
	 ```

  1. Чтобы удалить секрет, выполните команду:

     ```bash
     yc lockbox secret delete --id e4qkyo469mu2********
     ```

     Результат:

     ```text
     id: e4qkyo469mu2********
     folder_id: b1ulgko2th57********
     created_at: "2021-11-08T17:13:48.393Z"
     ...
       status: ACTIVE
       payload_entry_keys:
       - <ключ>
     ```

  1. Проверьте, что секрета нет в списке:

     ```bash
     yc lockbox secret list --cloud-id <идентификатор_облака> --folder-name <имя_каталога>
     ```

     Результат:

     ```text
     +----------------------+-----------------+------------+---------------------+----------------------+--------+
     |          ID          |      NAME       | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
     +----------------------+-----------------+------------+---------------------+----------------------+--------+
     | e6q942hj2r5n******** | <имя_секрета_1> |            | 2021-11-09 13:07:12 | e2r9pdm39tn2******** | ACTIVE |
     +----------------------+-----------------+------------+---------------------+----------------------+--------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием секрета:

     {% cut "Пример описания секрета в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_lockbox_secret" "my_secret" {
       name                = "My secret"
       description         = "test secret from tf"
       folder_id           = "b1gmitvfx321d3********"
       kms_key_id          = "abjp8q2fjfg0s********"
       deletion_protection = true
       labels              = {
         tf-label    = "tf-label-value",
         empty-label = ""
       }
     }
     ...
     ```

     {% endcut %}

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить удаление секрета можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

    ```bash
    yc lockbox secret list
    ```

- API {#api}

  Чтобы удалить секрет, воспользуйтесь методом REST API [delete](../api-ref/Secret/delete.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Delete](../api-ref/grpc/secret_service.md#Delete).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
